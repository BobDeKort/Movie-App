//
//  Style.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


internal let STYLES_DID_UPDATE = Notification.Name(rawValue: "stylesDidUpdate")


open class Styles {
    
    open static let shared = Styles()
    
    private var _styles = [String:Style]()
    private var _colorHolders = [String:ColorHolder]()
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private init() {
        self.processStyleDataWithFileNamed("styles", publishUpdate: false)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func addStyle(_ style:Style) {
        if self._styles[style.name] == nil {
            self._styles[style.name] = style
        } else {
            print("A style named: '\(style.name)' already exists!")
        }
    }
    
    open func styleNamed(_ name:String)->Style? {
        return self._styles[name]
    }
    
    open func colorNamed(_ name:String)->UIColor? {
        return self._colorHolders[name]?.color
    }
        
    open func processStyleDataWithFileNamed(_ fileName:String) {
		self.processStyleDataWithFileNamed(fileName, publishUpdate: true)
    }
	
	open func processStyleDataWithFileAtPath(_ path:String) {
		self.processStyleDataWithFileAtPath(path, publishUpdate: true)
	}
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func pathForStylesDescriptorNamed(_ name:String)->String? {
        var filePath:String?
        if let interfaceBuilderProjectResourcePaths = ProcessInfo.processInfo.environment["IB_PROJECT_SOURCE_DIRECTORIES"]?.components(separatedBy: ":") {
            for path in interfaceBuilderProjectResourcePaths {
                let url = URL(fileURLWithPath: path)
                if url.lastPathComponent == "Pods" {
                    filePath = url.deletingLastPathComponent().appendingPathComponent(name + ".plist").path
                }
            }
        } else {
            filePath = Bundle.main.path(forResource: name, ofType: "plist")
        }
        return filePath
    }
	
	private func processStyleDataWithFileNamed(_ fileName:String, publishUpdate:Bool) {
		if let stylesFilePath = self.pathForStylesDescriptorNamed(fileName) {
			self.processStyleDataWithFileAtPath(stylesFilePath, publishUpdate: publishUpdate)
		}
	}
	
	private func processStyleDataWithFileAtPath(_ path:String, publishUpdate:Bool) {
		
        guard let styleData = NSDictionary(contentsOfFile: path) as? [String:AnyObject] else {
                return
        }
        
        // Parse color strings
        if var colorEntries = styleData["colors"] as? [String:String] {
            var numParsedColors = 1
            while colorEntries.count > 0 && numParsedColors > 0 {
                numParsedColors = 0
                for (name, colorString) in colorEntries {
                    if let color = UIColor(hexString: colorString) {
                        if let colorHolder = self._colorHolders[name] {
                            colorHolder.color = color
                        } else {
                            self._colorHolders[name] = ColorHolder(color: color)
                        }
                        colorEntries.removeValue(forKey: name)
                        numParsedColors += 1
                    } else if let colorHolder = self._colorHolders[colorString] {
                        self._colorHolders[name] = colorHolder
                        colorEntries.removeValue(forKey: name)
                        numParsedColors += 1
                    }
                }
            }
            if colorEntries.count > 0 {
                // Not everything was parsed in the above code, this means there are unsatifyable colorStrings
                print("WARNING: not all colors could be parsed, this probably means a name is used, but no actual color is ever assigned to it")
            }
        }
        
        var styleDatas = styleData["styles"] as? [String:[String:AnyObject]]
        if styleDatas != nil {
            
            // Read styles
            var numParsedStyles = 1
            while styleDatas!.count > 0 && numParsedStyles > 0 {
                let styleDatasCopy = styleDatas!
                numParsedStyles = 0
                for (name, styleData) in styleDatasCopy {
                    var style = self._styles[name]
                    if let parentName = styleData["parent"] as? String {
                        if let parentStyle = self._styles[parentName] {
                            if style != nil {
                                print("WARNING: You cannot override the parent property of a style! Style named '\(name)' will be replaced completely.")
                            }
                            let style = Style(name: name, parentStyle: parentStyle, overridesData: styleData)
                            self._styles[name] = style
                            styleDatas!.removeValue(forKey: name)
                            numParsedStyles += 1
                        }
                    } else {
                        if style == nil {
                            // Create a new style with the data
                            style = Style(name: name, data: styleData)
                        } else {
                            style!.parseData(styleData)
                        }
                        self._styles[name] = style!
                        styleDatas!.removeValue(forKey: name)
                        numParsedStyles += 1
                    }
                }
            }
            if styleDatas!.count > 0 {
                // Not everything was parsed in the above code, this means there are unsatifyable parent child cycles
                print("WARNING: not all styles could be parsed, this probably means a parent style does not exist, or there are 2 or more styles referring to eachother as a parentStyle.")
            }
        }
        
        if publishUpdate {
            NotificationCenter.default.post(name: STYLES_DID_UPDATE, object: self)
        }
    }
}

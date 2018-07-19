//
//  Style.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


open class Style {
    open let name:String
    
    // Border style
    open var borderWidth:CGFloat?
    open var borderStyle:UITextBorderStyle?
    
    // Image tinting
    open var tintImageWithForegroundColor:Bool?
    
    // Cell separator style
    open var tableViewSeparatorStyle:UITableViewCellSeparatorStyle?
    
    // Text
    open var font:UIFont?
    open var fullUppercaseText:Bool?
    
    // Corners
    open var cornerRadius:CGFloat?
    open var clipsToBounds:Bool?
    
    // Foreground color names
    private (set) var foregroundColorString:String?
    private (set) var highlightedForegroundColorString:String?
    private (set) var selectedForegroundColorString:String?
    private (set) var disabledForegroundColorString:String?
    
    // Background color names
    private (set) var backgroundColorString:String?
    private (set) var highlightedBackgroundColorString:String?
    private (set) var selectedBackgroundColorString:String?
    private (set) var disabledBackgroundColorString:String?
    
    // Border color names
    private (set) var borderColorString:String?
    private (set) var highlightedBorderColorString:String?
    private (set) var selectedBorderColorString:String?
    private (set) var disabledBorderColorString:String?
    
    // Cell style color names
    private (set) var tableViewSeparatorColorString:String?
    
    // Styled text
    private (set) var styledTextDictionary:[String:Any]?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    public init(name:String) {
        self.name = name
    }
    
    public init(name:String, data:[String:Any]) {
        self.name = name
        self.parseData(data)
    }
    
    public init(name:String, parentStyle:Style, overridesData:[String:Any]) {
        self.name = name
     
        // Set properties from parent
        
        // - foreground colors
        self.foregroundColorString = parentStyle.foregroundColorString
        self.highlightedForegroundColorString = parentStyle.highlightedForegroundColorString
        self.selectedForegroundColorString = parentStyle.selectedForegroundColorString
        self.disabledForegroundColorString = parentStyle.disabledForegroundColorString
        
        // - background colors
        self.backgroundColorString = parentStyle.backgroundColorString
        self.highlightedBackgroundColorString = parentStyle.highlightedBackgroundColorString
        self.selectedBackgroundColorString = parentStyle.selectedBackgroundColorString
        self.disabledBackgroundColorString = parentStyle.disabledBackgroundColorString
        
        // - border style
        self.borderWidth = parentStyle.borderWidth
        self.borderColorString = parentStyle.borderColorString
        self.highlightedBorderColorString = parentStyle.highlightedBorderColorString
        self.selectedBorderColorString = parentStyle.selectedBorderColorString
        self.disabledBorderColorString = parentStyle.disabledBorderColorString
        self.borderStyle = parentStyle.borderStyle
        
        
        // - image tinting
        self.tintImageWithForegroundColor = parentStyle.tintImageWithForegroundColor
        
        // - cell separator style
        self.tableViewSeparatorStyle = parentStyle.tableViewSeparatorStyle
        self.tableViewSeparatorColorString = parentStyle.tableViewSeparatorColorString
        
        // - font
        self.font = parentStyle.font
        
        // - text
        self.fullUppercaseText = parentStyle.fullUppercaseText
        
        // - other
        self.cornerRadius = parentStyle.cornerRadius
        self.clipsToBounds = parentStyle.clipsToBounds
        
        // Set overrides
        self.parseData(overridesData)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    // Foreground colors
    open var foregroundColor:UIColor? {
        return self.colorFromString(self.foregroundColorString)
    }
    
    open var highlightedForegroundColor:UIColor? {
        return self.colorFromString(self.highlightedForegroundColorString)
    }
    
    open var selectedForegroundColor:UIColor? {
        return self.colorFromString(self.selectedForegroundColorString)
    }
    
    open var disabledForegroundColor:UIColor? {
        return self.colorFromString(self.disabledForegroundColorString)
    }
    
    // Background colors
    open var backgroundColor:UIColor? {
        return self.colorFromString(self.backgroundColorString)
    }
    
    open var highlightedBackgroundColor:UIColor? {
        return self.colorFromString(self.highlightedBackgroundColorString)
    }
    
    open var selectedBackgroundColor:UIColor? {
        return self.colorFromString(self.selectedBackgroundColorString)
    }
    
    open var disabledBackgroundColor:UIColor? {
        return self.colorFromString(self.disabledBackgroundColorString)
    }
    
    // Border style
    open var borderColor:UIColor? {
        return self.colorFromString(self.borderColorString)
    }
    
    open var highlightedBorderColor:UIColor? {
        return self.colorFromString(self.highlightedBorderColorString)
    }
    
    open var selectedBorderColor:UIColor? {
        return self.colorFromString(self.selectedBorderColorString)
    }
    
    open var disabledBorderColor:UIColor? {
        return self.colorFromString(self.disabledBorderColorString)
    }
    
    // Cell separator style
    open var tableViewSeparatorColor:UIColor? {
        return self.colorFromString(self.tableViewSeparatorColorString)
    }
    
    // Styled text
    open var styledTextAttributes:[NSAttributedStringKey:Any]? {
        if let styledTextDictionary = self.styledTextDictionary {
            return self.stringAttributesFromDictionary(styledTextDictionary)
        } else {
            return nil
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    func parseData(_ data:[String:Any]) {
        // Foreground colors
        if let foregroundColorString = data["foregroundColor"] as? String {
            self.foregroundColorString = foregroundColorString
        }
        if let highlightedForegroundColorString = data["highlightedForegroundColor"] as? String {
            self.highlightedForegroundColorString = highlightedForegroundColorString
        }
        if let selectedForegroundColorString = data["selectedForegroundColor"] as? String {
            self.selectedForegroundColorString = selectedForegroundColorString
        }
        if let disabledForegroundColorString = data["disabledForegroundColor"] as? String {
            self.disabledForegroundColorString = disabledForegroundColorString
        }
        
        // Background colors
        if let backgroundColorString = data["backgroundColor"] as? String {
            self.backgroundColorString = backgroundColorString
        }
        if let highlightedBackgroundColorString = data["highlightedBackgroundColor"] as? String {
            self.highlightedBackgroundColorString = highlightedBackgroundColorString
        }
        if let selectedBackgroundColorString = data["selectedBackgroundColor"] as? String {
            self.selectedBackgroundColorString = selectedBackgroundColorString
        }
        if let disabledBackgroundColorString = data["disabledBackgroundColor"] as? String {
            self.disabledBackgroundColorString = disabledBackgroundColorString
        }
        
        // Border style
        if let borderWidth = data["borderWidth"] as? CGFloat {
            self.borderWidth = borderWidth
        }
        if let borderColorString = data["borderColor"] as? String {
            self.borderColorString = borderColorString
        }
        if let highlightedBorderColorString = data["highlightedBorderColor"] as? String {
            self.highlightedBorderColorString = highlightedBorderColorString
        }
        if let selectedBorderColorString = data["selectedBorderColor"] as? String {
            self.selectedBorderColorString = selectedBorderColorString
        }
        if let disabledBorderColorString = data["disabledBorderColor"] as? String {
            self.disabledBorderColorString = disabledBorderColorString
        }
        
        if let borderStyle = data["borderStyle"] as? String {
            switch borderStyle {
            case "none":
                self.borderStyle = .none
                
            case "line":
                self.borderStyle = .line
                
            case "bezel":
                self.borderStyle = .bezel
                
            case "roundedRect":
                self.borderStyle = .roundedRect
                
            default:
                break
                
            }
        }
        
        // Image tinting
        if let tintImageWithForegroundColor = data["tintImageWithForegroundColor"] as? Bool {
            self.tintImageWithForegroundColor = tintImageWithForegroundColor
        }
        
        // TableView style
        if let tableViewSeparatorStyleString = data["tableViewSeparatorStyle"] as? String {
            switch tableViewSeparatorStyleString {
            case "none":
                self.tableViewSeparatorStyle = .none
                
            case "singleLine":
                self.tableViewSeparatorStyle = .singleLine
                
            case "singleLineEtched":
                self.tableViewSeparatorStyle = .singleLineEtched
                
            default:
                break
            }
        }
        if let tableViewSeparatorColorString = data["tableViewSeparatorColor"] as? String {
            self.tableViewSeparatorColorString = tableViewSeparatorColorString
        }
        
        // Fonts
        if let font = self.parseFont(data: data, key: "font") {
            self.font = font
        }
        
        // Text
        if let fullUppercaseText = data["fullUppercaseText"] as? Bool {
            self.fullUppercaseText = fullUppercaseText
        }
        
        // CornerRadius
        if let cornerRadius = data["cornerRadius"] as? CGFloat {
            self.cornerRadius = cornerRadius
        }
        if let clipsToBounds = data["clipsToBounds"] as? Bool {
            self.clipsToBounds = clipsToBounds
        }
        
        // Styled text
        if let styledTextDictionary = data["styledTextAttributes"] as? [String:Any] {
            self.styledTextDictionary = styledTextDictionary
        }
    }
    
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------

    private func colorFromString(_ string:String?)->UIColor? {
        var color:UIColor?
        
        guard let string = string else {
            return nil
        }
        
        if let namedColor = Styles.shared.colorNamed(string) {
            color = namedColor
        } else {
            color = UIColor(hexString: string)
        }
        return color
    }
    
    private func stringAttributesFromDictionary(_ data:[String:Any]?)->[NSAttributedStringKey:Any]? {
        guard let data = data else {
            return nil
        }

        var attributes = [NSAttributedStringKey:Any]()
        
        var paragraphStyleNeeded = false
        let paragraphStyle = NSMutableParagraphStyle()

        // Line spacing
        if let lineSpacing = data["lineSpacing"] as? CGFloat {
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyleNeeded = true
        }
        
        // Line height multiple
        if let lineHeightMultiple = data["lineHeightMultiple"] as? CGFloat {
            paragraphStyle.lineHeightMultiple = lineHeightMultiple
            paragraphStyleNeeded = true
        }

        // Underline style
        if let underlineStyleString = data["underlineStyle"] as? String {
            let underlineStyle:Int
            switch underlineStyleString {
            case "byWord":
                underlineStyle = NSUnderlineStyle.byWord.rawValue
                
            case "patternDash":
                underlineStyle = NSUnderlineStyle.patternDash.rawValue
                
            case "patternDashDot":
                underlineStyle = NSUnderlineStyle.patternDashDot.rawValue
                
            case "patternDashDotDot":
                underlineStyle = NSUnderlineStyle.patternDashDotDot.rawValue
                
            case "patternDot":
                underlineStyle = NSUnderlineStyle.patternDot.rawValue
                
            case "double":
                underlineStyle = NSUnderlineStyle.styleDouble.rawValue
                
            case "single":
                underlineStyle = NSUnderlineStyle.styleSingle.rawValue
                
            case "thick":
                underlineStyle = NSUnderlineStyle.styleThick.rawValue

            case "none":
                fallthrough
            default:
                underlineStyle = NSUnderlineStyle.styleNone.rawValue
            }
            attributes[NSAttributedStringKey.underlineStyle] = underlineStyle
        }
        
        // Underline color
        if let underlineColorString = data["underlineColor"] as? String, let color = self.colorFromString(underlineColorString) {
            attributes[NSAttributedStringKey.underlineColor] = color
        }
        
        // Font
        if let font = self.parseFont(data: data, key: "font") {
            attributes[NSAttributedStringKey.font] = font
        }
        
        // ForegroundColor
        if let foregroundColorString = data["foregroundColor"] as? String, let color = self.colorFromString(foregroundColorString) {
            attributes[NSAttributedStringKey.foregroundColor] = color
        }
        
        // Kern
        if let kern = data["kern"] as? CGFloat {
            attributes[NSAttributedStringKey.kern] = kern
        }
        
        if paragraphStyleNeeded {
            attributes[NSAttributedStringKey.paragraphStyle] = paragraphStyle
        }
        
        return attributes
    }
    
    private func parseFont(data:[String:Any], key:String)->UIFont? {
        if let fontData = data[key] as? [String:Any] {
            if let name = fontData["name"] as? String ?? self.font?.fontName,
                let size = fontData["size"] as? CGFloat ?? self.font?.pointSize {
                switch name {
                case "systemFont":
                    return UIFont.systemFont(ofSize: size)
                    
                case "boldSystemFont":
                    return UIFont.boldSystemFont(ofSize: size)
                    
                case "italicSystemFont":
                    return UIFont.italicSystemFont(ofSize: size)
                    
                case "thinSystemFont":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.thin)
                    
                case "blackSystemFont":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.black)
                    
                case "heavySystemFont":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.heavy)
                    
                case "lightSystemFont":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.light)
                    
                case "mediumSystemFont":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
                    
                case "semiboldSystemFont":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.semibold)
                    
                case "ultraLightSystemFont":
                    return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.ultraLight)
                    
                default:
                    return UIFont(name: name, size: size)
                }
            }
        }
        return nil
    }
}

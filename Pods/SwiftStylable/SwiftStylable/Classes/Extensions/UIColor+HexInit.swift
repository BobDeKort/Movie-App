//
//  UIColor+HexInit.swift
//  YourLegalMatch
//
//  Created by Marcel Bloemendaal on 07/09/15.
//  Copyright © 2015 YipYip. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor
{
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	public convenience init?(hexString: String)
	{
        guard hexString.count > 3 && hexString.hasPrefix("#") else {
            return nil
        }
        
		var red:   CGFloat = 0.0
		var green: CGFloat = 0.0
		var blue:  CGFloat = 0.0
		var alpha: CGFloat = 1.0

        let index   = hexString.index(after: hexString.startIndex)
        let hex     = String(hexString[index...])
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        
        guard scanner.scanHexInt64(&hexValue) else {
            return nil
        }
        
        switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                return nil
            
        }
    
		self.init(red:red, green:green, blue:blue, alpha:alpha)
	}
}

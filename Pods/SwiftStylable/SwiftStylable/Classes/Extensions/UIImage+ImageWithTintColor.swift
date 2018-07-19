//
//  UIImage+Extension.swift
//  Genova Fashion App
//
//  Created by Marcel Bloemendaal on 06/01/15.
//  Copyright (c) 2015 Marcel Bloemendaal. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage
{
	public func imageWithTintColor(_ color: UIColor) -> UIImage
	{
		UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
		
		let context = UIGraphicsGetCurrentContext()!
		context.translateBy(x: 0, y: self.size.height)
		context.scaleBy(x: 1.0, y: -1.0)
		context.setBlendMode(CGBlendMode.normal)
		
		let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
		context.clip(to: rect, mask: self.cgImage!)
		color.setFill()
		context.fill(rect)
		
		let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
		UIGraphicsEndImageContext()
		
		return newImage
	}
}


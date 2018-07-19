//
//  Stylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 09/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation


public protocol Stylable : class {
	var styleName:String? { get set }
	var substyleName:String? { get set }
	
	func applyStyle(_ style:Style)
}

extension Stylable {
	public func updateStyles() {
		if let styleName = self.styleName, let style = Styles.shared.styleNamed(styleName) {
			self.applyStyle(style)
		}
		if let substyleName = self.substyleName, let substyle = Styles.shared.styleNamed(substyleName) {
			self.applyStyle(substyle)
		}
		
	}
}



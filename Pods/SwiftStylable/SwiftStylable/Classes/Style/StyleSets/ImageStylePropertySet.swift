//
//  ButtonStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class ImageStylePropertySet : StylePropertySet {
	
	private weak var _view: ImageStylable?
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	init(_ view: ImageStylable) {
		self._view = view
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Public methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	open func applyStyle(_ style:Style) {
		
		guard let view = self._view else {
			return
		}
		
		if let tintImageWithForegroundColor = style.tintImageWithForegroundColor {
			view.tintImageWithForegroundColor = tintImageWithForegroundColor
		}
	}
}

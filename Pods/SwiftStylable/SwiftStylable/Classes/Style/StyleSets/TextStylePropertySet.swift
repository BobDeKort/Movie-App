//
//  ButtonStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class TextStylePropertySet : StylePropertySet {
	
	private weak var _view: TextStylable?
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	init(_ view: TextStylable) {
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
		
		if let font = style.font {
			view.textFont = font
		}
		if let fullUppercaseText = style.fullUppercaseText {
			view.fullUppercaseText = fullUppercaseText
		}
	}
}

//
//  ButtonStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class BackgroundAndBorderStylePropertySet : StylePropertySet {
	
	private weak var _view: BackgroundAndBorderStylable?
	private var _canBeHighlighted:Bool
	private var _canBeSelected:Bool
	private var _canBeDisabled:Bool
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	init(_ view: BackgroundAndBorderStylable, canBeHighlighted:Bool = false, canBeSelected:Bool = false, canBeDisabled:Bool = false) {
		self._view = view
		self._canBeHighlighted = canBeHighlighted
		self._canBeSelected = canBeSelected
		self._canBeDisabled = canBeDisabled
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

		if let backgroundColor = style.backgroundColor {
			view.normalBackgroundColor = backgroundColor
		}
		if let borderWidth = style.borderWidth {
			view.layer.borderWidth = borderWidth
		}
		if let borderColor = style.borderColor {
			view.borderColor = borderColor
		}
		if let cornerRadius = style.cornerRadius {
			view.layer.cornerRadius = cornerRadius
		}
		if let clipsToBounds = style.clipsToBounds {
			view.clipsToBounds = clipsToBounds
		}
		
		if self._canBeHighlighted {
			if let highlightedBackgroundColor = style.highlightedBackgroundColor {
				view.highlightedBackgroundColor = highlightedBackgroundColor
			}
			if let highlightedBorderColor = style.highlightedBorderColor {
				view.highlightedBorderColor = highlightedBorderColor
			}
		}
		
		if self._canBeSelected {
			if let selectedBackgroundColor = style.selectedBackgroundColor {
				view.selectedBackgroundColor = selectedBackgroundColor
			}
			if let selectedBorderColor = style.selectedBorderColor {
				view.selectedBorderColor = selectedBorderColor
			}
		}
		
		if self._canBeDisabled {
			if let disabledBackgroundColor = style.disabledBackgroundColor {
				view.disabledBackgroundColor = disabledBackgroundColor
			}
			if let disabledBorderColor = style.disabledBorderColor {
				view.disabledBorderColor = disabledBorderColor
			}
		}
	}
}

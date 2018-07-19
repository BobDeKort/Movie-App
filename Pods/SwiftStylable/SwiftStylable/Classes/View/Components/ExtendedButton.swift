//
//  ExtendedButton.swift
//  YipYipSwift
//
//  Created by Marcel Bloemendaal on 08/01/15.
//  Copyright (c) 2015 Marcel Bloemendaal. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable open class ExtendedButton: UIButton {
	
	private var _normalBackgroundColor:UIColor?
	private var _highlightedBackgroundColor:UIColor?
	private var _selectedBackgroundColor:UIColor?
	private var _disabledBackgroundColor:UIColor?
	
	private var _normalBorderColor:UIColor?
	private var _highlightedBorderColor:UIColor?
	private var _selectedBorderColor:UIColor?
	private var _disabledBorderColor:UIColor?
	
	private var _normalTitle:String?
	private var _highlightedTitle:String?
	private var _selectedTitle:String?
	private var _disabledTitle:String?
	
	private var _customHorizontalTitleAlignment:UIControlContentHorizontalAlignment = .center
	private var _customVerticalTitleAlignment:UIControlContentVerticalAlignment = .center
	private var _customHorizontalImageAlignment:UIControlContentHorizontalAlignment = .center
	private var _customVerticalImageAlignment:UIControlContentVerticalAlignment = .center
	
	private var _defaultHorizontalContentAlignment = UIControlContentHorizontalAlignment.center
	private var _defaultVerticalContentAlignment = UIControlContentVerticalAlignment.center
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: - Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self._init()
	}
	
	public required override init(frame: CGRect) {
		super.init(frame: frame)
		
		self._init()
	}
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Properties
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	// -----------------------------------------------------------
	// MARK: -- Layout
	// -----------------------------------------------------------
	
	@IBInspectable override open var contentHorizontalAlignment: UIControlContentHorizontalAlignment {
		get {
			return super.contentHorizontalAlignment
		}
		set {
			self._defaultHorizontalContentAlignment = newValue
			if !self.customItemPlacement {
				super.contentHorizontalAlignment = newValue
			}
		}
	}
	
	@IBInspectable override open var contentVerticalAlignment: UIControlContentVerticalAlignment {
		get {
			return super.contentVerticalAlignment
		}
		set {
			self._defaultVerticalContentAlignment = newValue
			if !self.customItemPlacement {
				super.contentVerticalAlignment = newValue
			}
		}
	}
	
	@IBInspectable open var customItemPlacement:Bool = false {
		didSet {
			if self.customItemPlacement {
				super.contentHorizontalAlignment = .center
				super.contentVerticalAlignment = .center
			} else {
				self.contentHorizontalAlignment = self._defaultHorizontalContentAlignment
				self.contentVerticalAlignment = self._defaultVerticalContentAlignment
			}
		}
	}
	
	@IBInspectable open var titlePlacementIndex:Int = 4 {
		didSet {
			if self.titlePlacementIndex > -1 && self.titlePlacementIndex < 9 {
				switch self.titlePlacementIndex % 3 {
				case 0:
					self._customHorizontalTitleAlignment = .left
					
				case 2:
					self._customHorizontalTitleAlignment = .right
					
				default:
					self._customHorizontalTitleAlignment = .center
				}
				switch self.titlePlacementIndex / 3 {
				case 0:
					self._customVerticalTitleAlignment = .top
					
				case 2:
					self._customVerticalTitleAlignment = .bottom
					
				default:
					self._customVerticalTitleAlignment = .center
				}
				self.setNeedsLayout()
			} else {
				self._customHorizontalTitleAlignment = .center
				self._customVerticalTitleAlignment = .center
			}
		}
	}
	
	@IBInspectable open var imagePlacementIndex:Int = 4 {
		didSet {
			if self.imagePlacementIndex > -1 && self.imagePlacementIndex < 9 {
				switch self.imagePlacementIndex % 3 {
				case 0:
					self._customHorizontalImageAlignment = .left
					
				case 2:
					self._customHorizontalImageAlignment = .right
					
				default:
					self._customHorizontalImageAlignment = .center
				}
				switch self.imagePlacementIndex / 3 {
				case 0:
					self._customVerticalImageAlignment = .top
					
				case 2:
					self._customVerticalImageAlignment = .bottom
					
				default:
					self._customVerticalImageAlignment = .center
				}
				self.setNeedsLayout()
			} else {
				self._customHorizontalImageAlignment = .center
				self._customVerticalImageAlignment = .center
			}
		}
	}
	
	
	// -----------------------------------------------------------
	// MARK: -- States
	// -----------------------------------------------------------
	
	override open var isHighlighted:Bool {
		get	{
			return super.isHighlighted
		}
		set(value) {
			super.isHighlighted = value
			self.updateColors(updateImageTintColor: self.tintImageWithTitleColor)
		}
	}
	
	override open var isSelected:Bool {
		get	{
			return super.isSelected
		}
		set(value) {
			super.isSelected = value
			self.updateColors(updateImageTintColor: self.tintImageWithTitleColor)
		}
	}
	
	override open var isEnabled:Bool {
		get	{
			return super.isEnabled
		}
		set(value) {
			super.isEnabled = value
			self.updateColors(updateImageTintColor: self.tintImageWithTitleColor)
		}
	}
	
	@IBInspectable open var tintImageWithTitleColor:Bool = false {
		didSet {
			if self.tintImageWithTitleColor != oldValue {
				self.updateImageRenderingModeForState(UIControlState())
				self.updateImageRenderingModeForState(.highlighted)
				self.updateImageRenderingModeForState(.selected)
				self.updateImageRenderingModeForState(.disabled)
			}
			self.updateColors(updateImageTintColor: true)
		}
	}
	
	@IBInspectable open var fullUppercaseText:Bool = false {
		didSet {
			if self.fullUppercaseText != oldValue {
				super.setTitle(self.fullUppercaseText ? self._normalTitle?.uppercased() : self._normalTitle, for: .normal)
				super.setTitle(self.fullUppercaseText ? self._highlightedTitle?.uppercased() : self._highlightedTitle, for: .highlighted)
				super.setTitle(self.fullUppercaseText ? self._selectedTitle?.uppercased() : self._selectedTitle, for: .selected)
				super.setTitle(self.fullUppercaseText ? self._disabledTitle?.uppercased() : self._disabledTitle, for: .disabled)
			}
		}
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	open override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	// -----------------------------------------------------------
	//  UIButton overrides
	// -----------------------------------------------------------
	
	// -----------------------------------------------------------
	//  Extra state color properties
	// -----------------------------------------------------------
	
	open func setBackgroundColor(_ color:UIColor?, for state:UIControlState)
	{
		switch (state)
		{
		case UIControlState():
			_normalBackgroundColor = color
			
		case UIControlState.highlighted:
			_highlightedBackgroundColor = color
			
		case UIControlState.selected:
			_selectedBackgroundColor = color
			
		case UIControlState.disabled:
			_disabledBackgroundColor = color
			
		default:
			break;
		}
		self.updateColors(updateImageTintColor: false)
	}
	
	open func backgroundColor(for state:UIControlState)->UIColor? {
		var color:UIColor?
		
		switch (state)
		{
		case UIControlState():
			color = self._normalBackgroundColor
			
		case UIControlState.highlighted:
			color = self._highlightedBackgroundColor
			
		case UIControlState.selected:
			color = self._selectedBackgroundColor
			
		case UIControlState.disabled:
			color = self._disabledBackgroundColor
			
		default:
			color = nil
		}
		return color
	}
	
	open func setBorderColor(_ color:UIColor?, for state:UIControlState)
	{
		switch (state)
		{
		case UIControlState():
			_normalBorderColor = color
			break
			
		case UIControlState.highlighted:
			_highlightedBorderColor = color
			break
			
		case UIControlState.selected:
			_selectedBorderColor = color
			break
			
		case UIControlState.disabled:
			_disabledBorderColor = color
			break
			
		default:
			break
		}
		self.updateColors(updateImageTintColor: false)
	}
	
	open func borderColor(for state:UIControlState)->UIColor? {
		var color:UIColor?
		
		switch (state)
		{
		case UIControlState():
			color = self._normalBorderColor
			
		case UIControlState.highlighted:
			color = self._highlightedBorderColor
			
		case UIControlState.selected:
			color = self._selectedBorderColor
			
		case UIControlState.disabled:
			color = self._disabledBorderColor
			
		default:
			color = nil
		}
		return color
	}

	open override func setTitleColor(_ color: UIColor?, for state: UIControlState) {
		super.setTitleColor(color, for: state)
		self.updateColors(updateImageTintColor: self.tintImageWithTitleColor && self.state == state)
	}
	
	open override func setImage(_ image: UIImage?, for state: UIControlState) {
		super.setImage(image, for: state)
		self.updateImageRenderingModeForState(state)
		self.updateColors(updateImageTintColor: self.tintImageWithTitleColor)
	}
	
	open override func setTitle(_ title: String?, for state: UIControlState) {
		switch state {
		case UIControlState.normal:
			self._normalTitle = title
			super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
			
		case UIControlState.highlighted:
			self._highlightedTitle = title
			super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
			
		case UIControlState.selected:
			self._selectedTitle = title
			super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
			
		case UIControlState.disabled:
			self._disabledTitle = title
			super.setTitle(self.fullUppercaseText ? title?.uppercased() : title, for: state)
			
		default:
			super.setTitle(title, for: state)
		}
	}
	
	open override func title(for state: UIControlState)->String? {
		switch state {
		case UIControlState.normal:
			return self._normalTitle
			
		case UIControlState.highlighted:
			return self._highlightedTitle
			
		case UIControlState.selected:
			return self._selectedTitle
			
		case UIControlState.disabled:
			return self._disabledTitle
			
		default:
			return super.title(for: state)
		}
	}
	
	// -----------------------------------------------------------
	// MARK: -- Layout methods
	// -----------------------------------------------------------
	
	open override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
		if self.customItemPlacement {
			let titleSize = super.titleRect(forContentRect: CGRect(x: 0.0, y: 0.0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).size
			var x:CGFloat = 0.0
			var y:CGFloat = 0.0
			let width:CGFloat = min(titleSize.width, contentRect.width)
			let height:CGFloat = min(titleSize.height, contentRect.height)
			switch self._customHorizontalTitleAlignment {
			case .left:
				x = contentRect.minX
				
			case .right:
				x = contentRect.maxX - width
				
			default:
				// Center
				x = contentRect.midX - width * 0.5
			}
			switch self._customVerticalTitleAlignment {
			case .top:
				y = contentRect.minY
				
			case .bottom:
				y = contentRect.maxY - height
				
			default:
				// Center
				y = contentRect.midY - height * 0.5
			}
			
			return CGRect(x: x,
						  y: y,
						  width: width,
						  height: height)
			
		} else {
			return super.titleRect(forContentRect: contentRect)
		}
	}
	
	open override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
		if self.customItemPlacement {
			let imageSize = super.imageRect(forContentRect: CGRect(x: 0.0, y: 0.0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).size
			var x:CGFloat = 0.0
			var y:CGFloat = 0.0
			let width:CGFloat = min(imageSize.width, contentRect.width)
			let height:CGFloat = min(imageSize.height, contentRect.height)
			switch self._customHorizontalImageAlignment {
			case .left:
				x = contentRect.minX
				
			case .right:
				x = contentRect.maxX - width
				
			default:
				// Center
				x = contentRect.midX - width * 0.5
			}
			switch self._customVerticalImageAlignment {
			case .top:
				y = contentRect.minY
				
			case .bottom:
				y = contentRect.maxY - height
				
			default:
				// Center
				y = contentRect.midY - height * 0.5
			}
			
			return CGRect(x: x,
						  y: y,
						  width: width,
						  height: height)
			
		} else {
			return super.imageRect(forContentRect: contentRect)
		}
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Private methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	private func _init() {
		self._normalTitle = super.title(for: .normal)
		self._highlightedTitle = super.title(for: .highlighted)
		self._selectedTitle = super.title(for: .selected)
		self._disabledTitle = super.title(for: .disabled)
		
		self._defaultHorizontalContentAlignment = self.contentHorizontalAlignment
		self._defaultVerticalContentAlignment = self.contentVerticalAlignment
	}
	
	private func updateColors(updateImageTintColor:Bool)
	{
		if self.isEnabled
		{
			if (self.isHighlighted)
			{
				self.backgroundColor = self._highlightedBackgroundColor ?? self._normalBackgroundColor
				self.layer.borderColor = self._highlightedBorderColor?.cgColor ?? (self._normalBorderColor ?? UIColor.clear).cgColor
				if updateImageTintColor, let imageView = self.imageView, imageView.image != nil {
					imageView.tintColor = self.titleColor(for: .highlighted)
				}
			}
			else if (self.isSelected)
			{
				self.backgroundColor = self._selectedBackgroundColor ?? self._normalBackgroundColor
				self.layer.borderColor = self._selectedBorderColor?.cgColor ?? (self._normalBorderColor ?? UIColor.clear).cgColor
				if updateImageTintColor, let imageView = self.imageView, imageView.image != nil {
					imageView.tintColor = self.titleColor(for: .selected)
				}
			}
			else
			{
				self.backgroundColor = self._normalBackgroundColor
				self.layer.borderColor = (self._normalBorderColor ?? UIColor.clear).cgColor
				if updateImageTintColor, let imageView = self.imageView, imageView.image != nil {
					imageView.tintColor = self.titleColor(for: UIControlState())
				}
			}
		}
		else
		{
			self.backgroundColor = self._disabledBackgroundColor ?? self._normalBackgroundColor
			self.layer.borderColor = self._disabledBorderColor?.cgColor ?? (self._normalBorderColor ?? UIColor.clear).cgColor
			if updateImageTintColor, let imageView = self.imageView, imageView.image != nil {
				imageView.tintColor = self.titleColor(for: .disabled)
			}
		}
	}
	
	private func updateImageRenderingModeForState(_ state:UIControlState) {
		let renderingMode = self.tintImageWithTitleColor ? UIImageRenderingMode.alwaysTemplate : UIImageRenderingMode.alwaysOriginal
		if let image = self.image(for: state), image.renderingMode != renderingMode {
			super.setImage(image.withRenderingMode(renderingMode), for: state)
		}
	}
}


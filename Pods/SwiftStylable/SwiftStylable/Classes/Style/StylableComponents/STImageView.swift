//
//  STImageView.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable open class STImageView : UIImageView, Stylable, BackgroundAndBorderStylable, ForegroundStylable, ImageStylable {

	private var _stComponentHelper: STComponentHelper!
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: - Initializers & deinit
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setUpSTComponentHelper()
	}
	
	override public init(frame: CGRect) {
		super.init(frame: frame)
		self.setUpSTComponentHelper()
	}
	
	public override init(image: UIImage?) {
		super.init(image: image)
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Computed properties
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	@IBInspectable open var styleName:String? {
		set {
			self._stComponentHelper.styleName = newValue
		}
		get {
			return self._stComponentHelper.styleName
		}
	}
	
	@IBInspectable open var substyleName:String? {
		set {
			self._stComponentHelper.substyleName = newValue
		}
		get {
			return self._stComponentHelper.substyleName
		}
	}
	
	@IBInspectable open var imageName:String? {
        didSet {
            if let imageName = self.imageName {
                self.image = self.paintCodeImageNamed(imageName)
            } else {
                self.image = nil
            }
        }
    }
	
	@IBInspectable open var tintImageWithForegroundColor = false {
		didSet {
			if self.tintImageWithForegroundColor != oldValue {
				self.updateImageRenderingMode()
			}
		}
	}
	
	open override var image: UIImage? {
		didSet {
			self.updateImageRenderingMode()
		}
	}
	
	var foregroundColor: UIColor? {
		set {
			self.tintColor = newValue
		}
		get {
			return self.tintColor
		}
	}
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Public methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	open func applyStyle(_ style:Style) {
		self._stComponentHelper.applyStyle(style)
	}
    
    open func paintCodeImageNamed(_ name:String)->UIImage? {
        return nil
    }
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Private methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	private func updateImageRenderingMode() {
		if let image = self.image {
			let renderingMode = self.tintImageWithForegroundColor ? UIImageRenderingMode.alwaysTemplate : UIImageRenderingMode.alwaysOriginal
			super.image = image.withRenderingMode(renderingMode)
		}
	}
	
	private func setUpSTComponentHelper() {
		self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
			BackgroundAndBorderStylePropertySet(self),
			ForegroundStylePropertySet(self),
			ImageStylePropertySet(self)
		])
	}
}

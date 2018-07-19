//
//  STHorizontalHairline.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 27/02/2017.
//
//

import Foundation
import UIKit


@IBDesignable class STHorizontalHairline : UIView, Stylable, BackgroundAndBorderStylable {
	
	private var _stComponentHelper: STComponentHelper!
	
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
		self.setupSTComponentHelper()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
		self.setupSTComponentHelper()
    }
	
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------

    override var intrinsicContentSize:CGSize {
        get {
            return CGSize(width: 1.0, height: CGFloat(1.0 / UIScreen.main.nativeScale))
        }
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return CGSize(width: targetSize.width, height: CGFloat(1.0 / UIScreen.main.nativeScale))
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return CGSize(width: targetSize.width, height: CGFloat(1.0 / UIScreen.main.nativeScale))
    }
    
	@IBInspectable open var styleName:String? {
		didSet {
			self.updateStyles()
		}
	}
	
	@IBInspectable open var substyleName:String? {
		didSet {
			self.updateStyles()
		}
	}
	
        
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
		self._stComponentHelper.applyStyle(style)
    }
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Private methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	private func setupSTComponentHelper() {
		self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
			BackgroundAndBorderStylePropertySet(self)
		])
	}

}

//
//  STView.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable open class STView : UIView, Stylable, BackgroundAndBorderStylable {
	
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
	
    
   // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
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
		
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public methods
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
	
	private func setUpSTComponentHelper() {
		self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
			BackgroundAndBorderStylePropertySet(self)
		])
	}
}

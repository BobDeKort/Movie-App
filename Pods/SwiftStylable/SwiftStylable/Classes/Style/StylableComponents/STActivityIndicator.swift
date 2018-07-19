//
//  STActivityIndicator.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 31/08/16.
//
//

import Foundation
import UIKit

@IBDesignable open class STActivityIndicator : UIActivityIndicatorView, Stylable {
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STActivityIndicator.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(STActivityIndicator.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Computed properties
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
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
    // MARK: - Public methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        self.color = style.foregroundColor
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Internal methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
	@objc func stylesDidUpdate(_ notification:Notification) {
		self.updateStyles()
	}
}

//
//  STLabel.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class STLabel : UILabel, Stylable, BackgroundAndBorderStylable, ForegroundStylable, TextStylable, StyledTextStylable {
	
	private var _stComponentHelper: STComponentHelper!
	private var _text:String?
    private var _styledText:String?

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
		self._text = super.text
		self.setUpSTComponentHelper()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
		self._text = super.text
		self.setUpSTComponentHelper()
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
	
	open override var text: String? {
		set {
            self._text = newValue
            super.text = self.fullUppercaseText ? newValue?.uppercased() : newValue
            self._styledText = nil
		}
		get {
            return self._text
		}
	}
    
    open override var attributedText: NSAttributedString? {
        didSet {
            self._styledText = nil
        }
    }
	
	open var fullUppercaseText = false {
		didSet {
			self.text = self._text
		}
	}
	
	var foregroundColor: UIColor? {
		set {
			self.textColor = newValue ?? UIColor.black
		}
		get {
			return self.textColor
		}
	}
    
    var textFont: UIFont? {
        set {
            if let font = newValue {
                self.font = font
            }
        }
        get {
            return self.font
        }
    }
    
    var styledTextAttributes:[NSAttributedStringKey:Any]? {
        didSet {
            if self._styledText != nil {
                self.styledText = self._styledText
            }
        }
    }

    @IBInspectable open var styledText:String? {
        set {
            self._styledText = newValue
            self._text = newValue
            if let text = newValue {
                super.attributedText = NSAttributedString(string: text, attributes: self.styledTextAttributes ?? [NSAttributedStringKey:Any]())
            }
        }
        get {
            return self._styledText
        }
    }

    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Public properties
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
			BackgroundAndBorderStylePropertySet(self),
			ForegroundStylePropertySet(self),
			TextStylePropertySet(self),
            StyledTextStylePropertySet(self)
		])
	}

}

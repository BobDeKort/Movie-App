//
//  STTextView.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 08/05/2017.
//
//

import Foundation
import UIKit


//
//  STLabel.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class STTextView : UITextView, Stylable, BackgroundAndBorderStylable, ForegroundStylable, TextStylable, StyledTextStylable {

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
    
    override public init(frame: CGRect, textContainer:NSTextContainer?) {
        super.init(frame: frame, textContainer: nil)
        
        self._text = super.text
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
            self.font = font
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

    open var fullUppercaseText = false {
        didSet {
            self.text = self._text
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
        if let font = style.font {
            self.font = font
        }
        if let foregroundColor = style.foregroundColor {
            self.textColor = foregroundColor
        }
        if let fullUppercaseText = style.fullUppercaseText {
            self.fullUppercaseText = fullUppercaseText
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
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

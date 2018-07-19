//
//  STTextField.swift
//  Pods
//
//  Created by Marcel Bloemendaal on 24/08/16.
//
//

import Foundation
import UIKit

@IBDesignable open class STTextField : UITextField, Stylable, BackgroundAndBorderStylable, TextBorderStylable {
    
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
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func setUpSTComponentHelper() {
        self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
            BackgroundAndBorderStylePropertySet(self),
            TextBorderStylePropertySet(self)
        ])
    }
}

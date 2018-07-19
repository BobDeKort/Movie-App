//
//  ButtonStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class TextBorderStylePropertySet : StylePropertySet {
    
    private weak var _view: TextBorderStylable?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    init(_ view: TextBorderStylable) {
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
        
        if let borderStyle = style.borderStyle {
            view.layer.masksToBounds = true
            view.borderStyle = borderStyle
        }
    }
}

//
//  ButtonStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class StyledTextStylePropertySet : StylePropertySet {
    
    private weak var _view: StyledTextStylable?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    init(_ view: StyledTextStylable) {
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
        
        if let styledTextAttributes = style.styledTextAttributes {
            view.styledTextAttributes = styledTextAttributes
        }
    }
}

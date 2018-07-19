//
//  ButtonStyleSet.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class TableViewSeparatorStylePropertySet : StylePropertySet {
    
    private weak var _view: TableViewSeparatorStylable?
    
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: Initializers
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    init(_ view: TableViewSeparatorStylable) {
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
        
        if let tableViewSeparatorStyle = style.tableViewSeparatorStyle {
            view.separatorStyle = tableViewSeparatorStyle
        }
        if let tableViewSeparatorColor = style.tableViewSeparatorColor {
            view.separatorColor = tableViewSeparatorColor
        }
    }
}

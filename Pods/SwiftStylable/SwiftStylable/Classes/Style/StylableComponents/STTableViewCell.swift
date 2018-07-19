//
//  STTableViewCell.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 10/08/16.
//  Copyright © 2016 YipYip. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable open class STTableViewCell : UITableViewCell, Stylable, BackgroundAndBorderStylable
{
    private var _stComponentHelper: STComponentHelper!
    
    private var _selected = false
    private var _highlighted = false
	
	private var _backgroundColor = UIColor.white
	private var _borderColor:UIColor = UIColor.clear
	private var _highlightedBackgroundColor:UIColor?
	private var _highlightedBorderColor:UIColor?
	private var _selectedBackgroundColor:UIColor?
	private var _selectedBorderColor:UIColor?
	
	
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Initializers & deinit
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    
    // -----------------------------------------------------------
    // -- TableViewCell overrides
    // -----------------------------------------------------------
	
    override open func setSelected(_ selected: Bool, animated: Bool) {
        self._selected = selected
		if self.styleName != nil {
            self.updateColors()
        } else {
            super.setSelected(selected, animated: animated)
        }
    }
    
    override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self._highlighted = highlighted
		if self.styleName != nil {
            self.updateColors()
        } else {
            super.setHighlighted(highlighted, animated: animated)
        }
    }
    
    // -----------------------------------------------------------
    // -- Stylable implementation
    // -----------------------------------------------------------
    
    open func applyStyle(_ style:Style) {
        self._stComponentHelper.applyStyle(style)
		self.updateColors()
    }
	
    
    // -----------------------------------------------------------------------------------------------------------------------
    //
    // MARK: - Private methods
    //
    // -----------------------------------------------------------------------------------------------------------------------
    
    private func setUpSTComponentHelper() {
        self._stComponentHelper = STComponentHelper(stylable: self, stylePropertySets: [
            BackgroundAndBorderStylePropertySet(self, canBeHighlighted: true, canBeSelected: true)
        ])
    }
    
    private func updateColors() {
        if self._highlighted {
            self.backgroundColor = self._highlightedBackgroundColor ?? self._backgroundColor
            self.layer.borderColor = self._highlightedBorderColor?.cgColor ?? self._borderColor.cgColor
        } else if self._selected {
            self.backgroundColor = self._selectedBackgroundColor ?? self._backgroundColor
            self.layer.borderColor = self._selectedBorderColor?.cgColor ?? self._borderColor.cgColor
        } else {
            self.backgroundColor = self._backgroundColor
            self.layer.borderColor = self._borderColor.cgColor
        }
    }
}

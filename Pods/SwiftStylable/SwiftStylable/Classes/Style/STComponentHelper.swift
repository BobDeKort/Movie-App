//
//  STComponentHelper.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

class STComponentHelper {
    private weak var _stylable:Stylable?
	private let _stylePropertySets:[StylePropertySet]
	
	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Initializers
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
    init(stylable: Stylable, stylePropertySets: [StylePropertySet]) {
        self._stylable = stylable
		self._stylePropertySets = stylePropertySets
		
		NotificationCenter.default.addObserver(self, selector: #selector(STComponentHelper.stylesDidUpdate(_:)), name: STYLES_DID_UPDATE, object: nil)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	
	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Properties
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	var styleName:String? {
		didSet {
			if self.styleName != oldValue {
				self.updateStyles()
			}
		}
	}
	
	var substyleName:String? {
		didSet {
			if self.substyleName != oldValue {
				self.updateStyles()
			}
		}
	}
	

	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Public methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	

	func applyStyle(_ style: Style) {
		for stylePropertySet in self._stylePropertySets {
			stylePropertySet.applyStyle(style)
		}
	}
	
	// -----------------------------------------------------------
	// MARK: -- Notifications
	// -----------------------------------------------------------
	
	@objc func stylesDidUpdate(_ notification:Notification) {
        self._stylable?.updateStyles()
	}
	

	// -----------------------------------------------------------------------------------------------------------------------
	//
	// MARK: Private methods
	//
	// -----------------------------------------------------------------------------------------------------------------------
	
	private func updateStyles() {
		if let styleName = self.styleName, let style = Styles.shared.styleNamed(styleName) {
			self.applyStyle(style)
		}
		if let substyleName = self.substyleName, let substyle = Styles.shared.styleNamed(substyleName) {
			self.applyStyle(substyle)
		}
	}
}

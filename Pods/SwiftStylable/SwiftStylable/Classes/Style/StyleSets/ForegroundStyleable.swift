//
//  ForegroundStyleable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

protocol ForegroundStylable : class {
	var foregroundColor: UIColor? { get set }
	var highlightedForegroundColor: UIColor? { get set }
	var selectedForegroundColor: UIColor? { get set }
	var disabledForegroundColor: UIColor? { get set }
}

extension ForegroundStylable {
	var highlightedForegroundColor: UIColor? {
		get {
			return nil
		}
		set {
			
		}
	}
	var selectedForegroundColor: UIColor? {
		get {
			return nil
		}
		set {
			
		}
	}
	var disabledForegroundColor: UIColor? {
		get {
			return nil
		}
		set {
			
		}
	}
}

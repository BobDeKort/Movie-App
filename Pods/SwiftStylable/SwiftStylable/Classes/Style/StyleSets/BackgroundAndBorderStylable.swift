//
//  BackgroundStylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation

protocol BackgroundAndBorderStylable : class {
	var backgroundColor: UIColor? { get set }
    var normalBackgroundColor:UIColor? { get set }
	var highlightedBackgroundColor: UIColor? { get set }
	var selectedBackgroundColor: UIColor? { get set }
	var disabledBackgroundColor: UIColor? { get set }
	var borderColor: UIColor? { get set }
	var highlightedBorderColor: UIColor? { get set }
	var selectedBorderColor: UIColor? { get set }
	var disabledBorderColor: UIColor? { get set }
	var layer: CALayer { get }
	var clipsToBounds: Bool { get set }
}

extension BackgroundAndBorderStylable {
    
    /*
    Instead of the plain 'backgroundColor' property, this style component sets the 'normalBackgroundColor' property instead.
    This extension provides a default implementation that links it directly to 'backgroundColor', but this can be overridden.
    The reason for this is to avoid problems with classes implementing different background states, where the backgroundColor
    property should not be used directly, but functions like setBackgroundColor(for:) should be used. Such classes can now
    simply override the normalBackgroundColor property.
    */
    
    var normalBackgroundColor: UIColor? {
        get {
            return self.backgroundColor
        }
        set {
            self.backgroundColor = newValue
        }
    }
    
	var highlightedBackgroundColor: UIColor? {
		get {
			return nil
		}
		set {
			
		}
	}
	var selectedBackgroundColor: UIColor? {
		get {
			return nil
		}
		set {
			
		}
	}
	var disabledBackgroundColor: UIColor? {
		get {
			return nil
		}
		set {
			
		}
	}

	var highlightedBorderColor: UIColor? {
		get {
			return nil
		}
		set {
			
		}
	}
	
	var borderColor: UIColor? {
		get {
			var color:UIColor?
			if let cgColor = self.layer.borderColor {
				color = UIColor(cgColor: cgColor)
			}
			return color
		}
		set {
			self.layer.borderColor = newValue?.cgColor
		}
	}

	var selectedBorderColor: UIColor? {
		get {
			return nil
		}
		set {
			
		}
	}
	var disabledBorderColor: UIColor? {
		get {
			return nil
		}
		set {
			
		}
	}
}

//
//  ButtonStylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 17/04/2018.
//

import Foundation


protocol ButtonTextStylable : AnyObject {
	var titleLabel:UILabel? { get }
	var fullUppercaseText:Bool { get set }
}

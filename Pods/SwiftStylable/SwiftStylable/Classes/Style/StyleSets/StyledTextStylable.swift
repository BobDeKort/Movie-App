//
//  StyledTextStylable.swift
//  SwiftStylable
//
//  Created by Marcel Bloemendaal on 19/04/2018.
//

import Foundation

protocol StyledTextStylable : class {
    var styledTextAttributes:[NSAttributedStringKey:Any]? { get set }
}

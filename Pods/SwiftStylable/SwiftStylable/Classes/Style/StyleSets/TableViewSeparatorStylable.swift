//
//  SeparatorStylable.swift
//  Pods-SwiftStylableExample
//
//  Created by Marcel Bloemendaal on 19/04/2018.
//

import Foundation

protocol TableViewSeparatorStylable : class {
    var separatorColor: UIColor? { get set }
    var separatorStyle: UITableViewCellSeparatorStyle { get set }
}

//
//  UIView+DropShadow.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/19/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addDropShadow(color: UIColor = .darkGray, opacity: Float = 1, offSet: CGSize = CGSize(width: 1, height: 1), radius: CGFloat = 3, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

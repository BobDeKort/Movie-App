//
//  FavoritesDataSource.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/19/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class FavoritesDataSource: NSObject, UITableViewDataSource {
    var viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRect.zero)
        return cell
    }
}

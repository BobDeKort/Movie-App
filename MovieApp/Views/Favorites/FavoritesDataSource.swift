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
    private let viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesViewModel.favoritesCellId, for: indexPath) as! MovieTableViewCell
        
        if let vm = self.viewModel.cellViewModelFor(indexPath: indexPath) {
            cell.configure(viewModel: vm)
        }
        
        return cell
    }
}

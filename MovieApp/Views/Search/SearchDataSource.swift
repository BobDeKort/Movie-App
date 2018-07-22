//
//  SearchDataSource.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class SearchDataSource: NSObject, UITableViewDataSource {
    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCellViewModel.movieCellId, for: indexPath) as! MovieTableViewCell
        if let vm = self.viewModel.cellViewModelFor(indexPath: indexPath) {
            cell.configure(viewModel: vm)
        }
    
        return cell
    }
}

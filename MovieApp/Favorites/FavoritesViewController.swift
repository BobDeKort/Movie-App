//
//  FavoritesViewController
//  MovieApp
//
//  Created by Bob De Kort on 7/19/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController, UISearchResultsUpdating {
    
    private let viewModel = FavoritesViewModel()
    private var searchButton: UIBarButtonItem!
    
    // ----------------------------------------
    // MARK: Lifecycle methods
    // ----------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.pageTitle
        
        // TableView setup
        self.tableView.delegate = self
        self.tableView.dataSource = FavoritesDataSource(viewModel: self.viewModel)
        
        // SearchButton setup
        searchButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(searchAction))
        navigationItem.rightBarButtonItem = searchButton
        
        // SearchController setup
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search

    }
    
    // ----------------------------------------
    // MARK: User interactions methods
    // ----------------------------------------
    
    @objc private func searchAction(_ sender: UIBarButtonItem) {
        print("search")
        // TODO: REMOVE - Testing functionality
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController")
        self.present(vc, animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("search results")
    }
}


//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate {
    
    // ----------------------------------------
    // MARK: IBOutlets
    // ----------------------------------------
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    
    // ----------------------------------------
    // MARK: Variables
    // ----------------------------------------
    
    private let viewModel = SearchViewModel()
    private var datasource: SearchDataSource?
    
    // ----------------------------------------
    // MARK: Lifecylce methods
    // ----------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Main setup
        self.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.datasource = SearchDataSource(viewModel: self.viewModel)
        
        // SearchController setup
        self.searchBar.delegate = self
        self.searchBar.becomeFirstResponder()
        
        // Results tableview setup
        self.resultsTableView.delegate = self
        self.resultsTableView.dataSource = self.datasource
        self.resultsTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: MovieCellViewModel.movieCellId)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resultsDidChange), name: SearchViewModel.searchResultsDidChange, object: self.viewModel)
        
    }
    
    @objc private func resultsDidChange() {
        if !self.viewModel.isPageRefreshing {
            if Thread.isMainThread {
                self.resultsTableView.reloadData()
            } else {
                DispatchQueue.main.sync {
                    self.resultsTableView.reloadData()
                }
            }
        }
    }
    
    // ----------------------------------------
    // MARK: Search bar Delegate methods
    // ----------------------------------------
    
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            self.viewModel.getResults(query: text, isNextPage: false)
        }
    }
    
    // -------------------------------------------------
    // MARK: Table view + Scroll view delegate methods
    // -------------------------------------------------
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.resultsTableView.deselectRow(at: indexPath, animated: true)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        vc.viewModel = self.viewModel.detailViewModelFor(indexPath: indexPath)
        self.present(vc, animated: true, completion: nil)
    }
    
    internal func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if resultsTableView.contentOffset.y >= resultsTableView.contentSize.height - resultsTableView.bounds.height {
            if !self.viewModel.isPageRefreshing {
                print("VC Movie count \(self.viewModel.numberOfMovies)")
                self.viewModel.isPageRefreshing = true
                self.viewModel.getNextResults()
            }
        }
    }
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

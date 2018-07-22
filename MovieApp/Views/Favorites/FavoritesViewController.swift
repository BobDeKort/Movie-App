//
//  FavoritesViewController
//  MovieApp
//
//  Created by Bob De Kort on 7/19/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = FavoritesViewModel()
    private var datasource: FavoritesDataSource?
    private let genresController = GenresController()
    private var addButton: UIBarButtonItem!
    
    public var refreshControl = UIRefreshControl()
    
    // ----------------------------------------
    // MARK: Lifecycle methods
    // ----------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.pageTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // TableView setup
        self.tableView.delegate = self
        self.datasource = FavoritesDataSource(viewModel: self.viewModel)
        self.tableView.dataSource = self.datasource
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: FavoritesViewModel.favoritesCellId)
        
        // AddButton setup
        self.addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        self.navigationItem.rightBarButtonItem = addButton
        
        // Refresh control setup
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
        self.tableView.refreshControl = refreshControl
        
         NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: FavoritesViewModel.favoritesDidChange, object: self.viewModel)
    }
    
    @objc private func refresh() {
        self.tableView.reloadData()
    }
    
    // ----------------------------------------
    // MARK: User interactions methods
    // ----------------------------------------
    
    @objc private func addAction(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "searchViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        vc.viewModel = self.viewModel.detailViewModelFor(indexPath: indexPath)
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.numberOfMovies - 1 {
            self.refreshControl.endRefreshing()
        }
    }
}


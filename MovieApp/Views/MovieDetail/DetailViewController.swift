//
//  DetailViewController
//  MovieApp
//
//  Created by Bob De Kort on 7/19/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit
import SwiftStylable
import Cosmos

class DetailViewController: UIViewController {
    
    // ----------------------------------------
    // MARK: Stored properties
    // ----------------------------------------
    
    var viewModel: DetailViewModel!
    
    // ----------------------------------------
    // MARK: IBOutlets
    // ----------------------------------------
    
    // - Backdrop
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var backdropShadingImageView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    //  - Main scroll view
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var runtimeLabel: STLabel!
    @IBOutlet weak var genresLabel: STLabel!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var titleLabel: STLabel!
    @IBOutlet weak var overviewLabel: STLabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // ----------------------------------------
    // MARK: Lifecycle methods
    // ----------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Scroll view setup
        self.scrollView.addDropShadow()
        
        // Container view setup
        self.containerView.layer.cornerRadius = 8
        
        // Poster image setup
        self.posterImageView.addDropShadow()
        
        // Favorites button setup
        self.favoriteButton.setImage(UIImage(named: "like"), for: .normal)
        self.favoriteButton.setImage(UIImage(named: "liked"), for: .selected)
        self.favoriteButton.isSelected = self.viewModel.isFavorited
        
        self.configure()
    }
    
    // ----------------------------------------
    // MARK: Configuration
    // ----------------------------------------
    
    private func configure() {
        if let posterPath = self.viewModel.posterPath {
            self.setImageWith(path: posterPath, type: .poster)
        }
        if let backdropPath = self.viewModel.backdropPath {
            self.setImageWith(path: backdropPath, type: .backdrop)
        }
        if let runtime = self.viewModel.runtime {
            self.runtimeLabel.text = String(runtime)
        }
        
        // TODO: genres
        
        self.starRatingView.rating = self.viewModel.rating
        self.titleLabel.text = self.viewModel.title
        self.overviewLabel.text = self.viewModel.overview
    }
    
    private func setImageWith(path: String, type: Imagetype) {
        NetworkController.shared.getImageFrom(path: path, type: type) { (result) in
            switch result {
            case let .success(image):
                switch type {
                case .backdrop:
                    DispatchQueue.main.sync {
                        self.backdropImageView.image = image
                    }
                case .poster:
                    DispatchQueue.main.sync {
                        self.posterImageView.image = image
                    }
                }
            case let .failure(type):
                // TODO: handle errors
                print("ERROR: \(type)")
            }
        }
    }
    
    // ----------------------------------------
    // MARK: User interaction methods
    // ----------------------------------------
    
    @IBAction func toggleFavorites(_ sender: Any) {
        if self.viewModel.isFavorited {
            FavoritesController.shared.removeFavorite(self.viewModel.id)
            self.favoriteButton.isSelected = false
        } else {
            FavoritesController.shared.addFavorite(self.viewModel.id)
            self.favoriteButton.isSelected = true
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


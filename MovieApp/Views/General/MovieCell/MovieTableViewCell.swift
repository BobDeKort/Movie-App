//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Bob De Kort on 7/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit
import Cosmos

class MovieTableViewCell: UITableViewCell {
    
    // ----------------------------------------------------
    // MARK: - IBOutlets
    // ----------------------------------------------------
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    
    // ----------------------------------------------------
    // MARK: - Stored properties
    // ----------------------------------------------------
    
    private var viewModel: MovieCellViewModel!
    
    // ----------------------------------------------------
    // MARK: - Configuration
    // ----------------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(viewModel: MovieCellViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = self.viewModel.title
        self.ratingView.rating = self.viewModel.rating
        
        // Favorited button setup
        self.favoriteButton.setImage(UIImage(named: "like"), for: .normal)
        self.favoriteButton.setImage(UIImage(named: "liked"), for: .selected)
        self.favoriteButton.isSelected = self.viewModel.isFavorited
        
        // Poster image setup
        if let posterPath = self.viewModel.posterPath {
            self.setImageWith(path: posterPath)
        } else {
            self.setDefaultImage()
        }
    }
    
    // ----------------------------------------------------
    // MARK: - User interaction methods
    // ----------------------------------------------------
    
    @IBAction func favoriteAction(_ sender: Any) {
        if self.viewModel.isFavorited {
            FavoritesController.shared.removeFavorite(self.viewModel.id)
            self.favoriteButton.isSelected = false
        } else {
            FavoritesController.shared.addFavorite(self.viewModel.id)
            self.favoriteButton.isSelected = true
        }
    }
    
    // ----------------------------------------------------
    // MARK: - Private methods
    // ----------------------------------------------------
    
    private func setImageWith(path: String) {
        NetworkController.shared.getImageFrom(path: path, type: .poster) { (result) in
            switch result {
            case let .success(image):
                DispatchQueue.main.sync {
                    self.posterImageView.image = image
                }
            case let .failure(type):
                // TODO: Show error
                print("ERROR: \(type)")
                self.setDefaultImage()
            }
        }
    }
    
    private func setDefaultImage() {
        // TODO: set default image
    }
    
    override func prepareForReuse() {
        // Reseting field so there are no trails of reuse
        self.posterImageView.image = nil
        self.titleLabel.text = nil
        self.ratingView.rating = 0
        self.favoriteButton.isSelected = false
    }
}

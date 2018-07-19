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
    
    private let viewModel = DetailViewModel()
    
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
    }
    
    // ----------------------------------------
    // MARK: User interaction methods
    // ----------------------------------------
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


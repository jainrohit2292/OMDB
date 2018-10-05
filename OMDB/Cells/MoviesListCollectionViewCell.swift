//
//  MoviesListCollectionViewCell.swift
//  OMDB
//
//  Created by Rohit Jain on 04/10/18.
//  Copyright © 2018 Rohit Jain. All rights reserved.
//

import UIKit
import SDWebImage

class MoviesListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        // Initialization code
    }
    
    func configureCell(model: MoviesArrayDataModel) {
        self.movieTitle.text = model.Title
        self.releaseDate.text = DateUtil.getMovieReleaseDate(movieYear: model.Year!)
        self.moviePoster.sd_setImage(with: URL(string: model.Poster!), completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.moviePoster.image = nil
        self.movieTitle.text = ""
        self.releaseDate.text = ""
    }

}

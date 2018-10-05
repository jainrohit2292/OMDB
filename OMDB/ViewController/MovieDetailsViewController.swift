//
//  MovieDetailsViewController.swift
//  OMDB
//
//  Created by Rohit Jain on 04/10/18.
//  Copyright © 2018 Rohit Jain. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    var movie:MoviesArrayDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        if let movieData = self.movie {
            self.title = movieData.Title
            self.movieTitle.text = movieData.Title
            self.releaseDate.text = DateUtil.getMovieReleaseDate(movieYear: movieData.Year!)
            self.typeLabel.text = movieData.DataType
            self.moviePoster.sd_setImage(with: URL(string: movieData.Poster!), completed: nil)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

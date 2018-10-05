//
//  MoviesListViewController.swift
//  OMDB
//
//  Created by Rohit Jain on 04/10/18.
//  Copyright © 2018 Rohit Jain. All rights reserved.
//

import UIKit

class MoviesListViewController: UIViewController {

    let movieListCellReuseIdentifier = "movieListCell"
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    var currentPage: Int = 1
    var totalItems: Int = 0
    var moviesList:[MoviesArrayDataModel] = []
    let movieTitle = "Batman"
    let detailPageIdentifier = "movieDetailsViewController"
    var selectedMovie:MoviesArrayDataModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OMDB"
        self.moviesCollectionView.register(UINib(nibName: "MoviesListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: movieListCellReuseIdentifier)
        currentPage = 1
        getMoviesList()
    }
    
    func getMoviesList() {
        if (Reachability.isConnectedToNetwork()){
            if(moviesList.count == 0){
                getMoviesData(showSpinner: true)
            }else{
                if(moviesList.count < totalItems){
                    currentPage += 1
                    getMoviesData(showSpinner: false)
                }
            }
        }else{
            if(moviesList.count == 0){
                showNetworkAlert()
            }
        }
    }
    
    func getMoviesData(showSpinner: Bool) {
        var spinnerView: UIView?
        if showSpinner {
            spinnerView = UIViewController.displaySpinner(onView: self.view)
        }
        MovieListNetworkWrapper.sharedInstance.getMoviesList(title: movieTitle, pageNumber: currentPage, success: { (result) in
            if(spinnerView != nil){
                UIViewController.removeSpinner(spinner: spinnerView!)
            }
            self.moviesList = self.moviesList + result.moviesList!
            self.totalItems = result.totalMovies!
            self.moviesCollectionView.reloadData()
        }, failure: { (errorData) in
            if(spinnerView != nil){
                UIViewController.removeSpinner(spinner: spinnerView!)
            }
        })
    }
    
    func showNetworkAlert() {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        moviesCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailPageIdentifier) {
            let vc = segue.destination as! MovieDetailsViewController
            vc.movie = self.selectedMovie
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MoviesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenHeight = (UIScreen.main.bounds.width) - 30
        let cellWidth = screenHeight / 2
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieListCellReuseIdentifier, for: indexPath) as! MoviesListCollectionViewCell
        let item = moviesList[indexPath.row]
        cell.configureCell(model: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = self.moviesList[indexPath.item]
        self.selectedMovie = selectedItem
        performSegue(withIdentifier: detailPageIdentifier, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row + 1 == (moviesList.count - 3)) {
            self.getMoviesList()
        }
    }
}

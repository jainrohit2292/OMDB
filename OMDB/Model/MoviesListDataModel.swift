//
//  MoviesListDataModel.swift
//  OMDB
//
//  Created by Rohit Jain on 04/10/18.
//  Copyright © 2018 Rohit Jain. All rights reserved.
//

import Foundation
import UIKit

class MoviesSearchDataModel: NSObject, NSCoding {
    
    var moviesList:[MoviesArrayDataModel]?
    var totalMovies: Int?
    
    init(With dictionary:[String:Any]?) {
        super.init()
        if let dict = dictionary{
            if let countValue = dict["totalResults"] as? String{
                totalMovies = (countValue as NSString).integerValue
            }
            if let moviesArray = dict["Search"] as? [Any]{
                moviesList = []
                for movieObj in moviesArray{
                    let movie = MoviesArrayDataModel(With: movieObj as? [String:Any])
                    moviesList?.append(movie)
                }
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        totalMovies = aDecoder.decodeObject(forKey: "totalResults") as? Int
        moviesList = aDecoder.decodeObject(forKey: "Search") as? [MoviesArrayDataModel]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(totalMovies, forKey: "totalResults")
        aCoder.encode(moviesList, forKey: "Search")
    }
}

class MoviesArrayDataModel: NSObject, NSCoding {
    
    var imdbID: String?
    var Poster: String?
    var Title: String?
    var DataType: String?
    var Year: String?
    
    init(With dictionary:[String:Any]?) {
        super.init()
        if let dict = dictionary{
            if let nodeValue = dict["imdbID"] as? String{
                imdbID = nodeValue
            }
            if let nodeValue = dict["Poster"] as? String{
                Poster = nodeValue
            }
            if let nodeValue = dict["Title"] as? String{
                Title = nodeValue
            }
            if let nodeValue = dict["Type"] as? String{
                DataType = nodeValue
            }
            if let nodeValue = dict["Year"] as? String{
                Year = nodeValue
            }
        }
    }
    required init(coder aDecoder: NSCoder) {
        super.init()
        imdbID = aDecoder.decodeObject(forKey: "imdbID") as? String
        Poster = aDecoder.decodeObject(forKey: "Poster") as? String
        Title = aDecoder.decodeObject(forKey: "Title") as? String
        DataType = aDecoder.decodeObject(forKey: "Type") as? String
        Year = aDecoder.decodeObject(forKey: "Year") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(imdbID, forKey: "imdbID")
        aCoder.encode(Poster, forKey: "Poster")
        aCoder.encode(Title, forKey: "Title")
        aCoder.encode(DataType, forKey: "Type")
        aCoder.encode(Year, forKey: "Year")
    }
}

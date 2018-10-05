//
//  MovieListNetworkWrapper.swift
//  OMDB
//
//  Created by Rohit Jain on 04/10/18.
//  Copyright © 2018 Rohit Jain. All rights reserved.
//

import UIKit
import Alamofire

class MovieListNetworkWrapper: NSObject {
    static let sharedInstance = MovieListNetworkWrapper()
    
    private override init() {
        super.init()
    }
    
    func getMoviesList(title:String,pageNumber:Int,success:@escaping (MoviesSearchDataModel) -> Void, failure:@escaping (ErrorResponse) -> Void){
        let requestObject = RequestObject()
        requestObject.baseURL = APIConstants.URL.omdbBaseUrl
        requestObject.apiPath = "?s=\(title)&page=\(pageNumber)&apikey=\(APIConstants.Key.api_key)"
        requestObject.requestType = .get
        
        NetworkManager.getDataFor(Request: requestObject, success: {object in
            if let obj = object.responseObject as? [String:Any]{
                let imageModel:MoviesSearchDataModel = MoviesSearchDataModel.init(With: obj)
                success(imageModel)
            }
        }, failure: {error in
            print(error)
            failure(error)
        })
    }
}

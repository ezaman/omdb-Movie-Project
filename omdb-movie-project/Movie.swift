//
//  Movie.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/7/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import Foundation


class Movie {
    
    //    var title: String
    //
    //    init?(movieDict: [String: AnyObject]) {
    //
    //        if let jsonTitle = movieDict["Title"] as? String {
    //            self.title = jsonTitle
    //        } else {return nil}
    //
    //
    //    }
    
    var title: String?
    var poster: String?
    var type: String?
    var year: String?
    var imdbID: String?
    
    init?(movieDict: NSDictionary) {
        
        guard let
     
            movieTitle = movieDict["Title"] as? String,
            moviePoster = movieDict["Poster"] as? String,
            movieType = movieDict["Type"] as? String,
            movieYear = movieDict["Year"] as? String,
            movieImdbID = movieDict["imdbID"] as? String
            
        else { return }
        
            self.title = movieTitle
            self.poster = moviePoster
            self.type = movieType
            self.year = movieYear
            self.imdbID = movieImdbID
            
        }
    }








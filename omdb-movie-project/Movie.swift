//
//  Movie.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/7/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import Foundation


class Movie

{
    
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
    
    var plot: String?
    var actors: String?
    var released: String?
    var director: String?
    var writer: String?
    var imdbRating: String?
    var metaScore: String?
    
    var fullPlot: String?
    
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
    
    
//    init?(detailDictionary: NSDictionary)
//    {
//        guard let
//        
//        moviePlot = detailDictionary["Plot"] as? String,
//        movieActors = detailDictionary["Actors"] as? String,
//        movieReleased = detailDictionary["Released"] as? String,
//        movieDirector = detailDictionary["Director"] as? String,
//        movieWriter = detailDictionary["Writer"] as? String,
//        movieImdbRating = detailDictionary["imdbRating"] as? String,
//        movieMetaScore = detailDictionary["Metascore"] as? String
//        
//        else { return }
//        
//        self.plot = moviePlot
//        self.actors = movieActors
//        self.released = movieReleased
//        self.director = movieDirector
//        self.writer = movieWriter
//        self.imdbRating = movieImdbRating
//        self.metaScore = movieMetaScore
//    
//    }
    
    
    func movieDetails(dictionary: NSDictionary, completion: (Bool) -> ()) {
        
        self.plot = dictionary["Plot"] as? String
        self.actors = dictionary["Actors"] as? String
        self.released = dictionary["Released"] as? String
        self.director = dictionary["Director"] as? String
        self.writer = dictionary["Writer"] as? String
        self.imdbRating = dictionary["imdbRating"] as? String
        self.metaScore = dictionary["Metascore"] as? String
        
        completion(true)
    }
    
    init?(plotDictionary: NSDictionary) {
        
       guard let
        
    movieFullPlot = plotDictionary["Plot"] as? String
        
    else { return }
        
    self.fullPlot = movieFullPlot
        
    }
    
    
    
    }








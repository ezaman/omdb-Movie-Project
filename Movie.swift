//
//  Movie.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/28/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import Foundation
import CoreData


class Movie: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

        convenience init(dictionary: NSDictionary, entity: NSEntityDescription, managedObjectContext: NSManagedObjectContext) {
    
            self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    
            guard let
    
                movieTitle = dictionary["Title"] as? String,
                moviePoster = dictionary["Poster"] as? String,
                movieYear = dictionary["Year"] as? String,
                movieImdbID = dictionary["imdbID"] as? String
    
                else { return }
    
            self.title = movieTitle
            self.poster = moviePoster
            self.year = movieYear
            self.imdbID = movieImdbID
    
        }
    
        func movieDetails(dictionary: NSDictionary, completion: (Bool) -> ()) {
    
            self.shortPlot = dictionary["Plot"] as? String
            self.actors = dictionary["Actors"] as? String
            self.released = dictionary["Released"] as? String
            self.director = dictionary["Director"] as? String
            self.writer = dictionary["Writer"] as? String
            self.imdbRating = dictionary["imdbRating"] as? String
            self.metascore = dictionary["Metascore"] as? String
    
            completion(true)
        }
    
        func plotDictionary(dictionary: NSDictionary, completion: (Bool) -> ()) {
            
            self.fullPlot = dictionary["Plot"] as? String
            
        }

    
    
}

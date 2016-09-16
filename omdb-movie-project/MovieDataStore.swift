//
//  MovieDataStore.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/7/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import Foundation


class MovieDataStore {
    
    
    static let sharedDataStore = MovieDataStore()
   
    var movieResults = [Movie]()
    
    private init() {}
    
    
    func searchMoviesWith(query: String, completionHandler: (NSArray) -> ()){
        
        OMDBAPIClient.searchOMDBAPI(query) { (jsonResults) in
            //print(jsonResults)
            
            for movie in jsonResults {
                if let movieDictionary = Movie.init(movieDict: movie){
                    
                    self.movieResults.append(movieDictionary)
                    //print(self.movieResults)
                    
                }
                
                for movies in self.movieResults {
                    //print(movies.title!)
                }
                
                
            }
            completionHandler(self.movieResults)
            /*
             1. get array of results from json
             2. loop over array to create movie objects
             3. add movie objects to datastore array
             4. use completion handler to inform collection view that array of movies is ready
             */
     
            
        }
    }
    
func searchMoviesWithID(movie: Movie, completion: (NSDictionary)-> ()){
        OMDBAPIClient.moviesWithID(movie.imdbID!) { (dictionary) in
            
        movie.movieDetails(dictionary, completion: { success in
            if success {
                completion(dictionary)
            }
        })
//            for detailDict in dictionary {
//                if let movieDictionary = Movie.init(detailDictionary: detailDict) {
//                    self.movieResults.append(movieDictionary)
//                }
//            }

        }
    }
    
    func getFullPlot(movie: Movie, completion: ([Movie]) -> ()) {
       OMDBAPIClient.fullPlot(movie.imdbID!) { (dictionary) in
        
        for plotDict in dictionary {
            
            if let plotDictionary = Movie.init(plotDictionary: plotDict){
                self.movieResults.append(plotDictionary)
            }
        
        }
        
        completion(self.movieResults)
        
        
    }
    
    

}

}


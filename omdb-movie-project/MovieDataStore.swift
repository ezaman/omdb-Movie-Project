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
    var currentQuery = ""
    let omdbClient = OMDBAPIClient.sharedInstance
    //var pageNumber = 1
    //var totalResults = 0

    private init() {}
    

    
    func searchMoviesWith(query: String, page: Int, completionHandler: Bool -> ()){

        // save query first through
        // check query each time to see if it's changed
        // if query changed, reset currentQuery, pageNumber, totalReselts
//        print("page number outside \(page)")

        omdbClient.searchOMDBAPI(query, page: page) { jsonResults in
//            print("*****************\n\(jsonResults)\n*******************")
//            print("page number inside \(page)")

            let moviesArray  = jsonResults["Search"] as? [NSDictionary]
            guard let unwrappedMoviesArray = moviesArray else {return }
            

        // let resultCount = jsonResults["totalResults"] as? Int
 
//            print(self.totalResults)
            
            for movie in unwrappedMoviesArray {
                if let movieDictionary = Movie.init(movieDict: movie){
                    
                    self.movieResults.append(movieDictionary)
                    
//                    print("movie added: \(movieDictionary.title)")
                    //print(self.movieResults)
                    
                }
            }
            
            if self.movieResults.count > 0 {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
            
        }
    }
    
func searchMoviesWithID(movie: Movie, completion: (NSDictionary)-> ()){
        omdbClient.moviesWithID(movie.imdbID!) { (dictionary) in
            
        movie.movieDetails(dictionary, completion: { success in
            if success {
                completion(dictionary)
            }
        })
        }
    }
    
    func getFullPlot(movie: Movie, completion: (NSDictionary) -> ()) {
       omdbClient.fullPlot(movie.imdbID!) { (dictionary) in

    movie.movieDetails(dictionary, completion: { (success) in
        if success {
            completion(dictionary)
        }
    })

    }
        

}
//    func nextPage() {
//       omdbClient.nextPage()
//    }

}


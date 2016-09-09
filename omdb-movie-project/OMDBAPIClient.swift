//
//  OMDBAPIClient.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/7/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import Foundation

class OMDBAPIClient {
  
    
    class func searchOMDBAPI(query: String, completionHandler: ([NSDictionary]) -> ()) {
                 //write networking statements, pass back json dictionary to datastore
   
        let searchString = query.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let urlString = "https://www.omdbapi.com/?s="
        let movie = "&type=movie"
        let urlWithParameters = "\(urlString)\(searchString)\(movie)"
        let url = NSURL(string: urlWithParameters)
        
        
        var session = NSURLSession.sharedSession()
        
        guard let unwrappedURL = url else { fatalError("error") }
        
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) -> Void in
            do {
                //let unwrappedData = data else { fatalError("error") }
                var jsonData = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: AnyObject]

                //print(jsonData)
                let moviesArray  = jsonData["Search"] as? [NSDictionary]
                guard let unwrappedMoviesArray = moviesArray else {return }
                //var newArray = []
//                for movie in unwrappedMoviesArray {
//                    let movieDictionary = Movie.init(movieDict: (movie as? NSDictionary)!)
//            
//           
//                }
              
                
                completionHandler(unwrappedMoviesArray)
            }
            catch {
                print(error)
            }
            
            
            
        }
        task.resume()
        
    }
    
    
//    
//    func movieDetailslWithID(id: String, completion: (NSDictionary)-> ())
//    {
//        let urlString = "https://www.omdbapi.com/?i=\(id)"
//        let url = NSURL(string: urlString)
//        
//        guard let unwrappedURL = url else {return}
//        
//        let session = NSURLSession.sharedSession()
//        
//        let dataTask = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
//            
//            guard let unwrappedData = data else {return}
//            
//            do{
//                let movieDetails = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
//               // print(movieDetails)
//                if let movieDetailDict = movieDetails
//              
//                {
//                    completion(movieDetailDict)
//                }
//                
//            }
//            catch
//            {
//                print(error)
//            }
//        }
//        dataTask.resume()
//        
//    }
    
   
    
}
//
//  OMDBAPIClient.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/7/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import Foundation

class OMDBAPIClient {
  
    static var pageNum = 1
    
    class func searchOMDBAPI(query: String, completionHandler: ([NSDictionary]) -> ()) {
                 //write networking statements, pass back json dictionary to datastore
   
        let searchString = query.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let urlString = "https://www.omdbapi.com/?s=\(searchString)&p="
        //let movie = "&type=movie"
        
        let urlWithParameters = "\(urlString)\(pageNum)"
        let url = NSURL(string: urlWithParameters)
        
        guard let unwrappedURL = url else { fatalError("error") }
       
        var session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) -> Void in
            
            guard let unwrappedData = data else {return}
            
            do {
                //let unwrappedData = data else { fatalError("error") }
                var jsonData = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: NSJSONReadingOptions.AllowFragments) as! [String: AnyObject]

//                print(jsonData)
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
    
    class func nextPage () {
        pageNum = pageNum + 1
    }
    
 class func moviesWithID(id: String, completion: (NSDictionary)-> ())
    {
        let urlString = "https://www.omdbapi.com/?i=\(id)"
        let url = NSURL(string: urlString)
        
        guard let unwrappedURL = url else {return}
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                let movieDetails = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options:[]) as? NSDictionary
//                print(movieDetails)
                
                if let movieInfo = movieDetails
              
                {
//                    print("\n\n\n\n\n\n\(movieInfo)")
                    completion(movieInfo)
                    
                }
                
            }
            catch
            {
                print(error)
            }
        }
        dataTask.resume()
        
    }
    
    class func fullPlot(id: String, completion: ([NSDictionary]) -> ()) {
        let urlString = "https://www.omdbapi.com/?i=\(id)&plot=full"
        
        let url = NSURL(string: urlString)
        
        guard let unwrappedURL = url else {return}
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                let fullMoviePlot = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? [NSDictionary]
                
                if let moviePlots = fullMoviePlot
                {
                    completion(moviePlots)
                }
            }
            catch
            {
                print(error)
            }
        }
        dataTask.resume()
    }
    
    }
    
    
    
   
    

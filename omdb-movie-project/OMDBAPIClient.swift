//
//  OMDBAPIClient.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/7/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import Foundation

class OMDBAPIClient {
  
    static let sharedInstance = OMDBAPIClient()
    
    var pageNum = 1
    
    func nextPage () {
        pageNum += 1
    }
    
    func searchOMDBAPI(query: String, page: Int, completionHandler: ([String: AnyObject]) -> ()) {
        //write networking statements, pass back json dictionary to datastore
   
//        print("page number \(page)")

        let searchString = query.stringByReplacingOccurrencesOfString(" ", withString: "+")
        let urlString = "https://www.omdbapi.com/?s=\(searchString)&page=\(page)"
//        let urlWithParameters = "\(urlString)\(page)"
        let url = NSURL(string: urlString)
        guard let unwrappedURL = url else { fatalError("error") }
        print(unwrappedURL)

        var session = NSURLSession.sharedSession()
        
        
        let task = session.dataTaskWithURL(unwrappedURL) { (data, response, error) -> Void in
            
            guard let unwrappedData = data else {return}
            
            do {
                //let unwrappedData = data else { fatalError("error") }
                var jsonData = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: NSJSONReadingOptions.AllowFragments) as! [String: AnyObject]
                print("uw URL: \(unwrappedURL)")
                print("##########################\n############################\n\(jsonData)\n##################################\n##############################")
//                let moviesArray  = jsonData["Search"] as? [NSDictionary]
//                guard let unwrappedMoviesArray = moviesArray else {return }
//
                //let resultCount  = jsonData["totalResults"]
                //print(resultCount)
                
                //var newArray = []
//                for movie in unwrappedMoviesArray {
//                    let movieDictionary = Movie.init(movieDict: (movie as? NSDictionary)!)
//            
//           
//                }
              
                
                completionHandler(jsonData)
            }
            catch {
                print(error)
            }
            
            
            
        }
        task.resume()
        
    }
    
    
  func moviesWithID(id: String, completion: (NSDictionary)-> ())
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
    
    func fullPlot(id: String, completion: (NSDictionary) -> ()) {
        let urlString = "https://www.omdbapi.com/?i=\(id)&plot=full"
        
        let url = NSURL(string: urlString)
        
        guard let unwrappedURL = url else {return}
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(unwrappedURL) { (data, response, error) in
            
            guard let unwrappedData = data else {return}
            
            do{
                let fullMoviePlot = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: []) as? NSDictionary
                
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

    
    
    
   
    

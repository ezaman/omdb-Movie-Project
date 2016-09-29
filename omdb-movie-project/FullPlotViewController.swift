//
//  FullPlotViewController.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/16/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import UIKit
import CoreData

class FullPlotViewController: UIViewController {

    
    @IBOutlet weak var fullPlot: UILabel!
    
    
    var movie: Movie!
    let store = MovieDataStore.sharedDataStore
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        gettingFullPlot()
        
        self.title = "Full Plot"
//    guard let unwrappedMovie = self.movie else {return}
//    self.store.getFullPlot(movie) {
//         let plot = dictionary["Plot"] as? String
//       
//         //print(plot)
//        dispatch_async(dispatch_get_main_queue(),{
//         self.fullPlot.text = plot
//        })
//        }
        
        
    }
    
    func gettingFullPlot()
    {
        let request = NSFetchRequest(entityName: "Favorites")
        
        do{
            let object = try store.managedObjectContext.executeFetchRequest(request) as! [Favorites]
            
            guard let movieObject = self.movie else {return}
            
            if object.count == 0
            {
              
                self.store.getFullPlot(movieObject)
                {
                    dispatch_async(dispatch_get_main_queue(),{
                        self.fullPlot.text = self.movie.fullPlot
                    
                    })
                }
            }
            
            for movies in object
            {
                guard let savedMovie = movies.movies?.first?.imdbID else {return}
                
                if object.count != 0 && savedMovie == movieObject.imdbID
                {
                    
                     dispatch_async(dispatch_get_main_queue(),{
                    self.fullPlot.text = movies.movies?.first?.fullPlot
                   })
                }
                else if object.count != 0 && savedMovie != movieObject.imdbID
                {
                    
                    guard let unwrappedMovie = movie else {return}
                    
                    self.store.getFullPlot(unwrappedMovie)
                    {
                        dispatch_async(dispatch_get_main_queue(),{
                            self.fullPlot.text = self.movie?.fullPlot
                           
                        })
                    }
                    
                }
                
            }
       
        }
        catch{print("Error")}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}

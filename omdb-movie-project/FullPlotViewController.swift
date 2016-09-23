//
//  FullPlotViewController.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/16/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import UIKit

class FullPlotViewController: UIViewController {

    
    @IBOutlet weak var fullPlot: UILabel!
    
    
    var movie: Movie!
    let store = MovieDataStore.sharedDataStore
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
     guard let unwrappedMovie = self.movie else {return}
        
    self.store.getFullPlot(movie) { (dictionary) in
         let plot = dictionary["Plot"] as? String
       
         //print(plot)
        dispatch_async(dispatch_get_main_queue(),{
         self.fullPlot.text = plot
        })
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

}

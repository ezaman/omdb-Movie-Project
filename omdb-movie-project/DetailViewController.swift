//
//  DetailViewController.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/14/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var shortPlot: UILabel!
    @IBOutlet weak var directorName: UILabel!
    @IBOutlet weak var starNames: UILabel!
    @IBAction func fullPlotDescription(sender: AnyObject) {
    }
    
    @IBOutlet weak var releaseYear: UILabel!
    
    @IBOutlet weak var writerName: UILabel!
    
    @IBOutlet weak var imdbScore: UILabel!
    
    @IBOutlet weak var metascore: UILabel!
    
    var movie: Movie?
    let store = MovieDataStore.sharedDataStore
    
    var fullPlot = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let unwrappedMovie = self.movie else {return}
        self.title = unwrappedMovie.title

       // NSOperationQueue.mainQueue(getData())
            getData()
  
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getData() {
        guard let unwrappedMovie = self.movie else {return}
        self.store.searchMoviesWithID(unwrappedMovie) { (dictionary) in
            let plot = dictionary["Plot"] as? String
            
            let actors = dictionary["Actors"] as? String
            let released = dictionary["Released"] as? String
            let director = dictionary["Director"] as? String
            let writer = dictionary["Writer"] as? String
            let imdbRating = dictionary["imdbRating"] as? String
            let metaScore = dictionary["Metascore"] as? String
           // if let image = dictionary["Poster"] as? String
            
            dispatch_async(dispatch_get_main_queue(),{

            self.shortPlot.text = plot
            self.directorName.text = director
            self.starNames.text = actors
            self.writerName.text = writer
            self.imdbScore.text = imdbRating
            self.metascore.text = metaScore
            self.releaseYear.text = released
            
                if let image = dictionary["Poster"] as? String {
                   if image == "N/A" {
                 self.detailImage.image = UIImage.init(named: "frown")
                }
            
            let url = NSURL(string: image)
            
            if let urldata = url {
                var imageData = NSData(contentsOfURL: urldata)
                if let newData = imageData {
                    
                    self.detailImage.image = UIImage.init(data: newData)
                }
              }
            }
          })
            
        }
        
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fullPlotSegue" {
            let detailVC = segue.destinationViewController as! FullPlotViewController
            
            guard let unwrappedMovie = self.movie else {return}
            detailVC.movie = unwrappedMovie
            print(detailVC.movie)
            
        }
    }
        
   
}

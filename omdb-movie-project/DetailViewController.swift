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
    
    var movie: Movie?
    let store = MovieDataStore.sharedDataStore
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let unwrappedMovie = self.movie else {return}
        self.title = unwrappedMovie.title

    self.store.searchMoviesWithID(unwrappedMovie) { (dictionary) in
        
          let plot = dictionary["Plot"] as? String
       
        let actors = dictionary["Actors"] as? String
        let released = dictionary["Released"] as? String
        let director = dictionary["Director"] as? String
        let writer = dictionary["Writer"] as? String
        let imdbRating = dictionary["imdbRating"] as? String
        let metaScore = dictionary["Metascore"] as? String
        let image = dictionary["Poster"] as? String
        
        self.shortPlot.text = plot
        self.directorName.text = director
        self.starNames.text = actors
    
        let url = NSURL(string: image!)
        if let urldata = url {
            var imageData = NSData(contentsOfURL: urldata)
            if let newData = imageData {
                
                self.detailImage.image = UIImage.init(data: newData)
            }

        }
        
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fullPlotSegue" {
            let detailVC = segue.destinationViewController as! FullPlotViewController
        
            if let movieUnwrapped = movie{
               detailVC.movie = movie
               
                
        }
    }
        
    }
    
//    func getMovieDetails () {
//         guard let unwrappedMovie = self.movie else {return}
//       
//        unwrappedMovie.movieDetails() { (result) in
//
//        }
//        
//        self.store.searchMoviesWithID(unwrappedMovie) { (result) in
//            for movieDict in result {
//                self.shortPlot.text = movieDict.plot
//                self.starNames.text = movieDict.actors
//                
//            }
//        }
//
//        
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

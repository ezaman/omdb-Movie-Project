//
//  DetailViewController.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/14/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    @IBOutlet weak var shortPlot: UITextView!
    @IBOutlet weak var detailImage: UIImageView!
   // @IBOutlet weak var shortPlot: UILabel!

    @IBAction func fullPlotDescription(sender: AnyObject) {
    }
    
    @IBOutlet weak var directorName: UITextView!
    @IBOutlet weak var writerName: UITextView!
    @IBOutlet weak var starNames: UITextView!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var imdbScore: UILabel!
    @IBOutlet weak var metascore: UILabel!
    
    var movie: Movie?
    let store = MovieDataStore.sharedDataStore
    
    var fullPlot = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchData()
        //guard let unwrappedMovie = self.movie else {return}
        
        self.tabBarController?.navigationItem.title = movie?.title
        self.title = movie?.title

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "⭐️", style: .Done, target: self, action: #selector(DetailViewController.saveMovie))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Apple SD Gothic Neo", size: 25)!], forState: UIControlState.Normal)
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blackColor()
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        

        dispatch_async(dispatch_get_main_queue(),{
            self.getData()
      
        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    
    
    func getData() {
        
        let request = NSFetchRequest(entityName: "Favorites")
        
        do {
            let movieObject = try store.managedObjectContext.executeFetchRequest(request) as! [Favorites]
            guard let unwrappedMovieObject = self.movie else {return}
            
            if movieObject.count == 0 {
               self.store.searchMoviesWithID(unwrappedMovieObject) {
                dispatch_async(dispatch_get_main_queue(),{
                self.shortPlot.text = self.movie?.shortPlot
                self.directorName.text = self.movie?.director
                self.starNames.text = self.movie?.actors
                self.writerName.text = self.movie?.writer
                self.imdbScore.text = self.movie?.imdbRating
                self.metascore.text = self.movie?.metascore
                self.releaseYear.text = self.movie?.released
                self.movieImage()
                })
               }
            
            }
            
            for movie in movieObject {
                
                guard let movieID = movie.movies?.first?.imdbID else {return}
                
                if movieObject.count != 0 && movieID == unwrappedMovieObject.imdbID {
                    
                    self.shortPlot.text = movie.movies?.first?.shortPlot
                    self.directorName.text = movie.movies?.first?.director
                    self.starNames.text = movie.movies?.first?.actors
                    self.writerName.text = movie.movies?.first?.writer
                    self.imdbScore.text = movie.movies?.first?.imdbRating
                    self.metascore.text = movie.movies?.first?.metascore
                    self.releaseYear.text = movie.movies?.first?.released
                    self.movieImage()
                    
                    
                }else if movieID != unwrappedMovieObject.imdbID{
                    dispatch_async(dispatch_get_main_queue(),{
                    self.shortPlot.text = self.movie?.shortPlot
                    self.directorName.text = self.movie?.director
                    self.starNames.text = self.movie?.actors
                    self.writerName.text = self.movie?.writer
                    self.imdbScore.text = self.movie?.imdbRating
                    self.metascore.text = self.movie?.metascore
                    self.releaseYear.text = self.movie?.released
                    self.movieImage()
                    })
                }
            
            }
        }
        

    
        catch {
            print("error")
        }
        
    }


//        guard let unwrappedMovie = self.movie else {return}
//        self.store.searchMoviesWithID(unwrappedMovie) { (dictionary) in
//            let plot = dictionary["Plot"] as? String
//            
//            let actors = dictionary["Actors"] as? String
//            let released = dictionary["Released"] as? String
//            let director = dictionary["Director"] as? String
//            let writer = dictionary["Writer"] as? String
//            let imdbRating = dictionary["imdbRating"] as? String
//            let metaScore = dictionary["Metascore"] as? String
//           // if let image = dictionary["Poster"] as? String
//            
//            dispatch_async(dispatch_get_main_queue(),{
//
//            self.shortPlot.text = plot
//            self.directorName.text = director
//            self.starNames.text = actors
//            self.writerName.text = writer
//            self.writerName.sizeToFit()
//            self.imdbScore.text = imdbRating
//            self.metascore.text = metaScore
//            self.releaseYear.text = released
//            
//                if let image = dictionary["Poster"] as? String {
//                   if image == "N/A" {
//                 self.detailImage.image = UIImage.init(named: "frown")
//                }
//            
//            let url = NSURL(string: image)
//            
//            if let urldata = url {
//                var imageData = NSData(contentsOfURL: urldata)
//                if let newData = imageData {
//                    
//                    self.detailImage.image = UIImage.init(data: newData)
//                }
//              }
//            }
//                
//           })
//            
//        }
        
    
    
    func movieImage() {
        let image = self.movie?.poster
        if let unwrappedImage = image {
            let urlOne = NSURL(string: unwrappedImage)
            if let url = urlOne {
                let imageData = NSData(contentsOfURL: url)
                
                if let unwrappedData = imageData {
                    self.detailImage.image = UIImage.init(data: unwrappedData)
                }
                
            }
        }
    }
    
    
    func saveMovie () {
        
        guard let movieTitle = self.movie?.title else {return}
        
        let alert = UIAlertController(title: "Saved",
                                      message: "\(movieTitle) is saved as a favorite!",
                                      preferredStyle: .Alert)
        self.presentViewController(alert, animated: true, completion: nil)
        self.navigationItem.rightBarButtonItem = nil
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                alert.dismissViewControllerAnimated(true, completion: nil)
                
            })
        }
        
        let context = store.managedObjectContext
        let savingMovie = NSEntityDescription.insertNewObjectForEntityForName("Favorites", inManagedObjectContext: context) as! Favorites
        guard let movieToSave = self.movie else {return }
        savingMovie.movies?.insert(movieToSave)
        
        store.saveContext()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "fullPlotSegue" {
            let detailVC = segue.destinationViewController as! FullPlotViewController
            
            guard let unwrappedMovie = self.movie else {return}
            detailVC.movie = unwrappedMovie
   
            
        }
    }
        
   
}

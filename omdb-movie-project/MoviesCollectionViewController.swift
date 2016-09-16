//
//  MoviesCollectionViewController.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/7/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class MoviesCollectionViewController: UICollectionViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    
    var titleArray = [String]()
    var posterArray = [String]()
    var yearArray = [String]()
    var idArray = [String]()
    var typeArray = [String]()
    
    var searchBar = UISearchBar(frame: CGRectZero)
    var image = UIImage()
    
    var movie: Movie?
    
    let store = MovieDataStore.sharedDataStore
    
    var searchString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        self.navigationItem.titleView = searchBar

        searchBarSearchButtonClicked(searchBar)
        
    }
    
    
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text?.characters.count > 1 {
            self.searchString = searchBar.text!
            self.store.searchMoviesWith(self.searchString) { (storeArray) in
                for results in self.store.movieResults{
                    self.titleArray.append(results.title!)
                    self.posterArray.append(results.poster!)
                    self.yearArray.append(results.year!)
                    self.idArray.append(results.imdbID!)
                    self.typeArray.append(results.type!)
            }
        }
    }
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.collectionView?.reloadData()
        }
    
    }
    
    
    
    
    
    //        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }

    
   
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return self.store.movieResults.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.movieName.text = self.store.movieResults[indexPath.row].title
      
        var urlData = NSURL(string: self.store.movieResults[indexPath.row].poster!)
        
        if let url = urlData {
            var imageData = NSData(contentsOfURL: url)
            if let newData = imageData {
               
                    cell.moviePoster.image = UIImage.init(data: newData)
            }
        
        }

        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
            let detailVC = segue.destinationViewController as! DetailViewController
     
            let indexPath = collectionView!.indexPathForCell(sender as! UICollectionViewCell)
            //print(indexPath)
            if let unwrappedPath = indexPath {
                
                let movieID = self.store.movieResults[unwrappedPath.row]
                detailVC.movie = movieID
               
            }
        }
    }
    
    
}

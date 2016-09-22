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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var titleArray = [String]()
    var posterArray = [String]()
    var yearArray = [String]()
    var idArray = [String]()
    var typeArray = [String]()
    
    var searchBar = UISearchBar(frame: CGRectZero)
    var image = UIImage()
    
    var movie: Movie?
    
    let store = MovieDataStore.sharedDataStore
    let apiClient = OMDBAPIClient()
    
    var searchString = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.sizeToFit()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        //searchBar.text = "Comedy"
        self.navigationItem.titleView = searchBar
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        
        
        
        self.store.searchMoviesWith("Comedy", page: self.apiClient.pageNum) { (success) in
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.collectionView?.reloadData()
                
            })
        }
        
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let searchResult = searchBar.text
        guard let unwrappedSearch = searchResult else {return}
        
        if unwrappedSearch == ""
        {
            self.store.movieResults.removeAll()
            
            dispatch_async(dispatch_get_main_queue(),{
                self.collectionView?.reloadData()
                
            })
            
        }
        if unwrappedSearch != ""
        {
            self.store.movieResults.removeAll()
            
            let search = unwrappedSearch.stringByReplacingOccurrencesOfString(" ", withString: "+").lowercaseString
            //self.store.pageNumber = 1
            //self.store.nextPage()
            //            self.apiClient.nextPage()
            //            print("page number outside \(self.apiClient.pageNum)")
            self.store.searchMoviesWith(search, page: self.apiClient.pageNum, completionHandler: { (success) in
                //                print("page number inside \(self.apiClient.pageNum)")
                dispatch_async(dispatch_get_main_queue(),{
                    self.collectionView?.reloadData()
                })
            })
            
        }
        if store.movieResults.count == 0
        {
            dispatch_async(dispatch_get_main_queue(),{
                self.collectionView?.reloadData()
            })
        }
        
        
    }
    
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.store.movieResults.count
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        
        cell.movieName.text = self.store.movieResults[indexPath.row].title
        
        // NSOperationQueue().addOperationWithBlock {
        
        if let unwrappedImage = self.store.movieResults[indexPath.row].poster {
            if unwrappedImage == "N/A" {
                cell.moviePoster.image = UIImage.init(named: "No_Image")
            }
            let imageURL = NSURL(string: unwrappedImage)
            
            if let url = imageURL {
                let imageData = NSData(contentsOfURL: url)
                
                if let unwrappedPoster = imageData {
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        cell.moviePoster.image = UIImage.init(data: unwrappedPoster)
                        self.activityIndicator.hidden = false
                        self.activityIndicator.stopAnimating()
                    })
                }
            }
            
            
            
            //            let urlData = NSURL(string: self.store.movieResults[indexPath.row].poster!)
            //
            //            if let url = urlData {
            //
            //                if url == "N/A" {
            //                    cell.moviePoster.image = UIImage.init(named: "no-poster")
            //                }
            //                else {
            //                let imageData = NSData(contentsOfURL: url)
            //                if let newData = imageData {
            //
            //                    NSOperationQueue.mainQueue().addOperationWithBlock({
            //                        cell.moviePoster.image = UIImage.init(data: newData)
            //                    })
            //
            //                }
            //
            //              }
            //            }
        }
        
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let searchResult = searchBar.text
        guard let unwrappedSearch = searchResult else {return}
        
        if self.store.movieResults.count - 1 == indexPath.row {
            //print("\(self.store.movieResults.count - 1) is equal \(indexPath.row)")
            if unwrappedSearch == ""
            {
                //self.store.nextPage()
                self.apiClient.pageNum = 2
                self.store.searchMoviesWith("Comedy", page: apiClient.pageNum, completionHandler: { (success) in
                    dispatch_async(dispatch_get_main_queue(),{
                        self.collectionView?.reloadData()
                    })
                })
                
            }
            if unwrappedSearch != ""
            {
                self.apiClient.nextPage()
                print("counts \(self.store.movieResults.count)")
                
                //                self.apiClient.
                //                print("page number outside \(self.apiClient.pageNum)")
                
                self.store.searchMoviesWith(unwrappedSearch, page: apiClient.pageNum,completionHandler: { (success) in
                    //                    print("page number inside \(self.apiClient.pageNum)")
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        self.collectionView?.reloadData()
                    })
                })
                //
            }
            
            
            self.apiClient.nextPage()
            self.store.searchMoviesWith(self.searchBar.text!, page: apiClient.pageNum,completionHandler: { success in
                print("results received in 'willDisplayCell'")
                if success {
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        self.collectionView?.reloadData()
                    })
                    
                }
            })
        }
        
        
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



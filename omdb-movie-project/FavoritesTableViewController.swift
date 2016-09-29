//
//  FavoritesTableViewController.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/29/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    
    let store = MovieDataStore.sharedDataStore
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        store.fetchData()
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(true)
        
        store.fetchData()
        self.tableView.reloadData()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return store.favorites.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FaveCell", forIndexPath: indexPath)
        as! FavoritesTableViewCell
        
        let movie = store.favorites[indexPath.row].movies
        
        cell.faveTitle.text = movie?.first?.title
        cell.faveRelease.text = movie?.first?.released

        let pic = movie?.first?.poster
        
        if let unwrappedPic = pic
        {
            if unwrappedPic == "N/A"
            {
                cell.favePic.image = UIImage.init(named: "frown")
            }
            let picUrl = NSURL(string: unwrappedPic)
            if let url = picUrl
            {
                let data = NSData(contentsOfURL: url)
                
                if let unwrappedData = data
                {
                    cell.favePic.image = UIImage.init(data: unwrappedData)
                }
            }
            
        }

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // Delete the row from the data source
            
            let context = store.managedObjectContext
            context.deleteObject(store.favorites[indexPath.row])
            
            store.favorites.removeAtIndex(indexPath.row)
            store.saveContext()
            
            self.tableView.reloadData()
            
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "faveToDetail" {
            
            let destinationVC = segue.destinationViewController as? DetailViewController
            
            let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            
            if let unwrappedIndexPath = indexPath
            {
                let movieID = self.store.favorites[unwrappedIndexPath.row].movies
                guard let faveTitle = movieID?.first else {return}
                
                guard let destVC = destinationVC else {return}
                destVC.movie = faveTitle
                
            }

        }
        
    }
    

}

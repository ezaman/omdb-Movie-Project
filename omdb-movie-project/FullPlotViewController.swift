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
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
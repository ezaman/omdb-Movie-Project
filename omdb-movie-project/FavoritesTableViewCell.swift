//
//  FavoritesTableViewCell.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/29/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var favePic: UIImageView!
    @IBOutlet weak var faveTitle: UILabel!
    @IBOutlet weak var faveRelease: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

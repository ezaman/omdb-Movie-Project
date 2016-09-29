//
//  Movie+CoreDataProperties.swift
//  omdb-movie-project
//
//  Created by Ehsan Zaman on 9/28/16.
//  Copyright © 2016 Ehsan Zaman. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var title: String?
    @NSManaged var poster: String?
    @NSManaged var year: String?
    @NSManaged var imdbID: String?
    @NSManaged var released: String?
    @NSManaged var shortPlot: String?
    @NSManaged var director: String?
    @NSManaged var writer: String?
    @NSManaged var actors: String?
    @NSManaged var imdbRating: String?
    @NSManaged var metascore: String?
    @NSManaged var fullPlot: String?

}

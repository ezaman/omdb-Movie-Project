//
//  Favorites+CoreDataProperties.swift
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

extension Favorites {

    @NSManaged var movies: Set<Movie>?

}

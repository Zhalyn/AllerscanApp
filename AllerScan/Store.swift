//
//  Store.swift
//  TestAPP
//
//  Created by Жалын on 7/5/19.
//  Copyright © 2019 ZLJ. All rights reserved.
//

import Foundation
import CoreData

class Store: NSManagedObject {
    
    @NSManaged var sName: String
    @NSManaged var sDesc: String
    @NSManaged var sImage: NSData
    @NSManaged var sLat: String
    @NSManaged var sLng: String
}

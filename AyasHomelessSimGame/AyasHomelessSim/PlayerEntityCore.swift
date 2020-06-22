//
//  PlayerEntityCore.swift
//  AyasHomelessSim
//
//  Created by furkanayas on 25.05.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class PlayerEntityCore: NSManagedObject {

   // @NSManaged public var certificate: [String]?
    @NSManaged public var certificate: String?
    @NSManaged public var happiness:Int16
    @NSManaged public var health:Int16
  //  @NSManaged public var shelter: [String]?
    @NSManaged public var shelter: String?
    @NSManaged public var hunger:Int16
    @NSManaged public var money: Int64
    @NSManaged public var username:String
  //  @NSManaged public var transport: [String]?
    @NSManaged public var transport: String?
     @NSManaged public var day:Int16
     @NSManaged public var language:Bool
    
}

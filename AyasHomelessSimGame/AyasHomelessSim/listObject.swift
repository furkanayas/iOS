//
//  listObject.swift
//  AyasHomelessSim
//
//  Created by furkanayas on 25.05.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit

class listObject: Decodable {
    var name:String?
    var happiness: Int16?
    var health: Int16?
    var hunger: Int16?
    var price: Int64?
    var type: Int16?
    
    init(json:[String:Any]){
        name = json["name"] as? String
        happiness = json["happiness"] as? Int16
        health = json["health"] as? Int16
        hunger = json["hunger"] as? Int16
        price = json["price"] as? Int64
        type = json["type"] as? Int16
    }
}

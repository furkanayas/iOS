//
//  NewsPaperEntityCore.swift
//  AyasNewsPaperFinal
//
//  Created by furkanayas on 28.04.2020.
//  Copyright © 2020 furkanayas. All rights reserved.
//

import UIKit
import CoreData

class NewsPaperEntityCore: NSManagedObject {
    @NSManaged public var name:String
    @NSManaged public var isactive:Bool
    @NSManaged public var date:Date
    @NSManaged public var imag:Data
    @NSManaged public var logo:Data
    @NSManaged public var imagstatu:Bool
}

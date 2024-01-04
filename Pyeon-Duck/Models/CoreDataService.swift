//
//  CoreDataService.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/20/23.
//

import CoreData
import UIKit

class CoreDataService {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private init() {}
}

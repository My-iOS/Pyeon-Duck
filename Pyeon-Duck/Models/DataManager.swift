//
//  DataManager.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/22/23.
//

import Foundation

class DataManager {
    private(set) var expirationList: [ExpirationDate] = []
    private(set) var stockList: [Stock] = []

    var context = CoreDataService.context
}

// CRUD
extension DataManager {
    // Create
    func addExpiration(_ expiration: String) {
        let newItem = ExpirationDate(context: context)
        newItem.title = expiration
        print("##### \(newItem)")
        do {
            try context.save()
            print("##### \(expirationList)")
            requestExpiration()
        } catch {
            print("Insert Error: \(error)")
        }
    }

    // Read
    func requestExpiration() {
        do {
            expirationList = try context.fetch(ExpirationDate.fetchRequest())
            print("##### \(expirationList)")
        } catch {
            print("Fetch Error: \(error)")
        }
    }
}

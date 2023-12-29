//
//  DataManager.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/22/23.
//

import Foundation

class DataManager {
    private(set) var expirationList: [ExpirationDate] = []
    private(set) var stockCategoryList: [StockCategory] = []

    var context = CoreDataService.context
}

// MARK: - CoreData CRUD

// CRUD
extension DataManager {
    // Create
    func addExpiration(_ title: String, _ date: String, _ image: Data, _ creationDate: String, isConfirm: Bool) {
        var newItem = ExpirationDate(context: context)
        newItem.title = title
        newItem.itemImage = image
        newItem.date = date
        newItem.creationDate = creationDate
        newItem.isConfirm = isConfirm

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
        } catch {
            print("Fetch Error: \(error)")
        }
    }

    // Delete
    func deleteExpiration(at indexPath: IndexPath) {
        let itemIndexPath = expirationList[indexPath.row]
        context.delete(itemIndexPath)

        do {
            try context.save()
            requestExpiration()
        } catch {
            print("#### Delete Error : \(error)")
        }
    }
}

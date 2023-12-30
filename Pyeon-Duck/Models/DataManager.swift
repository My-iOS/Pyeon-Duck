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
    private(set) var stockItemList: [StockItem] = []

    var context = CoreDataService.context
}

// MARK: - Expiration CRUD

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

    // Update - Content
    func updateExpiration(_ expiration: ExpirationDate, newTitle: String, newDate: String, newModifiedDate: String) {
        expiration.title = newTitle
        expiration.date = newDate
        expiration.modifiedDate = newModifiedDate

        do {
            try context.save()
            requestExpiration()
        } catch {
            print("#### Update Error : \(error)")
        }
    }

    // Update - Status
    func updateConfirm(_ expiration: ExpirationDate, isConfirm: Bool) {
        expiration.isConfirm = isConfirm

        do {
            try context.save()
            requestExpiration()
        } catch {
            print("#### Update Error : \(error)")
        }
    }
}

// MARK: - StockCategory CRUD

extension DataManager {
    // Create
    func addStockCategory(_ title: String) {
        var newItem = StockCategory(context: context)
        newItem.categoryTitle = title

        do {
            try context.save()
            print("#### \(stockCategoryList)")
            requestStockCategory()
        } catch {
            print("#### Insert Error: \(error)")
        }
    }

    // Read
    func requestStockCategory() {
        do {
            stockCategoryList = try context.fetch(StockCategory.fetchRequest())
        } catch {
            print("#### Fetch Error: \(error)")
        }
    }

    // Delete
    func deleteStockCategory(at indexPath: IndexPath) {
        let itemIndexPath = stockCategoryList[indexPath.row]
        context.delete(itemIndexPath)

        do {
            try context.save()
            requestStockCategory()
        } catch {
            print("#### Delete Error: \(error)")
        }
    }
}

// MARK: - StockItem CRUD

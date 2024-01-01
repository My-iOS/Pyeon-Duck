//
//  DataManager.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/22/23.
//

import CoreData
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
        let newItem = ExpirationDate(context: context)
        newItem.id = UUID()
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
    func deleteExpiration(at expiration: ExpirationDate) {
        context.delete(expiration)
        do {
            try context.save()
            requestExpiration() // 배열을 다시 fetch하여 갱신
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

    // Update
    func updateStockCategory(_ stockCategory: StockCategory, title: String) {
        stockCategory.categoryTitle = title

        do {
            try context.save()
            requestStockCategory()
        } catch {
            print("#### Update Error: \(error)")
        }
    }
}

// MARK: - StockItem CRUD

extension DataManager {
    // Create
    func addStockItem(_ title: String, _ image: Data, _ count: Int, selectedCategory: StockCategory) {
        let newItem = StockItem(context: context)
        newItem.itemTitle = title
        newItem.itemImage = image
        newItem.itemCount = Int64(count)
        newItem.parentCategory = selectedCategory

        do {
            try context.save()
            requestStockItem(selectedCategory: selectedCategory)
            print("#### Save Stock : \(stockItemList.count)")
        } catch {
            print("#### StockItem insert error: \(error)")
        }
    }

    // Read
    func requestStockItem(with request: NSFetchRequest<StockItem> = StockItem.fetchRequest(), predicate: NSPredicate? = nil, selectedCategory: StockCategory) {
        let categoryPredicate = NSPredicate(format: "parentCategory.categoryTitle MATCHES %@", selectedCategory.categoryTitle ?? "N/A")

        if let addtionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, addtionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }

        do {
            stockItemList = try context.fetch(request)

            print("#### Start : \(stockItemList.count)")
        } catch {
            print("#### StockItem request error: \(error)")
        }
    }

    // Delete
    func deleteStockItem(at stockItem: StockItem, _ selectedCategory: StockCategory) {
        context.delete(stockItem)

        do {
            try context.save()
            requestStockItem(selectedCategory: selectedCategory)
        } catch {
            print("#### Delete Stock Item Error : \(error)")
        }
    }

    // Update - Content
    func updateStockItem(stockItem: StockItem, newTitle: String, newImage: Data, newCount: Int, selectedCategory: StockCategory) {
        stockItem.itemTitle = newTitle
        stockItem.itemImage = newImage
        stockItem.itemCount = Int64(newCount)

        do {
            try context.save()
            requestStockItem(selectedCategory: selectedCategory)
        } catch {
            print("#### Update Stock Item Error : \(error)")
        }
    }

    func updateStockConfirm(_ stockItem: StockItem, isConfirm: Bool, selectedCategory: StockCategory) {
        stockItem.isConfirm = isConfirm

        do {
            try context.save()
            requestStockItem(selectedCategory: selectedCategory)
        } catch {
            print("#### Update Error : \(error)")
        }
    }
}

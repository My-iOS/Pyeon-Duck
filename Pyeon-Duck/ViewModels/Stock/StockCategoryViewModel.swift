//
//  StockViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import Foundation

class StockCategoryViewModel {
    private var dataManager: DataManager

    var requestStockCategoryCount: Int {
        self.dataManager.stockCategoryList.count
    }

    var stockCategoryList: [StockCategory] {
        return self.dataManager.stockCategoryList
    }

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

// MARK: - CRUD

extension StockCategoryViewModel {
    func fetchStockCategory() {
        self.dataManager.requestStockCategory()
    }

    func addStockCategory(_ title: String) {
        self.dataManager.addStockCategory(title)
    }

    func deleteStockCategory(at indexPath: IndexPath) {
        self.dataManager.deleteStockCategory(at: indexPath)
    }

    // Task
    // Update
}

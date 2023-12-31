//
//  StockDetailViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/30/23.
//

import Foundation

class StockItemViewModel {
    private var dataManager = DataManager()
    var selectedStockCategory: StockCategory?

    var requestStockItemCount: Int {
        return self.dataManager.stockItemList.count
    }

    var stockItemList: [StockItem] {
        return self.dataManager.stockItemList
    }
}

// MARK: - CRUD

extension StockItemViewModel {
    func fetchStockItem(_ selectedCategory: StockCategory) {
        self.dataManager.requestStockItem(selectedCategory: selectedCategory)
    }

    func deleteStockItem(at indexPath: IndexPath, selectedCategory: StockCategory) {
        self.dataManager.deleteStockItem(at: indexPath, selectedCategory)
    }

    func updateStockItem(stockItem: StockItem, newTitle: String, newImage: Data, newCount: Int, selectedCategory: StockCategory) {
        self.dataManager.updateStockItem(stockItem: stockItem, newTitle: newTitle, newImage: newImage, newCount: newCount, selectedCategory: selectedCategory)
    }

    func updateCompletedStatus(_ stockItem: StockItem, isConfirm: Bool, selectedCategory: StockCategory) {
        self.dataManager.updateStockConfirm(stockItem, isConfirm: isConfirm, selectedCategory: selectedCategory)
    }
}

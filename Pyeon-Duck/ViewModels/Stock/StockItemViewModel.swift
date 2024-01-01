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
        return self.dataManager.stockItemList.sorted { $0.isConfirm && !$1.isConfirm }
    }
}

// MARK: - CRUD

extension StockItemViewModel {
    func fetchStockItem(_ selectedCategory: StockCategory) {
        self.dataManager.requestStockItem(selectedCategory: selectedCategory)
    }

    func deleteStockItem(at stockItem: StockItem, selectedCategory: StockCategory) {
        self.dataManager.deleteStockItem(at: stockItem, selectedCategory)
    }

    func updateStockItem(stockItem: StockItem, newTitle: String, newImage: Data, newCount: Int, selectedCategory: StockCategory) {
        self.dataManager.updateStockItem(stockItem: stockItem, newTitle: newTitle, newImage: newImage, newCount: newCount, selectedCategory: selectedCategory)
    }

    func updateCompletedStatus(_ stockItem: StockItem, isConfirm: Bool, selectedCategory: StockCategory) {
        self.dataManager.updateStockConfirm(stockItem, isConfirm: isConfirm, selectedCategory: selectedCategory)
    }
}

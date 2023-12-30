//
//  StockDetailViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/30/23.
//

import Foundation

class StockDetailViewModel {
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

extension StockDetailViewModel {
    func fetchStockItem(_ selectedCategory: StockCategory) {
        self.dataManager.requestStockItem(selectedCategory: selectedCategory)
    }
}

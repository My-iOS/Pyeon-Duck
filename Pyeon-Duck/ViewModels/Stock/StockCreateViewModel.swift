//
//  StockCreateViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/30/23.
//

import Foundation

class StockCreateViewModel {
    private var dataManager = DataManager()
    var selectedStockCategory: StockCategory?
}

extension StockCreateViewModel {
    func addStockItem(_ title: String, _ image: Data, _ count: Int64, _ selectedCategory: StockCategory) {
        self.dataManager.addStockItem(title, image, Int(count), selectedCategory: selectedCategory)
    }
}

//
//  StockViewModel.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import Foundation

class StockViewModel {
    private var dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

// MARK: - CRUD

extension StockViewModel {
    var requestStockCount: Int {
        self.dataManager.stockList.count
    }
}

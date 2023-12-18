//
//  StockVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import UIKit

class StockVC: UIViewController {
    var viewModel: StockViewModel!

    deinit {
        print("Deinitialized StockVC")
    }
}

// MARK: - View Life Cycle

extension StockVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "재고조사"
    }
}

// MARK: - ViewModelInjectable

extension StockVC: ViewModelInjectable {
    func injectViewModel(_ viewModelType: StockViewModel) {
        self.viewModel = viewModelType
    }
}

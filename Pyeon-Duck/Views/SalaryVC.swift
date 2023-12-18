//
//  SalaryVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import UIKit

class SalaryVC: UIViewController {
    var viewModel: SalaryViewModel!

    deinit {
        print("Deinitialized SalaryVC")
    }
}

// MARK: - View Life Cycle

extension SalaryVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "시급 계산기"
    }
}

// MARK: - ViewModelInjectable

extension SalaryVC: ViewModelInjectable {
    func injectViewModel(_ viewModelType: SalaryViewModel) {
        self.viewModel = viewModelType
    }
}

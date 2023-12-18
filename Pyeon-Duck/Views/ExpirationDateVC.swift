//
//  ExpirationDateVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/13/23.
//

import UIKit

class ExpirationDateVC: UIViewController {
    var viewModel: ExpirationDateViewModel!

    deinit {
        print("Deinitialized ExpirationDateVC")
    }
}

// MARK: - View Life Cycle

extension ExpirationDateVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "유통기한"
    }
}

// MARK: - ViewModelInjectable

extension ExpirationDateVC: ViewModelInjectable {
    func injectViewModel(_ viewModelType: ExpirationDateViewModel) {
        self.viewModel = viewModelType
    }
}

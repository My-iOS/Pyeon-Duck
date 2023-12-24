//
//  StockVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import UIKit

/*
 필수 구현 사항
 1. 재고 리스트 CRUD
 2. 재고 정렬 (가나다순, 완료 순)
 */

class StockVC: UIViewController {
    var viewModel: StockViewModel!

    var tableView = CustomTableView(frame: .zero, style: .plain)

    deinit {
        print("Deinitialized StockVC")
    }
}

// MARK: - View Life Cycle

extension StockVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "재고조사"
        setUpUI()
    }
}

// MARK: - Setting Up UI

extension StockVC {
    func setUpUI() {
        view.backgroundColor = .white
        addView()
        registerCell()
        createTableView()

        createAddButton()
    }

    func addView() {
        view.addSubview(tableView)
    }

    func registerCell() {
        tableView.register(StocCategorykCell.self, forCellReuseIdentifier: StocCategorykCell.identifier)
    }
}

// MARK: - Method

extension StockVC {
    // Create Add NavigationItem
    func createAddButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        tabBarController?.navigationItem.rightBarButtonItem = button
    }

    @objc func didTapAddButton(_ sender: UIBarButtonItem) {}
}

// MARK: - Confirm TableView

extension StockVC {
    func createTableView() {
        tableView.backgroundColor = .systemOrange
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Method

extension StockVC {}

// MARK: - UITableViewDataSource

extension StockVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.requestStockCategoryCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StocCategorykCell.identifier, for: indexPath) as? StocCategorykCell else { return UITableViewCell() }
        cell.backgroundColor = .systemPink
        return cell
    }
}

// MARK: - UITableViewDelegate

extension StockVC: UITableViewDelegate {}

// MARK: - ViewModelInjectable

extension StockVC: ViewModelInjectable {
    func injectViewModel(_ viewModelType: StockViewModel) {
        viewModel = viewModelType
    }
}

//
//  StockVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import UIKit

class StockVC: UIViewController {
    var viewModel: StockViewModel!
    var itemList = Stock.sampleData

    private var tableView = CustomTableView(frame: .zero, style: .plain)

    deinit {
        print("Deinitialized StockVC")
    }
}

// MARK: - View Life Cycle

extension StockVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "재고조사"
    }
}

// MARK: - Setting Up UI

extension StockVC {
    func setUpUI() {
        view.backgroundColor = .white
        addView()
        registerCell()
        createTableView()
    }

    func addView() {
        view.addSubview(tableView)
    }

    func registerCell() {
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.identifier)
    }
}

// MARK: - Confirm TableView

extension StockVC {
    func createTableView() {
        tableView.backgroundColor = .systemOrange
        tableView.dataSource = self
//        tableView.delegate = self

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
        return itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.identifier, for: indexPath) as? StockCell else { return UITableViewCell() }
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

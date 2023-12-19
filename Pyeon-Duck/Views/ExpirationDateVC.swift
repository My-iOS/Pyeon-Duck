//
//  ExpirationDateVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/13/23.
//

import UIKit

class ExpirationDateVC: UIViewController {
    var viewModel: ExpirationDateViewModel!
    var itemList = ExpirationDate.sampleData

    private var tableView = CustomTableView(frame: .zero, style: .plain)

    deinit {
        print("Deinitialized ExpirationDateVC")
    }
}

// MARK: - View Life Cycle

extension ExpirationDateVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "유통기한"
    }
}

// MARK: - Setting Up UI

extension ExpirationDateVC {
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
        tableView.register(ExpirationCell.self, forCellReuseIdentifier: ExpirationCell.identifier)
    }
}

// MARK: - Confirm TableView

extension ExpirationDateVC {
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

extension ExpirationDateVC {}

// MARK: - UITableViewDataSource

extension ExpirationDateVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpirationCell.identifier, for: indexPath) as? ExpirationCell else { return UITableViewCell() }
        cell.backgroundColor = .systemPink
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ExpirationDateVC: UITableViewDelegate {}

// MARK: - ViewModelInjectable

extension ExpirationDateVC: ViewModelInjectable {
    func injectViewModel(_ viewModelType: ExpirationDateViewModel) {
        viewModel = viewModelType
    }
}

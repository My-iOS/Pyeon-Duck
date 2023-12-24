//
//  ExpirationListVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/24/23.
//

import UIKit

class ExpirationListVC: UIViewController {
    var viewModel = ExpirationListViewModel(dataManager: DataManager())

    var tableView = CustomTableView(frame: .zero, style: .insetGrouped)

    deinit {
        print("#### Deinitilized ExpirationListVC")
    }
}

// MARK: - View Life Cycle

extension ExpirationListVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup UI

extension ExpirationListVC {
    func setupUI() {
        view.backgroundColor = .white
        addView()
        createTableView()
        registerCell()
    }

    func addView() {
        view.addSubview(tableView)
    }
}

// MARK: - Make Components && Constraints

extension ExpirationListVC {
    func createTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func registerCell() {
        tableView.register(ExpirationListCell.self, forCellReuseIdentifier: ExpirationListCell.identifier)
    }
}

// MARK: - UITableViewDataSource

extension ExpirationListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpirationListCell.identifier, for: indexPath) as? ExpirationListCell else { return UITableViewCell() }
        cell.backgroundColor = .red
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ExpirationListVC: UITableViewDelegate {}

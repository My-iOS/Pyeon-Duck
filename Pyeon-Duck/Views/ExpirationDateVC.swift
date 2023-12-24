//
//  ExpirationDateVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/13/23.
//

import UIKit

/*
 필수 구현 사항
 1. 연도 5년 간 표시(기본값) - 2024년
 2. 년도 바뀔 시, 자동으로 1년 추가
 */

class ExpirationDateVC: UIViewController {
    var viewModel: ExpirationDateViewModel!

    var tableView = CustomTableView(frame: .zero, style: .plain)

    deinit {
        print("Deinitialized ExpirationDateVC")
    }
}

// MARK: - View Life Cycle

extension ExpirationDateVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()

        viewModel.fetchExpirationList()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "유통기한"
        tableView.reloadData()
    }
}

// MARK: - Setting Up UI

extension ExpirationDateVC {
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

extension ExpirationDateVC {
    // Create Add NavigationItem
    func createAddButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        tabBarController?.navigationItem.rightBarButtonItem = button
    }

    @objc func didTapAddButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Folder", message: "Enter new folder", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)

        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }

            self?.viewModel.addExpiration(text)
            self?.tableView.reloadData()

        }))

        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ExpirationDateVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.requestExpirationCount ?? 0
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

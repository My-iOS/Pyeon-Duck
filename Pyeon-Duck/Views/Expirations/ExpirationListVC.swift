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
    var addFloattingButton = CustomButton(frame: .zero)

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

        createAddFloattingButton()
    }

    func addView() {
        view.addSubview(tableView)
        view.addSubview(addFloattingButton)
    }
}

// MARK: - Make Components && Constraints

extension ExpirationListVC {
    func createTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func registerCell() {
        tableView.register(ExpirationListCell.self, forCellReuseIdentifier: ExpirationListCell.identifier)
    }
}

// MARK: - AddFloattingButton Method

extension ExpirationListVC {
    @objc func didTapAddButton(_ sender: UIButton) {
        let vc = ExpirationCreateVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    func createAddFloattingButton() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30) // 이미지 크기 조절
        let image = UIImage(systemName: "plus", withConfiguration: configuration)
        addFloattingButton.setImage(image, for: .normal)
        addFloattingButton.backgroundColor = .systemRed
        addFloattingButton.tintColor = .white
        addFloattingButton.layer.cornerRadius = 30
        addFloattingButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            addFloattingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            addFloattingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            addFloattingButton.widthAnchor.constraint(equalToConstant: 60),
            addFloattingButton.heightAnchor.constraint(equalToConstant: 60),
        ])
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

extension ExpirationListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("#### \(indexPath)")
        let vc = ExpirationDetailVC()
        present(vc, animated: true)
    }
}

//
//  ExpirationListVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/24/23.
//

import UIKit

class ExpirationListVC: UIViewController {
    var viewModel = ExpirationListViewModel(dataManager: DataManager())

    var tableView = CustomTableView(frame: .zero, style: .plain)
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
        viewModel.fetchExpirationList()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchExpirationList()
        tableView.reloadData()
    }
}

// MARK: - Setup UI

extension ExpirationListVC {
    func setupUI() {
        view.backgroundColor = .systemGray6
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
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

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
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold) // 이미지 크기 조절
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
        return viewModel.expirationList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpirationListCell.identifier, for: indexPath) as? ExpirationListCell else { return UITableViewCell() }
        let item = viewModel.expirationList[indexPath.row]
        cell.isConfirm = item.isConfirm
        cell.confirm(item.title ?? "N/A", item.itemImage ?? Data(), item.isConfirm)
        cell.setupAlpah(item.isConfirm)

        cell.actionHandler = { [weak self] isConfirm in
            guard let self = self else { return }
            print("#### 지금 \(isConfirm)")
            viewModel.updateCompletedStatus(item, isConfirm: isConfirm)
        }

        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - UITableViewDelegate

extension ExpirationListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.expirationList[indexPath.row]
        let vc = ExpirationDetailVC()
        vc.viewModel.selectedItem = item
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 오른쪽에 만들기
        let item = viewModel.expirationList[indexPath.row]

        let like = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.viewModel.deleteExpiration(at: indexPath)
            tableView.reloadData()
            success(true)
        }
        like.backgroundColor = .systemRed

        let share = UIContextualAction(style: .normal, title: "편집") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("Share 클릭 됨")

            let vc = ExpirationCreateVC()
            vc.viewModel.expirationItem = item
            vc.viewModel.selectedTagNum = 2

            vc.itemTitleTextField.text = item.title
            vc.datePicker.date = self.viewModel.strToDate(item.date ?? Date.now.description)

            self.navigationController?.pushViewController(vc, animated: true)
            success(true)
        }
        share.backgroundColor = .systemBlue

        // actions배열 인덱스 0이 왼쪽에 붙어서 나옴
        return UISwipeActionsConfiguration(actions: [like, share])
    }
}

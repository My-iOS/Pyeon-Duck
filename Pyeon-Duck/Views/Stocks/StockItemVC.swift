//
//  StockItemVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/25/23.
//

import UIKit

class StockItemVC: UIViewController {
    var viewModel = StockItemViewModel()

    var tableView = CustomTableView(frame: .zero, style: .plain)
    var addFloattingButton = CustomButton(frame: .zero)

    var currentCategory: String?
}

// MARK: - View Life Cycle

extension StockItemVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchStockItem(viewModel.selectedStockCategory!)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = currentCategory ?? "N/A"
        viewModel.fetchStockItem(viewModel.selectedStockCategory!)
        tableView.reloadData()
    }
}

// MARK: - Set up UI

extension StockItemVC {
    func setupUI() {
        view.backgroundColor = .systemGray5
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

// MARK: - Create Components && Make Constraints

extension StockItemVC {
    func createTableView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
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
        tableView.register(StockItemCell.self, forCellReuseIdentifier: StockItemCell.identifier)
    }
}

// MARK: - AddFloattingButton Method

extension StockItemVC {
    @objc func didTapAddButton(_ sender: UIButton) {
        let vc = StockCreateVC()
        vc.viewModel.selectedStockCategory = viewModel.selectedStockCategory
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

extension StockItemVC: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.requestStockItemCount
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockItemCell.identifier, for: indexPath) as? StockItemCell else { return UITableViewCell() }
        let item = viewModel.stockItemList[indexPath.row]
        cell.isConfirm = item.isConfirm
        cell.confirm(item.itemTitle ?? "N/A", Int(item.itemCount), item.itemImage ?? Data(), item.isConfirm)
        cell.setupAlpah(item.isConfirm)

        cell.actionHandler = { [weak self] isConfirm in
            guard let self = self else { return }

            HapticManager.shared.hapticImpact(style: .light)
            viewModel.updateCompletedStatus(item, isConfirm: isConfirm, selectedCategory: viewModel.selectedStockCategory!)
            viewWillAppear(true)
        }

        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - UITableViewDelegate

extension StockItemVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.stockItemList[indexPath.row]
        let vc = StockDetailVC()
        vc.viewModel.stockItem = item
        vc.viewModel.selectedCategory = viewModel.selectedStockCategory
        navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 오른쪽에 만들기
        let item = viewModel.stockItemList[indexPath.row]

        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.viewModel.deleteStockItem(at: item, selectedCategory: self.viewModel.selectedStockCategory!)
            tableView.reloadData()
            success(true)
        }
        delete.backgroundColor = .systemRed

        // actions배열 인덱스 0이 왼쪽에 붙어서 나옴
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - SWIFT UI PREVIEWS

// #if DEBUG
// import SwiftUI
//
// @available(iOS 13, *)
// extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
//        // this variable is used for injecting the current view controller
//        let viewController: UIViewController
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//    }
//
//    func toPreview() -> some View {
//        // inject self (the current view controller) for the preview
//        Preview(viewController: self)
//    }
// }
//
// @available(iOS 13.0, *)
// struct StockItemVC_Preview: PreviewProvider {
//    static var previews: some View {
//        StockItemVC().toPreview()
//    }
// }
// #endif

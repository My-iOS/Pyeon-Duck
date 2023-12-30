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

class StockCategoryVC: UIViewController {
    var viewModel: StockViewModel!

    var addFloattingButton = CustomButton(frame: .zero)
    var tableView = CustomTableView(frame: .zero, style: .insetGrouped)

    deinit {
        print("Deinitialized StockVC")
    }
}

// MARK: - View Life Cycle

extension StockCategoryVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchStockCategory()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "재고조사"
        tabBarController?.navigationItem.rightBarButtonItem = nil
        setUpUI()
        viewModel.fetchStockCategory()
        tableView.reloadData()
    }
}

// MARK: - Setting Up UI

extension StockCategoryVC {
    func setUpUI() {
        view.backgroundColor = .white
        addView()
        registerCell()
        createTableView()
        createAddFloattingButton()
    }

    func addView() {
        view.addSubview(tableView)
        view.addSubview(addFloattingButton)
    }

    func registerCell() {
        tableView.register(StocCategorykCell.self, forCellReuseIdentifier: StocCategorykCell.identifier)
    }
}

// MARK: - AddFloattingButton Method

extension StockCategoryVC {
    // To-Do Stuff : Alert 로 카테고리 생성
    @objc func didTapAddButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "alert", message: "textField", preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in textField.placeholder = "input todo" }

        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let content = alert.textFields?.first?.text,
                  let self = self
            else {
                return
            }
            self.viewModel.addStockCategory(content)

            self.tableView.reloadData()
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
        }

        alert.addAction(cancel)
        alert.addAction(save)

        present(alert, animated: true, completion: nil)
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
            addFloattingButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -12),
            addFloattingButton.widthAnchor.constraint(equalToConstant: 60),
            addFloattingButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - Confirm TableView

extension StockCategoryVC {
    func createTableView() {
        tableView.backgroundColor = .systemOrange
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource

extension StockCategoryVC: UITableViewDataSource {
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

extension StockCategoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StockItemVC()
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 오른쪽에 만들기
        let item = viewModel.stockCategoryList[indexPath.row]

        let like = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.viewModel.deleteStockCategory(at: indexPath)

            DispatchQueue.main.async {
                tableView.reloadData()
            }
            success(true)
        }
        like.backgroundColor = .systemRed

        let share = UIContextualAction(style: .normal, title: "편집") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("Share 클릭 됨")

//
            success(true)
        }
        share.backgroundColor = .systemBlue

        // actions배열 인덱스 0이 왼쪽에 붙어서 나옴
        return UISwipeActionsConfiguration(actions: [like, share])
    }
}

// MARK: - ViewModelInjectable

extension StockCategoryVC: ViewModelInjectable {
    func injectViewModel(_ viewModelType: StockViewModel) {
        viewModel = viewModelType
    }
}

// #if DEBUG
// import SwiftUI
//
// extension UIViewController {
//    private struct Preview: UIViewControllerRepresentable {
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
//        Preview(viewController: self)
//    }
// }
//
// struct StockVC_PreView: PreviewProvider {
//    static var previews: some View {
//        // StockViewModel의 인스턴스를 생성하고 주입합니다.
//        let dataManager = DataManager()
//        let viewModel = StockViewModel(dataManager: dataManager)
//        let stockVC = StockVC()
//        stockVC.injectViewModel(viewModel)
//
//        return stockVC.toPreview()
//    }
// }#endif

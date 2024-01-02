//
//  StockVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import UIKit

class StockCategoryVC: UIViewController {
    var viewModel: StockCategoryViewModel!

    var addFloattingButton = CustomButton(frame: .zero)
    var tableView = CustomTableView(frame: .zero, style: .plain)

    deinit {
        print("Deinitialized StockVC")
    }
}

// MARK: - View Life Cycle

extension StockCategoryVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
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
        view.backgroundColor = .systemGray6
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
        tableView.register(StockCategoryCell.self, forCellReuseIdentifier: StockCategoryCell.identifier)
    }
}

// MARK: - AddFloattingButton Method

extension StockCategoryVC {
    // To-Do Stuff : Alert 로 카테고리 생성
    @objc func didTapAddButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "카테고리", message: "", preferredStyle: .alert)
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "카테고리명을 입력해주세요"
            textField.clearButtonMode = .whileEditing
        }

        let save = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            guard let content = alert.textFields?.first?.text,
                  let self = self
            else {
                return
            }
            self.viewModel.addStockCategory(content)

            self.tableView.reloadData()
        }

        let cancel = UIAlertAction(title: "취소", style: .destructive) { (cancel) in
        }

        alert.addAction(cancel)
        alert.addAction(save)

        present(alert, animated: true, completion: nil)
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
            addFloattingButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -12),
            addFloattingButton.widthAnchor.constraint(equalToConstant: 60),
            addFloattingButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - Confirm TableView

extension StockCategoryVC {
    func createTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockCategoryCell.identifier, for: indexPath) as? StockCategoryCell else { return UITableViewCell() }
        let item = viewModel.stockCategoryList[indexPath.row]
        cell.titleLabel.text = item.categoryTitle
        cell.countLabel.text = "\(Int(item.items?.count ?? 0)) 개"
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - UITableViewDelegate

extension StockCategoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.stockCategoryList[indexPath.row]
        let vc = StockItemVC()
        vc.currentCategory = item.categoryTitle
        vc.viewModel.selectedStockCategory = item
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 오른쪽에 만들기
        let item = viewModel.stockCategoryList[indexPath.row]

        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.viewModel.deleteStockCategory(at: indexPath)

            DispatchQueue.main.async {
                tableView.reloadData()
            }
            success(true)
        }
        delete.backgroundColor = .systemRed

        let edit = UIContextualAction(style: .normal, title: "편집") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in

            let alert = UIAlertController(title: "카테고리 편집", message: "", preferredStyle: .alert)
            alert.addTextField { (textField: UITextField) in
                textField.placeholder = "새로운 카테고리명을 입력해주세요"
                textField.clearButtonMode = .whileEditing
            }

            let save = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
                guard let content = alert.textFields?.first?.text,
                      let self = self
                else {
                    return
                }
                self.viewModel.updateStockCategory(item, title: content)

                self.tableView.reloadData()
            }

            let cancel = UIAlertAction(title: "취소", style: .destructive) { (cancel) in
            }

            alert.addAction(cancel)
            alert.addAction(save)

            self.present(alert, animated: true, completion: nil)

            success(true)
        }
        edit.backgroundColor = .systemBlue

        // actions배열 인덱스 0이 왼쪽에 붙어서 나옴
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }
}

// MARK: - ViewModelInjectable

extension StockCategoryVC: ViewModelInjectable {
    func injectViewModel(_ viewModelType: StockCategoryViewModel) {
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

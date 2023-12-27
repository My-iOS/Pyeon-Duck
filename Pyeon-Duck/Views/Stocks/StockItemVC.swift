//
//  StockItemVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/25/23.
//

import UIKit

class StockItemVC: UIViewController {
    var tableView = CustomTableView(frame: .zero, style: .insetGrouped)
    var addFloattingButton = CustomButton(frame: .zero)
}

// MARK: - View Life Cycle

extension StockItemVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Set up UI

extension StockItemVC {
    func setupUI() {
        view.backgroundColor = .white
        addView()
        createTableView()

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
        tableView.backgroundColor = .systemOrange
        tableView.dataSource = self
        tableView.delegate = self

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - AddFloattingButton Method

extension StockItemVC {
    @objc func didTapAddButton(_ sender: UIButton) {
        let vc = StockCreateVC()
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

extension StockItemVC: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension StockItemVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StockDetailVC()
        navigationController?.pushViewController(vc, animated: true)
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

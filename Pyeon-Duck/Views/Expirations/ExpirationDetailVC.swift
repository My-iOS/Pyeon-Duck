//
//  ExpirationDetailVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/25/23.
//

import UIKit

class ExpirationDetailVC: UIViewController {
    var viewModel = ExpirationDetailViewModel()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    // MARK: - 본 내용들이 들어가는 View

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    // MARK: - 상태 표시 설명 라벨

    let describeImageLabel = CustomLabel(frame: .zero) // 이미지 설명
    let describeTitleLable = CustomLabel(frame: .zero) // 상품 이름 설명
    let describeExpirationLabel = CustomLabel(frame: .zero) // 상품 날짜 설명
    let describeCreateDateLabel = CustomLabel(frame: .zero) // 상품 작성 일자 설명
    let describeModifiedDateLabel = CustomLabel(frame: .zero) // 변경 일자 설명

    // MARK: - 상태 표시 라벨들

    let imageView = CustomImageView(frame: .zero) // 상품 이미지 라벨
    let itemTitleLabel = CustomLabel(frame: .zero) // 상품 이름 라벨
    let expirationDateLabel = CustomLabel(frame: .zero) // 유통기한 라벨
    let createDateLabel = CustomLabel(frame: .zero) // 작성 일자 라벨
    let modifiedDateLabel = CustomLabel(frame: .zero) // 수정 일자 라벨

    // MARK: - 변경 버튼

    var editButton = CustomButton(frame: .zero) // 변경 버튼
}

// MARK: - View Life Cycle

extension ExpirationDetailVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Set up UI

extension ExpirationDetailVC {
    func setupUI() {
        view.backgroundColor = .white
        addView()

        createScrollView()
        createContentView()
        createDescribeImageLabel()
        createImageView()
        createDescribeTitleLabel()
        createItemTitleLabel()
        createDescribeExpirationLabel()
        createExpirationDateLabel()
        createDescribeCreateDateLabel()
        createCreateDateLabel()
        createDescribeModifiedDateLabel()
        createModifiedDateLabel()

        createEditButton()
    }

    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [describeImageLabel, describeTitleLable, describeExpirationLabel, describeCreateDateLabel, describeModifiedDateLabel].forEach {
            contentView.addSubview($0)
        }

        [imageView, itemTitleLabel, expirationDateLabel, expirationDateLabel, createDateLabel, modifiedDateLabel, editButton].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - Create Components && Make Constraints

extension ExpirationDetailVC {
    func createScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func createContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//            contentView.heightAnchor.constraint(equalToConstant: 1000),
        ])
    }

    func createDescribeImageLabel() {
        describeImageLabel.text = "상품 이미지"
        describeImageLabel.textAlignment = .center
        describeImageLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            describeImageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            describeImageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            describeImageLabel.widthAnchor.constraint(equalToConstant: 150),
            describeImageLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createImageView() {
        // 대체 이미지 설정
        let defaultImage = UIImage(systemName: "bell")
        if let image = viewModel.selectedItem?.itemImage {
            imageView.image = UIImage(data: image)
        } else {
            imageView.image = defaultImage
            imageView.tintColor = .white
        }

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true // 코너 반경을 적용하기 위해 필요

        // Auto Layout 설정
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: describeImageLabel.bottomAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }

    func createDescribeTitleLabel() {
        describeTitleLable.text = "상품 이름 :"
        describeTitleLable.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            describeTitleLable.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            describeTitleLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            describeTitleLable.widthAnchor.constraint(equalToConstant: 150),
            describeTitleLable.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createItemTitleLabel() {
        itemTitleLabel.text = viewModel.selectedItem?.title
        itemTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: describeTitleLable.topAnchor, constant: 0),
            itemTitleLabel.leadingAnchor.constraint(equalTo: describeTitleLable.trailingAnchor, constant: 12),
            itemTitleLabel.widthAnchor.constraint(equalToConstant: 150),
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createDescribeExpirationLabel() {
        describeExpirationLabel.text = "유통기한 :"
        describeExpirationLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            describeExpirationLabel.topAnchor.constraint(equalTo: describeTitleLable.bottomAnchor, constant: 20),
            describeExpirationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            describeExpirationLabel.widthAnchor.constraint(equalToConstant: 150),
            describeExpirationLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createExpirationDateLabel() {
        expirationDateLabel.text = viewModel.selectedItem?.date
        expirationDateLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            expirationDateLabel.topAnchor.constraint(equalTo: describeTitleLable.bottomAnchor, constant: 20),
            expirationDateLabel.leadingAnchor.constraint(equalTo: describeExpirationLabel.trailingAnchor, constant: 24),
            expirationDateLabel.widthAnchor.constraint(equalToConstant: 150),
            expirationDateLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createDescribeCreateDateLabel() {
        describeCreateDateLabel.text = "작성일자 :"
        describeCreateDateLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            describeCreateDateLabel.topAnchor.constraint(equalTo: describeExpirationLabel.bottomAnchor, constant: 20),
            describeCreateDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            describeCreateDateLabel.widthAnchor.constraint(equalToConstant: 150),
            describeCreateDateLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createCreateDateLabel() {
        createDateLabel.text = viewModel.selectedItem?.creationDate
        createDateLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            createDateLabel.topAnchor.constraint(equalTo: describeExpirationLabel.bottomAnchor, constant: 20),
            createDateLabel.leadingAnchor.constraint(equalTo: describeCreateDateLabel.trailingAnchor, constant: 24),
            createDateLabel.widthAnchor.constraint(equalToConstant: 150),
            createDateLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createDescribeModifiedDateLabel() {
        describeModifiedDateLabel.text = "변경 일자 :"
        describeModifiedDateLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            describeModifiedDateLabel.topAnchor.constraint(equalTo: describeCreateDateLabel.bottomAnchor, constant: 20),
            describeModifiedDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            describeModifiedDateLabel.widthAnchor.constraint(equalToConstant: 150),
            describeModifiedDateLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createModifiedDateLabel() {
        if viewModel.selectedItem?.modifiedDate == nil {
            modifiedDateLabel.text = "N/A"
        } else {
            modifiedDateLabel.text = viewModel.selectedItem?.modifiedDate
        }

        modifiedDateLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            modifiedDateLabel.topAnchor.constraint(equalTo: describeModifiedDateLabel.topAnchor, constant: 0),
            modifiedDateLabel.leadingAnchor.constraint(equalTo: describeModifiedDateLabel.trailingAnchor, constant: 24),
            modifiedDateLabel.widthAnchor.constraint(equalToConstant: 150),
            modifiedDateLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createEditButton() {
        editButton.setTitle("변경", for: .normal)
        editButton.layer.cornerRadius = 10
        editButton.backgroundColor = .systemBlue
        editButton.tintColor = .white
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: describeModifiedDateLabel.bottomAnchor, constant: 30),
            editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            editButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 150),
            editButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - Edit Button Method

extension ExpirationDetailVC {
    @objc func didTapEditButton(_ sender: UIButton) {
        let vc = ExpirationCreateVC()
        vc.viewModel.expirationItem = viewModel.selectedItem
        vc.viewModel.selectedTagNum = 2

        vc.itemTitleTextField.text = viewModel.selectedItem?.title
        vc.datePicker.date = viewModel.strToDate(viewModel.selectedItem?.date ?? Date.now.description)

        navigationController?.pushViewController(vc, animated: true)
    }
}

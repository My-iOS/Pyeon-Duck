//
//  ExpirationCreateVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/24/23.
//

import Speech
import UIKit

class ExpirationCreateVC: UIViewController {
    var viewModel = ExpirationDateCreateViewModel()
    private var textFieldPosY = CGFloat(0)

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = false
        return scrollView
    }()

    // MARK: - 본 내용들이 들어가는 View

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - 상품 안내

    let itemImageLabel = CustomLabel(frame: .zero) // 상품 이미지 레이블
    let itemTitleLabel = CustomLabel(frame: .zero) // 상품 이름
    let createdItemDateLabel = CustomLabel(frame: .zero) // 등록한 상품 날짜
    let modifiedItemDateLabel = CustomLabel(frame: .zero) // 수정한 상품 날짜
    let expirationDateLabel = CustomLabel(frame: .zero) // 상품 유통기한 날짜

    // MARK: - 상품 입력

    var imageView = CustomImageView(frame: .zero) // 직접 찍은 상품 이미지
    var itemTitleTextField = CustomTextField(frame: .zero) // 상품 입력 텍스트 필드
    var microphoneButton = CustomButton(frame: .zero) // 음성 입력 버튼
    let datePicker = UIDatePicker() // 유통기한 날짜 입력

    // MARK: - 저장 버튼

    var saveButton = CustomButton(frame: .zero) // 저장 버튼

    deinit {
        print("#### Deinitialized ExpirationCreateVC")
    }
}

// MARK: - View Life Cycle

extension ExpirationCreateVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "유통기한 상품 작성"
        navigationItem.largeTitleDisplayMode = .never
        setupUI()
    }
}

// MARK: - Setup UI

extension ExpirationCreateVC {
    func setupUI() {
        view.backgroundColor = .systemGray6
        viewModel.sstService.speechRecognizer?.delegate = self
        hideKeyboardWhenTappedAround()
        keyboardCheck()

        addView()
        createScrollView()
        createContentView()

        createItemImageLabel()
        createImageView()
        createItemTitleLabel()
        createItemTitleTextField()
        createMicrophoneButton()
        createExpirationDateLabel()
        createDatePicker()
        createSaveButton()
    }

    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [itemImageLabel, imageView, itemTitleLabel, itemTitleTextField, microphoneButton, expirationDateLabel, datePicker, saveButton].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - Create UI Components && Make Constraints

extension ExpirationCreateVC {
    func createScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    func createContentView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // 너비 제약 조건 추가
//            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1400), // 높이 제약 조건 추가 (필요에 따라 조절)
        ])
    }

    func createItemImageLabel() {
        itemImageLabel.text = "상품 이미지"
        itemImageLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            itemImageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            itemImageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImageLabel.widthAnchor.constraint(equalToConstant: 120),
            itemImageLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createImageView() {
        if viewModel.expirationItem == nil {
            imageView.image = UIImage(systemName: "camera")
        } else {
            if let image = viewModel.expirationItem?.itemImage {
                imageView.image = UIImage(data: image)
            }
        }

        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray6
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true

        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        imageView.addGestureRecognizer(tapGesture)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: itemImageLabel.bottomAnchor, constant: 12),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }

    func createItemTitleLabel() {
        itemTitleLabel.text = "상품 이름"
        itemTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            itemTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            itemTitleLabel.widthAnchor.constraint(equalToConstant: 120),
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createItemTitleTextField() {
        itemTitleTextField.clearButtonMode = .whileEditing
        itemTitleTextField.placeholder = "상품 이름을 입력해주세요."
        itemTitleTextField.addLeftPadding()
        itemTitleTextField.layer.cornerRadius = 10
        itemTitleTextField.layer.borderWidth = 1
        itemTitleTextField.layer.borderColor = UIColor.gray.cgColor
        itemTitleTextField.backgroundColor = .white
        itemTitleTextField.delegate = self

        NSLayoutConstraint.activate([
            itemTitleTextField.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 24),
            itemTitleTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            itemTitleTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -96),
            itemTitleTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            itemTitleTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createMicrophoneButton() {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold) // 이미지 크기 조절
        let image = UIImage(systemName: "mic.fill", withConfiguration: configuration)
        microphoneButton.setImage(image, for: .normal)
        microphoneButton.imageView?.tintColor = .white
        microphoneButton.backgroundColor = .red
        microphoneButton.layer.cornerRadius = 10
        microphoneButton.addTarget(self, action: #selector(didTapMicrophoneButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            microphoneButton.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 24),
            microphoneButton.leadingAnchor.constraint(equalTo: itemTitleTextField.trailingAnchor, constant: 10),
            microphoneButton.widthAnchor.constraint(equalToConstant: 60),
            microphoneButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createExpirationDateLabel() {
        expirationDateLabel.text = "상품 유통기한"
        expirationDateLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            expirationDateLabel.topAnchor.constraint(equalTo: itemTitleTextField.bottomAnchor, constant: 24),
            expirationDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            expirationDateLabel.widthAnchor.constraint(equalToConstant: 130),
            expirationDateLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createDatePicker() {
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.timeZone = TimeZone(abbreviation: "GMT+9:00") // Changed to GMT+0:00
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: expirationDateLabel.topAnchor, constant: 0),
            datePicker.leadingAnchor.constraint(equalTo: expirationDateLabel.trailingAnchor, constant: 0),
            datePicker.widthAnchor.constraint(equalToConstant: 200),
            datePicker.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createSaveButton() {
        if viewModel.selectedTagNum == 1 {}
        saveButton.setTitle("저장", for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = .systemBlue
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: expirationDateLabel.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 180),
            saveButton.heightAnchor.constraint(equalToConstant: 60),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
    }
}

// MARK: - SaveButton Method

extension ExpirationCreateVC {
    @objc func didTapSaveButton(_ sender: UIButton) {
        // Convert UIImage to Data
        if itemTitleTextField.text == "" {
            showBlankAlert()
        } else {
            if viewModel.selectedTagNum == 1 {
                // Create
                if let imageData = imageView.image?.pngData() {
                    if imageView.image?.isSymbolImage == true {
                        viewModel.addExpiration(itemTitleTextField.text ?? "N/A", viewModel.dateToStrFormatted(datePicker.date), UIImage(named: "DuckBlankImage")!.pngData()!, viewModel.dateToStrFormatted(Date.now), isConfirm: false)
                    } else {
                        viewModel.addExpiration(itemTitleTextField.text ?? "N/A", viewModel.dateToStrFormatted(datePicker.date), imageData, viewModel.dateToStrFormatted(Date.now), isConfirm: false)
                    }
                }

                navigationController?.popViewController(animated: true)

            } else {
                // Update
                if let item = viewModel.expirationItem {
                    viewModel.updateExpiration(item, newTitle: itemTitleTextField.text ?? "N/A", newDate: viewModel.dateToStrFormatted(datePicker.date), newModifiedDate: viewModel.dateToStrFormatted(Date.now))
                }

                let view = navigationController?.viewControllers as [UIViewController]

                navigationController?.popToViewController(view[1], animated: true)
            }
        }
    }
}

// MARK: - MicrophoneButton Method

extension ExpirationCreateVC {
    @objc func didTapMicrophoneButton(_ sender: UIButton) {
        print("#### \(#function)")
        itemTitleTextField.text = nil
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold) // 이미지 크기 조절
        let image = UIImage(systemName: "mic.fill", withConfiguration: configuration)
        microphoneButton.setImage(image, for: .normal)
        microphoneButton.imageView?.tintColor = .white
        microphoneButton.backgroundColor = .red

        if viewModel.sstService.audioEngine.isRunning {
            viewModel.sstService.audioEngine.stop()
            viewModel.sstService.recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false

        } else {
            viewModel.sstService.startRecording { [weak self] str in
                self?.itemTitleTextField.text = str
            } stopHandler: { [weak self] isStop in
                self?.microphoneButton.isEnabled = isStop
            } placeHandler: { [weak self] str in
                self?.itemTitleTextField.text = str
            }

            let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold) // 이미지 크기 조절
            let image = UIImage(systemName: "mic.fill", withConfiguration: configuration)
            microphoneButton.setImage(image, for: .normal)
            microphoneButton.imageView?.tintColor = .red
            microphoneButton.backgroundColor = .white
        }
    }
}

// MARK: - UITextFieldDelegate

extension ExpirationCreateVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}

// MARK: - 빈 칸 확인 Alert

extension ExpirationCreateVC {
    func showBlankAlert() {
        let alert = UIAlertController(title: "빈 칸이 있습니다.", message: "", preferredStyle: .alert)
        let confirmAlert = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAlert)
        present(alert, animated: true)
    }
}

// MARK: - ImageView Tap Gesture Method

extension ExpirationCreateVC {
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true

        present(picker, animated: false)
    }
}

extension ExpirationCreateVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 이미지 피커에서 이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // 이미지 피커 컨트롤러 창 닫기
        picker.dismiss(animated: false) { () in
            // 이미지를 이미지 뷰에 표시
            let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.imageView.image = img
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: false) { () in
            // 알림 창 호출
            let alert = UIAlertController(title: "", message: "사진 촬영이 취소되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: true)
        }
    }
}

// MARK: - SFSpeechRecognizerDelegate

extension ExpirationCreateVC: SFSpeechRecognizerDelegate {
    // 음성 인식기의 사용 가능 상태가 변경될 때 호출됩니다.
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            // True
            microphoneButton.isEnabled = true
        } else {
            // False
            microphoneButton.isEnabled = false
        }
    }
}

// MARK: - Hide Keyboard When Tapped Around

extension ExpirationCreateVC {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ExpirationCreateVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - 키보드 올렸을 때 뷰 올리는 코드

extension ExpirationCreateVC {
    func keyboardCheck() {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didShowKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func willShowKeyboard(notification: NSNotification) {
        scrollView.isScrollEnabled = false
        if itemTitleTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if contentView.frame.origin.y == textFieldPosY {
                    contentView.frame.origin.y -= keyboardSize.height / 2 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        }
    }

    @objc func didShowKeyboard(notification: NSNotification) {
        scrollView.isScrollEnabled = false
        if itemTitleTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if contentView.frame.origin.y == textFieldPosY {
                    contentView.frame.origin.y -= keyboardSize.height / 2 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        }
    }

    @objc func willHideKeyboard(notification: NSNotification) {
        if contentView.frame.origin.y != textFieldPosY {
            contentView.frame.origin.y = textFieldPosY
            scrollView.isScrollEnabled = true
            itemTitleTextField.isEnabled = true
        }
    }
}

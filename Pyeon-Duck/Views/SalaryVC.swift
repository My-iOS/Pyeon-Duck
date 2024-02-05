//
//  SalaryVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/14/23.
//

import UIKit

class SalaryVC: UIViewController {
    var viewModel: SalaryViewModel!
    private var textFieldPosY = CGFloat(0)

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = true
        return scrollView
    }()

    // MARK: - 본 내용들이 들어가는 View

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - 제목들

    let hourlyWageTitleLabel = CustomLabel(frame: .zero) // 시급 제목
    let workHoursTitleLabel = CustomLabel(frame: .zero) // 근로 시간 제목
    let numberOfWorkingDaysTitleLabel = CustomLabel(frame: .zero) // 근로일 수 제목

    // MARK: - 텍스트필드들

    let hourlyWageTextField = CustomTextField(frame: .zero) // 시급 입력 텍스트필드
    let workHoursTextField = CustomTextField(frame: .zero) // 근로 시간 입력 텍스트 필드

    // MARK: - 근무일 수 담는 스택뷰

    let numberOfWorkingDaysStackView = CustomStackView(frame: .zero)

    // MARK: - 스택뷰에 들어갈 버튼들

    let sundayButton = CustomButton(frame: .zero)
    let mondayButton = CustomButton(frame: .zero)
    let tuesayButton = CustomButton(frame: .zero)
    let wednesdayButton = CustomButton(frame: .zero)
    let thursdayButton = CustomButton(frame: .zero)
    let fridayButton = CustomButton(frame: .zero)
    let saturdayButton = CustomButton(frame: .zero)

    // MARK: - 계산 결과 출력 제목 라벨들

    let resultDailyWageLabel = CustomLabel(frame: .zero) // 일급 계산 결과
    let resultWeeklyWageLabel = CustomLabel(frame: .zero) // 주급 계산 결과
    let resultMonthlyWageLabel = CustomLabel(frame: .zero) // 월급 계산 결과

    // MARK: - 계산 결과 출력 텍스트필드들

    let resultDailyTextField = CustomTextField(frame: .zero) // 일급 계산 결과 출력
    let resultWeeklyTextField = CustomTextField(frame: .zero) // 주급 계산 결과 출력
    let resultMonthlyTextField = CustomTextField(frame: .zero) // 월급 계산 결과 출력

    // MARK: - 계산 하기 버튼

    let calculatorButton = CustomButton(frame: .zero) // 계산 버튼

    // MARK: - 계산

    deinit {
        print("Deinitialized SalaryVC")
    }
}

// MARK: - View Life Cycle

extension SalaryVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "시급 계산기"
        setUpUI()
    }
}

// MARK: - 전체 UI

extension SalaryVC {
    func setUpUI() {
        hideKeyboardWhenTappedAround()
//        keyboardCheck()

        addView()

        createScrollView()
        createContentView()

        createHourlyWageTitleLabel()
        createHourlyWageTextField()
        createWorkHoursTitleLabel()
        createWorkHoursTextField()
        createNumberOfWorkingDaysTitleLabel()

        createNumberOfWorkingDaysStackView()
        createDayButtons()

        createResultDailyWageLabel()
        createResultDailyTextField()
        createResultWeeklyWageLabel()
        createResultWeeklyTextField()
        createResultMonthlyWageLabel()
        createResultMonthlyTextField()

        createCalulatorButton()

        createResetButton()
    }

    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [hourlyWageTitleLabel, hourlyWageTextField, workHoursTitleLabel, workHoursTextField, numberOfWorkingDaysTitleLabel, numberOfWorkingDaysStackView].forEach {
            contentView.addSubview($0)
        }

        [sundayButton, mondayButton, tuesayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton].forEach { numberOfWorkingDaysStackView.addArrangedSubview($0) }

        [resultDailyWageLabel, resultWeeklyWageLabel, resultMonthlyWageLabel, resultDailyTextField, resultWeeklyTextField, resultMonthlyTextField, calculatorButton].forEach {
            contentView.addSubview($0)
        }
    }
}

// MARK: - UI 작업

extension SalaryVC {
    func createScrollView() {
        scrollView.delegate = self

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
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

    func createHourlyWageTitleLabel() {
        hourlyWageTitleLabel.text = "시급"
        hourlyWageTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            hourlyWageTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            hourlyWageTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            hourlyWageTitleLabel.widthAnchor.constraint(equalToConstant: 120),
            hourlyWageTitleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createHourlyWageTextField() {
        hourlyWageTextField.placeholder = "시급을 입력해주세요"
        hourlyWageTextField.backgroundColor = .white
        hourlyWageTextField.layer.cornerRadius = 10
        hourlyWageTextField.layer.borderWidth = 1
        hourlyWageTextField.layer.borderColor = UIColor.black.cgColor
        hourlyWageTextField.addLeftPadding()
        hourlyWageTextField.clearButtonMode = .whileEditing
        hourlyWageTextField.addTarget(self, action: #selector(hourlyTextFieldDidChange), for: .editingChanged)

        NSLayoutConstraint.activate([
            hourlyWageTextField.topAnchor.constraint(equalTo: hourlyWageTitleLabel.bottomAnchor, constant: 10),
            hourlyWageTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            hourlyWageTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            hourlyWageTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createWorkHoursTitleLabel() {
        workHoursTitleLabel.text = "근로 시간"
        workHoursTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            workHoursTitleLabel.topAnchor.constraint(equalTo: hourlyWageTextField.bottomAnchor, constant: 24),
            workHoursTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            workHoursTitleLabel.widthAnchor.constraint(equalToConstant: 120),
            workHoursTitleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createWorkHoursTextField() {
        workHoursTextField.placeholder = "하루 근로 시간을 입력해주세요"
        workHoursTextField.backgroundColor = .white
        workHoursTextField.layer.cornerRadius = 10
        workHoursTextField.layer.borderWidth = 1
        workHoursTextField.layer.borderColor = UIColor.black.cgColor
        workHoursTextField.addLeftPadding()
        workHoursTextField.clearButtonMode = .whileEditing
        workHoursTextField.addTarget(self, action: #selector(workHoursTextFieldDidChange), for: .editingChanged)

        NSLayoutConstraint.activate([
            workHoursTextField.topAnchor.constraint(equalTo: workHoursTitleLabel.bottomAnchor, constant: 10),
            workHoursTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            workHoursTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            workHoursTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createNumberOfWorkingDaysTitleLabel() {
        numberOfWorkingDaysTitleLabel.text = "근무일 수"
        numberOfWorkingDaysTitleLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            numberOfWorkingDaysTitleLabel.topAnchor.constraint(equalTo: workHoursTextField.bottomAnchor, constant: 24),
            numberOfWorkingDaysTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            numberOfWorkingDaysTitleLabel.widthAnchor.constraint(equalToConstant: 120),
            numberOfWorkingDaysTitleLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createNumberOfWorkingDaysStackView() {
        numberOfWorkingDaysStackView.axis = .horizontal
        numberOfWorkingDaysStackView.spacing = 4
        numberOfWorkingDaysStackView.distribution = .fillEqually
        numberOfWorkingDaysStackView.backgroundColor = .clear

        NSLayoutConstraint.activate([
            numberOfWorkingDaysStackView.topAnchor.constraint(equalTo: numberOfWorkingDaysTitleLabel.bottomAnchor, constant: 5),
            numberOfWorkingDaysStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            numberOfWorkingDaysStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24), // 추가된 제약 조건
            numberOfWorkingDaysStackView.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createDayButtons() {
        let buttonWidth: CGFloat = 40 // 적절한 너비 값으로 변경

        // 일요일
        sundayButton.setTitle("일", for: .normal)
        sundayButton.backgroundColor = .systemRed.withAlphaComponent(0.5)
        sundayButton.layer.cornerRadius = 10
        sundayButton.tag = 1
        sundayButton.addTarget(self, action: #selector(didTapDayButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            sundayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            sundayButton.heightAnchor.constraint(equalToConstant: 50),
        ])

        // 월요일
        mondayButton.setTitle("월", for: .normal)
        mondayButton.backgroundColor = .systemOrange.withAlphaComponent(0.5)
        mondayButton.layer.cornerRadius = 10
        mondayButton.tag = 2
        mondayButton.addTarget(self, action: #selector(didTapDayButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            mondayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            mondayButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        // 화요일
        tuesayButton.setTitle("화", for: .normal)
        tuesayButton.backgroundColor = .systemOrange.withAlphaComponent(0.5)
        tuesayButton.layer.cornerRadius = 10
        tuesayButton.tag = 3
        tuesayButton.addTarget(self, action: #selector(didTapDayButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            tuesayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            tuesayButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        // 수요일
        wednesdayButton.setTitle("수", for: .normal)
        wednesdayButton.backgroundColor = .systemOrange.withAlphaComponent(0.5)
        wednesdayButton.layer.cornerRadius = 10
        wednesdayButton.tag = 4
        wednesdayButton.addTarget(self, action: #selector(didTapDayButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            wednesdayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            wednesdayButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        // 목요일
        thursdayButton.setTitle("목", for: .normal)
        thursdayButton.backgroundColor = .systemOrange.withAlphaComponent(0.5)
        thursdayButton.layer.cornerRadius = 10
        thursdayButton.tag = 5
        thursdayButton.addTarget(self, action: #selector(didTapDayButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            thursdayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            thursdayButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        // 금요일
        fridayButton.setTitle("금", for: .normal)
        fridayButton.backgroundColor = .systemOrange.withAlphaComponent(0.5)
        fridayButton.layer.cornerRadius = 10
        fridayButton.tag = 6
        fridayButton.addTarget(self, action: #selector(didTapDayButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            fridayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            fridayButton.heightAnchor.constraint(equalToConstant: 60),
        ])

        // 토요일
        saturdayButton.setTitle("토", for: .normal)
        saturdayButton.layer.cornerRadius = 10
        saturdayButton.tag = 7
        saturdayButton.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        saturdayButton.addTarget(self, action: #selector(didTapDayButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            saturdayButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            saturdayButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultDailyWageLabel() {
        resultDailyWageLabel.text = "나의 일급은?"
        resultDailyWageLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            resultDailyWageLabel.topAnchor.constraint(equalTo: numberOfWorkingDaysStackView.bottomAnchor, constant: 24),
            resultDailyWageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultDailyWageLabel.widthAnchor.constraint(equalToConstant: 200),
            resultDailyWageLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultDailyTextField() {
        resultDailyTextField.placeholder = "여기에 일급 결과가 출력됩니다."
        resultDailyTextField.backgroundColor = .white
        resultDailyTextField.layer.cornerRadius = 10
        resultDailyTextField.addLeftPadding()
        resultDailyTextField.isEnabled = false
        resultDailyTextField.layer.borderWidth = 1
        resultDailyTextField.layer.borderColor = UIColor.black.cgColor

        NSLayoutConstraint.activate([
            resultDailyTextField.topAnchor.constraint(equalTo: resultDailyWageLabel.bottomAnchor, constant: 24),
            resultDailyTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultDailyTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            resultDailyTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultWeeklyWageLabel() {
        resultWeeklyWageLabel.text = "나의 주급은?"
        resultWeeklyWageLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            resultWeeklyWageLabel.topAnchor.constraint(equalTo: resultDailyTextField.bottomAnchor, constant: 24),
            resultWeeklyWageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultWeeklyWageLabel.widthAnchor.constraint(equalToConstant: 200),
            resultWeeklyWageLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultWeeklyTextField() {
        resultWeeklyTextField.placeholder = "여기에 주급 결과가 출력됩니다."
        resultWeeklyTextField.backgroundColor = .white
        resultWeeklyTextField.layer.cornerRadius = 10
        resultWeeklyTextField.addLeftPadding()
        resultWeeklyTextField.isEnabled = false
        resultWeeklyTextField.layer.borderWidth = 1
        resultWeeklyTextField.layer.borderColor = UIColor.black.cgColor

        NSLayoutConstraint.activate([
            resultWeeklyTextField.topAnchor.constraint(equalTo: resultWeeklyWageLabel.bottomAnchor, constant: 24),
            resultWeeklyTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultWeeklyTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            resultWeeklyTextField.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultMonthlyWageLabel() {
        resultMonthlyWageLabel.text = "나의 월급은?"
        resultMonthlyWageLabel.font = .systemFont(ofSize: 24, weight: .bold)

        NSLayoutConstraint.activate([
            resultMonthlyWageLabel.topAnchor.constraint(equalTo: resultWeeklyTextField.bottomAnchor, constant: 24),
            resultMonthlyWageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultMonthlyWageLabel.widthAnchor.constraint(equalToConstant: 200),
            resultMonthlyWageLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    func createResultMonthlyTextField() {
        resultMonthlyTextField.placeholder = "여기에 월급 결과가 출력됩니다."
        resultMonthlyTextField.backgroundColor = .white
        resultMonthlyTextField.layer.cornerRadius = 10
        resultMonthlyTextField.addLeftPadding()
        resultMonthlyTextField.isEnabled = false
        resultMonthlyTextField.layer.borderWidth = 1
        resultMonthlyTextField.layer.borderColor = UIColor.black.cgColor

        NSLayoutConstraint.activate([
            resultMonthlyTextField.topAnchor.constraint(equalTo: resultMonthlyWageLabel.bottomAnchor, constant: 24),
            resultMonthlyTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            resultMonthlyTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            resultMonthlyTextField.heightAnchor.constraint(equalToConstant: 60),

        ])
    }

    func createCalulatorButton() {
        calculatorButton.setTitle("계산하기", for: .normal)
        calculatorButton.layer.cornerRadius = 10
        calculatorButton.backgroundColor = .red
        calculatorButton.addTarget(self, action: #selector(didTapCalculatorButton), for: .touchUpInside)

        NSLayoutConstraint.activate([
            calculatorButton.topAnchor.constraint(equalTo: resultMonthlyTextField.bottomAnchor, constant: 34),
            calculatorButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            calculatorButton.widthAnchor.constraint(equalToConstant: 120),
            calculatorButton.heightAnchor.constraint(equalToConstant: 60),
            calculatorButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
        ])
    }
}

// MARK: - DayButton Method

extension SalaryVC {
    @objc func didTapDayButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            viewModel.weeklyWorkdayArray[sender.tag - 1].toggle()
            sundayButton.backgroundColor = viewModel.weeklyWorkdayArray[sundayButton.tag - 1] ? .systemRed : .systemRed.withAlphaComponent(0.5)
        case 2:
            viewModel.weeklyWorkdayArray[sender.tag - 1].toggle()
            mondayButton.backgroundColor = viewModel.weeklyWorkdayArray[mondayButton.tag - 1] ? .systemOrange : .systemOrange.withAlphaComponent(0.5)
        case 3:
            viewModel.weeklyWorkdayArray[sender.tag - 1].toggle()
            tuesayButton.backgroundColor = viewModel.weeklyWorkdayArray[tuesayButton.tag - 1] ? .systemOrange : .systemOrange.withAlphaComponent(0.5)
        case 4:
            viewModel.weeklyWorkdayArray[sender.tag - 1].toggle()
            wednesdayButton.backgroundColor = viewModel.weeklyWorkdayArray[wednesdayButton.tag - 1] ? .systemOrange : .systemOrange.withAlphaComponent(0.5)
        case 5:
            viewModel.weeklyWorkdayArray[sender.tag - 1].toggle()
            thursdayButton.backgroundColor = viewModel.weeklyWorkdayArray[thursdayButton.tag - 1] ? .systemOrange : .systemOrange.withAlphaComponent(0.5)
        case 6:
            viewModel.weeklyWorkdayArray[sender.tag - 1].toggle()
            fridayButton.backgroundColor = viewModel.weeklyWorkdayArray[fridayButton.tag - 1] ? .systemOrange : .systemOrange.withAlphaComponent(0.5)
        case 7:
            viewModel.weeklyWorkdayArray[sender.tag - 1].toggle()
            saturdayButton.backgroundColor = viewModel.weeklyWorkdayArray[saturdayButton.tag - 1] ? .systemBlue : .systemBlue.withAlphaComponent(0.5)
        default:
            break
        }
    }
}

// MARK: - CalculatorButton Method

extension SalaryVC {
    @objc func didTapCalculatorButton(_ sender: UIButton) {
        if hourlyWageTextField.text == "" || workHoursTextField.text == "" {
            showBlankAlert()
        } else if viewModel.filterWorkDayArr.isEmpty {
            showEmptyDaysAlert()
        } else {
            let hourlyWage = viewModel.numberFormattedStrToInt(hourlyWageTextField.text ?? "0")
            let workHours = viewModel.numberFormattedStrToInt(workHoursTextField.text ?? "0")

            let dailyResult = hourlyWage * workHours
            let weeklyResult = dailyResult * viewModel.filterWorkDayArr.count
            let monthlyResult = dailyResult * viewModel.countWeekdaysInCurrentMonth(weekday: viewModel.filterWorkDayArr)

            resultDailyTextField.text = viewModel.numberFormatted(dailyResult)
            resultWeeklyTextField.text = viewModel.numberFormatted(weeklyResult)
            resultMonthlyTextField.text = viewModel.numberFormatted(monthlyResult)
        }
    }
}

// MARK: - TextField DidChange Method

extension SalaryVC {
    @objc func hourlyTextFieldDidChange(_ sender: Any) {
        guard let input = Int(hourlyWageTextField.text ?? "0") else { return }

        if input > 999 {
            hourlyWageTextField.text = viewModel.numberFormatted(input)
        } else {
            hourlyWageTextField.text = input.description
        }
    }

    @objc func workHoursTextFieldDidChange(_ sender: Any) {
        guard let input = Int(workHoursTextField.text ?? "0") else { return }

        if input > 999 {
            workHoursTextField.text = viewModel.numberFormatted(input)
        } else {
            workHoursTextField.text = input.description
        }
    }
}

// MARK: - 빈 칸 확인 경고

extension SalaryVC {
    func showBlankAlert() {
        let alert = UIAlertController(title: "빈 칸이 있습니다.", message: "", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }

    func showEmptyDaysAlert() {
        let alert = UIAlertController(title: "요일을 확인해주세요.", message: "", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
}

// MARK: - Reset Button

extension SalaryVC {
    func createResetButton() {
        let resetButton = UIBarButtonItem(image: UIImage(systemName: "gobackward"), style: .plain, target: self, action: #selector(didTapRestButton))
        resetButton.tintColor = .black
        tabBarController?.navigationItem.rightBarButtonItem = resetButton
    }

    @objc func didTapRestButton(_ sender: UIBarButtonItem) {
        hourlyWageTextField.text = nil
        workHoursTextField.text = nil
        resultDailyTextField.text = nil
        resultWeeklyTextField.text = nil
        resultMonthlyTextField.text = nil
        viewModel.resetWeeklyWorkdayArray()
        viewWillAppear(true)
        print("#### \(#function)")
    }
}

// MARK: - UIScrollViewDelegate

extension SalaryVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

// MARK: - ViewModelInjectable

// 상위 TabBarVC에서 ViewModel 주입

extension SalaryVC: ViewModelInjectable {
    func injectViewModel(_ viewModelType: SalaryViewModel) {
        viewModel = viewModelType
    }
}

// MARK: - Hide Keyboard When Tapped Around

extension SalaryVC {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SalaryVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - 키보드 올렸을 때 뷰 올리는 코드

extension SalaryVC {
    func keyboardCheck() {
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didShowKeyboard), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func willShowKeyboard(notification: NSNotification) {
        scrollView.isScrollEnabled = false
        if hourlyWageTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if contentView.frame.origin.y == textFieldPosY {
                    contentView.frame.origin.y -= keyboardSize.height / 3 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        } else if workHoursTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if contentView.frame.origin.y == textFieldPosY {
                    contentView.frame.origin.y -= keyboardSize.height / 3 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        }
    }

    @objc func didShowKeyboard(notification: NSNotification) {
        scrollView.isScrollEnabled = false
        if hourlyWageTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if contentView.frame.origin.y == textFieldPosY {
                    contentView.frame.origin.y -= keyboardSize.height / 3 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        } else if workHoursTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if contentView.frame.origin.y == textFieldPosY {
                    contentView.frame.origin.y -= keyboardSize.height / 3 - UIApplication.shared.windows.first!.safeAreaInsets.bottom
                }
            }
        }
    }

    @objc func willHideKeyboard(notification: NSNotification) {
        if contentView.frame.origin.y != textFieldPosY {
            contentView.frame.origin.y = textFieldPosY
            scrollView.isScrollEnabled = true
            hourlyWageTextField.isEnabled = true
            workHoursTextField.isEnabled = true
        }
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
//    internal func toPreview() -> some View {
//        // inject self (the current view controller) for the preview
//        Preview(viewController: self)
//    }
// }
//
// @available(iOS 13.0, *)
// struct SalaryVC_Preview: PreviewProvider {
//    static var previews: some View {
//        SalaryVC().toPreview()
//    }
// }
// #endif

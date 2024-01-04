//
//  ExpirationDateVC.swift
//  Pyeon-Duck
//
//  Created by 준우의 MacBook 16 on 12/13/23.
//

import UIKit

class ExpirationCalendarVC: UIViewController {
    var viewModel = ExpirationCalendarViewModel()

    // 달력 선언
    let dateView: UICalendarView = {
        let view = UICalendarView()
        view.locale = Locale(identifier: "ko_KR")
        view.timeZone = TimeZone(abbreviation: "KST")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fontDesign = .serif
        view.backgroundColor = .systemBackground
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 10
        view.tintColor = UIColor.red

        // 달력 커스텀을 위해 설정해 주어야 하는 속성
        view.wantsDateDecorations = true

        return view
    }()

    var addFloattingButton = CustomButton(frame: .zero)

    deinit {
        print("Deinitialized ExpirationDateVC")
    }
}

// MARK: - View Life Cycle

extension ExpirationCalendarVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        viewModel.fetchExpirationList()
        viewModel.scheduleNotificationIfNeeded()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.navigationItem.title = "유통기한 달력"
        tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.navigationItem.rightBarButtonItem = nil

        viewModel.fetchExpirationList()
        setUpUI()
    }
}

// MARK: - Setting Up UI

extension ExpirationCalendarVC {
    func setUpUI() {
        view.backgroundColor = .systemGray6
        addView()

        createDateView()
        createAddFloattingButton()

        setCalendar()
        reloadDateView(date: Date())
    }

    func addView() {
        view.addSubview(dateView)
        view.addSubview(addFloattingButton)
    }
}

// MARK: - Confirm UI

extension ExpirationCalendarVC {
    func createDateView() {
        let dateViewConstraints = [
            dateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            dateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            dateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            dateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ]

        NSLayoutConstraint.activate(dateViewConstraints)
    }
}

// MARK: - DateView Method

extension ExpirationCalendarVC {
    func setCalendar() {
        dateView.delegate = self

        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateView.selectionBehavior = dateSelection
    }

    func reloadDateView(date: Date?) {
        if date == nil { return }
        let calendar = Calendar.current
        dateView.reloadDecorations(forDateComponents: [calendar.dateComponents([.day, .month, .year], from: date!)], animated: true)
    }
}

// MARK: - AddFloattingButton Method

extension ExpirationCalendarVC {
    @objc func didTapAddButton(_ sender: UIButton) {
        let vc = ExpirationCreateVC()
        tabBarController?.navigationController?.pushViewController(vc, animated: true)
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
            addFloattingButton.trailingAnchor.constraint(equalTo: dateView.trailingAnchor, constant: -12),
            addFloattingButton.widthAnchor.constraint(equalToConstant: 60),
            addFloattingButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - UICalendarViewDelegate && UICalendarSelectionSingleDateDelegate

extension ExpirationCalendarVC: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    // UICalendarView
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        if let date = Calendar.current.date(from: dateComponents) {
            viewModel.date = viewModel.strToDateFormatted(date)
        }
        
        if viewModel.expirationList.count > 0 {
            return .customView {
                let view = UIView()
                view.layer.cornerRadius = 5
                view.backgroundColor = .systemRed
                view.frame.size = .init(width: 10, height: 10)
                return view
            }
            
        } else {
            return nil
        }
    }

    // 달력에서 날짜 선택했을 경우
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let dateComponents = dateComponents,
              let date = Calendar.current.date(from: dateComponents)
        else {
            print("날짜 선택이 잘못되었습니다.")
            return
        }

        selection.setSelected(dateComponents, animated: true)
        viewModel.selectedDate = dateComponents
        reloadDateView(date: date)

        let vc = ExpirationListVC()
        vc.currentDate = viewModel.strToDateFormatted(date)
        vc.viewModel.selectedDate = viewModel.strToDateFormatted(date)

        navigationController?.pushViewController(vc, animated: true)
    }
}

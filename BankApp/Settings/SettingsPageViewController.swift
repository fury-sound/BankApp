//
//  SettingsPageViewController.swift
//  BankApp
//
//  Created by Valery Zvonarev on 30.04.2026.
//

import UIKit

final class SettingsPageViewController: UIViewController {

    // MARK: - Properties
    private let settingsVM = SettingsViewModel()

    // MARK: - Subviews
    //    private lazy var settingsLabel: UILabel = {
    //        let label = UILabel()
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        label.text = "Настройки"
    //        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    //        label.numberOfLines = 1
    //        label.adjustsFontForContentSizeCategory = true
    //        label.textAlignment = .natural
    //        label.backgroundColor = .blue
    //        return label
    //    }()

    private lazy var themeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Тема экрана"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()

    private lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🔔 Уведомления"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 1
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()

    private lazy var switchView: UISwitch = {
        let switchView = UISwitch()
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.backgroundColor = .clear
        return switchView
    }()

    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["☀️ Светлая", "🌙 Темная", "💻 Системная"]
        let segmentedView = UISegmentedControl(items: items)
        segmentedView.translatesAutoresizingMaskIntoConstraints = false
        segmentedView.backgroundColor = .clear
        return segmentedView
    }()

    private lazy var switchNotification: UISwitch = {
        let notificationView = UISwitch()
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        notificationView.backgroundColor = .clear
        return notificationView
    }()

    private lazy var themeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()

    private lazy var notificationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        return stackView
    }()

    private lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Выйти из профиля", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 12
        return button
    }()

    private lazy var removeAllAccountsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить все профили и выйти", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 12
        return button
    }()


    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        settingsVM.showAllAccountInfo()
    }

    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }

    private func setupSubviews() {
        themeStackView.addArrangedSubview(themeLabel)
        themeStackView.addArrangedSubview(segmentedControl)
//        themeStackView.addArrangedSubview(switchView)
        notificationStackView.addArrangedSubview(notificationLabel)
        notificationStackView.addArrangedSubview(switchNotification)

        segmentedControl.selectedSegmentIndex = settingsVM.themeManager.currentTheme.rawValue
        segmentedControl.addTarget(self, action: #selector(themeSwitchTapped), for: .valueChanged)
//        switchView.addTarget(self, action: #selector(themeSwitchTapped), for: .touchUpInside)
        switchNotification.addTarget(self, action: #selector(notificationSwitchTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitAppTapped), for: .touchUpInside)
        removeAllAccountsButton.addTarget(self, action: #selector(removeAllAccounts), for: .touchUpInside)
        //        [settingsLabel, stackView].forEach {
        [themeStackView, notificationStackView, removeAllAccountsButton, exitButton].forEach {
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //            settingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            //            settingsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            //            settingsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            themeStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            themeStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            themeStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            notificationStackView.topAnchor.constraint(equalTo: themeStackView.bottomAnchor, constant: 20),
            notificationStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            notificationStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            removeAllAccountsButton.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: -20),
            removeAllAccountsButton.heightAnchor.constraint(equalToConstant: 50),
            removeAllAccountsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            removeAllAccountsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            exitButton.heightAnchor.constraint(equalToConstant: 50),
            exitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive) { [weak self] _ in
            guard let self else { return }
            self.settingsVM.removeAllAccounts()
            self.settingsVM.exitProfile(currentView: self)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

    // MARK: - Actions
    @objc private func themeSwitchTapped(_ sender: UISegmentedControl) {
//        print("Theme switch tapped", sender.selectedSegmentIndex)
//        if settingsVM.currentTheme == false {
//            overrideUserInterfaceStyle = .dark
//        } else {
//            overrideUserInterfaceStyle = .light
//        }
//        switch sender.selectedSegmentIndex {
//            case 0:
//                overrideUserInterfaceStyle = .light
//            case 1:
//                overrideUserInterfaceStyle = .dark
//            case 2:
//                overrideUserInterfaceStyle = .unspecified
//            default:
//                overrideUserInterfaceStyle = .unspecified
//
//        }
        settingsVM.changeTheme(sender.selectedSegmentIndex)
    }

    @objc private func notificationSwitchTapped() {
        print("Notification switch tapped")
        settingsVM.toggleNotifications()
    }

    @objc private func exitAppTapped() {
        settingsVM.exitProfile(currentView: self)
    }

    @objc private func removeAllAccounts() {
        showAlert(title: "Удалить все профили", message: "Вы удаляете все профили на устройстве. Вы уверены?")
    }
}

#Preview {
    SettingsPageViewController()
}


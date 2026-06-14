//
//  OnboardingContentViewController.swift
//  BankApp
//
//  Created by Valery Zvonarev on 06.05.2026.
//

import UIKit

final class OnboardingContentViewController: UIViewController {

    // MARK: - Properties
    private var onboardingViewModel: OnboardingViewModel?
    private var currentPageTag = 0

    // MARK: - Subviews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.text = "Лучшее банковское приложение"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 2
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()

    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //        imageView.image = UIImage(named: "Onboarding1")
        //        imageView.image = UIImage(named: "bgImage1")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        //        imageView.backgroundColor = .red
        return imageView
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        //        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        //        button.backgroundColor = .green
        button.tintColor = .systemGray
        //        button.setTitleColor(UIColor.systemPink, for: .normal)
        return button
    }()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }

    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }

    private func setupSubviews() {
        nextButton.addTarget(self, action: #selector(didTappedNext), for: .touchUpInside)
        [bgImageView, titleLabel, nextButton].forEach {
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bgImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: nextButton.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configure(pageData: PageInfo, viewModel: OnboardingViewModel) {
        self.currentPageTag = pageData.pageTag
        titleLabel.text = pageData.mainText
        bgImageView.image = UIImage(named: pageData.imageName)
        //        pageControl.numberOfPages = 3
        nextButton.setTitle(pageData.buttonText, for: .normal)
        self.onboardingViewModel = viewModel
    }

    //     MARK: - Actions
    @objc private func didTappedNext() {
        //        print("next onboarding screen")
        if currentPageTag != 3 {
            onboardingViewModel?.goToNextPage(currentPage: currentPageTag, onboardingVC: self)
        } else {
            onboardingViewModel?.goToMainWindow(onboardingVC: self)
        }
    }
}

#Preview {
    OnboardingContentViewController()
}


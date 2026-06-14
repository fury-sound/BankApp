//
//  PageViewController.swift
//  BankApp
//
//  Created by Valery Zvonarev on 06.05.2026.
//

import UIKit

protocol OnboardingPageViewControllerDelegate: AnyObject {
    func goToNextPage()
}

final class PageViewController: UIPageViewController {

    // MARK: - Properties
    private let viewModel = OnboardingViewModel()
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = viewModel.pages.count
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()

    // MARK: - Subviews

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        viewModel.delegate = self
        // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }

    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .clear
        viewModel.setPages()
        if let firstPage = viewModel.pages.first {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }

    private func setupSubviews() {
        view.addSubview(pageControl)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }

    private func updatePageControl(for viewController: UIViewController) {
        if let contentVC = viewController as? OnboardingContentViewController,
           let index = viewModel.pages.firstIndex(of: contentVC) {
            pageControl.currentPage = index
        }
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate, OnboardingPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let currentVC = pageViewController.viewControllers?.first {
            updatePageControl(for: currentVC)
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let contentVC = viewController as? OnboardingContentViewController,
              let currentIndex = viewModel.pages.firstIndex(of: contentVC),
              currentIndex > 0 else { return nil }
        return viewModel.pages[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let contentVC = viewController as? OnboardingContentViewController,
              let currentIndex = viewModel.pages.firstIndex(of: contentVC),
              currentIndex < viewModel.pages.count - 1 else { return nil }
        return viewModel.pages[currentIndex + 1]
    }

    func goToNextPage() {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: true) { [weak self] _ in
            self?.updatePageControl(for: nextViewController)
        }
    }

    //    func goToPreviousPage() {
    //        guard let currentViewController = self.viewControllers?.first else { return }
    //        guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }
    //        setViewControllers([previousViewController], direction: .reverse, animated: false, completion: nil)
    //    }
}

#Preview {
    PageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
}


//
//  MainPageViewController.swift
//  BankApp
//
//  Created by Valery Zvonarev on 10.04.2026.
//

import UIKit

final class MainPageViewController: UIViewController {

    // MARK: - Properties
    private var bankNews: [NewsCellModel] = []
    private let networkService = NetworkService.shared
    private let dateFormatterService = DateFormatterService.shared
    let activityIndicator = UIActivityIndicatorView(style: .large)

//    private let activityIndicator: UIActivityIndicatorView = {
//        let activityIndicator = UIActivityIndicatorView(style: .large)
//        activityIndicator.startAnimating()
//        return activityIndicator
//    }()

    // MARK: - Subviews
//    private lazy var welcomeLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Новости банка"
//        label.font = .systemFont(ofSize: 28, weight: .bold)
//        label.textColor = .label
//        label.backgroundColor = .clear
//        label.textAlignment = .center
//        label.numberOfLines = 2
//        label.layer.cornerRadius = 20
//        label.clipsToBounds = true
//        return label
//    }()

    private lazy var noConnectionView: NoConnectionView = {
        let errorView = NoConnectionView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.isHidden = true
        errorView.reloadButton.addTarget(self, action: #selector(retryNetworkCall), for: .touchUpInside)
        return errorView
    }()

    private lazy var titleView: UIView = {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .systemBackground
        myView.layer.cornerRadius = 20
        myView.layer.borderWidth = 1
        myView.layer.borderColor = UIColor.myColorBW.cgColor
        return myView
    }()

    private var mainPageViewModel = MainPageViewModel()

    private let newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NewsCellView.self, forCellReuseIdentifier: NewsCellView.reuseIdentifier)
        return tableView
    }()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        setupConnectionErrorView()
//        updateBorderColor()
        fetchNews()
    }

    // MARK: - Layout
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
//            updateBorderColor()
//        }
//    }

    private func setupConnectionErrorView() {
        view.addSubview(noConnectionView)
        noConnectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noConnectionView.topAnchor.constraint(equalTo: view.topAnchor),
            noConnectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noConnectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            noConnectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
//        navigationController?.navigationBar.prefersLargeTitles = true
    }

//    private func updateBorderColor() {
//        let dynamicColor = UIColor.myColorBW
//        titleView.layer.borderColor = dynamicColor.cgColor
//    }

    private func setupSubviews() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
        [newsTableView, activityIndicator].forEach { view.addSubview($0) }
//        titleView.addSubview(welcomeLabel)
//        [titleView, newsTableView].forEach { view.addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
//            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            titleView.heightAnchor.constraint(equalToConstant: 40),
//            welcomeLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
//            welcomeLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
//            welcomeLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
//            welcomeLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
//            newsTableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 5),

            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func fetchNews() {
//        print(#function)
        bankNews = []
        activityIndicator.startAnimating()
//        networkService.fetch(endpoint: .news) { [weak self] result in
        networkService.fetch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let news):
                        self?.bankNews = news
//                        guard let bankNews = self?.bankNews else { return }
//                        print(bankNews.count)
//                        print(bankNews[0].title)
//                        print(bankNews[0].mainText)
//                        print(bankNews[0].date)
//                        print(bankNews[0].imageName)
                        self?.newsTableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.showConnectionErrorView()
                }
                self?.activityIndicator.stopAnimating()
            }
        }
    }

    private func showConnectionErrorView() {
        noConnectionView.isHidden = false
        view.bringSubviewToFront(noConnectionView)
    }

    // MARK: - Actions
    @objc private func retryNetworkCall() {
        print("Повторная попытка подключения к сети")
        UIView.animate(withDuration: 0.3) {
            self.noConnectionView.isHidden = true
        }
        fetchNews()
    }
}

extension MainPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mainPageViewModel.newsArrays.count
        return bankNews.count
//        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        print("bankNews.count:", bankNews.count)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCellView.reuseIdentifier, for: indexPath) as? NewsCellView else {
            return UITableViewCell()
        }
//        cell.configure(with: mainPageViewModel.newsArrays[indexPath.row])
        if bankNews.count > 0 {
            cell.configure(with: bankNews[indexPath.row])
//            let newsItem = bankNews[0]
//            print("newsItem:", newsItem.title)
        }
//        print("bankNews[0].title:", bankNews[0].title)
//        print(bankNews[0].mainText)
//        print(bankNews[0].date)
//        print(bankNews[0].imageName)
        return cell
    }
}

extension MainPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = bankNews[indexPath.row]
//        print("model:", model.title)
        let detailVC = SelectedNewsViewController() //NewsViewController(news: model)
        detailVC.navigationItem.largeTitleDisplayMode = .always
        detailVC.title = dateFormatterService.dateFormatted(with: model.date)
        detailVC.configure(with: model)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

#Preview {
    MainPageViewController()
}


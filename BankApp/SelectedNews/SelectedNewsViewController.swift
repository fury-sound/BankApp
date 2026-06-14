    //
    //  SelectedNewsViewController.swift
    //  BankApp
    //
    //  Created by Valery Zvonarev on 15.05.2026.
    //

import UIKit

final class SelectedNewsViewController: UIViewController {

        // MARK: - Properties
    private var selectedNewsVM = SelectedNewsViewModel()
    private var urlString: String = ""
    private let imageService = ImageService.shared

        // MARK: - Subviews
    private var mainText: UITextView = {
        let textView = UITextView()
            //        textView.translatesAutoresizingMaskIntoConstraints = false
            //        textView.backgroundColor = .red
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isFindInteractionEnabled = false
        textView.textContainerInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.textContainer.maximumNumberOfLines = 0
        textView.autocorrectionType = .no
        textView.spellCheckingType = .no
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textView.setContentHuggingPriority(.required, for: .vertical)
        return textView
    }()

    private var newsTitle: UILabel = {
        let label = UILabel()
            //        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
            //        label.font = .preferredFont(forTextStyle: .title1)
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .label
        label.layer.cornerRadius = 12
            //        label.backgroundColor = .systemOrange
        label.backgroundColor = .clear
        return label
    }()

    private var newsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
            //        view.backgroundColor = .systemBlue
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        return view
    }()

    private lazy var cellImageView: UIImageView = {
        let myImageView = UIImageView()
            //        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.contentMode = .scaleAspectFit
        myImageView.clipsToBounds = true
        myImageView.layer.cornerRadius = 12
        myImageView.layer.borderWidth = 1
        myImageView.layer.borderColor = UIColor.black.cgColor
            //        myImageView.backgroundColor = .white
        myImageView.backgroundColor = .systemYellow
            //        myImageView.tintColor = .systemBlue
        return myImageView
    }()

    private lazy var webViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Web версия", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

        // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
            //        configure()
    }

        // MARK: - Layout

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let image = cellImageView.image {
            selectedNewsVM.updateImageHeight(image, imageWidthValue: cellImageView.bounds.width)
        }
            //        renderHTMLIfNeeded()
    }

    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }

    private func setupSubviews() {
        webViewButton.addTarget(self, action: #selector(openWebView), for: .touchUpInside)
        [mainText, cellImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        [contentView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            newsScrollView.addSubview($0)
        }
        [newsTitle, newsScrollView, webViewButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        selectedNewsVM.imageHeightConstraint = cellImageView.heightAnchor.constraint(equalToConstant: 200)
        selectedNewsVM.imageHeightConstraint?.isActive = true
        NSLayoutConstraint.activate([
            newsTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            newsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            newsTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            newsTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            newsScrollView.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 10),
            newsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsScrollView.bottomAnchor.constraint(equalTo: webViewButton.topAnchor),
            //            webVersionButton.topAnchor.constraint(equalTo: newsScrollView.bottomAnchor, constant: 10),
            webViewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            webViewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            webViewButton.heightAnchor.constraint(equalToConstant: 30),
            webViewButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: newsScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: newsScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: newsScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: newsScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: newsScrollView.widthAnchor),

            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            mainText.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 10),
            mainText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }

    func configure(with model: NewsCellModel) {
            //        print(model.title)
            //        cellTitle.text = model.title
            //        cellBody.text = model.mainText
            //        displayHTML(htmlString: model.mainText, textView: mainText)
            //        cellImageView.image = UIImage(systemName: model.imageName)
            //        cellImageView.image = UIImage(named: "evercoin")
//        newsDate.text = selectedNewsVM.dateFormatted(with: model.date)
        newsTitle.text = model.title
        urlString = model.pageLink
        mainText.text = selectedNewsVM.htmlToText(model.mainText)
            //        pendingHTML = model.mainText
            //        didRenderHTML = false
//        print("in SelectedNewsViewController model.imageName", model.imageName)
        imageService.setImage(into:
                                cellImageView,
                              from: model.imageName,
                              placeholder: UIImage(systemName: "star.fill")
        )
            //        imageService.getImage(from: model.imageName, into: cellImageView) { [weak self] image in
            //            self?.cellImageView.image = image
            //        }
            //        if let image = UIImage(named: model.imageName) {
            //            cellImageView.image = image
            //            view.layoutIfNeeded()
            //            selectedNewsVM.updateImageHeight(image, imageWidthValue: cellImageView.bounds.width)
            //        } else {
            //            guard let image = UIImage(named: "evercoin") else { return }
            //            cellImageView.image = image
            //            view.layoutIfNeeded()
            //            selectedNewsVM.updateImageHeight(image, imageWidthValue: cellImageView.bounds.width)
            //        }
            //                if let image = UIImage(named: model.imageName) {
            //        if let image = UIImage(named: "evercoin") {
            //            cellImageView.image = image
            //            view.layoutIfNeeded()
            //            selectedNewsVM.updateImageHeight(image, imageWidthValue: cellImageView.bounds.width)
            //        }
            //        view.setNeedsLayout()
    }

        //    func configure() {
        //        //        cellTitle.text = "Название"
        //        mainText.text = "Основной текст Основной текст Основной текст"
        //        newsDate.text = "12 мая 2026 г."
        //        //        cellImageView.image = UIImage(systemName: "star.fill")
        //        //        cellImageView.image = UIImage(named: "evercoin")
        //        if let image = UIImage(named: "evercoin") {
        //            cellImageView.image = image
        //            updateImageHeight(image)
        //        }
        //    }

        // MARK: - Actions
    @objc private func openWebView() {
        print("open web page")
        let url = URL(string: urlString)
        let webPageVC = WebPageViewController(url: url)
            //        safariVC.delegate = self
        present(webPageVC, animated: true)
    }
}

    //#Preview {
    //    SelectedNewsViewController()
    //}

#Preview {
    let selectedNewsVC = SelectedNewsViewController()
    let title = "Новость"
    let mainBody = "<p>Основной заголовок</p> <b>Основной заголовок</b> Основной текст Основной текст Основной текст Основной текст Основной текст"
    let mainDate = "12 мая 2026 г."
    let newsCellModel = NewsCellModel(title: title,
                                      mainText: mainBody,
                                      date: mainDate,
                                      imageName: "evercoin",
                                      pageLink: "https://www.google.com")
    selectedNewsVC.configure(with: newsCellModel)
        //    selectedNewsVC.configure()
    return selectedNewsVC
}


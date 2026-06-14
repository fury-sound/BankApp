//
//  NewsCellView.swift
//  BankApp
//
//  Created by Valery Zvonarev on 11.05.2026.
//

import UIKit

final class NewsCellView: UITableViewCell {
    static let reuseIdentifier: String = "NewsCell"
    private let newsCellVM = NewsCellViewModel()
    private let imageService = ImageService.shared
    private let dateFormatterService = DateFormatterService.shared
//    private let activityIndicatorView = UIActivityIndicatorView(style: .large)

    private var cellTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
//        label.font = .preferredFont(forTextStyle: .title2)
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .myColorBW
        label.layer.cornerRadius = 12
//        label.backgroundColor = .systemGreen
        label.backgroundColor = .clear
        return label
    }()

//    private var cellBody: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
////        label.textAlignment = .justified
//        label.textAlignment = .justified
//        label.font = .preferredFont(forTextStyle: .body)
////        subTitlelabel.font = .systemFont(ofSize: 14, weight: .thin)
//        label.textColor = .myColorBW
//        label.layer.cornerRadius = 12
////        label.backgroundColor = .systemRed
//        label.backgroundColor = .clear
//        return label
//    }()

    private var cellBody: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isFindInteractionEnabled = false
        textView.backgroundColor = .clear
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

    private var cellDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .caption1)
        //        subTitlelabel.font = .systemFont(ofSize: 14, weight: .thin)
        label.textColor = .myColorBW
        label.layer.cornerRadius = 12
//        label.backgroundColor = .systemOrange
        label.backgroundColor = .clear
        return label
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .systemBlue
        view.backgroundColor = .clear
        view.layer.cornerRadius = 16
        return view
    }()

    private lazy var cellImageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.contentMode = .scaleAspectFill
        myImageView.clipsToBounds = true
        myImageView.layer.cornerRadius = 12
        myImageView.layer.borderWidth = 1
        myImageView.layer.borderColor = UIColor.black.cgColor
//        myImageView.backgroundColor = .white
        myImageView.backgroundColor = .clear
        myImageView.tintColor = .systemBlue
        return myImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        //        selectionSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellTitle.text = nil
        cellBody.text = nil
        cellImageView.image = nil
        cellDate.text = nil
    }

    // MARK: - Subviews

    // MARK: - Lifecycles

    // MARK: - Layout
    private func setupViewProperties(){
        contentView.backgroundColor = .systemBackground
    }

    private func setupSubviews(){
        //        cellTitleView.addSubview(cellTitleLabel)
        //        contentView.addSubview(cellTitleView)
        contentView.addSubview(containerView)
        containerView.addSubview(cellTitle)
//        containerView.addSubview(cellBody)
//        containerView.addSubview(cellBodyText)
        containerView.addSubview(cellDate)
        contentView.addSubview(cellImageView)
//        contentView.addSubview(activityIndicatorView)
        //        contentView.addSubview(cellTitleLabel)
        //        contentView.addSubview(cellSubtitleLabel)
        //        contentView.addSubview(cellImageView)
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: -5),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            cellTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            cellTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cellTitle.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            cellTitle.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
//            cellTitle.bottomAnchor.constraint(equalTo: cellBody.topAnchor, constant: -5),

//            cellBody.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 5),
//            cellBody.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
//            cellBody.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),

//            cellBody.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),

            cellDate.topAnchor.constraint(equalTo: cellTitle.bottomAnchor, constant: 5),
            cellDate.heightAnchor.constraint(equalToConstant: 20),
            cellDate.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            cellDate.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            cellDate.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5),

            //            cellTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            //            cellTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            //            cellTitleLabel.trailingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: -10),
            //
            //            cellSubtitleLabel.topAnchor.constraint(equalTo: cellTitleLabel.bottomAnchor, constant: 5),
            //            cellSubtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            //            cellSubtitleLabel.trailingAnchor.constraint(equalTo: cellImageView.leadingAnchor, constant: -10),
            //            cellSubtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellImageView.widthAnchor.constraint(equalToConstant: 75),
            cellImageView.heightAnchor.constraint(equalToConstant: 75),
//            activityIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            activityIndicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }

    func configure(with model: NewsCellModel) {
//        print(model.title)
        cellTitle.text = model.title
//        cellBody.text = model.mainText
//        cellDate.text = model.date
//        cellDate.text = newsCellVM.dateFormatted(with: model.date)
        cellDate.text = dateFormatterService.dateFormatted(with: model.date)
        displayHTML(htmlString: model.mainText, textView: cellBody)
//        print("model.imageName", model.imageName)
        imageService.setImage(into:
                                cellImageView,
                              from: model.imageName,
                              placeholder: UIImage(systemName: "star.fill")
        )
//        if let image = imageService. getCachedImage(from: model.imageName) {
//            cellImageView.image = image
//        } else {
//            cellImageView.image = UIImage(systemName: "star.fill")
//        }
    }

    func displayHTML(htmlString: String, textView: UITextView) {
//        let styledHTML = """
//    <style>
//        body {
//            color: \(textColor.);
//            font-family: -apple-system, system-ui;
//            font-size: 17px;
//            margin: 0;
//            padding: 0;
//        }
//        img {
//            max-width: 100%;
//            height: auto;
//            display: block;
//            margin: 10px 0;
//        }
//        /* Для адаптации к контейнеру */
//        .content img {
//            width: 100%;
//            object-fit: contain;
//        }
//    </style>
//    <div class="content">
//    \(htmlString)
//    </div>
//    """

        guard let data = htmlString.data(using: .utf8) else { return }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue,
        ]

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label
        ]

        do {
//            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            let attributedString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
            textView.attributedText = attributedString
        } catch {
            print("HTML parsing error: \(error.localizedDescription)")
            textView.text = htmlString
        }
    }

//    func configure() {
//        cellTitle.text = "Название"
//        cellBody.text = "Основной текст Основной текст Основной текст"
//        cellDate.text = "12 мая 2026 г."
////        cellImageView.image = UIImage(systemName: model.imageName)
//    }


//    func configure(with viewModel: NewsViewModel) {
//        titleLabel.text = viewModel.title
//        dateLabel.text = viewModel.date
//    }
}

//#Preview {
//    let cell = NewsCellView()
//    let title = "Новость"
//    let mainBody = "Основной текст Основной текст Основной текст Основной текст Основной текст Основной текст"
//    let mainDate = "12 мая 2026 г."
//    cell.frame = CGRect(x: 50, y: 200, width: 300, height: 150)
//    let container = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 150))
//    let newsCellModel = NewsCellModel(title: title,
//                                      mainText: mainBody,
//                                      date: mainDate,
//                                      imageName: "star.fill")
//    cell.configure(with: newsCellModel)
//    //    cell.translatesAutoresizingMaskIntoConstraints = false
//    //    container.translatesAutoresizingMaskIntoConstraints = false
//    //    NSLayoutConstraint.activate([
//    //        cell.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor)
//    //    ])
////    cell.configure()
//    container.backgroundColor = .systemBrown
//    container.addSubview(cell)
//
//    return container
//    //    CustomCellView()
//}

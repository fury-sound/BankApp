//
//  NoConnectionView.swift
//  BankApp
//
//  Created by Valery Zvonarev on 21.06.2026.
//

import UIKit
import SwiftUI

final class NoConnectionView: UIView {

    // MARK: - Properties

    // MARK: - Subviews
    private lazy var iconContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray3.cgColor
        view.layer.borderWidth = 1
        view.layer.shadowColor = UIColor.black.cgColor
        return view
    }()

    private lazy var errorImage: UIImageView = {
        let imageLabel = UIImageView()
        let image = UIImage(systemName: "wifi.exclamationmark.circle.fill")
        let config = UIImage.SymbolConfiguration(paletteColors: [.secondaryLabel, .systemGray6])
        let sizeConfig = UIImage.SymbolConfiguration(pointSize: 150, weight: .regular)
//        let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .regular)

//        imageLabel.image = UIImage(systemName: "exclamationmark.triangle.fill", withConfiguration: config)
        imageLabel.image = image?.withConfiguration(sizeConfig.applying(config))
        imageLabel.contentMode = .scaleAspectFit
//        imageLabel.contentMode = .center
//        imageLabel.tintColor = .systemGray3
//        imageLabel.backgroundColor = .magenta
//        imageLabel.translatesAutoresizingMaskIntoConstraints = false
//        imageLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        imageLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        imageLabel.layer.cornerRadius = 75
//        imageLabel.layer.masksToBounds = true
        return imageLabel
    }()

    private lazy var noConnectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет соединения"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.textAlignment = .natural
        label.numberOfLines = 1
        return label
    }()

    private lazy var errorMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Не удалось подключиться к серверу. \nПроверьте Интернет-соединение и \nпопробуйте еще раз"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var reloadButton: UIButton = {
        var config = UIButton.Configuration.gray() // Менее агрессивная кнопка для повтора
        config.title = "Повторить попытку"
        config.baseForegroundColor = .systemBlue
        config.cornerStyle = .medium
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 16, weight: .semibold)
            return outgoing
        }
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [errorImage, noConnectionLabel, errorMessageLabel, reloadButton])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        setupViewProperties()
//        setupSubviews()
//        setupConstraints()
//    }

    // MARK: - Layout
    private func setupViewProperties() {
        backgroundColor = .systemBackground
    }

    private func setupSubviews() {
//        reloadButton.addTarget(self, action: #selector(didTapReload), for: .touchUpInside)
        [stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }

// MARK: - Actions
//    @objc private func didTapReload(){
//        print(#function, "button tapped")
//    }
}

#Preview("Light theme") {
    NoConnectionView()
}

#Preview("Dark theme") {
    let vc = NoConnectionView()
    vc.overrideUserInterfaceStyle = .dark
    return vc
}


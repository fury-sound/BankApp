//
//  RateStackView.swift
//  BankApp
//
//  Created by Valery Zvonarev on 01.06.2026.
//

import UIKit

final class RateStackView: UIView {
    // MARK: - Properties
//    private let viewModel = RateStackViewModel()

    // MARK: - Subviews
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()

    // MARK: - Lifecycles
    init() {
        super.init(frame: .zero)
            // Do any additional setup after loading the view.
        setupViewProperties()
//        setupSubviews()
//        setupConstraints()
            //        configure(with: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


        // MARK: - Layout
    private func setupViewProperties() {
        backgroundColor = .clear
    }

//    private func setupSubviews() {
//        verticalStack.addArrangedSubview(titleLabel)
//        rowStack.addArrangedSubview(rateLabel)
//        contentView.addSubview(rowStack)
//        addSubview(contentView)
//    }
//
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            //            contentView.topAnchor.constraint(equalTo: topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            //            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            //            contentView.widthAnchor.constraint(greaterThanOrEqualToConstant: 92),
//            contentView.heightAnchor.constraint(equalToConstant: 50),
//
//            rowStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
//            rowStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
//            rowStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
//            rowStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
//        ])
//    }
//
//    func configure(with viewModel: RateRowViewModel) {
//            //        print("in configure")
//            //        titleLabel.text = viewModel.title
//            //        rateLabel.text = viewModel.rate
//        titleLabel.text = viewModel.rateArray[2].title
//        rateLabel.text = viewModel.rateArray[2].rate
//    }

}

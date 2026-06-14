//
//  RateRowView.swift
//  BankApp
//
//  Created by Valery Zvonarev on 28.05.2026.
//

import UIKit
//import SwiftUI

struct RateRowModel {
    let currency: String
    let buyRate: String
    let sellRate: String
}

//protocol RateRowViewProtocol: AnyObject {
//    func configure(with viewModel: RateRowViewModel)
//}

final class RateRowView: UIView {

        // MARK: - Properties
    private let viewModel = RateRowViewModel()

        // MARK: - Subviews
//    public var title: String? {
//        didSet {
//            titleLabel.text = title
//        }
//    }

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .systemBackground
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
//        view.radius(12)
//        view.addShadow()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .preferredFont(forTextStyle: .body)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.backgroundColor = .clear
        label.textColor = .black
//        label.textColor = .label
        return label
    }()

    private let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "Rate"
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .preferredFont(forTextStyle: .body)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.backgroundColor = .clear
        label.textColor = .black
//        label.textColor = .label
        return label
    }()

    private let rowStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
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
        setupSubviews()
        setupConstraints()
//        configure(with: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

        // MARK: - Layout
    private func setupViewProperties() {
        backgroundColor = .clear
    }

    private func setupSubviews() {
        rowStack.addArrangedSubview(titleLabel)
        rowStack.addArrangedSubview(rateLabel)
        contentView.addSubview(rowStack)
        addSubview(contentView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
//            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            contentView.widthAnchor.constraint(greaterThanOrEqualToConstant: 92),
            contentView.heightAnchor.constraint(equalToConstant: 40),

            rowStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            rowStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            rowStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            rowStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
        ])
    }

        // MARK: - Actions
        //    @objc private func didTapButton(){
        //    }
}

//extension RateRowView: RateRowViewProtocol {
extension RateRowView {

    func configure(with viewModel: RateRowModel) {
//        print("in configure")
        titleLabel.text = viewModel.currency
        rateLabel.text = viewModel.buyRate + " / " + viewModel.sellRate
//        print("in configure", titleLabel.text, rateLabel.text)
//        titleLabel.text = viewModel.rateArray[2].title
//        rateLabel.text = viewModel.rateArray[2].rate
    }
}

#Preview {
    let rateRow = RateRowView()
    rateRow.frame = CGRect(x: 25, y: 200, width: 350, height: 150)
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 150))
//    let viewModel = RateRowViewModel()
    let viewModel = RateRowModel(currency: "🇺🇸 USD - 🇧🇾 BelRub!", buyRate: "2.8300", sellRate: "2.9300")
    rateRow.configure(with: viewModel)
//    RateRowView()
    container.addSubview(rateRow)
    return container
}

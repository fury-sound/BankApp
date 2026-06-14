    //
    //  SiteRateViewController.swift
    //  BankApp
    //
    //  Created by Valery Zvonarev on 19.05.2026.
    //

import UIKit
import MapKit
import CoreLocation
import SwiftUI

final class SiteRateViewController: UIViewController {

        // MARK: - Properties
    private var viewModel = SiteRateViewModel()

        // MARK: - Subviews
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
            //        mapView.pointOfInterestFilter = .excludingAll // deprecated
            //        mapView.mapType = .standard //deprecated MKMapConfiguration
            //        mapView.showsTraffic = true
        mapView.showsBuildings = true
            //        mapView.isRotateEnabled = true
            //        mapView.isZoomEnabled = true

        return mapView
    }()

    private let branchNumber: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.numberOfLines = 1
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemBackground
        return label
    }()

    private let address: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 2
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemBackground
        return label
    }()

    private let workingHoursLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 8
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemBackground
        return label
    }()

    private let workingHours: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 8
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemBackground
        return label
    }()

    private let exchangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Курс обмена валют: "
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 1
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemBackground
        return label
    }()

    private let timeStack: UIStackView = {
            //        let stack = UIStackView(arrangedSubviews: [workingHoursLabel, workingHours])
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        return stack
    }()

    private let rateStack: UIStackView = {
            //        let stack = UIStackView(arrangedSubviews: [ratePair, rateLabel])
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()

    private let locationCoordinates: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Координаты: 111.111, 111.111"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemBackground
        return label
    }()

        //    init(viewModel: SiteRateViewModel = SiteRateViewModel()) {
        //        self.viewModel = viewModel
        //    }
        //
        //    required init?(coder: NSCoder) {
        //        fatalError("init(coder:) has not been implemented")
        //    }

        // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        configure(branchData: viewModel.siteRateInfo)
    }

        // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }

    private func setupSubviews() {
        let configuration = MKStandardMapConfiguration()
        configuration.emphasisStyle = .default
        configuration.showsTraffic = true
        configuration.pointOfInterestFilter = .includingAll
        mapView.preferredConfiguration = configuration
        timeStack.addArrangedSubview(workingHoursLabel)
        timeStack.addArrangedSubview(workingHours)
            //        rateStack.addArrangedSubview(ra)
        [branchNumber, exchangeLabel, rateStack, address, timeStack, locationCoordinates, mapView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            branchNumber.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            branchNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            branchNumber.bottomAnchor.constraint(equalTo: exchangeLabel.topAnchor, constant: -30),

            exchangeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            exchangeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            exchangeLabel.bottomAnchor.constraint(equalTo: rateStack.topAnchor, constant: -10),

            rateStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            rateStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            rateStack.bottomAnchor.constraint(equalTo: address.topAnchor, constant: -10),

            address.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            address.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            address.bottomAnchor.constraint(equalTo: workingHours.topAnchor, constant: -10),

            timeStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            timeStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            timeStack.bottomAnchor.constraint(equalTo: locationCoordinates.topAnchor, constant: -10),

            locationCoordinates.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            locationCoordinates.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            locationCoordinates.bottomAnchor.constraint(equalTo: mapView.topAnchor, constant: -10),
            locationCoordinates.heightAnchor.constraint(equalToConstant: 30),

            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mapView.heightAnchor.constraint(equalToConstant: 200),
            mapView.widthAnchor.constraint(equalToConstant: 200)

        ])
    }

    private func configure(branchData: RateViewModel) {
        branchNumber.text = branchData.branchNumber
        branchData.toViewModel().rates.forEach { rate in
            let row = RateRowView()
            row.configure(with: rate)
            row.heightAnchor.constraint(equalToConstant: 50).isActive = true
            row.translatesAutoresizingMaskIntoConstraints = false
            rateStack.addArrangedSubview(row)
        }

        let addressStr = "Беларусь, " + "\(branchData.locationType) \(branchData.location), \(branchData.streetType) \(branchData.street), \(branchData.building)"
//        print(addressStr)
        guard let branchNumberStr = branchNumber.text else { return }
        viewModel.showLocation(branchNumber: branchNumberStr, addressStr: addressStr, mapView: mapView) { [weak self] location in
            DispatchQueue.main.async {
                guard let self else { return }
                if let location {
                    self.locationCoordinates.text = "Координаты: \(location)"
                } else {
                    self.locationCoordinates.text = "Координаты не найдены"
                }
            }
        }
        print("viewModel.locationString", viewModel.locationString)
        address.text = "Адрес: " + addressStr
        let hours = branchData.workHours.trimmingCharacters(in: .whitespaces).split(separator: "|").joined(separator: "\n")
            //        print(hours)
        workingHoursLabel.text = "Часы работы:"
        workingHours.text = hours
//        guard let location = viewModel.locationString else {
//            print("nil in viewModel.locationString")
//            return
//        }
//        locationCoordinates.text = "Координаты:" + location
    }

}

    // MARK: - Actions
    //    @objc private func didTapButton(){
    //    }
    //}

#Preview {
    SiteRateViewController()
}


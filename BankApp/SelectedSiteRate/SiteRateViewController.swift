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
    private var bankRates: [RateViewModel] = []
    private let networkService = NetworkService.shared
    let activityIndicator = UIActivityIndicatorView(style: .large)

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
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        return stack
    }()

    private let rateStack: UIStackView = {
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

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        fetchRates()
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
        address.text = "Адрес: " + addressStr
//        print(branchData.workHours)
        let hours = branchData.workHours.trimmingCharacters(in: .whitespaces).split(separator: "|").joined(separator: "\n")
        workingHoursLabel.text = "Часы работы:"
        workingHours.text = hours
        loadCoordinates(for: addressStr)
    }

    private func fetchRates() {
        //        print(#function)
        bankRates = []
        activityIndicator.startAnimating()
        //        networkService.fetch(endpoint: .news) { [weak self] result in
        networkService.fetchRate { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let bankRatesAll):
                        self?.bankRates = bankRatesAll
//                        guard let bankRatesCurrent = bankRatesAll else { return }
                        print(bankRatesAll.count)
                        print(bankRatesAll[0].branchNumber)
                        print(bankRatesAll[0].location)
                        self?.viewModel.siteRateInfo = bankRatesAll[0]
                        self?.configure(branchData: bankRatesAll[0])
                    case .failure(let error):
                        print(error)
                }
                self?.activityIndicator.stopAnimating()
            }
        }
    }

    private func loadCoordinates(for address: String) {
        viewModel.geocodeAddress(address) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                    case .success(let coordinate):
//                        self.locationCoordinates.text = "Координаты: \(coordinate.latitude), \(coordinate.longitude)"
                        self.locationCoordinates.text = String(
                            format: "Координаты: %.5f, %.5f",
                            coordinate.latitude,
                            coordinate.longitude
                        )
                        self.showPin(
                            coordinate: coordinate,
                            title: self.branchNumber.text ?? "Не удалось получить номер отделения",
                            subtitle: address
                        )
                    case .failure(let error):
                        self.locationCoordinates.text = "Координаты не найдены"
                        print(error.localizedDescription)
                }
            }
        }
    }

    private func showPin(coordinate: CLLocationCoordinate2D,
                         title: String,
                         subtitle: String)  {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 500,
            longitudinalMeters: 500
        )
        mapView.setRegion(region, animated: true)
    }
}

// MARK: - Actions
//    @objc private func didTapButton(){
//    }
//}

#Preview {
    SiteRateViewController()
}


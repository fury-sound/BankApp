//
//  SiteRateViewModel.swift
//  BankApp
//
//  Created by Valery Zvonarev on 19.05.2026.
//

import Foundation
import MapKit

final class SiteRateViewModel {
    let geoCoder = CLGeocoder()
    //    var locationString: String?
    var locationCoordinates: CLLocationCoordinate2D?
    private var isGeocoding = false
    var bankRatesAll: [RateViewModel] = []

    var siteRateInfo = RateViewModel(
        usdIn: "2.7700", usdOut: "2.8150",
        eurIn: "3.2400", eurOut: "3.3350",
        rubIn: "3.7600", rubOut: "3.8200",
        workHours: "|Пн 00 00 23 59    |Вт 00 00 23 59    |Ср 00 00 23 59    |Чт 00 00 23 59    |Пт 00 00 23 59    |Сб 00 00 23 59    |Вс 00 00 23 59    |",
        branchNumber: "Отделение №100/1008",
        streetType: "шоссе ", street: "Варшавское", building: "1",
        location: "Брест", locationType: "г."
    )

    //    func geocodeAddress (
    //        _ address: String,
    //        completion: @escaping (CLLocationCoordinate2D?) -> Void
    //    ) {
    //        geoCoder.geocodeAddressString(address) { (placemarks, error) in
    //            if let error = error {
    //                let errorCode = (error as NSError).code
    //            }
    //        }
    //    }

    func makeCityList(from allRateList: [RateViewModel]) {
        var cityList: [String] = []
        allRateList.forEach {
            if !cityList.contains($0.location) {
                cityList.append($0.location)
            }
        }
//        cityList.removeFirst()
        print(cityList)
    }

    func geocodeAddress (
        _ address: String,
        completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> Void
    ) {
        if isGeocoding {
            print("Geocoding in progress")
            return
        }
        isGeocoding = true

        geoCoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard let self else { return }
            defer { self.isGeocoding = false }
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let placemark = placemarks?.first, let location = placemark.location else {
                completion(
                    .failure(
                        NSError(
                            domain: "Geocoding",
                            code: -1,
                            userInfo: [
                                NSLocalizedDescriptionKey: "Адрес не найден"
                            ]
                        )
                    )
                )
                return
            }
            completion(.success(location.coordinate))
        }
    }

//    func showLocation(
//        branchNumber: String,
//        addressStr: String,
//        mapView: MKMapView,
//        completion: @escaping (CLLocationCoordinate2D?) -> Void
//        //        completion: @escaping (String?) -> Void
//    ) {
//        if isGeocoding {
//            print("Geocoding in progress")
//            return
//        }
//        isGeocoding = true
//
//        geoCoder.geocodeAddressString(addressStr) { [weak self] (placemarks, error) in
//
//            defer { self?.isGeocoding = false }
//            guard let self else { return }
//
//            if let error = error {
//                let errorCode = (error as NSError).code
//                print("Ошибка геокодинга (код \(errorCode): \(error.localizedDescription)")
//                if errorCode == 2 {
//                    print("Проверьте интернет соединение: \(error.localizedDescription)")
//                }
//                completion(nil)
//                return
//            }
//            guard let placemark = placemarks?.first, let location = placemark.location else {
//                print("Адрес не найден")
//                completion(nil)
//                return
//            }
//            let coord = location.coordinate
//            self.locationCoordinates = location.coordinate
//            completion(locationCoordinates)
//            //            self.locationString = "\(coord.latitude), \(coord.longitude)"
//            //            completion(locationString)
//            //            else {
//            //                print("Ошибка геолокации", error?.localizedDescription)
//            //                return
//            //            }
//            //            print("latitude, longitude", coord.latitude, coord.longitude)
//            //            print("latitude, longitude: \(coord.latitude), \(coord.longitude)")
//            //            print("self.locationString in VM:", self.locationString)
//            let annotation = MKPointAnnotation()
//            annotation.title = branchNumber
//            annotation.subtitle = addressStr
//            annotation.coordinate = coord
//            mapView.addAnnotation(annotation)
//            let region = MKCoordinateRegion(
//                center: coord,
//                latitudinalMeters: 800,
//                longitudinalMeters: 800
//            )
//            mapView.setRegion(region, animated: true)
//            //                self.mapView.addAnnotation(annotation)
//        }
//    }
}

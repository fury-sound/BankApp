    //
    //  ImageService.swift
    //  BankApp
    //
    //  Created by Valery Zvonarev on 19.05.2026.
    //

import UIKit
import Kingfisher

protocol ImageServiceProtocol {
    func setImage(into imageView: UIImageView,
                  from urlString: String,
                  placeholder: UIImage?,
                  completion: ((Result<UIImage, Error>) -> Void)?)
    func prefetchImages(urls: [String])
    func clearCache()
//    func getCachedImage(from urlString: String) -> UIImage?
}

final class ImageService: ImageServiceProtocol {

    static let shared = ImageService()
    private init() {}

        // MARK: - Public methods

    func setImage(into imageView: UIImageView, from urlString: String, placeholder: UIImage? = nil, completion: ((Result<UIImage, any Error>) -> Void)? = nil) {
        guard let url = URL(string: urlString) else {
            completion?(.failure(URLError(.badURL)))
            return
        }
        imageView.kf.indicatorType = .activity

            // cache
        let options: KingfisherOptionsInfo = [
            .transition(.fade(0.2)),
            .cacheOriginalImage,
            .scaleFactor(UIScreen.main.scale),
            .memoryCacheExpiration(.seconds(300)),
            .diskCacheExpiration(.days(7))
        ]

        imageView.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options
        ) { result in
            switch result {
                case .success(let value):
                    completion?(.success(value.image))
                case .failure(let error):
                    completion?(.failure(error))
            }
        }
    }

        // предзагрузка
    func prefetchImages(urls: [String]) {
        let validUrls = urls.compactMap { URL(string: $0) }
        let prefetcher = ImagePrefetcher(urls: validUrls)
        prefetcher.start()
    }

        // очищаем кэш
    func clearCache() {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache()
    }

//    func getCachedImage(from urlString: String) -> UIImage? {
//        guard let url = URL(string: urlString) else { return nil }
//        let cache = KingfisherManager.shared.cache
//        let key = url.cacheKey
//        let options = KingfisherParsedOptionsInfo(nil)
//        if let memoryImage = cache.retrieveImageInMemoryCache(forKey: key, options: options) {
//            return memoryImage
//        }
//        do {
//                //            let diskImage = try cache.retrieveImageInDiskCache(forKey: key, options: nil)
//                //            return diskImage
//            if let data = try? cache.diskStorage.value(forKey: key) {
//                return UIImage(data: data)
//            }
//        }
//        return nil
//    }

}

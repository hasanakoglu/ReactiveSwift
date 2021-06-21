import RxSwift

let imageCache = NSCache<NSString, UIImage>()

protocol ImageProviderProtocol {
    func loadImageFromUrl(url: URL?) -> Observable<UIImage?>
}

final class ImageProvider: ImageProviderProtocol {
    func getImageFromUrl(from url: URL?) -> Observable<UIImage?> {
        guard let url = url else { return Observable.just(nil) }
        return URLSession.shared.data(from: url).map { data -> UIImage? in
            guard let image = UIImage(data: data) else { return nil }
            imageCache.setObject(image, forKey: url.absoluteString as NSString)
            return image
        }.asObservable()
    }
    
    func loadImageFromUrl(url: URL?) -> Observable<UIImage?> {
        guard let url = url else { return Observable.just(nil) }
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) {
            return Observable.just(imageFromCache)
        } else {
            return getImageFromUrl(from: url)
        }
    }
}

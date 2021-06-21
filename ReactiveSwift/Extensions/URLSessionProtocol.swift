import Foundation
import RxSwift
import RxCocoa

protocol URLSessionProtocol {
    func data(from url: URL) -> Observable<Data>
}

extension URLSession: URLSessionProtocol {
    func data(from url: URL) -> Observable<Data> {
        let request = URLRequest(url: url)
        return self.rx.data(request: request)
    }
}

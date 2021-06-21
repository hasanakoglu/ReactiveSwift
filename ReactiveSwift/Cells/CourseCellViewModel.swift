import RxSwift
import RxCocoa
import UIKit

final class CourseCellViewModel {
    let output: Output
    
    struct Output {
        let image: Driver<UIImage?>
    }
    
    init(courses: Course, imageProvider: ImageProviderProtocol = ImageProvider()) {
        output = Output(image: imageProvider.loadImageFromUrl(url: URL(string: courses.imageUrl ?? "")).asDriver(onErrorJustReturn: nil))
    }
}

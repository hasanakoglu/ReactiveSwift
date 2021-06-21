import Combine
import Reachability
import RxCocoa
import RxDataSources
import RxRelay
import RxSwift

final class MainViewModel {
    private let client: APIClient
    private let scheduler: SchedulerType
    private let disposeBag = DisposeBag()
    
    private var cancelBag = Set<AnyCancellable>() //combine
    
    private let coursesDataItemsRelay = BehaviorRelay<[Course]>(value: [])
    //    private let isDimViewHiddenRelay = BehaviorRelay<Bool>(value: true)
    
    //    private(set) lazy var isDimViewHidden: Driver<Bool> = isDimViewHiddenRelay.asDriver().distinctUntilChanged()
    
    let tableViewData: Observable<[MainViewSection]>
    
    //    private var hasNetworkConnection: Bool {
    //        guard let reachability = reachability else {
    //            return false
    //        }
    //        return reachability.connection != .unavailable
    //    }
    
    init(client: APIClient,
         scheduler: SchedulerType = MainScheduler.instance) {
        self.client = client
        self.scheduler = scheduler
        //        self.reachability = reachability
        
        let headerSection = Observable<[MainViewSection]>.just([.headerSection(items: [.header(title: "Reactive Coding", subtitle: "Welcome to a small example of how to populate a tableview with different sections using reactive coding!")])])
        
        let detailSection = coursesDataItemsRelay
            .map { items -> [MainViewSection] in
                let dashboardItems = items.map { MainViewItem.details(model: $0) }
                let detailSection = MainViewSection.detailSection(items: dashboardItems)
                return [detailSection]
            }
        
        tableViewData = Observable.combineLatest(headerSection, detailSection)
            .map { $0 + $1 }
            .distinctUntilChanged()
    }
    
    //rx version
    
    func fetchCourses() {
        client.fetchCourses()
            .observeOn(scheduler)
            .map { course in
                course.reduce(into: [Course]()) { courseDataItems, courseItem in
                    guard let id  = courseItem.id else { return }
                    guard let name = courseItem.name else { return }
                    guard let lessons = courseItem.numberOfLessons else { return }
                    guard let imageURL = courseItem.imageUrl else { return }
                    let item = Course(id: id, name: name, link: nil, imageUrl: imageURL, numberOfLessons: lessons)
                    courseDataItems.append(item)
                }
            }
            .map { [coursesDataItemsRelay] in coursesDataItemsRelay.value + $0 }
            .subscribe { [coursesDataItemsRelay] value in
                coursesDataItemsRelay.accept(value)
            }
            .disposed(by: disposeBag)
    }
    
    // combine version
    
    func fetchCourses2() {
        client.fetchCourses2()
            .receive(on: DispatchQueue.main)
            .map { (course) in
                course.reduce(into: [Course]()) { courseDataItems, courseItem in
                    guard let id  = courseItem.id else { return }
                    guard let name = courseItem.name else { return }
                    guard let lessons = courseItem.numberOfLessons else { return }
                    guard let imageURL = courseItem.imageUrl else { return }
                    let item = Course(id: id, name: name, link: nil, imageUrl: imageURL, numberOfLessons: lessons)
                    courseDataItems.append(item)
                }
            }
            .map { [coursesDataItemsRelay] in coursesDataItemsRelay.value + $0 }
            .sink(receiveCompletion: { _ in
                // completion
            }, receiveValue: { [coursesDataItemsRelay] value in
                coursesDataItemsRelay.accept(value)
            })
            .store(in: &cancelBag)
    }
}

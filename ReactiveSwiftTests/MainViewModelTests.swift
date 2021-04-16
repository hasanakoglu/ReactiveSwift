import RxSwift
import RxTest
import XCTest

@testable import ReactiveSwift

class ReactiveSwiftViewModelTests: XCTestCase {
    var subject: MainViewModel!
    let testScheduler = TestScheduler(initialClock: 0, simulateProcessingDelay: false)
    let disposeBag = DisposeBag()
    
    override func setUpWithError() throws {
        super.setUp()
        subject = MainViewModel(client: APIClient(),
                                scheduler: testScheduler)
    }

    override func tearDownWithError() throws {
        subject = nil
        super.tearDown()
    }
    
    func testHeaderSection() {
        let observer = testScheduler.createObserver([MainViewSection].self)
        subject.tableViewData.subscribe(observer).disposed(by: disposeBag)

        testScheduler.start()

        XCTAssertEqual(observer.events, [
            .next(0, [
                .headerSection(items: [headerItem()]),
                .detailSection(items: [])
            ])
        ])
    }
}

private extension ReactiveSwiftViewModelTests {
    func headerItem(
        title: String? = "Reactive Coding",
        subtitle: String? = "Welcome to a small example of how to populate a tableview with different sections using reactive coding!")-> MainViewItem
    {
        .header(title: title, subtitle: subtitle)
    }
}

class MockClient: APIClient {
    
}

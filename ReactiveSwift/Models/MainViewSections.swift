import RxDataSources

enum MainViewSection: Equatable {
    case headerSection(items: [MainViewItem])
    case detailSection(items: [MainViewItem])
}

enum MainViewItem: Equatable {
    case header(title: String?, subtitle: String?)
    case details(model: Course)
}

extension MainViewSection: SectionModelType {
    typealias Item = MainViewItem
    
    var items: [MainViewItem] {
        switch self {
        
        case .headerSection(let items):
            return items
        case .detailSection(let items):
            return items
        }
    }
    
    init(original: MainViewSection, items: [MainViewItem]) {
        switch original {
        
        case .headerSection:
            self = .headerSection(items: items)
        case .detailSection:
            self = .detailSection(items: items)
        }
    }
}

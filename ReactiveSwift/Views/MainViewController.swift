import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import UIKit

class MainViewController: UIViewController {
    let viewModel: MainViewModel
    
    private let disposeBag = DisposeBag()
    
//    private let dimView: UIView = UIView(frame: .zero)

    private var tableView: UITableView = UITableView()
    
    public init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        viewModel.fetchCourses() //rxswift
        viewModel.fetchCourses2() // combine
    }
    
    private func setupViews() {
        title = NSLocalizedString("RxSwift", comment: "")
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.largeTitleDisplayMode = .never

        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }

//        view.addSubview(dimView)
//        dimView.isHidden = true
//        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        dimView.snp.makeConstraints { make in
//            make.top.leading.trailing.bottom.equalToSuperview()
//        }

        view.backgroundColor = .black

        tableView.register(HeaderCell.self, forCellReuseIdentifier: HeaderCell.identifier)
        tableView.register(DetailsCell.self, forCellReuseIdentifier: DetailsCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func bind() {
        viewModel.tableViewData
            .bind(to: tableView.rx.items(dataSource: dataSourceTransformer()))
            .disposed(by: disposeBag)

//        viewModel.isDimViewHidden.drive(dimView.rx.isHidden).disposed(by: disposeBag)
    }
    
    private func dataSourceTransformer() -> RxTableViewSectionedReloadDataSource<MainViewSection> {
        return RxTableViewSectionedReloadDataSource { dataSource, table, indexPath, _ -> UITableViewCell in
            switch dataSource[indexPath] {
            case let .header(title: title, subtitle: subtitle):
                guard let cell = table.dequeueReusableCell(withIdentifier: HeaderCell.identifier,
                                                           for: indexPath) as? HeaderCell
                else {
                    return UITableViewCell()
                }

                cell.update(title: title, subtitle: subtitle)
                return cell
            case .details(let model):
                guard let cell = table.dequeueReusableCell(withIdentifier: DetailsCell.identifier,
                                                           for: indexPath) as? DetailsCell
                else {
                    return UITableViewCell()
                }

                cell.update(title: "\(model.id)", name: model.name)
                return cell
            }
        }
    }
}

extension UITableView {
    func register(_ cellClass: AnyClass) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass.self))
    }
}



import SnapKit
import UIKit
import RxSwift

class DetailsCell: UITableViewCell {
    static let identifier: String = "cell2"
    var titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()
    let cardView: UIView = UIView()
    let characterImageView: UIImageView = UIImageView()
    let disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func update(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        titleLabel.font = UIFont(name: "ArialMT", size: 12)
        subtitleLabel.font = UIFont(name: "ArialMT", size: 12)
    }
    
    func bind(to viewModel: CourseCellViewModel) {
        viewModel.output.image.drive(characterImageView.rx.image).disposed(by: disposeBag)
    }

    func setupViews() {
        selectionStyle = .none
        translatesAutoresizingMaskIntoConstraints = false

        cardView.backgroundColor = .white
        cardView.clipsToBounds = true
        cardView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFit

        contentView.addSubview(cardView)
        cardView.addSubview(characterImageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(subtitleLabel)

        initializeConstraints()
    }

    func initializeConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        characterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(200)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(characterImageView.snp.bottom).offset(10.0)
            make.leading.equalToSuperview().inset(16.0)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(5.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
    }
}


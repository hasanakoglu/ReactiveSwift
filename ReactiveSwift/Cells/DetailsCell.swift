import SnapKit
import UIKit

class DetailsCell: UITableViewCell {
    static let identifier: String = "cell2"
    var titleLabel: UILabel = UILabel()
    let nameLabel: UILabel = UILabel()
    let cardView: UIView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func update(title: String, name: String) {
        titleLabel.text = title
        nameLabel.text = name
        titleLabel.font = UIFont(name: "ArialMT", size: 12)
        nameLabel.font = UIFont(name: "ArialMT", size: 12)
    }

    func setupViews() {
        selectionStyle = .none
        translatesAutoresizingMaskIntoConstraints = false

        cardView.backgroundColor = .white
        cardView.clipsToBounds = true
        cardView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(cardView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(nameLabel)

        initializeConstraints()
    }

    func initializeConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.0)
            make.leading.equalToSuperview().inset(16.0)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.top.equalTo(titleLabel.snp.bottom).offset(5.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
    }
}


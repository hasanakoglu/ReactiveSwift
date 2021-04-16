import UIKit

class HeaderCell: UITableViewCell {
    static let identifier: String = "cell1"
    let titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func update(title: String?, subtitle: String?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        titleLabel.font = UIFont(name: "Arial-BoldMT", size: 20)
        subtitleLabel.font = UIFont(name: "Arial-ItalicMT", size: 14)
    }

    private func setupViews() {
        selectionStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)

        subtitleLabel.numberOfLines = 0

        initializeConstraints()
    }

    private func initializeConstraints() {
        let horizontalOffset: CGFloat = 16.0
        let verticalOffset: CGFloat = 27.0

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(verticalOffset)
            make.leading.trailing.equalToSuperview().inset(horizontalOffset)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.trailing.equalToSuperview().offset(-horizontalOffset)
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalOffset)
            make.bottom.equalToSuperview().offset(-horizontalOffset)
        }
    }
}

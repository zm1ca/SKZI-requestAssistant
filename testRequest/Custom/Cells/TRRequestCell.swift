//
//  TRRequestCell.swift
//  SKZI-requestAssistant
//
//  Created by Źmicier Fiedčanka on 9.09.20.
//

import UIKit
import SnapKit

final class TRRequestCell: UITableViewCell {

    static let reuseID      = "RequestCell"

    let titleLabel        = TRTitleLabel(textAlignment: .left, fontSize: 18)
    let paragraphsLabel   = TRBodyLabel(textAlignment: .left, font: UIFont.preferredFont(forTextStyle: .footnote))
    let dateModifiedLabel = TRBodyLabel(textAlignment: .right, font: UIFont.preferredFont(forTextStyle: .caption2))

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with presentable: RequestPresentable) {
        titleLabel.text        = presentable.title
        paragraphsLabel.text   = presentable.paragraphs
        dateModifiedLabel.text = presentable.dateModified
    }

    func layoutUI() {
        accessoryType   = .disclosureIndicator
        paragraphsLabel.numberOfLines = 2

        addSubviews(titleLabel, paragraphsLabel, dateModifiedLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(25)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(40)
        }

        dateModifiedLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(15)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(40)
        }

        paragraphsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(5)
            make.height.equalTo(32)
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(40)
        }
    }
}

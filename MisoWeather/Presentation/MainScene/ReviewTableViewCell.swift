//
//  ReviewTableViewCell.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/23.
//

import UIKit
import SnapKit

final class ReviewTableViewCell: UITableViewCell {
    
    // MARK: - subView
    
    var frontColor = UIColor.white
    var backColor = UIColor.backgroundColor
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = frontColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34.0)
        label.textColor = .textColor
        label.text = "🐯"
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .regular)
        label.textColor = .textColor
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11.0, weight: .thin)
        label.textColor = .textColor
        return label
    }()
    
    lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .light)
        label.textColor = .textColor
        label.numberOfLines = 0
        return label
    }()
    
    func setData(data: CommentList) {
        
        //2022-02-07T13:47:41.269958
    
        // 02-07
        let dateStart = data.createdAt.index(data.createdAt.startIndex, offsetBy: 5)
        let dateEnd = data.createdAt.index(data.createdAt.endIndex, offsetBy: -16)
        let dateRange = dateStart..<dateEnd
        let date = data.createdAt.substring(with: dateRange)
        
        var formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        var currentDate = formatter.string(from: Date())
        
        let start = data.createdAt.index(data.createdAt.startIndex, offsetBy: 11)
        let end = data.createdAt.index(data.createdAt.endIndex, offsetBy: -10)
        let range = start..<end
        let time = data.createdAt.substring(with: range)
        
        timeLabel.text = time
        
        //02-07 == 02-07
        if date != currentDate {
            let date = date.replacingOccurrences(of: "-", with: ".")
            timeLabel.text = date + "." + time
        }
        
        nameLabel.text = data.bigScale + "의 " + data.nickname
        reviewLabel.text = data.content

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = backColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewTableViewCell {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            backView
        ].forEach {addSubview($0)}
        
        [   emojiLabel,
            nameLabel,
            timeLabel,
            reviewLabel
        ].forEach {backView.addSubview($0)}
   
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }

        emojiLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(19)
            $0.centerY.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(emojiLabel.snp.trailing).offset(9)
            $0.top.equalTo(emojiLabel).inset(-2)
        }
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel)
            $0.trailing.equalTo(backView.snp.trailing).inset(20)
        }
        reviewLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.width.equalTo(width * 0.63)
        }
    }
}

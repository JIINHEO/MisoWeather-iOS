//
//  SurveyTableViewCell.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/01/24.
//

import UIKit
import SnapKit

final class SurveyTableViewCell: UITableViewCell {
    
    var chartList: [Chart] = []
    var titleList: [UILabel] = []
    var percentList: [UILabel] = []
    
    // MARK: - SubView
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.textColor = .textColor
        return label
    }()
    
    private lazy var leftBackgoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var rightBackgoundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var answerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .textColor
        label.text = "내 답변"
        return label
    }()
    
    private lazy var askTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .textColor
        label.text = "다른 사람들은"
        return label
    }()
    
    private lazy var checkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "checkCircle")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .mainColor
        return label
    }()
    
    // MARK: - ChartView
    private lazy var chartHideView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    private lazy var chart1: Chart = {
        let chart = Chart()
        chart.color = UIColor.mainColor!.cgColor
        return chart
    }()
    private lazy var chart2: Chart = {
        let chart = Chart()
        return chart
    }()
    private lazy var chart3: Chart = {
        let chart = Chart()
        return chart
    }()
    
    private lazy var chart1Label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11.0, weight: .bold)
        label.textColor = .mainColor
        label.textAlignment = .right
        return label
    }()
    private lazy var chart2Label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11.0, weight: .bold)
        label.textColor = .textColor
        label.textAlignment = .right
        return label
    }()
    private lazy var chart3Label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11.0, weight: .bold)
        label.textColor = .textColor
        label.textAlignment = .right
        return label
    }()
    
    private lazy var chart1PercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .mainColor
        label.textAlignment = .right
        return label
    }()
    private lazy var chart2PercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .textColor
        label.textAlignment = .right
        return label
    }()
    private lazy var chart3PercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .textColor
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Method

    private func setList() {
        chartList = [chart1, chart2, chart3]
        titleList = [chart1Label, chart2Label, chart3Label]
        percentList = [chart1PercentLabel, chart2PercentLabel, chart3PercentLabel]
    }
    
    func setSurveyData(surveyData: SurveyList) {
        for index in 0..<chartList.count {
            titleLabel.text = surveyData.surveyDescription + " " + surveyData.surveyTitle
            titleList[index].text = surveyData.keyList[index]
            chartList[index].percent = surveyData.valueList[index]
            percentList[index].text = "\(surveyData.valueList[index])%"
        }
    }
    
    func setUserSurveyData(userData: UserSurveyList) {
            questionLabel.text = userData.memberAnswer
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setList()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SurveyTableViewCell {
    // MARK: - layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
      
        [
            titleLabel,
            leftBackgoundView,
            rightBackgoundView,
            answerTitleLabel,
            askTitleLabel,
            checkImage,
            questionLabel,
            chart1,
            chart1Label,
            chart1PercentLabel,
            chart2,
            chart2Label,
            chart2PercentLabel,
            chart3,
            chart3Label,
            chart3PercentLabel,
            chartHideView
        ].forEach {addSubview($0)}

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.leading.equalToSuperview()
        }
        leftBackgoundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
            $0.width.equalTo(width * 0.3)
            $0.bottom.equalToSuperview().inset(10)
        }
        rightBackgoundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(18)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(width * 0.56)
            $0.bottom.equalToSuperview().inset(10)
        }
        answerTitleLabel.snp.makeConstraints {
            $0.top.equalTo(leftBackgoundView).inset(16)
            $0.centerX.equalTo(leftBackgoundView)
        }
        askTitleLabel.snp.makeConstraints {
            $0.top.equalTo(answerTitleLabel)
            $0.centerX.equalTo(rightBackgoundView)
        }
        checkImage.snp.makeConstraints {
            $0.top.equalTo(answerTitleLabel.snp.bottom).offset(6)
            $0.centerX.equalTo(leftBackgoundView)
            $0.width.equalTo(46)
            $0.height.equalTo(46)
        }
        questionLabel.snp.makeConstraints {
            $0.top.equalTo(checkImage.snp.bottom).offset(9)
            $0.centerX.equalTo(leftBackgoundView)
        }
        chartHideView.snp.makeConstraints {
            $0.top.equalTo(askTitleLabel.snp.bottom).offset(3)
            $0.leading.equalTo(rightBackgoundView).inset(width * 0.029)
            $0.width.equalTo(4)
            $0.height.equalTo(76)
        }
        chart1.snp.makeConstraints {
            $0.top.equalTo(answerTitleLabel.snp.bottom).offset(13)
            $0.leading.equalTo(rightBackgoundView.snp.leading).inset(width * 0.05)
            $0.height.equalTo(15)
            $0.width.equalTo(width * 0.25)
        }
        chart2.snp.makeConstraints {
            $0.top.equalTo(chart1.snp.bottom).offset(7)
            $0.leading.equalTo(rightBackgoundView.snp.leading).inset(width * 0.05)
            $0.height.equalTo(15)
            $0.width.equalTo(width * 0.25)
        }
        chart3.snp.makeConstraints {
            $0.top.equalTo(chart2.snp.bottom).offset(7)
            $0.leading.equalTo(rightBackgoundView.snp.leading).inset(width * 0.05)
            $0.height.equalTo(15)
            $0.width.equalTo(width * 0.25)
        }
        chart1Label.snp.makeConstraints {
            $0.centerY.equalTo(chart1)
            $0.leading.equalTo(chart1.snp.trailing)
            $0.width.equalTo(51)
        }
        chart2Label.snp.makeConstraints {
            $0.centerY.equalTo(chart2)
            $0.leading.equalTo(chart1.snp.trailing)
            $0.width.equalTo(51)
        }
        chart3Label.snp.makeConstraints {
            $0.centerY.equalTo(chart3)
            $0.leading.equalTo(chart1.snp.trailing)
            $0.width.equalTo(51)
        }
        chart1PercentLabel.snp.makeConstraints {
            $0.centerY.equalTo(chart1)
            $0.leading.equalTo(chart1Label.snp.trailing).offset(1)
            $0.width.equalTo(33)
        }
        chart2PercentLabel.snp.makeConstraints {
            $0.centerY.equalTo(chart2)
            $0.leading.equalTo(chart1Label.snp.trailing).offset(1)
            $0.width.equalTo(33)
        }
        chart3PercentLabel.snp.makeConstraints {
            $0.centerY.equalTo(chart3)
            $0.leading.equalTo(chart1Label.snp.trailing).offset(1)
            $0.width.equalTo(33)
        }
    }
}

//
//  QnaView.swift
//  MisoWeather
//
//  Created by jiinheo on 2022/02/11.
//

import UIKit
import SnapKit
import Lottie

class QnaView: UIView {
    
    var item: String
    
    // MARK: - SubView
    private lazy var animationView: LottieAnimationView = {
        let view = LottieAnimationView(name: "lf20_tnqgtf5o")
        view.frame = self.bounds
        view.contentMode = .scaleAspectFit
        view.play()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
 
        label.font = .systemFont(ofSize: 28, weight: .light)
        
        let text = """
                    오늘 같은 날씨엔
                    역시 \(self.item)!
                    """
        label.text = text
        
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: self.item))
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        label.attributedText = attributeString
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var thankyouLabel: UILabel = {
        let label = UILabel()
        label.text = "답변 감사해요!"
        label.font = .systemFont(ofSize: 24, weight: .light)
        return label
    }()
    
    // MARK: - LifeCycle Method

    init(frame: CGRect, item: String) {
        self.item = item
  
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QnaView {
    // MARK: - Layout
    private func setupView(width: CGFloat = UIScreen.main.bounds.width, height: CGFloat = UIScreen.main.bounds.height) {
        
        self.backgroundColor = .white
        
        [
            animationView,
            titleLabel,
            thankyouLabel
        ].forEach {self.addSubview($0)}
        
        animationView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalTo(animationView.snp.top).inset(-40)
            $0.centerX.equalToSuperview()
        }
        
        thankyouLabel.snp.makeConstraints {
            $0.top.equalTo(animationView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
        }
    }
}

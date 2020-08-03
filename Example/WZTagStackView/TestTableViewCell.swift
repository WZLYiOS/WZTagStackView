//
//  TestTableViewCell.swift
//  WZTagStackView_Example
//
//  Created by qiuqixiang on 2020/4/24.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import WZTagStackView

class TestTableViewCell: UITableViewCell {

    private lazy var tagView: WZTagStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.maxWith = UIScreen.main.bounds.size.width - 20
        $0.rowMarn = 10
        $0.verticalMarn = 10
        return $0
    }(WZTagStackView())
    
    /// 容器
    private lazy var stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.clear
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 0
        return $0
    }(UIStackView(arrangedSubviews: [tagView]))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configView()
        configViewLocation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
//        contentView.addSubview(tagView)
        contentView.addSubview(stackView)
    }
    func configViewLocation() {
        
//        tagView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
//        tagView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
//        tagView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
//        let bottomAncor = tagView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
//        bottomAncor.priority = .defaultLow
//        bottomAncor.isActive = true
        
//        NSLayoutConstraint.activate([
//            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
//            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
//            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
//        ])
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        let bottomAncor = stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        bottomAncor.priority = .defaultLow
        bottomAncor.isActive = true
    }
    
    func upload(tags: [TestLabel]) {
        tagView.reload(datas: tags)
    }
}

// MARK - 标签视图
class TestLabel: UILabel, WZTagStackViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 1
        self.text = "手机阿卡收到货"
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getOriginView() -> UIView {
        return self
    }
    
    func getViewSize() -> CGSize {
        return CGSize(width: ceil((UIScreen.main.bounds.width-50)/3), height: 30)
    }
    
}

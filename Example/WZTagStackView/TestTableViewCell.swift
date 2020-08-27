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
        $0.maxWith = (UIScreen.main.bounds.size.width-20)
        $0.rowMarn = 10
        $0.verticalMarn = ($0.maxWith-60*5)/4
//        $0.topMarn = 20
//        $0.bottomMarn = 30
//        $0.lelftMarn = 50
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
    
    private lazy var titleLabel: UILabel = {
        $0.text = "服务内容"
        return $0
    }(UILabel())
    
    private lazy var rightLabel: UILabel = {
        $0.text = "服务内容"
        $0.textAlignment = .right
        return $0
    }(UILabel())
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        configView()
        configViewLocation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightLabel)
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
        titleLabel.frame = CGRect(x: 20, y: 0, width: 100, height: 20)
        rightLabel.frame = CGRect(x: UIScreen.main.bounds.size.width-100, y: 0, width: 80, height: 20)
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
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
class TestLabel: UIView, WZTagStackViewProtocol {
    
    private lazy var lelftImageView: UIImageView = {
        $0.image = UIImage(named: "ic_workbench_date")
        return $0
    }(UIImageView())
    
    private lazy var titileLabel: UILabel = {
        $0.text = "用户库搜索"
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(lelftImageView)
        self.addSubview(titileLabel)
        lelftImageView.frame = CGRect(x: 8, y: 0, width: 44, height: 44)
        titileLabel.frame = CGRect(x: 0, y: 50, width: getViewSize().width, height: 13)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getOriginView() -> UIView {
        return self
    }
    
    func getViewSize() -> CGSize {
        return CGSize(width: 60, height: 65)
    }
    
}

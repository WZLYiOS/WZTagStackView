//
//  TestTableViewCell.swift
//  WZTagStackView_Example
//
//  Created by qiuqixiang on 2020/4/24.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import WZTagStackView
import SnapKit

class TestTableViewCell: UITableViewCell {

    private lazy var tagView: WZStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.rowMarn = 10
        $0.verticalMarn = 10
//        $0.topMarn = 100
//        $0.bottomMarn = 30
//        $0.lelftMarn = 50
        $0.axis = .vertical
        return $0
    }(WZStackView())
    
    
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
        contentView.addSubview(tagView)
    }
    func configViewLocation() {

        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalToSuperview()
        }
        rightLabel.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.top.equalToSuperview()
        }
        tagView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.lessThanOrEqualToSuperview().offset(-40).priority(.low)
        }
    }
    
    func upload(tags: [TestLabel]) {
//        tagView.reload(datas: tags)
        tagView.addArrangedSubviews(tags)
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
        configView()
        configViewLocation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 添加视图
    func configView() {
        addSubview(lelftImageView)
        addSubview(titileLabel)
    }
    
    /// 视图位置
    func configViewLocation() {
        lelftImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(0)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        titileLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(lelftImageView.snp.bottom).offset(10)
        }
    }
    
    func getOriginView() -> UIView {
        return self
    }
    
    func getViewSize() -> CGSize {
        return CGSize(width: 60, height: 65)
    }
    
}

/// 文本
class TestLabel2: UILabel {
    
    init(text: String) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.backgroundColor = UIColor.blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

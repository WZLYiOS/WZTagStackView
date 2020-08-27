//
//  HBTagStackView.swift
//  SweepTreasure
//
//  Created by qiuqixiang on 2020/4/1.
//  Copyright © 2020 划宝. All rights reserved.
//

import UIKit

// MARK - 标签内容视图
public class WZTagStackView: UIView {

    /// 每行间距
    public var rowMarn: CGFloat = 0
    
    /// 竖向间距
    public var verticalMarn: CGFloat = 0
    
    /// 顶部间距
    public var topMarn: CGFloat = 0
    
    /// 底部间距
    public var bottomMarn: CGFloat = 0
    
    /// 左边间距
    public var lelftMarn: CGFloat = 0
    
    /// 最大宽度
    public var maxWith: CGFloat = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public func reload(datas: [WZTagStackViewProtocol]) {
        
        /// 移除所有父视图
        while (self.subviews.count > 0) {
            self.subviews.last?.removeFromSuperview()
        }
        
        for item in datas {
            let view = item.getOriginView()
            view.frame.size = item.getViewSize()
            self.addSubview(view)
        }
        
        var x: CGFloat = lelftMarn
        var y: CGFloat = topMarn

        for (index, item) in datas.enumerated() {
            let view = item.getOriginView()
            view.translatesAutoresizingMaskIntoConstraints = false
            let viewSize = item.getViewSize()
            
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: x).isActive = true
            view.topAnchor.constraint(equalTo: topAnchor, constant: y).isActive = true
            view.widthAnchor.constraint(equalToConstant: viewSize.width).isActive = true
            view.heightAnchor.constraint(equalToConstant: viewSize.height).isActive = true
            x = x + viewSize.width + verticalMarn
            
            if x > maxWith  {
                x = lelftMarn
                y = y + viewSize.height + rowMarn
            }
            if index == datas.count - 1 {
                view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomMarn).isActive = true
            }
        }
    }
}

// MARK - 返回对应的视图协议
public protocol WZTagStackViewProtocol {
    
    /// 原始视图
    func getOriginView() -> UIView
    
    /// 获取该视图的宽高
    func getViewSize() -> CGSize
}

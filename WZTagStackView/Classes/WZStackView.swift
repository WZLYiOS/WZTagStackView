//
//  WZStackView.swift
//  WZTagStackView
//
//  Created by qiuqixiang on 2021/7/27.
//

import UIKit
import SnapKit

// MARK - 容器
open class WZStackView: UIView {
    
    public enum Axis  {
        case nomar     // 默认自适应
        case horizontal   // 横向
        case vertical    // 竖向
        case verticalColumn(Int) // 竖向几列
    }

    /// 每行间距
    public var rowMarn: CGFloat = 0
    
    /// 竖向间距
    public var verticalMarn: CGFloat = 0
    
    /// 内容间距
    public var contentEdgeInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    /// 排列方式
    public var axis: Axis = .nomar
    
    /// 添加视图
    open func addArrangedSubviews(_ views: [UIView]) {
        subviews.forEach{
            $0.removeFromSuperview()
        }
        views.forEach {
            addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        var x: CGFloat = contentEdgeInset.left
        var y: CGFloat = contentEdgeInset.top
        for (index, view) in subviews.enumerated() {
            let viewSize = view.frame.size
            switch axis {
            case .nomar:
                if ceil(viewSize.width) > ceil((frame.size.width - x - contentEdgeInset.right)) {
                    x = contentEdgeInset.left
                    y += viewSize.height + rowMarn
                }
                view.snp.remakeConstraints { make in
                    make.leading.equalTo(x)
                    make.top.equalTo(y)
                    if index == subviews.count - 1 {
                        make.bottom.equalTo(-contentEdgeInset.bottom)
                    }
                }
                x += viewSize.width + verticalMarn
            case .horizontal:
                view.snp.remakeConstraints { make in
                    make.leading.equalTo(x)
                    make.top.equalTo(y)
                    if index == subviews.count - 1 {
                        make.bottom.equalTo(-contentEdgeInset.bottom)
                    }
                }
                x += viewSize.width + verticalMarn
            case .vertical:
                view.snp.remakeConstraints { make in
                    make.leading.equalTo(x)
                    make.right.equalToSuperview().offset(-contentEdgeInset.right)
                    make.top.equalTo(y)
                    if index == subviews.count - 1 {
                        make.bottom.equalTo(-contentEdgeInset.bottom)
                    }
                }
                y += viewSize.height + rowMarn
            case let .verticalColumn(colums):
                
                ///
                var widx = (self.frame.size.width - contentEdgeInset.right - contentEdgeInset.left - verticalMarn*CGFloat((colums-1)))
                if widx > 0 {
                    widx = widx/CGFloat(colums)
                }
                
                /// 列
                let currentColumn = index % colums
                
                /// 行
                let currentRow = index / colums
                
                let top = (viewSize.height + rowMarn) * CGFloat(currentRow) + y
                let leading = x + (widx + verticalMarn)*CGFloat(currentColumn)
                view.snp.remakeConstraints { make in
                    make.leading.equalTo(leading)
                    make.width.equalTo(widx)
                    make.top.equalTo(top)
                    if index == subviews.count - 1 {
                        make.bottom.equalTo(-contentEdgeInset.bottom)
                    }
                }
            }
        }
    }
}

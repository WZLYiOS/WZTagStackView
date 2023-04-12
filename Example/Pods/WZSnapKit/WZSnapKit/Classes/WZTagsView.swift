//
//  WZTagsView.swift
//  Created on 2023/4/5
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2023 WZLY. All rights reserved.
//  @author 邱啟祥(739140860@qq.com)   
//

import UIKit

// MARK - 标签视图
open class WZTagsView: UIView {

   public enum `Type` {
        /// 九宫格
        case distributeSudokuViews(vertical: CGFloat, horizontal: CGFloat, warpCount: Int, itemHeight: CGFloat? = nil, itemWidth: CGFloat? = nil)
        
        /// 垂直/水平分布
        case distributeViewsAlong(axisType: NSLayoutConstraint.Axis, fixedItemSpacing: CGFloat, fixedItemLength: CGFloat? = nil)
        
        /// 自适应宽度分布，要提前计算宽度
        case distributeDetermineWidthViews(verticalSpacing: CGFloat, horizontalSpacing: CGFloat, maxWidth: CGFloat, itemHeight: CGFloat)
    }
    
    /// 视图类型
    public var type: `Type` = .distributeSudokuViews(vertical: 0, horizontal: 0, warpCount: 0, itemHeight: 0)

    /// 内容边距
    public var edgeInset: UIEdgeInsets = UIEdgeInsets.zero
    
    /// 添加视图
    public func addSubviews(_ views: [UIView]) {
        subviews.forEach{ $0.removeFromSuperview() }
        views.forEach{ addSubview($0) }
        switch type {
        case let .distributeSudokuViews(vertical, horizontal, warpCount, itemHeight, itemWidth):
            views.snp.distributeSudokuViews(verticalSpacing: vertical,
                                            horizontalSpacing: horizontal,
                                            warpCount: warpCount,
                                            edgeInset: edgeInset,
                                            itemHeight: itemHeight, itemWidth: itemWidth)
        case let .distributeViewsAlong(axisType, fixedItemSpacing, fixedItemLength):
            views.snp.distributeViewsAlong(axisType: axisType,
                                           fixedItemSpacing: fixedItemSpacing,
                                           edgeInset: edgeInset,
                                           fixedItemLength: fixedItemLength)
        case let .distributeDetermineWidthViews(verticalSpacing, horizontalSpacing, maxWidth, itemHeight):
            views.snp.distributeDetermineWidthViews(verticalSpacing: verticalSpacing,
                                                    horizontalSpacing: horizontalSpacing,
                                                    maxWidth: maxWidth,
                                                    determineWidths: views.map({$0.frame.size.width}),
                                                    itemHeight: itemHeight,
                                                    edgeInset: edgeInset)
        }
    }
}

//
//  SnapKit+.swift
//  Created on 2022/12/7
//  Description <#文件描述#>
//  PD <#产品文档地址#>
//  Design <#设计文档地址#>
//  Copyright © 2022 WZLY. All rights reserved.
//  @author 邱啟祥(739140860@qq.com)   
//

import Foundation
import SnapKit

public typealias ConstraintArray = Array

public extension ConstraintArray {
    var snp: ConstraintArrayDSL {
        return ConstraintArrayDSL(array: self as! Array<ConstraintView>)
    }
}

/// MARK - 数组扩展
public struct ConstraintArrayDSL {
    @discardableResult
    public func prepareConstraints(_ closure: (_ make: ConstraintMaker) -> Void) -> [Constraint] {
        var constraints = Array<Constraint>()
        for view in self.array {
            constraints.append(contentsOf: view.snp.prepareConstraints(closure))
        }
        return constraints
    }
    
    public func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        for view in self.array {
            view.snp.makeConstraints(closure)
        }
    }
    
    public func remakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        for view in self.array {
            view.snp.remakeConstraints(closure)
        }
    }
    
    public func updateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        for view in self.array {
            view.snp.updateConstraints(closure)
        }
    }
    
    public func removeConstraints() {
        for view in self.array {
            view.snp.removeConstraints()
        }
    }
 
    ///分配你给的宽度
    ///你应该先计算每个项目的宽度
    ///
    /// -参数
    /// - verticalSpacing:每个元素之间的垂直间距
    /// - horizontalSpacing:每个项目之间的水平间距
    /// - tailSpacing:最后一项和容器之后的间距
    /// - maxWidth:每一行或每一项的最大宽度
    /// - determinewidth:每个项目的宽度，你必须确保determinewidth。Count == self.array.count
    /// - itemHeight:每一项的高度
    /// - edgeInset:所有项目的edgeInset，默认为UIEdgeInsets.zero
    ///如果edgeInset。left或edgeInset。right不是0,maxWidth会改变，maxWidth -= (edgeInset。left + edgeInset.right)
    /// - topConstrainView:第一项之前的视图
    public func distributeDetermineWidthViews(verticalSpacing: CGFloat,
                                              horizontalSpacing: CGFloat,
                                              maxWidth: CGFloat,
                                              determineWidths: [CGFloat],
                                              itemHeight: CGFloat,
                                              edgeInset: UIEdgeInsets = UIEdgeInsets.zero,
                                              topConstrainView: ConstraintView? = nil) {
        
        guard self.array.count > 0, determineWidths.count == self.array.count, let tempSuperview = array.first?.superview else {
            return
        }
        
        var prev : ConstraintView?
        var vMinX: CGFloat = 0
        
        let maxW = maxWidth - (edgeInset.right + edgeInset.left)
        
        for (i,v) in self.array.enumerated() {
            
            let curWidth = min(determineWidths[i], maxW)
            v.snp.makeConstraints({ (make) in
                make.width.equalTo(curWidth)
                make.height.equalTo(itemHeight)
                if i == self.array.count - 1 {
                    make.bottom.equalTo(-edgeInset.bottom)
                }
                
                if prev == nil { // the first one
                    let tmpTarget = topConstrainView != nil ? topConstrainView!.snp.bottom : tempSuperview.snp.top
                    make.top.equalTo(tmpTarget).offset(edgeInset.top)
                    make.left.equalTo(tempSuperview).offset(edgeInset.left)
                    vMinX = curWidth + horizontalSpacing
                }
                else {
                    make.right.lessThanOrEqualToSuperview().offset(-edgeInset.right)
                    
                    if vMinX + curWidth > maxW {
                        make.top.equalTo(prev!.snp.bottom).offset(verticalSpacing)
                        make.left.equalTo(tempSuperview).offset(edgeInset.left)
                        vMinX = curWidth + horizontalSpacing
                    }
                    else {
                        make.top.equalTo(prev!)
                        make.left.equalTo(prev!.snp.right).offset(horizontalSpacing)
                        vMinX += curWidth + horizontalSpacing
                    }
                }
            })
            
            prev = v
        }
    }
    
    ///与水平或垂直分布
    ///你应该先计算每个项目的宽度
    ///
    /// -参数
    /// - axisType:沿哪个轴分发项目
    /// - fixedItemSpacing:每个项目之间的间距，如果axisType是水平(垂直)，fixedItemSpacing是水平(垂直)间距
    /// - fixedItemLength:如果axisType是水平(垂直)，fixedItemLength是宽度(高度)
    /// - edgeInset:所有项目的edgeInset，默认为UIEdgeInsets.zero
    /// - topConstrainView:第一项之前的视图
    public func distributeViewsAlong(axisType: NSLayoutConstraint.Axis,
                                     fixedItemSpacing: CGFloat = 0,
                                     edgeInset: UIEdgeInsets = UIEdgeInsets.zero,
                                     fixedItemLength: CGFloat? = nil,
                                     topConstrainView: ConstraintView? = nil) {
        
        guard self.array.count > 0, let tempSuperview = array.first?.superview else {
            return
        }
        
        if axisType == .vertical {
            self.array.first?.snp.makeConstraints({ (make) in
                if fixedItemLength != nil {
                    make.height.equalTo(fixedItemLength!)
                }
                
                let tmpTarget = topConstrainView != nil ? topConstrainView!.snp.bottom : tempSuperview.snp.top
                make.top.equalTo(tmpTarget).offset(edgeInset.top)
                make.centerX.equalTo(tempSuperview)
                make.left.equalTo(tempSuperview).offset(edgeInset.left).priority(.high)
                make.right.equalTo(tempSuperview).offset(-edgeInset.right).priority(.high)
                make.bottom.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.bottom)
            })
            
            for (preView, curView) in zip(self.array, self.array.dropFirst()) {
                curView.snp.makeConstraints({ (make) in
                    if fixedItemLength != nil {
                        make.height.equalTo(fixedItemLength!)
                    }
                    make.top.equalTo(preView.snp.bottom).offset(fixedItemSpacing)
                    make.centerX.equalTo(tempSuperview)
                    make.left.right.equalTo(preView).priority(.high)
                    make.bottom.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.bottom)
                })
            }
        }
        else {
            self.array.first?.snp.makeConstraints({ (make) in
                if fixedItemLength != nil {
                    make.width.equalTo(fixedItemLength!)
                }
                
                let tmpTarget = topConstrainView != nil ? topConstrainView!.snp.bottom : tempSuperview.snp.top
                make.top.equalTo(tmpTarget).offset(edgeInset.top)
                make.left.equalTo(tempSuperview).offset(edgeInset.left)
                make.right.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.right)
                make.bottom.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.bottom)
            })
            
            for (preView, curView) in zip(self.array, self.array.dropFirst()) {
                curView.snp.makeConstraints({ (make) in
                    if fixedItemLength != nil {
                        make.width.equalTo(fixedItemLength!)
                    }
                    
                    make.top.equalTo(preView)
                    make.left.equalTo(preView.snp.right).offset(fixedItemSpacing)
                    make.right.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.right)
                    make.bottom.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.bottom)
                })
            }
        }
    }
    
    
    /// distribute with the width that you give
    /// you should calculate the width of each item first
    ///
    /// - Parameters:
    ///   - verticalSpacing: the vertical spacing between each item
    ///   - horizontalSpacing: the horizontal spacing between each item
    ///   - itemHeight: the height of each item
    ///   - edgeInset: the edgeInset of all item, default is UIEdgeInsets.zero
    ///   - topConstrainView: the view before the first item
    public func distributeSudokuViews(verticalSpacing: CGFloat,
                                      horizontalSpacing: CGFloat,
                                      warpCount: Int,
                                      edgeInset: UIEdgeInsets = UIEdgeInsets.zero,
                                      itemHeight: CGFloat? = nil,
                                      itemWidth: CGFloat? = nil,
                                      topConstrainView: ConstraintView? = nil) {
        
        guard self.array.count > 0, warpCount >= 1, let tempSuperview = array.first?.superview else {
            return
        }
        
        let columnCount = warpCount
        let rowCount = self.array.count % warpCount == 0 ? self.array.count / warpCount : self.array.count / warpCount + 1;
        
        var prev : ConstraintView?
        
        for (i,v) in self.array.enumerated() {
            
            let currentRow = i / warpCount
            let currentColumn = i % warpCount
            
            v.snp.makeConstraints({ (make) in
                if prev != nil {
                    make.width.height.equalTo(prev!)
                }
                if currentRow == 0 {//fisrt row
                    let tmpTarget = topConstrainView != nil ? topConstrainView!.snp.bottom : tempSuperview.snp.top
                    make.top.equalTo(tmpTarget).offset(edgeInset.top)
                    if let h = itemHeight {
                        make.height.equalTo(h)
                    }
                    if let w = itemWidth {
                        make.width.equalTo(w)
                    }
                }
                if currentRow == rowCount - 1 {//last row
                    if currentRow != 0 && i - columnCount >= 0 {
                        make.top.equalTo(self.array[i-columnCount].snp.bottom).offset(verticalSpacing)
                    }
                    
                    if itemHeight != nil {
                        make.bottom.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.bottom)
                    }
                    else {
                        make.bottom.equalTo(tempSuperview).offset(-edgeInset.bottom)
                    }
                }
                
                if currentRow != 0 && currentRow != rowCount - 1 {//other row
                    make.top.equalTo(self.array[i-columnCount].snp.bottom).offset(verticalSpacing);
                }
                
                if currentColumn == 0 {//first col
                    make.left.equalTo(tempSuperview).offset(edgeInset.left)
                }
                if currentColumn == warpCount - 1 {//last col
                    if currentColumn != 0 {
                        make.left.equalTo(prev!.snp.right).offset(horizontalSpacing)
                    }
                    if itemWidth == nil {
                        make.right.equalTo(tempSuperview).offset(-edgeInset.right)
                    }
                }
                
                if currentColumn != 0 && currentColumn != warpCount - 1 {//other col
                    make.left.equalTo(prev!.snp.right).offset(horizontalSpacing);
                }
            })
            prev = v
        }
    }
    
    
    public var target: AnyObject? {
        return self.array as AnyObject
    }
    
    internal let array: Array<ConstraintView>
    
    internal init(array: Array<ConstraintView>) {
        self.array = array
    }
}

//private extension ConstraintArrayDSL {
//    func commonSuperviewOfViews() -> ConstraintView? {
//        var commonSuperview : ConstraintView?
//        var previousView : ConstraintView?
//
//        for view in self.array {
//            if previousView != nil {
//                commonSuperview = view.closestCommonSuperview(commonSuperview)
//            }else {
//                commonSuperview = view
//            }
//            previousView = view
//        }
//        return commonSuperview
//    }
//}
//
//private extension ConstraintView {
//    func closestCommonSuperview(_ view : ConstraintView?) -> ConstraintView? {
//        var closestCommonSuperview: ConstraintView?
//        var secondViewSuperview: ConstraintView? = view
//        while closestCommonSuperview == nil && secondViewSuperview != nil {
//            var firstViewSuperview: ConstraintView? = self
//            while closestCommonSuperview == nil && firstViewSuperview != nil {
//                if secondViewSuperview == firstViewSuperview {
//                    closestCommonSuperview = secondViewSuperview
//                }
//                firstViewSuperview = firstViewSuperview?.superview
//            }
//            secondViewSuperview = secondViewSuperview?.superview
//        }
//        return closestCommonSuperview
//    }
//}

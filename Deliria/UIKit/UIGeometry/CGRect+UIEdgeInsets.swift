//
//  CGRect+Operator.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/9.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

/**
 Create a new CGRect from CGRect and UIEdgeInsets

 - parameter lhs: CGRect
 - parameter rhs: UIEdgeInsets

 - returns: new CGRect
 */
public func +(lhs: CGRect, rhs: UIEdgeInsets) -> CGRect {
  return UIEdgeInsetsInsetRect(lhs, rhs)
}

/**
 Apply a UIEdgeInsets to CGRect

 - parameter lhs: CGRect
 - parameter rhs: UIEdgeInsets

 - returns: lhs
 */
public func +=(inout lhs: CGRect, rhs: UIEdgeInsets) -> CGRect {
  lhs = UIEdgeInsetsInsetRect(lhs, rhs)
  return lhs
}

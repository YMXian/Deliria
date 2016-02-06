//
//  CGRect+Extension.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/7.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import CoreGraphics

//  MARK: - Operator

public func +(lhs: CGRect, rhs: CGSize) -> CGRect {
  return CGRect(origin: lhs.origin, size: lhs.size + rhs)
}

public func +(lhs: CGRect, rhs: CGVector) -> CGRect {
  return CGRect(origin: lhs.origin + rhs, size: lhs.size)
}

public func -(lhs: CGRect, rhs: CGSize) -> CGRect {
  return CGRect(origin: lhs.origin, size: lhs.size - rhs)
}

public func -(lhs: CGRect, rhs: CGVector) -> CGRect {
  return CGRect(origin: lhs.origin - rhs, size: lhs.size)
}

public func *(lhs: CGRect, rhs: CGAffineTransform) -> CGRect {
  return CGRectApplyAffineTransform(lhs, rhs)
}

/* CGRect + CGPoint is meaningless, use Vector2DConvertible.vector to convert CGPoint to a CGVector */

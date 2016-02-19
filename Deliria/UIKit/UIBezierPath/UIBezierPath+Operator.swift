//
//  UIBezierPath+Operator.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/19.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UIBezierPath {
}

infix operator --> { associativity left }

infix operator +-> { associativity left }

infix operator +~> { associativity left }

postfix operator ->| { }

/**
 UIBezierPath move to point

 - parameter lhs: path
 - parameter rhs: point

 - returns: lhs
 */
public func --> (lhs: UIBezierPath, rhs: CGPoint) -> UIBezierPath {
  lhs.moveToPoint(rhs)
  return lhs
}

/**
 UIBezierPath add line to point

 - parameter lhs: path
 - parameter rhs: point

 - returns: lhs
 */
public func +-> (lhs: UIBezierPath, rhs: CGPoint) -> UIBezierPath {
  lhs.addLineToPoint(rhs)
  return lhs
}

/**
 UIBezierPath add curve to point

 - parameter lhs: lhs
 - parameter rhs: (endPoint, controlPoint1, controlPoint2)

 - returns: lhs
 */
public func +~> (lhs: UIBezierPath, rhs: (CGPoint, CGPoint, CGPoint)) -> UIBezierPath {
  let (endPoint, controlPoint1, controlPoint2) = rhs
  lhs.addCurveToPoint(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
  return lhs
}

/**
 Close a UIBezierPath

 - parameter lhs: path

 - returns: lhs
 */
public postfix func ->| (lhs: UIBezierPath) -> UIBezierPath {
  lhs.closePath()
  return lhs
}

//
//  UIBezierPath+Operator.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/19.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

precedencegroup BezierPathOperationGroup {

  higherThan: DefaultPrecedence

  associativity: left
}

infix operator    --> : BezierPathOperationGroup

infix operator    +-> : BezierPathOperationGroup

infix operator    +~> : BezierPathOperationGroup

postfix operator  ->|

/**
 UIBezierPath move to point

 - parameter lhs: path
 - parameter rhs: point

 - returns: lhs
 */
public func --> (lhs: UIBezierPath, rhs: CGPoint) -> UIBezierPath {
  lhs.move(to: rhs)
  return lhs
}

/**
 UIBezierPath add line to point

 - parameter lhs: path
 - parameter rhs: point

 - returns: lhs
 */
public func +-> (lhs: UIBezierPath, rhs: CGPoint) -> UIBezierPath {
  lhs.addLine(to: rhs)
  return lhs
}

public func +-> (lhs: CGPoint, rhs: CGPoint) -> UIBezierPath {
  return UIBezierPath() --> lhs +-> rhs
}

/**
 UIBezierPath add curve to point

 - parameter lhs: lhs
 - parameter rhs: [endPoint, controlPoint1, controlPoint2] or [endPoint, controlPoint]

 - returns: lhs
 */
public func +~> (lhs: UIBezierPath, rhs: [CGPoint]) -> UIBezierPath {
  if rhs.count == 3 {
    lhs.addCurve(to: rhs[0], controlPoint1: rhs[1], controlPoint2: rhs[2])
  } else if rhs.count == 2 {
    lhs.addQuadCurve(to: rhs[0], controlPoint: rhs[1])
  } else {
    fatalError("Wrong number of CGPoint after operator +~> :\(rhs.count)")
  }
  return lhs
}

public func +~> (lhs: CGPoint, rhs: [CGPoint]) -> UIBezierPath {
  return UIBezierPath() --> lhs +~> rhs
}

/**
 Close a UIBezierPath

 - parameter lhs: path

 - returns: lhs
 */
public postfix func ->| (lhs: UIBezierPath) -> UIBezierPath {
  lhs.close()
  return lhs
}

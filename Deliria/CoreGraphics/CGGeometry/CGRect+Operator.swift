//
//  CGRect+Operator.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/11.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import CoreGraphics

/**
Add a CGSize to a CGRect.size, returns a new CGRect

- parameter lhs: CGRect
- parameter rhs: CGSize

- returns: new CGRect
*/
public func +(lhs: CGRect, rhs: CGSize) -> CGRect {
  return CGRect(origin: lhs.origin, size: lhs.size + rhs)
}

/**
 Add a CGVector to a CGRect.origin, returns a new CGRect

 - parameter lhs: CGRect
 - parameter rhs: CGVector

 - returns: new CGRect
 */
public func +(lhs: CGRect, rhs: CGVector) -> CGRect {
  return CGRect(origin: lhs.origin + rhs, size: lhs.size)
}

/** See + */
public func +=(lhs: inout CGRect, rhs: CGSize) -> CGRect {
  lhs.size += rhs
  return lhs
}

/** See + */
public func +=(lhs: inout CGRect, rhs: CGVector) -> CGRect {
  lhs.origin += rhs
  return lhs
}

/** See + */
public func -(lhs: CGRect, rhs: CGSize) -> CGRect {
  return lhs + -rhs
}

/** See + */
public func -(lhs: CGRect, rhs: CGVector) -> CGRect {
  return lhs + -rhs
}

/** See - */
public func -=(lhs: inout CGRect, rhs: CGSize) -> CGRect {
  return lhs += -rhs
}

/** See - */
public func -=(lhs: inout CGRect, rhs: CGVector) -> CGRect {
  return lhs += -rhs
}

/* CGRect + CGPoint is meaningless, use Vector2DConvertible.vector to convert CGPoint to a CGVector */

/**
Apply CGAffineTransform to a CGRect, returns a new CGRect

- parameter lhs: CGRect
- parameter rhs: CGAffineTransform

- returns: a new CGRect
*/
public func *(lhs: CGRect, rhs: CGAffineTransform) -> CGRect {
  return lhs.applying(rhs)
}

public func *=(lhs: inout CGRect, rhs: CGAffineTransform) -> CGRect {
  let result = lhs.applying(rhs)
  lhs.origin = result.origin
  lhs.size   = result.size
  return lhs
}

/**
 Create a CGRect scaled from original CGRect

 - parameter lhs: CGRect
 - parameter rhs: CGFloat

 - returns: new CGRect
 */
public func *(lhs: CGRect, rhs: CGFloat) -> CGRect {
  return CGRect(origin: lhs.origin * rhs, size: lhs.size * rhs)
}

@discardableResult
public func *=(lhs: inout CGRect, rhs: CGFloat) -> CGRect {
  lhs.origin *= rhs
  lhs.size *= rhs
  return lhs
}

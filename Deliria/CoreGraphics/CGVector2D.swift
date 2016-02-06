//
//  CGVector2D.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/6.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import CoreGraphics

//  MARK: - Definition

public struct CGVector2D {

  /// demension-1
  public var x: CGFloat

  /// demension-2
  public var y: CGFloat

}

//  MARK: - Operations

public func +(lhs: CGVector2D, rhs: CGVector2D) -> CGVector2D {
  return CGVector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func -(lhs: CGVector2D, rhs: CGVector2D) -> CGVector2D {
  return CGVector2D(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func *(lhs: CGVector2D, rhs: CGFloat) -> CGVector2D {
  return CGVector2D(x: lhs.x * rhs, y: lhs.y + rhs)
}

public func /(lhs: CGVector2D, rhs: CGFloat) -> CGVector2D {
  return CGVector2D(x: lhs.x / rhs, y: lhs.y / rhs)
}

//  MARK: - Convertible

public protocol CGVector2DConvertible {

  /**
   Init from a CGVector2D

   - parameter vector: a CGVector2D

   - returns: new instance
   */
  init(vector: CGVector2D)

  /**
   Convert to a CGVector2D

   - returns: CGVector2D
   */
  func vector() -> CGVector2D

}

//  MARK: - Extensions

extension CGVector: CGVector2DConvertible {

  public init(vector: CGVector2D) {
    self.init(dx: vector.x, dy: vector.y)
  }

  public func vector() -> CGVector2D {
    return CGVector2D(x: self.dx, y: self.dy)
  }

}

extension CGPoint: CGVector2DConvertible {

  public init(vector: CGVector2D) {
    self.init(x: vector.x, y: vector.y)
  }

  public func vector() -> CGVector2D {
    return CGVector2D(x: self.x, y: self.y)
  }
}

extension CGSize: CGVector2DConvertible {

  public init(vector: CGVector2D) {
    self.init(width: vector.x, height: vector.y)
  }

  public func vector() -> CGVector2D {
    return CGVector2D(x: self.width, y: self.height)
  }
}


//  MARK: - Generic Operators

public func +<T: CGVector2DConvertible>(lhs: CGVector2DConvertible, rhs: CGVector2DConvertible) -> T {
  return T(vector: lhs.vector() + rhs.vector())
}

public func -<T: CGVector2DConvertible>(lhs: CGVector2DConvertible, rhs: CGVector2DConvertible) -> T {
  return T(vector: lhs.vector() - rhs.vector())
}

public func *<T: CGVector2DConvertible>(lhs: CGVector2DConvertible, rhs: CGFloat) -> T {
  return T(vector: lhs.vector() * rhs)
}

public func /<T: CGVector2DConvertible>(lhs: CGVector2DConvertible, rhs: CGFloat) -> T {
  return T(vector: lhs.vector() / rhs)
}

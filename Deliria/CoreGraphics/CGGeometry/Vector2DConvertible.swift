//
//  Vector2DConvertible.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/6.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import CoreGraphics

//  MARK: - Protocol

public protocol Vector2DConvertible {

  var x: CGFloat { get set }

  var y: CGFloat { get set }

  init(x: CGFloat, y: CGFloat)

}

//  MARK: - Operator

public prefix func -<T: Vector2DConvertible>(lhs: Vector2DConvertible) -> T {
  return T(x: -lhs.x, y: -lhs.y)
}

public func +<T: Vector2DConvertible>(lhs: Vector2DConvertible, rhs: Vector2DConvertible) -> T {
  return T(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func +=<T: Vector2DConvertible>(inout lhs: T, rhs: Vector2DConvertible) -> T {
  lhs.x = lhs.x + rhs.x
  lhs.y = lhs.y + rhs.y
  return lhs
}

public func +<T: Vector2DConvertible>(lhs: Vector2DConvertible, rhs: (CGFloat, CGFloat)) -> T {
  let (x, y) = rhs
  return T(x: lhs.x + x, y: lhs.y + y)
}

public func +=<T: Vector2DConvertible>(inout lhs: T, rhs: (CGFloat, CGFloat)) -> T {
  let (x, y) = rhs
  lhs.x = lhs.x + x
  lhs.y = lhs.y + y
  return lhs
}

public func -<T: Vector2DConvertible>(lhs: Vector2DConvertible, rhs: Vector2DConvertible) -> T {
  return T(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func -=<T: Vector2DConvertible>(inout lhs: T, rhs: Vector2DConvertible) -> T {
  lhs.x = lhs.x - rhs.x
  lhs.y = lhs.y - rhs.y
  return lhs
}

public func -<T: Vector2DConvertible>(lhs: Vector2DConvertible, rhs: (CGFloat, CGFloat)) -> T {
  let (x, y) = rhs
  return T(x: lhs.x - x, y: lhs.y - y)
}

public func -=<T: Vector2DConvertible>(inout lhs: T, rhs: (CGFloat, CGFloat)) -> T {
  let (x, y) = rhs
  lhs.x = lhs.x - x
  lhs.y = lhs.y - y
  return lhs
}

public func *<T: Vector2DConvertible>(lhs: Vector2DConvertible, rhs: CGFloat) -> T {
  return T(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func *=<T: Vector2DConvertible>(inout lhs: T, rhs: CGFloat) -> T {
  lhs.x *= rhs
  lhs.y *= rhs
  return lhs
}

public func /<T: Vector2DConvertible>(lhs: Vector2DConvertible, rhs: CGFloat) -> T {
  return T(x: lhs.x / rhs, y: lhs.y / rhs)
}

public func /=<T: Vector2DConvertible>(inout lhs: T, rhs: CGFloat) -> T {
  lhs.x /= rhs
  lhs.y /= rhs
  return lhs
}

//
//  Vector2DConvertible.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/6.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import CoreGraphics

//  MARK: - Protocol

/**
*  Vector2DConvertible abstracts all structs with two CGFloat variable, including CGVector, CGSize, CGPoint
*/
public protocol Vector2DConvertible {

  /// variable for demention-x
  var x: CGFloat { get set }

  /// variable for demention-y
  var y: CGFloat { get set }

  /**
   Initialize with x, y

   - parameter x: x
   - parameter y: y

   - returns: new instance
   */
  init(x: CGFloat, y: CGFloat)

}

//  MARK: - Operator

/**
Invert both x and y in a Vector2DConvertible

- parameter lhs: T: Vector2DConvertible

- returns: new T
*/
public prefix func -<T: Vector2DConvertible>(lhs: T) -> T {
  return T(x: -lhs.x, y: -lhs.y)
}

/**
 Add x and y seperately of two Vector2DConvertible

 - parameter lhs: T: Vector2DConvertible
 - parameter rhs: Vector2DConvertible

 - returns: new T
 */
public func +<T: Vector2DConvertible>(lhs: T, rhs: Vector2DConvertible) -> T {
  return T(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

/** Same as T: Vector2DConvertible + Vector2DConvertible, use tuple for second parameter */
public func +<T: Vector2DConvertible>(lhs: T, rhs: (CGFloat, CGFloat)) -> T {
  let (x, y) = rhs
  return T(x: lhs.x + x, y: lhs.y + y)
}

/**
 Add x and y seperately of right Vector2DConvertible to left one

 - parameter lhs: T: Vector2DConvertible
 - parameter rhs: Vector2DConvertible

 - returns: lhs
 */
@discardableResult
public func +=<T: Vector2DConvertible>(lhs: inout T, rhs: Vector2DConvertible) -> T {
  lhs.x += rhs.x
  lhs.y += rhs.y
  return lhs
}

/** Same as T: Vector2DConvertible += Vector2DConvertible, use tuple for right parameter */
@discardableResult
public func +=<T: Vector2DConvertible>(lhs: inout T, rhs: (CGFloat, CGFloat)) -> T {
  let (x, y) = rhs
  lhs.x += x
  lhs.y += y
  return lhs
}

/** See + */
public func -<T: Vector2DConvertible>(lhs: T, rhs: Vector2DConvertible) -> T {
  return T(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

/** See + */
public func -<T: Vector2DConvertible>(lhs: T, rhs: (CGFloat, CGFloat)) -> T {
  let (x, y) = rhs
  return T(x: lhs.x - x, y: lhs.y - y)
}

/** See += */
public func -=<T: Vector2DConvertible>(lhs: inout T, rhs: Vector2DConvertible) -> T {
  lhs.x = lhs.x - rhs.x
  lhs.y = lhs.y - rhs.y
  return lhs
}

/** See += */
public func -=<T: Vector2DConvertible>(lhs: inout T, rhs: (CGFloat, CGFloat)) -> T {
  let (x, y) = rhs
  lhs.x = lhs.x - x
  lhs.y = lhs.y - y
  return lhs
}

/**
 Scale a Vector2DConvertible with a ratio

 - parameter lhs: T: Vector2DConvertible
 - parameter rhs: CGFloat

 - returns: new T
 */
public func *<T: Vector2DConvertible>(lhs: T, rhs: CGFloat) -> T {
  return T(x: lhs.x * rhs, y: lhs.y * rhs)
}

/** See * */
@discardableResult
public func *=<T: Vector2DConvertible>(lhs: inout T, rhs: CGFloat) -> T {
  lhs.x *= rhs
  lhs.y *= rhs
  return lhs
}

/** See * */
public func /<T: Vector2DConvertible>(lhs: T, rhs: CGFloat) -> T {
  return T(x: lhs.x / rhs, y: lhs.y / rhs)
}

/** See / */
@discardableResult
public func /=<T: Vector2DConvertible>(lhs: inout T, rhs: CGFloat) -> T {
  lhs.x /= rhs
  lhs.y /= rhs
  return lhs
}

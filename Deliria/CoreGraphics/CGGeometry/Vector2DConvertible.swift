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

//  MARK: - Extension

extension CGPoint: Vector2DConvertible, ArrayLiteralConvertible {

  public typealias Element = CGFloat

  public init(arrayLiteral elements: CGPoint.Element...) {
    self.init(x: elements[0], y: elements[1])
  }
}

extension CGSize:  Vector2DConvertible, ArrayLiteralConvertible {

  public var x: CGFloat {
    get {
      return self.width
    }
    set(value) {
      self.width = value
    }
  }

  public var y: CGFloat {
    get {
      return self.height
    }
    set(value) {
      self.height = value
    }
  }

  public init(x: CGFloat, y: CGFloat) {
    self.width = x
    self.height = y
  }

  public typealias Element = CGFloat

  public init(arrayLiteral elements: CGPoint.Element...) {
    self.init(x: elements[0], y: elements[1])
  }

}

extension CGVector: Vector2DConvertible, ArrayLiteralConvertible {

  public var x: CGFloat {
    get {
      return self.dx
    }
    set(value) {
      self.dx = value
    }
  }

  public var y: CGFloat {
    get {
      return self.dy
    }
    set(value) {
      self.dy = value
    }
  }

  public init(x: CGFloat, y: CGFloat) {
    self.dx = x
    self.dy = y
  }

  public typealias Element = CGFloat

  public init(arrayLiteral elements: CGPoint.Element...) {
    self.init(x: elements[0], y: elements[1])
  }

}

//  MARK: - Operator

public prefix func -<T: Vector2DConvertible>(lhs: Vector2DConvertible) -> T {
  return T(x: -lhs.x, y: -lhs.y)
}

public func +<T: Vector2DConvertible>(lhs: Vector2DConvertible, rhs: Vector2DConvertible) -> T {
  return T(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func -<T: Vector2DConvertible>(lhs: Vector2DConvertible, rhs: Vector2DConvertible) -> T {
  return T(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func *<T: Vector2DConvertible>(lhs: Vector2DConvertible, rhs: CGFloat) -> T {
  return T(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func /<T: Vector2DConvertible>(lhs: Vector2DConvertible, rhs: CGFloat) -> T {
  return T(x: lhs.x / rhs, y: lhs.y / rhs)
}

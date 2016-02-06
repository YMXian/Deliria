//
//  CGVector+Extension.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/7.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import CoreGraphics

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

extension Vector2DConvertible {

  public var vector: CGVector {
    return CGVector(x: self.x, y: self.y)
  }

}

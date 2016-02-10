//
//  CGSize+Vector2DConvertible.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/7.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import CoreGraphics

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

extension Vector2DConvertible {

  public var size: CGSize {
    return CGSize(x: self.x, y: self.y)
  }

}

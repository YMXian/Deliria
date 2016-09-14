//
//  CGPoint+Vector2DConvertible.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/7.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import CoreGraphics

extension CGPoint: Vector2DConvertible, ExpressibleByArrayLiteral {

  /* .x, .y is supported directly */

  public typealias Element = CGFloat

  public init(arrayLiteral elements: CGPoint.Element...) {
    self.init(x: elements[0], y: elements[1])
  }
}

extension Vector2DConvertible {

  public var point: CGPoint {
    return CGPoint(x: self.x, y: self.y)
  }

}

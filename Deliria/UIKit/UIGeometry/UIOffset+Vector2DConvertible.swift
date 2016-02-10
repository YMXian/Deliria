//
//  UIOffset+Vector2DConvertible.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/9.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UIOffset: Vector2DConvertible, ArrayLiteralConvertible {

  public var x: CGFloat {
    get {
      return self.horizontal
    }
    set(value) {
      self.horizontal = value
    }
  }

  public var y: CGFloat {
    get {
      return self.vertical
    }
    set(value) {
      self.vertical = value
    }
  }

  public init(x: CGFloat, y: CGFloat) {
    self.horizontal = x
    self.vertical   = y
  }

  public typealias Element = CGFloat

  public init(arrayLiteral elements: CGPoint.Element...) {
    self.init(horizontal: elements[0], vertical: elements[1])
  }

}

extension Vector2DConvertible {

  public var offset: UIOffset {
    return UIOffset(horizontal: self.x, vertical: self.y)
  }

}

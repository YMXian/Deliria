//
//  CGRect+PositionHelper.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/7.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import CoreGraphics

//  MARK: - Helper

extension CGRect: ExpressibleByArrayLiteral {

  public var x: CGFloat {
    get {
      return self.origin.x
    }
    set(value) {
      self.origin.x = value
    }
  }

  public var y: CGFloat {
    get {
      return self.origin.y
    }
    set(value) {
      self.origin.y = value
    }
  }

  public var _width: CGFloat {
    get {
      return self.width
    }
    set(value) {
      self.size.width = value
    }
  }

  public var _height: CGFloat {
    get {
      return self.height
    }
    set(value) {
      self.size.height = value
    }
  }

  public var center: CGPoint {
    get {
      return self.origin + (self.width / 2, self.height / 2)
    }
    set(value) {
      self.origin += (value - self.center)
    }
  }

  public var topLeft: CGPoint {
    get {
      return self.origin
    }
    set(value) {
      self.origin = value
    }
  }

  public var topRight: CGPoint {
    get {
      return self.origin + (self.width, 0)
    }
    set(value) {
      self.origin += (value - self.topRight)
    }
  }

  public var bottomLeft: CGPoint {
    get {
      return self.origin + (0, self.height)
    }
    set(value) {
      self.origin += (value - self.bottomLeft)
    }
  }

  public var bottomRight: CGPoint {
    get {
      return self.origin + (self.width, self.height)
    }
    set(value) {
      self.origin += (value - self.bottomRight)
    }
  }

  public var topMiddle: CGPoint {
    get {
      return self.origin + (self.width / 2, 0)
    }
    set(value) {
      self.origin += (value - self.topMiddle)
    }
  }

  public var leftMiddle: CGPoint {
    get {
      return self.origin + (0, self.height / 2)
    }
    set(value) {
      self.origin += (value - self.leftMiddle)
    }
  }

  public var bottomMiddle: CGPoint {
    get {
      return self.origin + (self.width / 2, self.height)
    }
    set(value) {
      self.origin += (value - self.bottomMiddle)
    }
  }

  public var rightMiddle: CGPoint {
    get {
      return self.origin + (self.width, self.height / 2)
    }
    set(value) {
      self.origin += (value - self.rightMiddle)
    }
  }

  public typealias Element = CGFloat

  public init(arrayLiteral elements: CGRect.Element...) {
    self.origin = [elements[0], elements[1]]
    self.size   = [elements[2], elements[3]]
  }

}

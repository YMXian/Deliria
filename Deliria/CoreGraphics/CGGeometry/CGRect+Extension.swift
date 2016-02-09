//
//  CGRect+Extension.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/7.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import CoreGraphics

//  MARK: - Helper

extension CGRect {

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

  public var width: CGFloat {
    get {
      return self.size.width
    }
    set(value) {
      self.size.width = value
    }
  }

  public var height: CGFloat {
    get {
      return self.size.height
    }
    set(value) {
      self.size.height = value
    }
  }

  public var center: CGPoint {
    get {
      return self.origin + CGSizeMake(self.width/2, self.height/2)
    }
    set(value) {
      self.origin = self.origin + (value - self.center as CGPoint)
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
      return self.origin + CGSizeMake(self.width, 0)
    }
    set(value) {
      self.origin = self.origin + (value - self.topRight as CGPoint)
    }
  }

  public var bottomLeft: CGPoint {
    get {
      return self.origin + CGSizeMake(0, self.height)
    }
    set(value) {
      self.origin = self.origin + (value - self.bottomLeft as CGPoint)
    }
  }

  public var bottomRight: CGPoint {
    get {
      return self.origin + CGSizeMake(self.width, self.height)
    }
    set(value) {
      self.origin = self.origin + (value - self.bottomRight as CGPoint)
    }
  }

  public var topMiddle: CGPoint {
    get {
      return self.origin + CGSizeMake(self.width/2, 0)
    }
    set(value) {
      self.origin = self.origin + (value - self.topMiddle as CGPoint)
    }
  }

  public var leftMiddle: CGPoint {
    get {
      return self.origin + CGSizeMake(0, self.height/2)
    }
    set(value) {
      self.origin = self.origin + (value - self.leftMiddle as CGPoint)
    }
  }

  public var bottomMiddle: CGPoint {
    get {
      return self.origin + CGSizeMake(self.width/2, self.height)
    }
    set(value) {
      self.origin = self.origin + (value - self.bottomMiddle as CGPoint)
    }
  }

  public var rightMiddle: CGPoint {
    get {
      return self.origin + CGSizeMake(self.width, self.height/2)
    }
    set(value) {
      self.origin = self.origin + (value - self.rightMiddle as CGPoint)
    }
  }

}

//  MARK: - Operator

public func +(lhs: CGRect, rhs: CGSize) -> CGRect {
  return CGRect(origin: lhs.origin, size: lhs.size + rhs)
}

public func +(lhs: CGRect, rhs: CGVector) -> CGRect {
  return CGRect(origin: lhs.origin + rhs, size: lhs.size)
}

public func +=(inout lhs: CGRect, rhs: CGSize) -> CGRect {
  lhs.size = lhs.size + rhs
  return lhs
}

public func +=(inout lhs: CGRect, rhs: CGVector) -> CGRect {
  lhs.origin = lhs.origin + rhs
  return lhs
}

public func -(lhs: CGRect, rhs: CGSize) -> CGRect {
  return CGRect(origin: lhs.origin, size: lhs.size - rhs)
}

public func -(lhs: CGRect, rhs: CGVector) -> CGRect {
  return CGRect(origin: lhs.origin - rhs, size: lhs.size)
}

public func -=(inout lhs: CGRect, rhs: CGSize) -> CGRect {
  lhs.size = lhs.size - rhs
  return lhs
}

public func -=(inout lhs: CGRect, rhs: CGVector) -> CGRect {
  lhs.origin = lhs.origin - rhs
  return lhs
}

/* CGRect + CGPoint is meaningless, use Vector2DConvertible.vector to convert CGPoint to a CGVector */

public func *(lhs: CGRect, rhs: CGAffineTransform) -> CGRect {
  return CGRectApplyAffineTransform(lhs, rhs)
}

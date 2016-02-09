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

}

//  MARK: - Operator

/**
Add a CGSize to a CGRect.size, returns a new CGRect

- parameter lhs: CGRect
- parameter rhs: CGSize

- returns: new CGRect
*/
public func +(lhs: CGRect, rhs: CGSize) -> CGRect {
  return CGRect(origin: lhs.origin, size: lhs.size + rhs)
}

/**
 Add a CGVector to a CGRect.origin, returns a new CGRect

 - parameter lhs: CGRect
 - parameter rhs: CGVector

 - returns: new CGRect
 */
public func +(lhs: CGRect, rhs: CGVector) -> CGRect {
  return CGRect(origin: lhs.origin + rhs, size: lhs.size)
}

/** See + */
public func +=(inout lhs: CGRect, rhs: CGSize) -> CGRect {
  lhs.size += rhs
  return lhs
}

/** See + */
public func +=(inout lhs: CGRect, rhs: CGVector) -> CGRect {
  lhs.origin += rhs
  return lhs
}

/** See + */
public func -(lhs: CGRect, rhs: CGSize) -> CGRect {
  return lhs + -rhs
}

/** See + */
public func -(lhs: CGRect, rhs: CGVector) -> CGRect {
  return lhs + -rhs
}

/** See - */
public func -=(inout lhs: CGRect, rhs: CGSize) -> CGRect {
  return lhs += -rhs
}

/** See - */
public func -=(inout lhs: CGRect, rhs: CGVector) -> CGRect {
  return lhs += -rhs
}

/* CGRect + CGPoint is meaningless, use Vector2DConvertible.vector to convert CGPoint to a CGVector */

/**
Apply CGAffineTransform to a CGRect, returns a new CGRect

- parameter lhs: CGRect
- parameter rhs: CGAffineTransform

- returns: a new CGRect
*/
public func *(lhs: CGRect, rhs: CGAffineTransform) -> CGRect {
  return CGRectApplyAffineTransform(lhs, rhs)
}

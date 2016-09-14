//
//  NSMutableArray+Operator.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/10.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

/**
 Add << operator support for NSMutableArray

 - parameter lhs: NSMutableArray
 - parameter rhs: object

 - returns: lhs
 */
public func <<(lhs: NSMutableArray, rhs: AnyObject) -> NSMutableArray {
  lhs.add(rhs)
  return lhs
}

/**
 Repeat NSMutableArray content for n times, will remove all objects if n == 0

 - parameter lhs: NSMutableArray
 - parameter rhs: n

 - returns: lhs
 */
public func *= (lhs: NSMutableArray, rhs: UInt64) -> NSMutableArray {
  if rhs == 0 {
    lhs.removeAllObjects()
  } else {
    for _ in 0 ..< (rhs - 1) {
      lhs.addObjects(from: lhs as [AnyObject])
    }
  }
  return lhs
}

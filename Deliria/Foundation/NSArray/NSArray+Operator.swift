//
//  NSArray+Operator.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/10.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

/**
 Concat two NSArray

 - parameter lhs: NSArray
 - parameter rhs: NSArray

 - returns: new NSMutableArray with contents of lhs and rhs
 */
public func +(lhs: NSArray, rhs: NSArray) -> NSMutableArray {
  let array = NSMutableArray(capacity: lhs.count + rhs.count)
  array.addObjectsFromArray(lhs as [AnyObject])
  array.addObjectsFromArray(rhs as [AnyObject])
  return array
}

/**
 Create a new NSMutableArray by repeating content of NSArray for n times, will return a empty NSMutableArray if n == 0

 - parameter lhs: NSArray
 - parameter rhs: n

 - returns: new NSMutableArray
 */
public func *<T: UnsignedIntegerType>(lhs: NSArray, rhs: T) -> NSMutableArray {
  let array = NSMutableArray()
  rhs.times { _ in
    array.addObjectsFromArray(lhs as [AnyObject])
  }
  return array
}

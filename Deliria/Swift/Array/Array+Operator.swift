//
//  Array+Operator.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/10.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//


/**
Alias for Array.append

- parameter lhs: array
- parameter rhs: object

- returns: array with object appended
*/
public func << <T>(inout lhs: [T], rhs: T) -> [T] {
  lhs.append(rhs)
  return lhs
}

/**
 Create a new Array by repeating Array for n times

 - parameter lhs: Array
 - parameter rhs: n

 - returns: new Array
 */
public func * <T, I: UnsignedIntegerType>(lhs: [T], rhs: I) -> [T] {
  var array = [T]()
  rhs.times { _ in
    array += lhs
  }
  return array
}

/**
 Replace content of Array with n times of itself

 - parameter lhs: Array
 - parameter rhs: n

 - returns: lhs
 */
public func *= <T, I: UnsignedIntegerType>(inout lhs: [T], rhs: I) -> [T] {
  if rhs == 0 {
    lhs.removeAll()
  } else {
    (rhs - 1).times { _ in
      lhs += lhs
    }
  }
  return lhs
}

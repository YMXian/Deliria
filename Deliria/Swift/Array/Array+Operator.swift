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
@discardableResult
public func << <T>(lhs: inout [T], rhs: T) -> [T] {
  lhs.append(rhs)
  return lhs
}

@discardableResult
public func +=<T>(lhs: inout [T], rhs: T) -> [T] {
  return lhs << rhs
}

public func >><T: Equatable>(lhs: inout [T], rhs: T) -> [T] {
  if let idx = lhs.index(of: rhs) {
    lhs.remove(at: idx)
  }
  return lhs
}

public func -=<T: Equatable>(lhs: inout [T], rhs: T) -> [T] {
  return lhs >> rhs
}

/**
 Create a new Array by repeating Array for n times

 - parameter lhs: Array
 - parameter rhs: n

 - returns: new Array
 */
public func * <T>(lhs: [T], rhs: UInt64) -> [T] {
  var array = [T]()
  for _ in 0 ..< rhs {
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
public func *= <T>(lhs: inout [T], rhs: UInt64) -> [T] {
  if rhs == 0 {
    lhs.removeAll()
  } else {
    for _ in 0 ..< (rhs - 1) {
      lhs += lhs
    }
  }
  return lhs
}

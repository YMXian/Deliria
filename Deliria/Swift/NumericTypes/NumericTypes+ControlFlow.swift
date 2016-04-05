//
//  NumericTypes+ControlFlow.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/10.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

extension UnsignedIntegerType {

  /**
   Repeat block for n times

   - parameter block: block to execute
   */
  public func times(block: (Self) -> Void) {
    for i in 0..<self {
      block(i)
    }
  }

}

/**
 Shortcut to min(max(V, MIN), MAX)

 - parameter value:    value to limit
 - parameter minValue: minValue
 - parameter maxValue: maxValue

 - returns: limited value result
 */
public func limit<T: Comparable>(value: T, _ minValue: T, _ maxValue: T) -> T {
  return min(max(value, minValue), maxValue)
}

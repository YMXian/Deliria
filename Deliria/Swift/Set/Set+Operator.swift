//
//  Set+Operator.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/10.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

/**
Add Append operator << for Set

- parameter lhs: set
- parameter rhs: object

- returns: set
*/
public func << <T: Hashable>(lhs: inout Set<T>, rhs: T) -> Set<T> {
  lhs.insert(rhs)
  return lhs
}

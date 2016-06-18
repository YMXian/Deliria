//
//  NSUserDefaults+ConvenientMethods.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/18.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

public extension NSUserDefaults {

  public func setOrRemoveObject(object: AnyObject?, forKey key: String) {
    if let object = object {
      self.setObject(object, forKey: key)
    } else {
      self.removeObjectForKey(key)
    }
  }

}

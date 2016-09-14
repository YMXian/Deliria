//
//  NSUserDefaults+ConvenientMethods.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/18.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

public extension UserDefaults {

  public func setOrRemoveObject(_ object: AnyObject?, forKey key: String) {
    if let object = object {
      self.set(object, forKey: key)
    } else {
      self.removeObject(forKey: key)
    }
  }

}

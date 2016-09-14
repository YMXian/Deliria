//
//  ThemeRegistry.swift
//  Deliria
//
//  Created by Yanke Guo on 16/3/28.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

open class ThemeRegistry<T: UIView> {

  public typealias Builder = (_ view: T) -> Void

  fileprivate var builders = [String: Builder]()

  /**
   Register a theme

   - parameter themeName: theme name
   - parameter builder:   builder
   */
  open func add(_ themeName: String, builder: @escaping Builder) {
    self.builders[themeName] = builder
  }

  /**
   Apply a theme to view

   - parameter themeName: theme name
   - parameter view:      target view
   */
  open func apply(_ themeName: String, view: T) {
    self.builders[themeName]?(view)
  }

}

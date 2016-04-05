//
//  ThemeRegistry.swift
//  Deliria
//
//  Created by Yanke Guo on 16/3/28.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

public class ThemeRegistry<T: UIView> {

  public typealias Builder = (view: T) -> Void

  private var builders = [String: Builder]()

  /**
   Register a theme

   - parameter themeName: theme name
   - parameter builder:   builder
   */
  public func add(themeName: String, builder: Builder) {
    self.builders[themeName] = builder
  }

  /**
   Apply a theme to view

   - parameter themeName: theme name
   - parameter view:      target view
   */
  public func apply(themeName: String, view: T) {
    self.builders[themeName]?(view: view)
  }

}

//
//  ThemeManager.swift
//  Deliria
//
//  Created by Yanke Guo on 16/3/28.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

private var kThemeManagerThemeRegistryKey = 0

public class ThemeManager {

  private struct $ {
    static let sharedInstance = ThemeManager()
  }

  public func of <T: UIView> (clazz: T.Type) -> ThemeRegistry<T> {
    var registry = objc_getAssociatedObject(clazz, &kThemeManagerThemeRegistryKey) as? ThemeRegistry<T>
    if registry != nil { return registry! }
    registry = ThemeRegistry<T>()
    objc_setAssociatedObject(clazz, &kThemeManagerThemeRegistryKey, registry, .OBJC_ASSOCIATION_RETAIN)
    return registry!
  }

}

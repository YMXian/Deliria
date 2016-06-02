//
//  UIStoryboard+NameConvenience.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/2.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

public extension UIStoryboard {

  public var rootViewController: UIViewController? {
    get {
      return self.instantiateInitialViewController()
    }
  }

  public func viewControllerNamed(name: String) -> UIViewController? {
    return self.instantiateViewControllerWithIdentifier(name)
  }

}

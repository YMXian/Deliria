//
//  UIViewController+NamingConvenience.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/2.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

public extension UIViewController {

  public var window: UIWindow? {
    get {
      return self.view.window
    }
  }

  public func showAlertController(_ title: String?, message: String? = "", buttonTitle: String? = L("OK")) {
    self.present(UIAlertController(title: title, message: message, buttonTitle: buttonTitle), animated: true, completion: nil)
  }

  public func viewControllerNamed(_ name: String) -> UIViewController? {
    return self.storyboard?.viewControllerNamed(name)
  }

}

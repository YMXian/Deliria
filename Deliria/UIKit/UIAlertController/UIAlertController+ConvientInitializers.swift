//
//  UIAlertController+ConvientInitializers.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/20.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UIAlertController {

  public convenience init(title: String?, message: String?, buttonTitle: String?) {
    self.init(title: title, message: message, preferredStyle: .Alert)
    self.addAction(UIAlertAction(title: buttonTitle, style: .Cancel, handler: nil))
  }

}

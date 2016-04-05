//
//  UIView+Style.swift
//  Deliria
//
//  Created by Yanke Guo on 16/3/28.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

private var kDeliriaUIViewStyleKey = 0

extension UIView {

  public var style: String {
    get {
      return objc_getAssociatedObject(self, &kDeliriaUIViewStyleKey) as! String
    }
    set(value) {
      objc_setAssociatedObject(self, &kDeliriaUIViewStyleKey, value, .OBJC_ASSOCIATION_COPY)
    }
  }

}

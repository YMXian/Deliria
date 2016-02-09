//
//  UIColor+UIExtension.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/9.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UIColor {

  /**
   Create a image from current color and size

   - parameter size: size

   - returns: image
   */
  public func image(size: CGSize = [1,1]) -> UIImage {
    return UIImage.imageWithColor(self, size: size)
  }

}

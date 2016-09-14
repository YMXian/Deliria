//
//  UIColor+Utils.swift
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
  public func toImage(_ size: CGSize = [1, 1]) -> UIImage {
    return UIImage.imageWithColor(self, size: size)
  }

  /// Get RGBA as Tuple, in CGFloat 0.0 ~ 1.0
  public var RGBA: (CGFloat, CGFloat, CGFloat, CGFloat) {
    var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    return (r, g, b, a)
  }

  /// Get HSBA as Tuple, in CGFloat 0.0 ~ 1.0
  public var HSBA: (CGFloat, CGFloat, CGFloat, CGFloat) {
    var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
    self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    return (h, s, b, a)
  }

  /// Get White/Alpha as Tuple, in CGFloat 0.0 ~ 1.0
  public var WA: (CGFloat, CGFloat) {
    var w: CGFloat = 0, a: CGFloat = 0
    self.getWhite(&w, alpha: &a)
    return (w, a)
  }

}

//
//  UIImage+Generation.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/9.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

extension UIImage {

  /**
   Create a image with color and size

   - parameter color: color
   - parameter size:  size, default to {1, 1}

   - returns: image
   */
  public static func imageWithColor(color: UIColor, size: CGSize = [1, 1]) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, 1)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, CGRect(origin: CGPointZero, size: size))
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }

}

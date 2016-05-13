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

    //  Local NSCache for image with color
    struct Static {
      static let cache: NSCache = {
        let c = NSCache()
        //  Cost limit to 60x60 pixels
        c.totalCostLimit = 360
        return c
      }()
    }

    let cacheKey = "\(color.hash)-\(size.width)x\(size.height)"

    //  Try local cached image
    if let cachedImage = Static.cache.objectForKey(cacheKey) {
      return cachedImage as! UIImage
    }

    //  Create image
    UIGraphicsBeginImageContextWithOptions(size, false, 1)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, CGRect(origin: CGPoint.zero, size: size))
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()

    //  Put image to cache
    let (width, height) = image.pixelSize
    Static.cache.setObject(image, forKey: cacheKey, cost: width * height)

    return image
  }

}

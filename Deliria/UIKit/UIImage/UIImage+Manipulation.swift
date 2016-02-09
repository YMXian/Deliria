//
//  UIImage+Manipulation.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/9.
//
//  Reference: https://github.com/mbcharbonneau/UIImage-Categories
//

import CoreGraphics
import UIKit


extension UIImage {

  /// multiplate logic size with scale
  public var pixelSize: (Int, Int) {
    let size = self.size * self.scale
    return (Int(size.width), Int(size.height))
  }

  /// does this image has alpha channel
  public var hasAlpha: Bool {
    let alphaInfo = CGImageGetAlphaInfo(self.CGImage)
    switch alphaInfo {
    case .None, .NoneSkipFirst, .NoneSkipLast:
      return false
    default:
      return true
    }
  }

  /// create a new image with alpha channel
  public var imageWithAlpha: UIImage {
    if self.hasAlpha { return self }
    let (width, height) = self.pixelSize
    let options = CGBitmapInfo.ByteOrderDefault.rawValue | CGImageAlphaInfo.PremultipliedFirst.rawValue
    let context = CGBitmapContextCreate(nil, width, height, 8, 0, CGImageGetColorSpace(self.CGImage), options)
    CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), self.CGImage)
    let imageRef = CGBitmapContextCreateImage(context)
    let image = UIImage(CGImage: imageRef!, scale: self.scale, orientation: .Up)
    return image
  }

  /**
   Create a cropped image from original image

   - parameter bounds: CGRect

   - returns: new image
   */
  public func imageCropped(bounds: CGRect) -> UIImage {
    let imageRef = CGImageCreateWithImageInRect(self.CGImage, bounds * self.scale)
    return UIImage(CGImage: imageRef!, scale: self.scale, orientation: .Up)
  }

  /**
   Create a scaled image

   - parameter scale:   scale
   - parameter quality: quality

   - returns: scaled image
   */
  public func imageScaled(scale: CGFloat, quality: CGInterpolationQuality = .High) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.size, !self.hasAlpha, scale)
    let context = UIGraphicsGetCurrentContext()
    CGContextSetInterpolationQuality(context, quality)
    self.drawInRect(CGRectMake(0, 0, self.size.width, self.size.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }

  /**
   Scale image down to width/height provided, aspect ratio is kept, if width/height provided is larger than image size, do nothing, returns self

   - parameter width:   width
   - parameter height:  height
   - parameter quality: quality, default to .High

   - returns: scaled image of self
   */
  public func imageScaledDownTo(width: CGFloat, height: CGFloat, quality: CGInterpolationQuality = .High) -> UIImage {
    let scale = min(width / self.size.width, height / self.size.height)
    if scale < 1 {
      return self.imageScaled(scale, quality: quality)
    } else {
      return self
    }
  }

  /// Create a new image with orientation up
  public var imageWithOrientationFixed: UIImage {
    if self.imageOrientation == .Up {
      return self
    }
    var transform = CGAffineTransformIdentity

    switch self.imageOrientation {
    case .Down, .DownMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height)
      transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
    case .Left, .LeftMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.width, 0)
      transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
    case .Right, .RightMirrored:
      transform = CGAffineTransformTranslate(transform, 0, self.size.height)
      transform = CGAffineTransformRotate(transform, -CGFloat(M_PI_2))
    default:
      break
    }

    switch self.imageOrientation {
    case .UpMirrored, .DownMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.width, 0)
      transform = CGAffineTransformScale(transform, -1, 1)
    case .LeftMirrored, .RightMirrored:
      transform = CGAffineTransformTranslate(transform, self.size.height, 0)
      transform = CGAffineTransformScale(transform, -1, 1)
    default:
      break
    }

    let ctx = CGBitmapContextCreate(
      nil,
      Int(self.size.width),
      Int(self.size.height),
      CGImageGetBitsPerComponent(self.CGImage),
      0,
      CGImageGetColorSpace(self.CGImage),
      CGImageGetBitmapInfo(self.CGImage).rawValue)

    CGContextConcatCTM(ctx, transform)

    switch self.imageOrientation {
    case .Left, .LeftMirrored, .Right, .RightMirrored:
      CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.height, self.size.width), self.CGImage)
    default:
      CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage)
    }

    return UIImage(CGImage: CGBitmapContextCreateImage(ctx)!)
  }

}

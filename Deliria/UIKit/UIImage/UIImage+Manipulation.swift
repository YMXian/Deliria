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
    return (size.width.Int, size.height.Int)
  }

  /// Multiplate logic size with scale and create CGRect with origin 0, 0
  public var pixelRect: CGRect {
    let size = self.size * self.scale
    return [0, 0, size.width, size.height]
  }

  /// does this image has alpha channel
  public var hasAlpha: Bool {
    //  Get AlphaInfo
    let alphaInfo = CGImageGetAlphaInfo(self.CGImage)
    //  Switch
    switch alphaInfo {
    case .None, .NoneSkipFirst, .NoneSkipLast:
      return false
    default:
      return true
    }
  }

  /// create a new image with alpha channel
  public var imageWithAlpha: UIImage {
    //  Returns self if has alpha
    if self.hasAlpha { return self }

    //  Get CGImage
    if let srcImage = self.CGImage {

      //  Get size
      let width   = CGImageGetWidth(srcImage)
      let height  = CGImageGetHeight(srcImage)

      //  Create options
      let options = CGBitmapInfo.ByteOrderDefault.rawValue | CGImageAlphaInfo.PremultipliedFirst.rawValue
      //  Create context
      let context = CGBitmapContextCreate(nil, width, height, 8, 0, CGImageGetColorSpace(self.CGImage), options)

      //  Draw image
      CGContextDrawImage(context, [0, 0, width.CGFloat, height.CGFloat], srcImage)

      //  Get new CGImage
      if let imageRef = CGBitmapContextCreateImage(context) {
        return UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
      }
    }

    //  Fallback to self
    return self
  }

  /**
   Create a cropped image from original image

   - parameter bounds: CGRect

   - returns: new image
   */
  public func imageCropped(bounds: CGRect) -> UIImage {
    //  Get CGImage
    if let srcImage = self.CGImage {
      //  Calculate target bounds
      let targetBounds = bounds * self.affineTransformToOrientationUp * self.scale
      //  Create cropped CGImage
      if let imageRef = CGImageCreateWithImageInRect(srcImage, targetBounds) {
        return UIImage(CGImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
      }
    }
    return self
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
    self.drawInRect([0, 0, self.size.width, self.size.height])
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
  public func imageScaledAtMax(width: CGFloat, height: CGFloat, quality: CGInterpolationQuality = .High) -> UIImage {
    let scale = min(width / self.size.width, height / self.size.height)
    if scale < 1 {
      return self.imageScaled(scale, quality: quality)
    } else {
      return self
    }
  }

  /// The biggest image squared at top or left
  public var imageSquareAtTopOrLeft: UIImage {
    if self.size.height == self.size.width {
      return self
    }
    let size = min(self.size.width, self.size.height)
    return self.imageCropped([0, 0, size, size])
  }

  /**
   Create a new image with tinted color, alpha lost

   - parameter color: tint color

   - returns: new image
   */
  public func imageTintedWith(color: UIColor = UIColor.grayColor()) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    let rect: CGRect = [0, 0, self.size.width, self.size.height]
    let context = UIGraphicsGetCurrentContext()

    //  Draw original image
    self.drawInRect(rect, blendMode: .Normal, alpha: 1)

    //  Tint
    CGContextSetBlendMode(context, .Overlay)
    color.setFill()
    CGContextFillRect(context, rect)

    //  Mask by alpha values of original image
    self.drawInRect(rect, blendMode: .DestinationIn, alpha: 1)

    //  Create tintedImage
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }

  /// Create a image grayed
  public var imageGrayed: UIImage {

    //  Get CGImage
    if let srcImage = self.CGImage {

      //  Get pixel size
      let width   = CGImageGetWidth(srcImage)
      let height  = CGImageGetHeight(srcImage)

      //  Grayscale color space
      let colorSpace = CGColorSpaceCreateDeviceGray()

      //  Context
      let context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, CGImageAlphaInfo.None.rawValue)

      //  Draw image
      CGContextDrawImage(context, CGRectMake(0, 0, width.CGFloat, height.CGFloat), srcImage)

      //  Get CGImage
      if let outImage = CGBitmapContextCreateImage(context) {

        //  Create UIImage
        return UIImage(CGImage: outImage, scale: self.scale, orientation: self.imageOrientation)
      }
    }

    //  Fallback
    return self
  }

  /// The CGAffineTransform to change underlying CGImage to OrientationUp
  public var affineTransformToOrientationUp: CGAffineTransform {
    //  Prepare a CGAffineTransform
    var transform = CGAffineTransformIdentity

    //  Return CGAffineTransformIdentity if self is Up
    if self.imageOrientation == .Up {
      return transform
    }

    if let srcImage = self.CGImage {
      //  Get CGImage size
      let width   = CGImageGetWidth(srcImage)
      let height  = CGImageGetHeight(srcImage)

      //  Calculate position and rotation transform
      switch self.imageOrientation {
      case .Down, .DownMirrored:
        transform = CGAffineTransformTranslate(transform, width.CGFloat, height.CGFloat)
        transform = CGAffineTransformRotate(transform, M_PI.CGFloat)
      case .Left, .LeftMirrored:
        transform = CGAffineTransformTranslate(transform, width.CGFloat, 0)
        transform = CGAffineTransformRotate(transform, M_PI_2.CGFloat)
      case .Right, .RightMirrored:
        transform = CGAffineTransformTranslate(transform, 0, height.CGFloat)
        transform = CGAffineTransformRotate(transform, -M_PI_2.CGFloat)
      default:
        break
      }

      //  Calculate mirror transform
      switch self.imageOrientation {
      case .UpMirrored, .DownMirrored:
        transform = CGAffineTransformTranslate(transform, width.CGFloat, 0)
        transform = CGAffineTransformScale(transform, -1, 1)
      case .LeftMirrored, .RightMirrored:
        transform = CGAffineTransformTranslate(transform, height.CGFloat, 0)
        transform = CGAffineTransformScale(transform, -1, 1)
      default:
        break
      }
    }

    return transform
  }

  /// Create a new image with orientation up
  public var imageWithOrientationFixed: UIImage {
    if self.imageOrientation == .Up {
      return self
    }

    if let srcImage = self.CGImage {

      //  Extract pixel size with orientation
      let (width, height) = self.pixelSize

      //  Prepare a CGAffineTransform
      let transform = self.affineTransformToOrientationUp

      //  Create bitmap context
      let options = CGImageGetBitmapInfo(srcImage).rawValue | CGImageGetAlphaInfo(srcImage).rawValue
      let ctx = CGBitmapContextCreate(nil, width, height, CGImageGetBitsPerComponent(srcImage), 0, CGImageGetColorSpace(srcImage), options)

      //  Apply transform
      CGContextConcatCTM(ctx, transform)

      //  Draw image
      switch self.imageOrientation {
      case .Left, .LeftMirrored, .Right, .RightMirrored:
        CGContextDrawImage(ctx, CGRectMake(0, 0, height.CGFloat, width.CGFloat), srcImage)
      default:
        CGContextDrawImage(ctx, CGRectMake(0, 0, width.CGFloat, height.CGFloat), srcImage)
      }

      //  Create result image
      if let imageRef = CGBitmapContextCreateImage(ctx) {
        return UIImage(CGImage: imageRef, scale: self.scale, orientation: .Up)
      }

    }
    return self
  }

}

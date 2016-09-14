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
    if let alphaInfo = self.cgImage?.alphaInfo {
      //  Switch
      switch alphaInfo {
      case .none, .noneSkipFirst, .noneSkipLast:
        return false
      default:
        return true
      }
    }
    return false
  }

  /// create a new image with alpha channel
  public var imageWithAlpha: UIImage {
    //  Returns self if has alpha
    if self.hasAlpha { return self }

    //  Get CGImage
    if let srcImage = self.cgImage {

      //  Get size
      let width   = srcImage.width
      let height  = srcImage.height

      //  Create options
      let options = CGBitmapInfo().rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue
      //  Create context
      let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: (self.cgImage?.colorSpace!)!, bitmapInfo: options)

      //  Draw image
      context?.draw(srcImage, in: [0, 0, width.CGFloat, height.CGFloat])

      //  Get new CGImage
      if let imageRef = context?.makeImage() {
        return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
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
  public func imageCropped(_ bounds: CGRect) -> UIImage {
    //  Get CGImage
    if let srcImage = self.cgImage {
      //  Calculate target bounds
      let targetBounds = bounds * self.affineTransformToOrientationUp * self.scale
      //  Create cropped CGImage
      if let imageRef = srcImage.cropping(to: targetBounds) {
        return UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)
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
  public func imageScaled(_ scale: CGFloat, quality: CGInterpolationQuality = .high) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.size, !self.hasAlpha, scale)
    let context = UIGraphicsGetCurrentContext()
    context!.interpolationQuality = quality
    self.draw(in: [0, 0, self.size.width, self.size.height])
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }

  /**
   Scale image down to width/height provided, aspect ratio is kept, if width/height provided is larger than image size, do nothing, returns self

   - parameter width:   width
   - parameter height:  height
   - parameter quality: quality, default to .High

   - returns: scaled image of self
   */
  public func imageScaledAtMax(_ width: CGFloat, height: CGFloat, quality: CGInterpolationQuality = .high) -> UIImage {
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
  public func imageTintedWith(_ color: UIColor = UIColor.gray) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
    let rect: CGRect = [0, 0, self.size.width, self.size.height]
    let context = UIGraphicsGetCurrentContext()

    //  Draw original image
    self.draw(in: rect, blendMode: .normal, alpha: 1)

    //  Tint
    context?.setBlendMode(.overlay)
    color.setFill()
    context?.fill(rect)

    //  Mask by alpha values of original image
    self.draw(in: rect, blendMode: .destinationIn, alpha: 1)

    //  Create tintedImage
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }

  /// Create a image grayed
  public var imageGrayed: UIImage {

    //  Get CGImage
    if let srcImage = self.cgImage {

      //  Get pixel size
      let width   = srcImage.width
      let height  = srcImage.height

      //  Grayscale color space
      let colorSpace = CGColorSpaceCreateDeviceGray()

      //  Context
      let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue)

      //  Draw image
      context?.draw(srcImage, in: CGRect(x: 0, y: 0, width: width.CGFloat, height: height.CGFloat))

      //  Get CGImage
      if let outImage = context?.makeImage() {

        //  Create UIImage
        return UIImage(cgImage: outImage, scale: self.scale, orientation: self.imageOrientation)
      }
    }

    //  Fallback
    return self
  }

  /// The CGAffineTransform to change underlying CGImage to OrientationUp
  public var affineTransformToOrientationUp: CGAffineTransform {
    //  Prepare a CGAffineTransform
    var transform = CGAffineTransform.identity

    //  Return CGAffineTransformIdentity if self is Up
    if self.imageOrientation == .up {
      return transform
    }

    if let srcImage = self.cgImage {
      //  Get CGImage size
      let width   = srcImage.width
      let height  = srcImage.height

      //  Calculate position and rotation transform
      switch self.imageOrientation {
      case .down, .downMirrored:
        transform = transform.translatedBy(x: width.CGFloat, y: height.CGFloat)
        transform = transform.rotated(by: M_PI.CGFloat)
      case .left, .leftMirrored:
        transform = transform.translatedBy(x: width.CGFloat, y: 0)
        transform = transform.rotated(by: M_PI_2.CGFloat)
      case .right, .rightMirrored:
        transform = transform.translatedBy(x: 0, y: height.CGFloat)
        transform = transform.rotated(by: -M_PI_2.CGFloat)
      default:
        break
      }

      //  Calculate mirror transform
      switch self.imageOrientation {
      case .upMirrored, .downMirrored:
        transform = transform.translatedBy(x: width.CGFloat, y: 0)
        transform = transform.scaledBy(x: -1, y: 1)
      case .leftMirrored, .rightMirrored:
        transform = transform.translatedBy(x: height.CGFloat, y: 0)
        transform = transform.scaledBy(x: -1, y: 1)
      default:
        break
      }
    }

    return transform
  }

  /// Create a new image with orientation up
  public var imageWithOrientationFixed: UIImage {
    if self.imageOrientation == .up {
      return self
    }

    if let srcImage = self.cgImage {

      //  Extract pixel size with orientation
      let (width, height) = self.pixelSize

      //  Prepare a CGAffineTransform
      let transform = self.affineTransformToOrientationUp

      //  Create bitmap context
      let options = srcImage.bitmapInfo.rawValue | srcImage.alphaInfo.rawValue
      let ctx = CGContext(data: nil, width: width, height: height, bitsPerComponent: srcImage.bitsPerComponent, bytesPerRow: 0, space: srcImage.colorSpace!, bitmapInfo: options)

      //  Apply transform
      ctx?.concatenate(transform)

      //  Draw image
      switch self.imageOrientation {
      case .left, .leftMirrored, .right, .rightMirrored:
        ctx?.draw(srcImage, in: CGRect(x: 0, y: 0, width: height.CGFloat, height: width.CGFloat))
      default:
        ctx?.draw(srcImage, in: CGRect(x: 0, y: 0, width: width.CGFloat, height: height.CGFloat))
      }

      //  Create result image
      if let imageRef = ctx?.makeImage() {
        return UIImage(cgImage: imageRef, scale: self.scale, orientation: .up)
      }

    }
    return self
  }

}

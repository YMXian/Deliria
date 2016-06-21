//
//  ColorSet.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/21.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import UIKit

public struct ColorSet {

  public let main: UIColor

  public let dark: UIColor

  public let ultraLight: UIColor

  public let invert: UIColor

  public init(main: UIColor, dark: UIColor, ultraLight: UIColor, invert: UIColor) {
    self.main = main
    self.dark = dark
    self.ultraLight = ultraLight
    self.invert = invert
  }

}

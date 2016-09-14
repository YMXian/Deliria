//
//  NSLocalizedString+Shortcut.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/15.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

/**
 Alias for NSLocalizedString(key, comment)

 - parameter key:     key
 - parameter comment: comment

 - returns: localized string
 */
public func L(_ key: String, comment: String = "") -> String {
  return NSLocalizedString(key, comment: comment)
}

//
//  SCLExtensions.swift
//  SCLAlertView
//
//  Created by Christian Cabarrocas on 16/04/16.
//  Copyright © 2016 Alexey Poimtsev. All rights reserved.
//

import UIKit

extension Int {

    func UIColor() -> UIKit.UIColor {
      return UIKit.UIColor(hexString: self.String)
    }

    func CGColor() -> UIKit.CGColor {
      return UIColor().cgColor
    }
}

extension UInt {

    func UIColor() -> UIKit.UIColor {
      return UIKit.UIColor(hexString: self.String)
    }

    func CGColor() -> UIKit.CGColor {
      return UIColor().cgColor
    }
}

//
// Created by Yanke Guo on 16/3/26.
// Copyright (c) 2016 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit.UIApplication

extension UIApplication: AbstractRouter {

  public func routeUrl(_ url: URL) -> Bool {
    return UIApplication.shared.routeUrl(url)
  }

}

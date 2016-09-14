//
// Created by Yanke Guo on 16/3/25.
// Copyright (c) 2016 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

public protocol AbstractRouter {

  /**
   Handle the url, if successfully recognized, returns true, else returns false

   - parameter url: the url to handle

   - returns: successfully handled
   */
  func routeUrl(_ url: URL) -> Bool

}

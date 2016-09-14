//
// Created by Yanke Guo on 16/3/25.
// Copyright (c) 2016 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

public typealias RouterAction = (_ url: URL, _ params: [String:String]) -> Void

/*
 *  URL Router
 */

open class Router: AbstractRouter {

  /**
   CompatibilityMode

   - None:       Nothing
   - IgnoreHost: Ignore host, regard schema://what as same as shema:///what
   */

  public enum CompatibilityMode {

    case none, ignoreHost

    fileprivate func processUrl(_ url: URL) -> URL {
      switch self {
      case .none:
        return url
      case .ignoreHost:
        //TODO: Implement
        return url
      }
    }
  }

  fileprivate struct Entry {

    struct Item {

      let name: String

      let wildcard: Bool

      init(pattern: String) {
        if pattern.hasPrefix(":") {
          self.name = pattern.substring(from: pattern.characters.index(pattern.startIndex, offsetBy: 1))
          self.wildcard = true
        } else {
          self.name = pattern
          self.wildcard = false
        }
      }

    }

    let items: [Item]

    let action: RouterAction

    init(pattern: String, action: @escaping RouterAction) {
      self.items = (pattern as NSString).pathComponents.map { v in Item(pattern: v) }
      self.action = action
    }

    func execute(_ url: URL) -> Bool {
      //TODO: implement
      return false
    }

  }

  fileprivate var routers = [AbstractRouter]()

  fileprivate var entries = [Entry]()

  /// Default to .IgnoreHost
  open var compatibilityMode = CompatibilityMode.ignoreHost

  /**
   Append a router as subrouter

   - parameter router: subrouter
   */
  open func appendRouter(_ router: AbstractRouter) {
    self.routers += router
  }

  /**
   Prepend a router as subrouter

   - parameter router: subrouter
   */
  open func prependRouter(_ router: AbstractRouter) {
    self.routers.insert(router, at: 0)
  }

  open func routeUrl(_ url: URL) -> Bool {
    if !_selfRouteUrl(url) {
      return _subRouteUrl(url)
    }
    return true
  }

  fileprivate func _selfRouteUrl(_ url: URL) -> Bool {
    let url = self.compatibilityMode.processUrl(url)
    for entry in self.entries {
      if entry.execute(url) {
        return true
      }
    }
    return false
  }

  fileprivate func _subRouteUrl(_ url: URL) -> Bool {
    for router in self.routers {
      if router.routeUrl(url) {
        return true
      }
    }
    return false
  }

  /**
   Register a action for pattern

   - parameter pattern: pattern, support named component
   - parameter action:  action
   */
  open func registerAction(_ pattern: String, action: @escaping RouterAction) {
    self.entries << Entry(pattern: pattern, action: action)
  }

}

//
// Created by Yanke Guo on 16/3/25.
// Copyright (c) 2016 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

public typealias RouterAction = (url: NSURL, params: [String:String]) -> Void

/*
 *  URL Router
 */

public class Router: AbstractRouter {

  /**
   CompatibilityMode

   - None:       Nothing
   - IgnoreHost: Ignore host, regard schema://what as same as shema:///what
   */

  public enum CompatibilityMode {

    case None, IgnoreHost

    private func processUrl(url: NSURL) -> NSURL {
      switch self {
      case .None:
        return url
      case .IgnoreHost:
        //TODO: Implement
        return url
      }
    }
  }

  private struct Entry {

    struct Item {

      let name: String

      let wildcard: Bool

      init(pattern: String) {
        if pattern.hasPrefix(":") {
          self.name = pattern.substringFromIndex(pattern.startIndex.advancedBy(1))
          self.wildcard = true
        } else {
          self.name = pattern
          self.wildcard = false
        }
      }

    }

    let items: [Item]

    let action: RouterAction

    init(pattern: String, action: RouterAction) {
      self.items = (pattern as NSString).pathComponents.map { v in Item(pattern: v) }
      self.action = action
    }

    func execute(url: NSURL) -> Bool {
      //TODO: implement
      return false
    }

  }

  private var routers = [AbstractRouter]()

  private var entries = [Entry]()

  /// Default to .IgnoreHost
  public var compatibilityMode = CompatibilityMode.IgnoreHost

  /**
   Append a router as subrouter

   - parameter router: subrouter
   */
  public func appendRouter(router: AbstractRouter) {
    self.routers += router
  }

  /**
   Prepend a router as subrouter

   - parameter router: subrouter
   */
  public func prependRouter(router: AbstractRouter) {
    self.routers.insert(router, atIndex: 0)
  }

  public func routeUrl(url: NSURL) -> Bool {
    if !_selfRouteUrl(url) {
      return _subRouteUrl(url)
    }
    return true
  }

  private func _selfRouteUrl(url: NSURL) -> Bool {
    let url = self.compatibilityMode.processUrl(url)
    for entry in self.entries {
      if entry.execute(url) {
        return true
      }
    }
    return false
  }

  private func _subRouteUrl(url: NSURL) -> Bool {
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
  public func registerAction(pattern: String, action: RouterAction) {
    self.entries << Entry(pattern: pattern, action: action)
  }

}

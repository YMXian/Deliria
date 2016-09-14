//
//  MinDurationScheduler.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/18.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

open class MinDurationTimer {

  open var dispatchQueue = DispatchQueue.main

  fileprivate var initialMilliseconds: UInt64 = 0

  public init() {
  }

  open func mark() {
    self.initialMilliseconds = GetDeviceUptimeInMilliseconds()
  }

  open func commit(_ duration: UInt64, _ block: @escaping VoidBlock) {
    let current = GetDeviceUptimeInMilliseconds()
    let diff    = current - initialMilliseconds

    if diff >= duration {
      block()
    } else {
      dispatch_after_milliseconds(dispatchQueue, duration - diff, block)
    }
  }

}

//
//  MinDurationScheduler.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/18.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

public class MinDurationTimer {

  public var dispatchQueue = dispatch_get_main_queue()

  private var initialMilliseconds: UInt64 = 0

  public init() {
  }

  public func mark() {
    self.initialMilliseconds = GetDeviceUptimeInMilliseconds()
  }

  public func commit(duration: UInt64, _ block: VoidBlock) {
    let current = GetDeviceUptimeInMilliseconds()
    let diff    = current - initialMilliseconds

    if diff >= duration {
      block()
    } else {
      dispatch_after_milliseconds(dispatchQueue, duration - diff, block)
    }
  }

}

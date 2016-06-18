//
//  MinDurationScheduler.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/18.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

public class MinDurationScheduler {

  public var dispatchQueue = dispatch_get_main_queue()

  public var duration: UInt64

  public var complete: VoidBlock

  private var initialMilliseconds: UInt64 = 0

  public required init(duration: UInt64, complete: VoidBlock) {
    self.duration = duration
    self.complete = complete
  }

  public func start() {
    self.initialMilliseconds = GetDeviceUptimeInMilliseconds()
  }

  public func commit() {
    let current = GetDeviceUptimeInMilliseconds()
    let diff    = current - initialMilliseconds

    if diff >= duration {
      complete()
    } else {
      dispatch_after_milliseconds(dispatchQueue, duration - diff, complete)
    }
  }

}

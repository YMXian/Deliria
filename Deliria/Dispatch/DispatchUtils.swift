//
//  DispatchUtils.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/2.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

public typealias VoidBlock = () -> Void

//  MARK: - Dispatch Async

public func dispatch_async_main(block: VoidBlock) {
  dispatch_async(dispatch_get_main_queue(), block)
}

public func dispatch_async_low(block: VoidBlock) {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), block)
}

//  MARK: - Dispatch After

public func dispatch_after_seconds(queue: dispatch_queue_t, _ seconds: NSTimeInterval, _ block: VoidBlock) {
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * NSTimeInterval(NSEC_PER_SEC))), queue, block)
}

public func dispatch_main_after(seconds: NSTimeInterval, _ block: VoidBlock) {
  dispatch_after_seconds(dispatch_get_main_queue(), seconds, block)
}

//
//  DispatchUtils.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/2.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//
import Dispatch

public typealias VoidBlock = () -> Void

//  MARK: - Dispatch Async

public func dispatch_async_main(_ block: @escaping VoidBlock) {
  DispatchQueue.main.async(execute: block)
}

public func dispatch_async_low(_ block: @escaping VoidBlock) {
  DispatchQueue.global(qos: .utility).async(execute: block)
}

//  MARK: - Dispatch After

public func dispatch_after_seconds(_ queue: DispatchQueue, _ seconds: TimeInterval, _ block: @escaping VoidBlock) {
   queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(seconds * TimeInterval(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: block)
}

public func dispatch_after_milliseconds(_ queue: DispatchQueue, _ milliseconds: UInt64, _ block: @escaping VoidBlock) {
   queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(milliseconds * NSEC_PER_MSEC)) / Double(NSEC_PER_SEC), execute: block)
}

public func dispatch_main_after(_ seconds: TimeInterval, _ block: @escaping VoidBlock) {
  dispatch_after_seconds(DispatchQueue.main, seconds, block)
}

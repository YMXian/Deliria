//
//  SystemInfoUtils.swift
//  Deliria
//
//  Created by Yanke Guo on 16/6/18.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import Foundation

private var s_TimebaseInfo: mach_timebase_info_data_t = mach_timebase_info_data_t(numer: 0, denom: 0)

public func GetDeviceUptimeInMilliseconds() -> UInt64 {
  if s_TimebaseInfo.denom == 0 {
    mach_timebase_info(&s_TimebaseInfo)
  }
  return ((mach_absolute_time() * UInt64(s_TimebaseInfo.numer)) / (UInt64(s_TimebaseInfo.denom) * 1000 * 1000))
}

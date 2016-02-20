//
//  UIBezierPathOperator.swift
//  Deliria
//
//  Created by Yanke Guo on 16/2/20.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import XCTest
@testable import Deliria

class UIBezierPathOperator: XCTestCase {

    func testOperator() {
      let path = ([1,1] +-> [2,3] +~> [[1,3], [2,3], [2,4]] +-> [1,2])->|
      path.fill()
    }

}

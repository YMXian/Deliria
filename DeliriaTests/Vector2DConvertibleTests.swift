//
//  DeliriaTests.swift
//  DeliriaTests
//
//  Created by Yanke Guo on 16/2/6.
//  Copyright © 2016年 JuXian(Beijing) Technology Co., Ltd. All rights reserved.
//

import XCTest
@testable import Deliria

class DeliriaTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  func testVector2DConvertible() {
    let point1: CGPoint = [1.0, 2.0]
    let size1: CGSize  = [2.0, 1.0]
    var result: CGVector = point1 + size1
    XCTAssertEqual(result.x, 3.0)
    XCTAssertEqual(result.y, 3.0)
    result += (1.0, 1.0)
    XCTAssertEqual(result.x, 4.0)
    XCTAssertEqual(result.y, 4.0)
    let view = UIView()
    view.frame.origin.x = 1
    XCTAssertEqual(view.frame.x, 1)
    view.frame.origin.x += 1
    XCTAssertEqual(view.frame.x, 2)
  }

}

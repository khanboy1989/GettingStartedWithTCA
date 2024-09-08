//
//  AppFeatureTests.swift
//  GettingStartedWithTCATests
//
//  Created by Serhan Khan on 08/09/2024.
//

import ComposableArchitecture
import XCTest


@testable import GettingStartedWithTCA


final class AppFeatureTests: XCTestCase {
  func testIncrementInFirstTab() async {
      let store = await TestStore(initialState: AppFeature.State()) {
          AppFeature()
      }
      
      await store.send(\.tab1.incrementButtonTapped) {
          $0.tab1.count = 1 
      }
  }
}

//
//  CounterFeatureTests.swift
//  GettingStartedWithTCATests
//
//  Created by Serhan Khan on 05/09/2024.
//


import ComposableArchitecture
import XCTest

@testable import GettingStartedWithTCA

final class CounterFeatureTests: XCTestCase {
  func testCounter() async {
      let store = await TestStore(initialState: CounterFeature.State()) {
          CounterFeature()
      }
      
      await store.send(.incrementButtonTapped) {
          $0.count = 1
      }
      await store.send(.decrementButtonTapped) {
          $0.count = 0
      }
  }
    
    func testTimer() async {
        let store = await TestStore(initialState: CounterFeature.State()) {
          CounterFeature()
        }
        
        await store.send(.toggleTimerButtonTapped) {
          $0.isTimerRunning = true
        }
        await store.receive(\.timerTick) {
          $0.count = 1
        }
        await store.send(.toggleTimerButtonTapped) {
          $0.isTimerRunning = false
        }
    }
}

//
//  CounterFeature.swift
//  GettingStartedWithTCA
//
//  Created by Serhan Khan on 29/08/2024.
//

import ComposableArchitecture
import SwiftUI

// Reducer that keeps state and the actions
/*
 
 */
@Reducer
struct CounterFeature {
    @ObservableState
    struct State: Equatable {
        var count = 0
        var isLoading = false
        var fact: String?
        var isTimerRunning = false
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case resetButtonTapped
        case factButtonTapped
        case factResponse(String)
        case timerTick
        case toggleTimerButtonTapped
    }
    
    @Dependency(\.continuousClock) var clock
    @Dependency(\.numberFact) var numberFact
    
    enum CancelID { case timer }
    
    var body: some ReducerOf<Self> {
        Reduce { state , action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
            case .resetButtonTapped:
                state.count = 0
                state.fact = nil
                return .none
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                return .run {/*Captures the count's current value before triggering the event*/ [count = state.count] send in
                    // ✅ Do async work in here, and send actions back into the system.
                    // 🛑 Mutable capture of 'inout' parameter 'state' is not allowed in
                    //    concurrently-executing code
                    // 🛑 'async' call in a function that does not support concurrency
                    // 🛑 Errors thrown from here are not handled
//                    let (data, _) = try await URLSession.shared
//                        .data(from: URL(string: "http://numbersapi.com/\(count)")!)
//                    let fact = String(decoding: data, as: UTF8.self)
//                    await send(.factResponse(fact))
                    
                    try await send(.factResponse(self.numberFact.fetch(count)))

                }
            case let .factResponse(fact):
                state.fact = fact
                state.isLoading = false
                return .none
                
            case .timerTick:
                state.count += 1
                state.fact = nil
                return .none
                
            case .toggleTimerButtonTapped:
                state.isTimerRunning.toggle()
                if state.isTimerRunning {
                    return .run { send in
                        //                        while true {
                        //                            try await Task.sleep(for: .seconds(1))
                        //                            await send(.timerTick)
                        //                        }
                        for await _ in self.clock.timer(interval: .seconds(1)) {
                            await send(.timerTick)
                        }
                    }.cancellable(id: CancelID.timer)
                } else {
                    return .cancel(id: CancelID.timer)
                }
                
            }
        }
    }
}



//
//  UseCase.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 30/10/22.
//

import Foundation

enum UseCase: CaseIterable {
    case singleRequest
    case sequential
    case concurrent
    case complexConcurrent
    case wrapper
    case wrapperWithError
    
    var title: String {
        switch self {
        case .singleRequest:
            return "Single Request"
        case .sequential:
            return "Sequential"
        case .concurrent:
            return "Concurrent"
        case .complexConcurrent:
            return "Complex Concurrent"
        case .wrapper:
            return "Wrapper"
        case .wrapperWithError:
            return "Wrapper with Error"
        }
    }
    
    var description: String {
        switch self {
        case .singleRequest:
            return "This is an example of how some Apple APIs have migrated many of their methods to conform to the async approach."
        case .sequential:
            return "This use case shows when we need to perform multiple async tasks when each of them is dependent on the previous one. By using a default approach based on completion we end up facing a multilevel nested logic. On the other hand, with the structured approach, we are able to keep at a single level all the logic."
        case .concurrent:
            return "This use case shows when we want to perform different async tasks in parallel, being able to know when all of them have finished."
        case .complexConcurrent:
            return "This use case adds extra complexity to the Concurrent approach, performing different requests by groups."
        case .wrapper:
            return "Just a basic example of how we are able to wrap any async task and migrate them from a completion approach to the structured one."
        case .wrapperWithError:
            return "The same as Wrapper use case but adding error cases"
        }
    }
}

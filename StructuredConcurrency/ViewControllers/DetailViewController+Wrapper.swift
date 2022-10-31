//
//  DetailViewController+Wrapper.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 30/10/22.
//

import Foundation

extension DetailViewController {
    func getRandomNumberAfter3Seconds(completion: @escaping (Int) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            let randomNumber = Int.random(in: 0..<100)
            completion(randomNumber)
        }
    }
    
    func getRandomNumberAfter3Seconds() async -> Int {
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                let randomNumber = Int.random(in: 0..<100)
                continuation.resume(with: .success(randomNumber))
            }
        }
    }
}

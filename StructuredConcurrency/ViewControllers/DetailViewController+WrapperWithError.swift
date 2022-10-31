//
//  DetailViewController+WrapperWithError.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 31/10/22.
//

import Foundation

extension DetailViewController {
    func getEvenRandomNumberAfter3Seconds(completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            let randomNumber = Int.random(in: 0..<100)
            if randomNumber.isMultiple(of: 2) {
                completion(.success(randomNumber))
            } else {
                completion(.failure(CustomError.oddNumber))
            }
        }
    }
    
    func getEvenRandomNumberAfter3Seconds() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                let randomNumber = Int.random(in: 0..<100)
                if randomNumber.isMultiple(of: 2) {
                    continuation.resume(with: .success(randomNumber))
                } else {
                    continuation.resume(with: .failure(CustomError.oddNumber))
                }
            }
        }
    }
}

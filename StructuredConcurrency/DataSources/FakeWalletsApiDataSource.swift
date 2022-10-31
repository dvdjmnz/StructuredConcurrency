//
//  FakeWalletsApiDataSource.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 30/10/22.
//

import Foundation

class FakeWalletsApiDataSource {
    // MARK: - Default Approach
    func getWalletListIds(completion: @escaping ([String]) -> Void) {
        print("🌍 FETCHING WALLET LIST IDS")
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            completion(["1", "2", "3", "4"])
        }
    }
    
    func getWalletNumberOfMovements(id: String, completion: @escaping (Int) -> Void) {
        print("🌍 FETCHING WALLET NUMBER OF MOVEMENTS")
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            switch id {
            case "1":
                completion(1)
            case "2":
                completion(2)
            case "3":
                completion(3)
            case "4":
                completion(4)
            default:
                completion(0)
            }
        }
    }
    
    func getWalletAvailableBalance(id: String, completion: @escaping (Double) -> Void) {
        print("🌍 FETCHING WALLET AVAILABLE BALANCE")
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            switch id {
            case "1":
                completion(10.0)
            case "2":
                completion(20.0)
            case "3":
                completion(30.0)
            case "4":
                completion(40.0)
            default:
                completion(0.0)
            }
        }
    }
    
    func getWalletDiscountCoupons(id: String, completion: @escaping (Int) -> Void) {
        print("🌍 FETCHING WALLET DISCOUNT COUPONS")
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            switch id {
            case "1":
                completion(1)
            case "2":
                completion(2)
            case "3":
                completion(3)
            case "4":
                completion(4)
            default:
                completion(0)
            }
        }
    }
    
    // MARK: - Structured Approach
    func getWalletListIds() async -> [String] {
        print("🌍 FETCHING WALLET LIST IDS")
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
                continuation.resume(with: .success(["1", "2", "3", "4"]))
            }
        }
    }
    
    func getWalletNumberOfMovements(id: String) async -> Int {
        print("🌍 FETCHING WALLET NUMBER OF MOVEMENTS")
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
                switch id {
                case "1":
                    continuation.resume(with: .success(1))
                case "2":
                    continuation.resume(with: .success(2))
                case "3":
                    continuation.resume(with: .success(3))
                case "4":
                    continuation.resume(with: .success(4))
                default:
                    continuation.resume(with: .success(5))
                }
            }
        }
    }
    
    func getWalletAvailableBalance(id: String) async -> Double {
        print("🌍 FETCHING WALLET AVAILABLE BALANCE")
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
                switch id {
                case "1":
                    continuation.resume(with: .success(10.0))
                case "2":
                    continuation.resume(with: .success(20.0))
                case "3":
                    continuation.resume(with: .success(30.0))
                case "4":
                    continuation.resume(with: .success(40.0))
                default:
                    continuation.resume(with: .success(0.0))
                }
            }
        }
    }
    
    func getWalletDiscountCoupons(id: String) async -> Int {
        print("🌍 FETCHING WALLET DISCOUNT COUPONS")
        return await withCheckedContinuation { continuation in
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
                switch id {
                case "1":
                    continuation.resume(with: .success(1))
                case "2":
                    continuation.resume(with: .success(2))
                case "3":
                    continuation.resume(with: .success(3))
                case "4":
                    continuation.resume(with: .success(4))
                default:
                    continuation.resume(with: .success(0))
                }
            }
        }
    }
}

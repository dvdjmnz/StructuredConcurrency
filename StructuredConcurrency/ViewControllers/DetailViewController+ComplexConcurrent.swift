//
//  DetailViewController+ComplexConcurrent.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 30/10/22.
//

import Foundation

extension DetailViewController {
    func executeComplexConcurrentDefaultApproach(completion: @escaping ([Wallet]) -> Void) {
        let apiDataSource = FakeWalletsApiDataSource()
        apiDataSource.getWalletListIds { walletIds in
            var wallets = walletIds.map { Wallet(id: $0, numberOfMovements: 0, availableBalance: 0, discountCoupons: 0) }
            let group = DispatchGroup()
            for (index, walletId) in walletIds.enumerated() {
                group.enter()
                apiDataSource.getWalletAvailableBalance(id: walletId) { availableBalance in
                    wallets[index].availableBalance = availableBalance
                    group.leave()
                }
                group.enter()
                apiDataSource.getWalletNumberOfMovements(id: walletId) { numberOfMovements in
                    wallets[index].numberOfMovements = numberOfMovements
                    group.leave()
                }
                group.enter()
                apiDataSource.getWalletDiscountCoupons(id: walletId) { discountCoupons in
                    wallets[index].discountCoupons = discountCoupons
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                completion(wallets)
            }
        }
    }
    
    func executeComplexConcurrentStructuredApproach() async -> [Wallet] {
        let apiDataSource = FakeWalletsApiDataSource()
        let walletIds = await apiDataSource.getWalletListIds()
        return await withTaskGroup(of: (String, Int, Double, Int).self) { group in
            var wallets: [Wallet] = []
            for walletId in walletIds {
                group.addTask {
                    async let numberOfMovements = apiDataSource.getWalletNumberOfMovements(id: walletId)
                    async let availableBalance = apiDataSource.getWalletAvailableBalance(id: walletId)
                    async let discountCoupons = apiDataSource.getWalletDiscountCoupons(id: walletId)
                    return await (walletId, numberOfMovements, availableBalance, discountCoupons)
                }
            }

            for await (walletId, numberOfMovements, availableBalance, discountCoupons) in group {
                let wallet = Wallet(
                    id: walletId,
                    numberOfMovements: numberOfMovements,
                    availableBalance: availableBalance,
                    discountCoupons: discountCoupons
                )
                wallets.append(wallet)
            }
            return wallets.sorted(by: { $0.id < $1.id })
        }
    }
}

//
//  DetailViewController+Concurrent.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 30/10/22.
//

import Foundation

extension DetailViewController {
    func executeConcurrentDefaultApproach(completion: @escaping (Wallet) -> Void)  {
        let apiDataSource = FakeWalletsApiDataSource()
        let walletId = "1"
        var wallet = Wallet(id: walletId, numberOfMovements: 0, availableBalance: 0, discountCoupons: 0)
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        apiDataSource.getWalletNumberOfMovements(id: walletId) { numberOfMovements in
            wallet.numberOfMovements = numberOfMovements
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        apiDataSource.getWalletAvailableBalance(id: walletId) { availableBalance in
            wallet.availableBalance = availableBalance
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        apiDataSource.getWalletDiscountCoupons(id: walletId) { discountCoupons in
            wallet.discountCoupons = discountCoupons
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .global()) {
            completion(wallet)
        }
    }
    
    func executeConcurrentStructuredApproach() async -> Wallet {
        let apiDataSource = FakeWalletsApiDataSource()
        let walletId = "1"
        async let numberOfMovementsRequest = apiDataSource.getWalletNumberOfMovements(id: walletId)
        async let availableBalanceRequest = apiDataSource.getWalletAvailableBalance(id: walletId)
        async let discountCouponsRequest = apiDataSource.getWalletDiscountCoupons(id: walletId)
        let (numberOfMovements, availableBalance, discountCoupons) = await (numberOfMovementsRequest, availableBalanceRequest, discountCouponsRequest)
        return Wallet(id: walletId, numberOfMovements: numberOfMovements, availableBalance: availableBalance, discountCoupons: discountCoupons)
    }
}

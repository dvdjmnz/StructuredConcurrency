//
//  DetailViewController.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 30/10/22.
//

import UIKit

class DetailViewController: UIViewController {
    var useCase: UseCase!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = useCase.title
        descriptionLabel.text = useCase.description
    }
    
    @IBAction func didTapDefaultApproach(_ sender: Any) {
        switch useCase! {
        case .singleRequest:
            executeSingleRequestDefaultApproach()
        case .sequential:
            executeSequentialDefaultApproach()
        case .concurrent:
            executeConcurrentDefaultApproach { wallet in
                print(wallet)
            }
        case .complexConcurrent:
            executeComplexConcurrentDefaultApproach { wallets in
                print(wallets)
            }
        case .wrapper:
            getRandomNumberAfter3Seconds { number in
                print(number)
            }
        case .wrapperWithError:
            getEvenRandomNumberAfter3Seconds { result in
                switch result {
                case let .success(number):
                    print(number)
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    @IBAction func didTapStructuredApproach(_ sender: Any) {
        Task {
            switch useCase! {
            case .singleRequest:
                await executeSingleRequestStructuredApproach()
            case .sequential:
                executeSequentialStructuredApproach()
            case .concurrent:
                let wallet = await executeConcurrentStructuredApproach()
                print(wallet)
            case .complexConcurrent:
                let wallets = await executeComplexConcurrentStructuredApproach()
                print(wallets)
            case .wrapper:
                let number = await getRandomNumberAfter3Seconds()
                print(number)
            case .wrapperWithError:
                do {
                    let number = try await getEvenRandomNumberAfter3Seconds()
                    print(number)
                } catch {
                    print(error)
                }
            }
        }
    }
}

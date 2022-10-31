//
//  DetailViewController+SingleRequest.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 30/10/22.
//

import Foundation

extension DetailViewController {
    func executeSingleRequestDefaultApproach() {
        let request = URLRequest(url: URL(string: "https://catfact.ninja/fact")!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(data)
            print(response)
            print(error)
        }.resume()
    }
    
    func executeSingleRequestStructuredApproach() async {
        let request = URLRequest(url: URL(string: "https://catfact.ninja/fact")!)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print(data)
            print(response)
        } catch {
            print(error)
        }
    }
}

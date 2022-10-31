//
//  ViewController.swift
//  StructuredConcurrency
//
//  Created by David Jiménez Guinaldo on 30/10/22.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Use cases"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let useCase = sender as? UseCase else { return }
        guard let detailViewController = segue.destination as? DetailViewController else { return }
        detailViewController.useCase = useCase
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = UseCase.allCases[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UseCase.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let useCase = UseCase.allCases[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "DetailSegue", sender: useCase)
    }
}

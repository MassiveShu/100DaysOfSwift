//
//  ViewController.swift
//  Project 7.1
//
//  Created by Max Shu on 04.11.2022.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString: String

        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }

        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: .init(url: .init(string: urlString)!)) { [weak self] data, _, _ in
                if let data = try? Data(contentsOf: url) {

                    self?.parse(json: data)
                    return
                }
            }
            showError()
            task.resume()
        }
    }

    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed. Please check your connection and try again", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()
        do {
           let jsonPetitions = try decoder.decode(Petitions.self, from: json)
                petitions = jsonPetitions.results
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        } catch {
            print("+++ \(error)")
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}


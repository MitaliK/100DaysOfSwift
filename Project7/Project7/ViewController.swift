//
//  ViewController.swift
//  Project7
//
//  Created by Mitali Kulkarni on 3/13/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filteredPetitions = [Petition]()
    var filterText = "" {
        didSet {
            filterPetitionContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPetition))
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            // We create a new Data object using its contentsOf method. This returns the content from a URL, but it might throw an error
            if let data = try? Data(contentsOf: url) {
                // we are OK to parse data
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    // MARK: - JSON Parsing
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        // ask the decoder to convert the json data into single Petitions object
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            // assign the
            petitions = jsonPetitions.results
            filteredPetitions = petitions
            tableView.reloadData()
        }
    }

    // MARK: - Selector functions
    @objc func filterPetition() {
        let ac = UIAlertController(title: "Filter by title", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let filterAction = UIAlertAction(title: "Search", style: .default) { [weak self, weak ac] _ in
            self?.filterText = ac?.textFields?[0].text ?? ""
        }
        ac.addAction(filterAction)
        present(ac, animated: true, completion: nil)
    }
    
    func filterPetitionContent() {
        if (filterText.isEmpty) {
            filteredPetitions = petitions
        } else {
            filteredPetitions = petitions.filter { $0.title.contains(filterText)}
        }
        tableView.reloadData()
    }
    
    @objc func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "The data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - Tableview DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedViewController()
        vc.detailedItem = filteredPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}


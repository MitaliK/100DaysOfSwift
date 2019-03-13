//
//  ViewController.swift
//  Project1
//
//  Created by Mitali Kulkarni on 3/2/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var picture = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view, typically from a nib.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
     
        for item in items {
            if item.hasPrefix("nssl") {
                // this is picture to be loaded
                picture.append(item)
            }
        }
        picture.sort()
    }

    // MARK:- UITableviewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picture.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = picture[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = picture[indexPath.row]
            vc.totalImages = picture.count
            vc.imageIndex = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


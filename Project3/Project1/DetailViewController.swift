//
//  DetailViewController.swift
//  Project1
//
//  Created by Mitali Kulkarni on 3/2/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var contentImage: UIImageView!
    var selectedImage: String?
    var imageIndex: Int?
    var totalImages: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let total = totalImages, let index = imageIndex {
            title = "Picture \(index) of \(total)"
        } else {
            title = selectedImage
        }
        navigationItem.largeTitleDisplayMode = .never

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            contentImage.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = contentImage.image?.jpegData(compressionQuality: 0.8) else {
                print("No Image Found!!")
                return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

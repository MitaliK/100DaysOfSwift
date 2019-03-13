//
//  ViewController.swift
//  Project6b
//
//  Created by Mitali Kulkarni on 3/3/19.
//  Copyright © 2019 Mitali Kulkarni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5 ]
//
//        for label in viewsDictionary.keys {
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//            // view = mainView of VIew Controller
//            // addContraints -> add contraints to the view
//            // withVisualFormat -> H:|[label1]| -> H: means adding horizontal layout
//            // | means edge of the view(means edge of the viewController)
//            // [label] means put label here
//            //H:|[label1]| means horizontally i want the label to go from edge of vc
//        }
//        let metrics = ["labelHeight": 88]
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
//        // V: means adding vertical layout
//        // - means space which is 10 points by default
//        // we do not have | to the end of last label, which means we are not forcing the label to be stretched until the bottom edge of VC
//        // (==88) for the labels to be 88 points in height
//        // -(>=10)-| means space must be greater than or equal to 10 points between the edge of the VC
//        // when specifying the size of a space, you need to use the - before and after the size: a simple space, -, becomes -(>=10)-.
//        // @999 makes the prority of the label height less than 1000 and when its height  changes all other lables will also have height same as the height of label1
        
        var previous : UILabel?
        for label in [label1, label2, label3, label4, label5] {
            // All the labels will have same width as the view controller's width
            // all the labels will have same height of 88 points
//            label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
//            label.heightAnchor.constraint(equalToConstant: 88).isActive = true
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            // we want is for the top anchor for each label to be equal to the bottom anchor of the previous label in the loo
            if let previous = previous {
                // we have a previous label – create a height constraint
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                // First label
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            // set the previous label to be the current one, for the next loop iteration
            previous = label
        }
        
    }
}


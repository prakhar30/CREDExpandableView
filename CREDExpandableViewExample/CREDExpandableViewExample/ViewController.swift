//
//  ViewController.swift
//  CREDExpandableViewExample
//
//  Created by Prakhar Tripathi on 31/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import CREDExpandableView

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    let buttons: [CREDButton] = [CREDButton(title: "Button 1", backgroundColor: UIColor.green),
                                 CREDButton(title: "Button 2", backgroundColor: UIColor.red)]
    let labels: [CREDLabel] = [CREDLabel(text: "This is my first view", backgroundColor: UIColor.lightGray),
                               CREDLabel(text: "This is my second view", backgroundColor: UIColor.purple)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let view = try CREDExpandableView(numberOfViews: 2)
            let credViews = CREDView(buttons: buttons, labels: labels)
            
            try view.setupViews(views: credViews)
            view.display(inView: contentView)
        } catch {
            print(error)
        }
    }
}

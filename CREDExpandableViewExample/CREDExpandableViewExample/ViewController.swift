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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let view = try CREDExpandableView(numberOfViews: 3)
        } catch {
            print(error)
        }
    }
}

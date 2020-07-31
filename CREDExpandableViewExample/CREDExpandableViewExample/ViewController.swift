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
    var credView: CREDExpandableView?
    
    let buttons: [CREDButton] = [CREDButton(title: "Loan Amount", backgroundColor: UIColor.green),
                                 CREDButton(title: "EMI customisations", backgroundColor: UIColor.red),
                                 CREDButton(title: "Finalise loan", backgroundColor: UIColor.blue)]
    let labels: [CREDLabel] = [CREDLabel(text: "Please select the loan amount", backgroundColor: UIColor.lightGray),
                               CREDLabel(text: "Please select your suitable EMI customisations", backgroundColor: UIColor.green),
                               CREDLabel(text: "Please check your summary", backgroundColor: UIColor.yellow)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            credView = try CREDExpandableView(numberOfViews: 3)
            let credViews = CREDView(buttons: buttons, labels: labels)
            
            try credView?.setupViews(views: credViews)
            credView?.delegate = self
            credView?.display(inView: contentView)
            
            credView?.getView(atIndex: 0)?.backgroundColor = UIColor.orange
            credView?.getView(atIndex: 1)?.backgroundColor = UIColor.gray
            credView?.getView(atIndex: 2)?.backgroundColor = UIColor.systemPink
        } catch {
            print(error)
        }
    }
}

extension ViewController: CREDExpandableDelegate {
    func expandableView(expanded at: Int, button: UIButton, view: UIView, label: UILabel) {
        button.setTitle(buttons[at].title, for: .normal)
    }
    
    func expandableVIew(collapsed at: Int, button: UIButton) {
        if at == 0 {
            button.setTitle("Loan amount - 50000. Click here to change", for: .normal)
        } else if at == 1 {
            button.setTitle("6 months EMI selected. Click here to change", for: .normal)
        } else {
            button.setTitle("Summary", for: .normal)
        }
    }
}

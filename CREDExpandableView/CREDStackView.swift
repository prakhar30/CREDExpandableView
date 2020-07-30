//
//  CREDStackView.swift
//  CREDExpandableView
//
//  Created by Prakhar Tripathi on 31/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit

class CREDStackView {
    static let shared = CREDStackView()
    var views: CREDView?
    var stacks = [UIStackView]()
    var expanded = [Bool]()
    
    func displayExpandableView(in view: UIView) {
        let distri: UIStackView.Distribution = .fill
        let align: UIStackView.Alignment = .fill
        
        let mainStackView = UIStackView()
        mainStackView.axis = NSLayoutConstraint.Axis.vertical
        mainStackView.distribution = distri
        mainStackView.alignment = align
        view.addSubview(mainStackView)
        
        let stackView = CREDStackView.shared.getSubStackView(distribution: distri, alignment: align, index: 0, expanded: true)
        let stackView2 = CREDStackView.shared.getSubStackView(distribution: distri, alignment: align, index: 1, expanded: false)
        let stackView3 = CREDStackView.shared.getSubStackView(distribution: distri, alignment: align, index: 2, expanded: false)
        let stackView4 = CREDStackView.shared.getSubStackView(distribution: distri, alignment: align, index: 3, expanded: false)
        
        mainStackView.addArrangedSubview(stackView)
        mainStackView.addArrangedSubview(stackView2)
        mainStackView.addArrangedSubview(stackView3)
        mainStackView.addArrangedSubview(stackView4)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        stackView3.isHidden = true
        stackView4.isHidden = true
    }
    
    func getSubStackView(distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, index: Int, expanded: Bool) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = distribution
        stackView.alignment = alignment

        let views = CREDStackView.shared.getStandardViews(superView: stackView, buttonTag: index)
        stackView.addArrangedSubview(views.0)
        stackView.addArrangedSubview(views.1)
        stackView.addArrangedSubview(views.2)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        if expanded {
            CREDStackView.shared.expanded.append(true)
        } else {
            CREDStackView.shared.expanded.append(false)
            for view in stackView.arrangedSubviews {
                if !(view is UIButton) {
                    view.isHidden = true
                }
            }
        }
        
        CREDStackView.shared.stacks.append(stackView)
        
        return stackView
    }
    
    func getStandardViews(superView: UIView, buttonTag: Int) -> (UIButton, UIView, UILabel) {
        let button = UIButton()
        if buttonTag == 0 {
            button.backgroundColor = .cyan
        } else if buttonTag == 1{
            button.backgroundColor = .green
        } else {
            button.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        }
        button.tag = buttonTag
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle("Click me \(buttonTag)", for: .normal)
        button.addTarget(self, action:#selector(self.buttonClicked(_:)), for: .touchUpInside)
        
        let smallBox = UIView()
        smallBox.backgroundColor = UIColor.blue

        let textLabel = UILabel()
        textLabel.backgroundColor = UIColor.yellow
        textLabel.text  = "Hi World \(buttonTag)"
        textLabel.textAlignment = .center
        
        return (button, smallBox, textLabel)
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        if !CREDStackView.shared.expanded[sender.tag] {
            for (i, stack) in CREDStackView.shared.stacks.enumerated() {
                if i == sender.tag {
                    // expand this
                    for view in stack.arrangedSubviews {
                        if !(view is UIButton) {
                            view.isHidden = false
                        }
                    }
                    CREDStackView.shared.expanded[i] = true
                } else {
                    // collapse other
                    for view in stack.arrangedSubviews {
                        if !(view is UIButton) {
                            view.isHidden = true
                        }
                    }
                    CREDStackView.shared.expanded[i] = false
                }
            }
            
            for i in (sender.tag+1)..<CREDStackView.shared.stacks.count {
                if i == sender.tag + 1 {
                    CREDStackView.shared.stacks[i].isHidden = false
                } else {
                    CREDStackView.shared.stacks[i].isHidden = true
                }
            }
        }
    }

}

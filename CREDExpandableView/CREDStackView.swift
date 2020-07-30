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
    var numberOfViews: Int?
    var views: CREDView?
    var stacks = [UIStackView]()
    var expanded = [Bool]()
    
    func displayExpandableView(in view: UIView) {
        let distri: UIStackView.Distribution = .fill
        let align: UIStackView.Alignment = .fill
        var expandedViewSetup = false
        
        let mainStackView = UIStackView()
        mainStackView.axis = NSLayoutConstraint.Axis.vertical
        mainStackView.distribution = distri
        mainStackView.alignment = align
        view.addSubview(mainStackView)
        
        for i in 0..<CREDStackView.shared.numberOfViews! {
            let stackView = CREDStackView.shared.getSubStackView(distribution: distri, alignment: align, index: i, expanded: !expandedViewSetup)
            mainStackView.addArrangedSubview(stackView)
            expandedViewSetup = true
        }
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        if numberOfViews ?? 0 > 2 {
            for i in 2..<numberOfViews! {
                CREDStackView.shared.stacks[i].isHidden = true
            }
        }
    }
    
    func getSubStackView(distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, index: Int, expanded: Bool) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = distribution
        stackView.alignment = alignment

        let views = CREDStackView.shared.getStandardViews(superView: stackView, index: index)
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
    
    func getStandardViews(superView: UIView, index: Int) -> (UIButton, UIView, UILabel) {
        let button = UIButton()
        if index == 0 {
            button.backgroundColor = .cyan
        } else if index == 1{
            button.backgroundColor = .green
        } else {
            button.backgroundColor = UIColor.red.withAlphaComponent(0.7)
        }
        button.tag = index
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitle(CREDStackView.shared.views!.buttons[index].title, for: .normal)
        button.backgroundColor = CREDStackView.shared.views!.buttons[index].backgroundColor
        button.addTarget(self, action:#selector(self.buttonClicked(_:)), for: .touchUpInside)
        
        let smallBox = UIView()
        smallBox.backgroundColor = UIColor.clear

        let textLabel = UILabel()
        textLabel.backgroundColor = CREDStackView.shared.views!.labels[index].backgroundColor
        textLabel.text  = CREDStackView.shared.views!.labels[index].text
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

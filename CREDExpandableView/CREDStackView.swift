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
    var viewContainers = [CREDStackContainer]()
    weak var delegate: ExpandableViewDelegate?
    
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
        
        let firstContainters = CREDStackView.shared.viewContainers[0]
        CREDStackView.shared.delegate?.expandableView(expanded: 0,
                                                      button: firstContainters.button,
                                                      view: firstContainters.view,
                                                      label: firstContainters.label)
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
        
        let containerElements = CREDStackContainer(label: views.2, button: views.0, view: views.1)
        CREDStackView.shared.viewContainers.append(containerElements)
                
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
            var viewCollapsing: (() -> ())?

            // find expanded stack
            var expandedStackIndex = 0
            for (i, isExpanded) in CREDStackView.shared.expanded.enumerated() {
                if isExpanded {
                    expandedStackIndex = i
                }
            }
            // collapse expanded view
            viewCollapsing = {
                for view in CREDStackView.shared.stacks[expandedStackIndex].arrangedSubviews {
                    if !(view is UIButton) {
                        view.isHidden = true
                    }
                }
            }
            CREDStackView.shared.expanded[expandedStackIndex] = false
            let containerViews = CREDStackView.shared.viewContainers[expandedStackIndex]
            
            // expand clicked stack
            let stack = CREDStackView.shared.stacks[sender.tag]
            let viewExpanding = {
                for view in stack.arrangedSubviews {
                    if !(view is UIButton) {
                        view.isHidden = false
                    }
                }
            }
            CREDStackView.shared.expanded[sender.tag] = true
            let expandedContainerViews = CREDStackView.shared.viewContainers[sender.tag]
            
            
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.4)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
            CATransaction.setCompletionBlock {
                CREDStackView.shared.delegate?.expandableVIew(collapsed: expandedStackIndex, button: containerViews.button)
                CREDStackView.shared.delegate?.expandableView(expanded: sender.tag,
                                                              button: expandedContainerViews.button,
                                                              view: expandedContainerViews.view,
                                                              label: expandedContainerViews.label)
                
                for i in (sender.tag+1)..<CREDStackView.shared.stacks.count {
                    if i == sender.tag + 1 {
                        CREDStackView.shared.stacks[i].isHidden = false
                    } else {
                        CREDStackView.shared.stacks[i].isHidden = true
                    }
                }
            }
            
            UIView.animate(withDuration: 0.4) {
                viewExpanding()
                viewCollapsing?()
            }
            
            CATransaction.commit()
        }
    }

}

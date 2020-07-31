//
//  CREDExpandableViewProtocol.swift
//  CREDExpandableView
//
//  Created by Prakhar Tripathi on 31/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit

// Private protocol
protocol ExpandableViewDelegate: class {
    func expandableView(expanded at: Int, button: UIButton, view: UIView, label: UILabel)
    func expandableVIew(collapsed at: Int, button: UIButton)
}

// Public facing protocol
public protocol CREDExpandableDelegate: class {
    func expandableView(expanded at: Int, button: UIButton, view: UIView, label: UILabel)
    func expandableVIew(collapsed at: Int, button: UIButton)
}

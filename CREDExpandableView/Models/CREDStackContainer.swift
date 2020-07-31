//
//  CREDStackContainer.swift
//  CREDExpandableView
//
//  Created by Prakhar Tripathi on 31/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit

class CREDStackContainer {
    var label: UILabel
    var button: UIButton
    var view: UIView
    
    init(label: UILabel, button: UIButton, view: UIView) {
        self.label = label
        self.button = button
        self.view = view
    }
}

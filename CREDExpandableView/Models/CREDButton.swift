//
//  CREDButton.swift
//  CREDExpandableView
//
//  Created by Prakhar Tripathi on 31/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit

public struct CREDButton {
    var title: String
    var backgroundColor: UIColor = UIColor.clear
    
    public init(title: String, backgroundColor: UIColor = UIColor.clear) {
        self.title = title
        self.backgroundColor = backgroundColor
    }
}

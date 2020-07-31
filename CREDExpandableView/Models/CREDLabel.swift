//
//  CREDLabel.swift
//  CREDExpandableView
//
//  Created by Prakhar Tripathi on 31/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit

public struct CREDLabel {
    public var text: String
    public var backgroundColor: UIColor = UIColor.clear
    
    public init(text: String, backgroundColor: UIColor = UIColor.clear) {
        self.text = text
        self.backgroundColor = backgroundColor
    }
}

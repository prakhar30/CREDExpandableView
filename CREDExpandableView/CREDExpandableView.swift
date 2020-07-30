//
//  CREDExpandableView.swift
//  CREDExpandableView
//
//  Created by Prakhar Tripathi on 31/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

@objc(CREDExpandableView)
public class CREDExpandableView: NSObject {
    
    var numberOfViews: Int
    
    public init(numberOfViews: Int) throws {
        if numberOfViews >= CREDConfig.kMinimumViews && numberOfViews <= CREDConfig.kMaximumViews {
            self.numberOfViews = numberOfViews
        } else {
            throw CREDError.wrongInitialisation(ErrorConstants.kWrongInitialisation)
        }
    }
}

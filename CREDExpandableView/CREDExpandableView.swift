//
//  CREDExpandableView.swift
//  CREDExpandableView
//
//  Created by Prakhar Tripathi on 31/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit

@objc(CREDExpandableView)
public class CREDExpandableView: NSObject {
    
    private var numberOfViews: Int
    
    /// Initialise the CREDExpandable view with the required number of views
    public init(numberOfViews: Int) throws {
        if numberOfViews >= CREDConfig.kMinimumViews && numberOfViews <= CREDConfig.kMaximumViews {
            self.numberOfViews = numberOfViews
        } else {
            throw CREDError.wrongInitialisation(ErrorConstants.kWrongInitialisation)
        }
    }
    
    /// Setup the CREDExpandable view by massing in an array of the type CREDView which will configure your labels and buttons on the expandable view. Please note, pass in the exact number of values in the array as you have used to initialise the CREDExpandableView. Also, the order in which you pass these values will be maintained while creating the view.
    public func setupViews(views: CREDView) throws {
        if numberOfViews >= CREDConfig.kMinimumViews && numberOfViews <= CREDConfig.kMaximumViews {
            CREDStackView.shared.views = views
            CREDStackView.shared.numberOfViews = numberOfViews
        } else {
            throw CREDError.wrongSetup(ErrorConstants.kWrongNumberOfViewsPassed)
        }
    }
    
    /// Display the CREDExpandableView in the view passed as a parameter. The views are added subviews of the passed view.
    public func display(inView: UIView) {
        CREDStackView.shared.displayExpandableView(in: inView)
    }
}

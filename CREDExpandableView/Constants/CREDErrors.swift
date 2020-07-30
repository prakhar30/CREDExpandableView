//
//  Errors.swift
//  CREDExpandableView
//
//  Created by Prakhar Tripathi on 31/07/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation

enum CREDError: Error {
    case wrongInitialisation(String)
    case wrongSetup(String)
}

class ErrorConstants {
    static let kWrongInitialisation = "You can initialise the exapandable view with a minimum of 2 and a maximum of 4 stacks."
    static let kWrongNumberOfViewsPassed = "You have passed the wrong number of CREDViews to setup the CREDExpandableView. Please pass in the exact number of views with which you initialised the CREDExpandable view."
}

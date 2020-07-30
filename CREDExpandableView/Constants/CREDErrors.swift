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
}

class ErrorConstants {
    static let kWrongInitialisation = "You can initialise the exapandable view with a minimum of 2 and a maximum of 4 stacks."
}

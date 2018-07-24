//
//  Utis.swift
//  Flat-Land-Client
//
//  Created by Zackory Cramer on 7/23/18.
//  Copyright © 2018 Zackori Cui. All rights reserved.
//

import Foundation

extension CGVector{
    static func +(_ lhs:CGVector, _ rhs:CGVector) -> CGVector{
        return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy)
    }
}

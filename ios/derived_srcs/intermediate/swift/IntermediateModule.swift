//
//  IntermediateModule.swift
//  IntermediateModule
//
//  Created by jforbes on 6/9/23.
//

import Foundation
import Numerics

@objc public class IntermediateModuleClass: NSObject {
    @objc public static func doSomethingWithNumerics() {
        let numericsType = 5.0
        print(numericsType.reciprocal ?? 0)
    }
}

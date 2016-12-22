//
//  Enums.swift
//  E-testing
//
//  Created by Ondřej David on 07.09.16.
//  Copyright © 2016 Ondřej David. All rights reserved.
//

import Foundation
import UIKit

enum TestResult{
    case success
    case fail
    case notTested
    
    var color: UIColor {
    switch self {
        case .success: return UIColor(red: 45/255, green: 152/255, blue: 171/255, alpha: 1.0)
        case .fail: return UIColor(red: 151/255, green: 40/255, blue: 90/255, alpha: 1.0)
        case .notTested: return UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0)
    }
    }
}





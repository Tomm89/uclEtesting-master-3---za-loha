//
//  SubjectModel.swift
//  E-testing
//
//  Created by Ondřej David on 09.08.16.
//  Copyright © 2016 Ondřej David. All rights reserved.
//

import Foundation
import UIKit

class Subject {
    
    var name: String
    var rating: Int
    var tested: Bool
    
    init(name: String, rating: Int, tested: Bool) {
        self.name = name
        self.rating = rating
        self.tested = tested
    }
    

}

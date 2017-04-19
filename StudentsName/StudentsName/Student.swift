//
//  Student.swift
//  StudentsName
//
//  Created by ALIA M NEELY on 4/19/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation

struct Student {
    let name: String
}


//MARK: - JSON

extension Student {
    
    static let nameKey = "name"
    
    init?(studentsDictionary: [String: String]) {
        // dont need to cast it as? becasue we didnt use [String:Any]
        guard let name = studentsDictionary[Student.nameKey] else { return nil }
        self.init(name: name)
    }
    
    var studentDictionaryRepresentation: [String: String] {
        return[Student.nameKey: name]
    }
    
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: studentDictionaryRepresentation, options: .prettyPrinted)
    }
    
    
    
}





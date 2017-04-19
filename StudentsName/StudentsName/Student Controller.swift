//
//  Student Controller.swift
//  StudentsName
//
//  Created by ALIA M NEELY on 4/19/17.
//  Copyright © 2017 Wylan. All rights reserved.
//

import Foundation


class StudentController {
    
    //BAse URL
    
    static let baseURl = URL(string: "https://survey-10929.firebaseio.com/students")
    
    
    static func fetchStudents(completion: @escaping ([Student]) -> Void) {
        
        
        // add the parameters to the base url to prep it to fetch the students
        
        guard let url = baseURl?.appendingPathComponent(".json") else {fatalError("URL is NIl") }
        
        //perform the get request
        
        NetworkController.performRequest(for: url, httpMethod: .get) {data, error in
            guard let data = data else {completion([]); return }
            // grab the students dictionary from the data
            guard let studentsDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String:[String:String]] else {return}
            //create student object grabbign the
            
            let students = studentsDictionary.flatMap{ Student(studentsDictionary: $0.value) }
            completion(students)
        
        }
        
        
    }
    
    //Put 
    static func send(studentWithName name: String, completion: ((_ success: Bool) -> Void)? = nil) {
        
        let student = Student(name: name)
        
        //append the parameter" /" name and the extesion of json
        guard let url = baseURl?.appendingPathComponent(name).appendingPathExtension(".json") else {return}
        
        // put the student onto the web
        
        NetworkController.performRequest(for: url, httpMethod: .put, body: student.jsonData) {data, error in
            
            var success = false
            defer{ completion?(success) }
            
 
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8) else { return }
            
            if error != nil {
                print("Error: \(String(describing: error))")
            } else if responseDataString.contains("error") {
                print("Error: \(responseDataString)")
            } else {
                print("Success: \(responseDataString)")
                success = true
            }
            
            
        }
        
        
        
    }
    
    
    
}


























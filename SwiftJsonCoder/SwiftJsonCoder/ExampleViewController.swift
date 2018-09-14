//
//  ExampleViewController.swift
//  SwiftJsonCoder
//
//  Created by Ligo on 2018/1/6.
//  Copyright © 2018年 Ligo. All rights reserved.
//

import UIKit

class People: NSObject, Codable{
    var peopleName: String?
    var identifyID: String?
    var age: Int?
    var houses: Array<House>?
}

struct House: Codable{
    var houseName: String?
    var housePrice: Int?
}



class ExampleViewController: UIViewController {

    let peopleJsonStr = """
    {
    "peopleName" : "peopleName1",
    "identifyID" : "abc",
    "age" : 20,
    "houses":[
                {
                    "houseName" : "houseName1",
                    "housePrice" : 200000
                },
                {
                    "houseName" : "houseName2",
                    "housePrice" : 300000
                }
            ]
    }
"""
    
    
    let peopleArrayJsonStr = """
[
    {
    "peopleName" : "peopleName1",
    "identifyID" : "abc",
    "age" : 20,
    "houses":[
                {
                    "houseName" : "houseName1",
                    "housePrice" : 200000
                },
                {
                    "houseName" : "houseName2",
                    "housePrice" : 300000
                }
            ]
    },
    {
    "peopleName" : "peopleName2",
    "identifyID" : "def",
    "age" : 40,
    "houses":[
                {
                    "houseName" : "houseName3",
                    "housePrice" : 600000
                },
                {
                    "houseName" : "houseName4",
                    "housePrice" : 800000
                }
            ]
    }
]
"""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //jsonString to custom object
        let jsonStringToPeople = SwiftJsonCoder.shared.object(fromJsonObject: peopleJsonStr, objectType: People.self)
        if jsonStringToPeople != nil {
            print("jsonStringToPeople:\npeopleName: \(jsonStringToPeople?.peopleName ?? "--")\nage: \(jsonStringToPeople?.age ?? 0)")
            if jsonStringToPeople?.houses != nil
            {
                for house in (jsonStringToPeople?.houses)!
                {
                    print("\thouseName: \(house.houseName ?? "--") , housePrice: \(house.housePrice ?? 0)")
                }
            }
            
            
            //custom object to jsonString
            let objectToJsonString = SwiftJsonCoder.shared.jsonString(fromAny: jsonStringToPeople)
            print("\npeopleToJsonString:\n\(objectToJsonString)\n")
        }
        
        /*
        //jsonString to collection(Dictionary)
        let dic = SwiftJsonCoder.shared.collectionType(fromJsonObject: peopleJsonStr, objectType: Dictionary<String,Any>.self)
        if dic != nil {
            print("\njsonStringToDictionary:\n\(dic!)")
            
            //Dictionary to custom object
            let dictionaryToPeople = SwiftJsonCoder.shared.object(fromJsonObject: dic, objectType: People.self)
            if dictionaryToPeople != nil {
                print("\nDictionaryToPeople:\npeopleName: \(dictionaryToPeople?.peopleName ?? "--")\nage: \(dictionaryToPeople?.age ?? 0)")
                if dictionaryToPeople?.houses != nil
                {
                    for house in (dictionaryToPeople?.houses)!
                    {
                        print("\thouseName: \(house.houseName ?? "--") , housePrice: \(house.housePrice ?? 0)")
                    }
                }
            }
        }
        */
        //jsonString(Array) to custom object Array
        let jsonStringToPeopleArray = SwiftJsonCoder.shared.object(fromJsonObject: peopleArrayJsonStr, objectType: [People].self)
        if jsonStringToPeopleArray != nil && !(jsonStringToPeopleArray?.isEmpty)! {
            print("\n\n\njsonStringToPeopleArray:")
            for peo in jsonStringToPeopleArray!
            {
                print("peopleName: \(peo.peopleName ?? "--")\nage: \(peo.age ?? 0)")
                if peo.houses != nil
                {
                    for house in (peo.houses)!
                    {
                        print("\thouseName: \(house.houseName ?? "--") , housePrice: \(house.housePrice ?? 0)")
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tmpFunc() {
        print("tmpFunc")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

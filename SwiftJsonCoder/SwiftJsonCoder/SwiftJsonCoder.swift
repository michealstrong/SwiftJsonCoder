//
//  SwiftJsonCoder.swift
//  SwiftJsonCoder
//
//  Created by Ligo on 2018/1/6.
//  Copyright © 2018年 Ligo. All rights reserved.
//

import UIKit

let encounterEncodeFailKey = "Encode_Fail"

class SwiftJsonCoder {
    let encoder: JSONEncoder!
    let decoder: JSONDecoder!
    static let shared = SwiftJsonCoder()
    private init()
    {
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }
    
    
    /// to reset single inatance SwiftJsonParser's properties
    func reset()
    {
        
    }
    
    
    /// convert the  <T: Any> object to String
    /// - Parameter object: any class conforms 'Encodable' or 'Codable' and  struct conforms 'Encodable' or 'Codable'
    /// - Returns: String
    func jsonString<T: Any>(fromAny object: T) -> String where T : Encodable
    {
        let data: Data? = self.jsonData(fromAny: object)
        if data != nil {
            return String.init(data: data!, encoding: String.Encoding.utf8)!
        }
        return encounterEncodeFailKey
    }
    
    
    /// convert the  <T: Any> object to Data
    ///
    /// - Parameter object: any class conforms 'Encodable' or 'Codable' and  struct conforms 'Encodable' or 'Codable'
    /// - Returns: Data or nil
    func jsonData<T: Any>(fromAny object: T) -> Data? where T : Encodable
    {
        return try? self.encoder.encode(object)
    }
    
    
    /// convert the jsonData to the <T> object
    ///
    /// - Parameters:
    ///   - jsonData: the given Data must be a valid jsonData
    ///   - objectType: Any conform 'Decodable' or 'Codable'
    /// - Returns: Returns <T> object or nil
    func object<T>(fromJsonData jsonData: Data!, objectType: T.Type) -> T? where T : Decodable
    {
        let obj = try? self.decoder.decode(T.self, from: jsonData)
        return obj
    }
    
    /// convert the jsonStr to the <T> object
    ///
    /// - Parameters:
    ///   - jsonStr: the given String must be a valid json
    ///   - objectType: Any conform 'Decodable' or 'Codable'
    /// - Returns: Returns <T> object or nil
    func object<T>(fromJsonString jsonString: String!, objectType: T.Type) -> T? where T : Decodable
    {
        return self.object(fromJsonData: jsonString.data(using: String.Encoding.utf8)!, objectType: objectType)
    }
    
    ///   convert the dictionary to the <T> object
    ///
    /// - Parameters:
    ///   - dictionary: the given dictionary must be a valid json object, The dictionary must have the following properties
    ///     - All value are NSString, NSNumber, NSArray, NSDictionary, or NSNull
    ///     - All keys are NSStrings
    ///     - NSNumbers are not NaN or infinity
    ///   - objectType: Any conforms 'Decodable' or 'Codable'
    /// - Returns: Returns <T> object or nil
    func object<T>(fromDictionary dictionary: Dictionary<String,Any>!, objectType: T.Type) -> T? where T : Decodable
    {
        guard JSONSerialization.isValidJSONObject(dictionary) else {
            return nil
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        if jsonData != nil {
            let obj = try? self.decoder.decode(T.self, from: jsonData!)
            return obj
        }
        return nil
    }
    
    
    
    /// convert the given jsonData to the collectionTypes<T>. eg: Dictionary,Array
    ///
    /// - Parameters:
    ///   - jsonData: the given Data must be a valid jsonData
    ///   - objectType: collectionTypes conform 'Decodable' or 'Codable'
    /// - Returns: the expected collectionType or nil
    func collectionType<T>(fromJsonData jsonData: Data!, objectType: T.Type) -> T? where T : Decodable
    {
        return try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! T
    }
    
    
    
    /// convert the given jsonString to the collectionTypes<T>. eg: Dictionary,Array
    ///
    /// - Parameters:
    ///   - jsonString: the given String must be a valid json
    ///   - objectType: collectionTypes conform 'Decodable' or 'Codable'
    /// - Returns: the expected collectionType or nil
    func collectionType<T>(fromJsonString jsonString: String!, objectType: T.Type) -> T? where T : Decodable
    {
        return self.collectionType(fromJsonData: jsonString.data(using: String.Encoding.utf8), objectType: objectType)
    }
    
}

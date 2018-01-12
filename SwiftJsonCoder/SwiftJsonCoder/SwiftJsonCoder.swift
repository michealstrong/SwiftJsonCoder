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
        self.encoder.outputFormatting = .prettyPrinted
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
    
    /// convert the jsonObject to the <T> object
    ///
    /// - Parameters:
    ///   - jsonObject: can be 'Data','String','Dictionary<String,Any>' ,and only these three type
    ///   - objectType: Any conform 'Decodable' or 'Codable'
    /// - Returns: Returns <T> object or nil
    func object<T>(fromJsonObject jsonObject: Any!, objectType: T.Type) -> T? where T : Decodable
    {
        if jsonObject is Data {
            return try? self.decoder.decode(T.self, from: jsonObject as! Data)
        }
        else if jsonObject is String
        {
            if let data = (jsonObject as! String).data(using: .utf8)
            {
                return try? self.decoder.decode(T.self, from: data)
            }
        }
        else if jsonObject is Dictionary<String,Any>
        {
            let dictionary = jsonObject as! Dictionary<String,Any>
            guard JSONSerialization.isValidJSONObject(dictionary) else {
                return nil
            }
            if let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            {
                return try? self.decoder.decode(T.self, from: data)
            }
        }
        return nil
    }
    
    /// convert the given jsonData to the collectionTypes<T>. eg: Dictionary,Array
    ///
    /// - Parameters:
    ///   - jsonObject: can be 'Data','String' ,and only these two type
    ///   - objectType: collectionTypes conform 'Decodable' or 'Codable'
    /// - Returns: the expected collectionType or nil
    func collectionType<T>(fromJsonObject jsonObject: Any!, objectType: T.Type) -> T? where T : Decodable
    {
        if jsonObject is Data
        {
            return try? JSONSerialization.jsonObject(with: jsonObject as! Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! T
        }
        else if jsonObject is String
        {
            if let data = (jsonObject as! String).data(using: .utf8)
            {
                return try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! T
            }
            
        }
        return nil
    }
}

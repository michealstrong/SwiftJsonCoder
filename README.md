# SwiftJsonCoder
Swift Json Coder
a tool makes developers more convenient to convert json to object(including class,struct,collectionTypes...) and vice versa in swift;
actually i just use a singleton manager class to encapsulate the official tool class:JSONEncoder and JSONDecoder;
warnimg：all the object must comform "Encodable"(convert object to json) or "Decodable"(convert json to object), directly you can just comform "Codable"，meanning comform both of them.

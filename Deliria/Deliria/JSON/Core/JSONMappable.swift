//
//  Mappable.swift
//  ObjectMapper
//
//  Created by Scott Hoyt on 10/25/15.
//  Copyright © 2015 hearst. All rights reserved.
//

import Foundation

public protocol JSONMappable {
	/// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
	init?(_ map: JSONMap)
	/// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
	mutating func mapping(map: JSONMap)
	/// This is an optional function that can be used to:
	///		1) provide an existing cached object to be used for mapping
	///		2) return an object of another class (which conforms to Mappable) to be used for mapping. For instance, you may inspect the JSON to infer the type of object that should be used for any given mapping
	static func objectForMapping(map: JSONMap) -> JSONMappable?
}

public extension JSONMappable {

	public static func objectForMapping(map: JSONMap) -> JSONMappable? {
		return nil
	}

	/// Initializes object from a JSON String
	public init?(JSONString: String) {
		if let obj: Self = JSONMapper().map(JSONString) {
			self = obj
		} else {
			return nil
		}
	}

	/// Initializes object from a JSON Dictionary
	public init?(JSON: [String : AnyObject]) {
		if let obj: Self = JSONMapper().map(JSON) {
			self = obj
		} else {
			return nil
		}
	}

	/// Returns the JSON Dictionary for the object
	public func toJSON() -> [String: AnyObject] {
		return JSONMapper().toJSON(self)
	}

	/// Returns the JSON String for the object
	public func toJSONString(prettyPrint: Bool = false) -> String? {
		return JSONMapper().toJSONString(self, prettyPrint: prettyPrint)
	}
}

public extension Array where Element: JSONMappable {

	/// Initialize Array from a JSON String
	public init?(JSONString: String) {
		if let obj: [Element] = JSONMapper().mapArray(JSONString) {
			self = obj
		} else {
			return nil
		}
	}

	/// Initialize Array from a JSON Array
	public init?(JSONArray: [[String : AnyObject]]) {
		if let obj: [Element] = JSONMapper().mapArray(JSONArray) {
			self = obj
		} else {
			return nil
		}
	}

	/// Returns the JSON Array
	public func toJSON() -> [[String : AnyObject]] {
		return JSONMapper().toJSONArray(self)
	}

	/// Returns the JSON String for the object
	public func toJSONString(prettyPrint: Bool = false) -> String? {
		return JSONMapper().toJSONString(self, prettyPrint: prettyPrint)
	}
}

public extension Set where Element: JSONMappable {

	/// Initializes a set from a JSON String
	public init?(JSONString: String) {
		if let obj: Set<Element> = JSONMapper().mapSet(JSONString) {
			self = obj
		} else {
			return nil
		}
	}

	/// Initializes a set from JSON
	public init?(JSONArray: [[String : AnyObject]]) {
		if let obj: Set<Element> = JSONMapper().mapSet(JSONArray) {
			self = obj
		} else {
			return nil
		}
	}

	/// Returns the JSON Set
	public func toJSON() -> [[String : AnyObject]] {
		return JSONMapper().toJSONSet(self)
	}

	/// Returns the JSON String for the object
	public func toJSONString(prettyPrint: Bool = false) -> String? {
		return JSONMapper().toJSONString(self, prettyPrint: prettyPrint)
	}
}

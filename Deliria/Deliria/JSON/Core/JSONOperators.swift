//
//  Operators.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-09.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2015 Hearst
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

/**
* This file defines a new operator which is used to create a mapping between an object and a JSON key value.
* There is an overloaded operator definition for each type of object that is supported in ObjectMapper.
* This provides a way to add custom logic to handle specific types of objects
*/

infix operator <- {}

// MARK:- Objects with Basic types

/// Object of Basic type
public func <- <T>(inout left: T, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.basicType(&left, object: right.value())
	case .ToJSON:
		MappingToJSON.basicType(left, map: right)
	default: ()
	}
}

/// Optional object of basic type
public func <- <T>(inout left: T?, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalBasicType(&left, object: right.value())
	case .ToJSON:
		MappingToJSON.optionalBasicType(left, map: right)
	default: ()
	}
}

/// Implicitly unwrapped optional object of basic type
public func <- <T>(inout left: T!, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalBasicType(&left, object: right.value())
	case .ToJSON:
		MappingToJSON.optionalBasicType(left, map: right)
	default: ()
	}
}

// MARK:- Raw Representable types

/// Object of Raw Representable type
public func <- <T: RawRepresentable>(inout left: T, right: JSONMap) {
	left <- (right, JSONEnumTransform())
}

/// Optional Object of Raw Representable type
public func <- <T: RawRepresentable>(inout left: T?, right: JSONMap) {
	left <- (right, JSONEnumTransform())
}

/// Implicitly Unwrapped Optional Object of Raw Representable type
public func <- <T: RawRepresentable>(inout left: T!, right: JSONMap) {
	left <- (right, JSONEnumTransform())
}

// MARK:- Arrays of Raw Representable type

/// Array of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [T], right: JSONMap) {
	left <- (right, JSONEnumTransform())
}

/// Array of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [T]?, right: JSONMap) {
	left <- (right, JSONEnumTransform())
}

/// Array of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [T]!, right: JSONMap) {
	left <- (right, JSONEnumTransform())
}

// MARK:- Dictionaries of Raw Representable type

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [String: T], right: JSONMap) {
	left <- (right, JSONEnumTransform())
}

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [String: T]?, right: JSONMap) {
	left <- (right, JSONEnumTransform())
}

/// Dictionary of Raw Representable object
public func <- <T: RawRepresentable>(inout left: [String: T]!, right: JSONMap) {
	left <- (right, JSONEnumTransform())
}

// MARK:- Transforms

/// Object of Basic type with Transform
public func <-<Transform: JSONTransformType>(inout left: Transform.Object, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let value = transform.transformFromJSON(map.currentValue)
		MappingFromJSON.basicType(&left, object: value)
	case .ToJSON:
		let value: Transform.JSON? = transform.transformToJSON(left)
		MappingToJSON.optionalBasicType(value, map: map)
	default: ()
	}
}

/// Optional object of basic type with Transform
public func <-<Transform: JSONTransformType>(inout left: Transform.Object?, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let value = transform.transformFromJSON(map.currentValue)
		MappingFromJSON.optionalBasicType(&left, object: value)
	case .ToJSON:
		let value: Transform.JSON? = transform.transformToJSON(left)
		MappingToJSON.optionalBasicType(value, map: map)
	default: ()
	}
}

/// Implicitly unwrapped optional object of basic type with Transform
public func <-<Transform: JSONTransformType>(inout left: Transform.Object!, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let value = transform.transformFromJSON(map.currentValue)
		MappingFromJSON.optionalBasicType(&left, object: value)
	case .ToJSON:
		let value: Transform.JSON? = transform.transformToJSON(left)
		MappingToJSON.optionalBasicType(value, map: map)
	default: ()
	}
}

/// Array of Basic type with Transform
public func <-<Transform: JSONTransformType>(inout left: [Transform.Object], right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		MappingFromJSON.basicType(&left, object: values)
	case .ToJSON:
		let values = toJSONArrayWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(values, map: map)
	default: ()
	}
}

/// Optional array of Basic type with Transform
public func <-<Transform: JSONTransformType>(inout left: [Transform.Object]?, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		MappingFromJSON.optionalBasicType(&left, object: values)
	case .ToJSON:
		let values = toJSONArrayWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(values, map: map)
	default: ()
	}
}

/// Implicitly unwrapped optional array of Basic type with Transform
public func <-<Transform: JSONTransformType>(inout left: [Transform.Object]!, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let values = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		MappingFromJSON.optionalBasicType(&left, object: values)
	case .ToJSON:
		let values = toJSONArrayWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(values, map: map)
	default: ()
	}
}

/// Dictionary of Basic type with Transform
public func <-<Transform: JSONTransformType>(inout left: [String: Transform.Object], right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
		MappingFromJSON.basicType(&left, object: values)
	case .ToJSON:
		let values = toJSONDictionaryWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(values, map: map)
	default: ()
	}
}

/// Optional dictionary of Basic type with Transform
public func <-<Transform: JSONTransformType>(inout left: [String: Transform.Object]?, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
		MappingFromJSON.optionalBasicType(&left, object: values)
	case .ToJSON:
		let values = toJSONDictionaryWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(values, map: map)
	default: ()
	}
}

/// Implicitly unwrapped optional dictionary of Basic type with Transform
public func <-<Transform: JSONTransformType>(inout left: [String: Transform.Object]!, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let values = fromJSONDictionaryWithTransform(map.currentValue, transform: transform)
		MappingFromJSON.optionalBasicType(&left, object: values)
	case .ToJSON:
		let values = toJSONDictionaryWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(values, map: map)
	default: ()
	}
}

private func fromJSONArrayWithTransform<Transform: JSONTransformType>(input: AnyObject?, transform: Transform) -> [Transform.Object]? {
	if let values = input as? [AnyObject] {
		return values.flatMap { value in
			return transform.transformFromJSON(value)
		}
	} else {
		return nil
	}
}

private func fromJSONDictionaryWithTransform<Transform: JSONTransformType>(input: AnyObject?, transform: Transform) -> [String: Transform.Object]? {
	if let values = input as? [String: AnyObject] {
		return values.filterMap { value in
			return transform.transformFromJSON(value)
		}
	} else {
		return nil
	}
}

private func toJSONArrayWithTransform<Transform: JSONTransformType>(input: [Transform.Object]?, transform: Transform) -> [Transform.JSON]? {
	return input?.flatMap { value in
		return transform.transformToJSON(value)
	}
}

private func toJSONDictionaryWithTransform<Transform: JSONTransformType>(input: [String: Transform.Object]?, transform: Transform) -> [String: Transform.JSON]? {
	return input?.filterMap { value in
		return transform.transformToJSON(value)
	}
}

// MARK:- Mappable Objects - <T: Mappable>

/// Object conforming to Mappable
public func <-<T: JSONMappable>(inout left: T, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON:
		MappingFromJSON.object(&left, map: right)
	case .ToJSON:
		MappingToJSON.object(left, map: right)
	}
}

/// Optional Mappable objects
public func <-<T: JSONMappable>(inout left: T?, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalObject(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalObject(left, map: right)
	default: ()
	}
}

/// Implicitly unwrapped optional Mappable objects
public func <-<T: JSONMappable>(inout left: T!, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalObject(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalObject(left, map: right)
	default: ()
	}
}

// MARK:- Transforms of Mappable Objects - <T: Mappable>

/// Object conforming to Mappable that have transforms
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Transform.Object, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let value: Transform.Object? = transform.transformFromJSON(map.currentValue)
		MappingFromJSON.basicType(&left, object: value)
	case .ToJSON:
		let value: Transform.JSON? = transform.transformToJSON(left)
		MappingToJSON.optionalBasicType(value, map: map)
	default: ()
	}
}

/// Optional Mappable objects that have transforms
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Transform.Object?, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let value: Transform.Object? = transform.transformFromJSON(map.currentValue)
		MappingFromJSON.optionalBasicType(&left, object: value)
	case .ToJSON:
		let value: Transform.JSON? = transform.transformToJSON(left)
		MappingToJSON.optionalBasicType(value, map: map)
	default: ()
	}
}

/// Implicitly unwrapped optional Mappable objects that have transforms
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Transform.Object!, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let value: Transform.Object? = transform.transformFromJSON(map.currentValue)
		MappingFromJSON.optionalBasicType(&left, object: value)
	case .ToJSON:
		let value: Transform.JSON? = transform.transformToJSON(left)
		MappingToJSON.optionalBasicType(value, map: map)
	default: ()
	}
}

// MARK:- Dictionary of Mappable objects - Dictionary<String, T: Mappable>

/// Dictionary of Mappable objects <String, T: Mappable>
public func <-<T: JSONMappable>(inout left: Dictionary<String, T>, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.objectDictionary(&left, map: right)
	case .ToJSON:
		MappingToJSON.objectDictionary(left, map: right)
	default: ()
	}
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
public func <-<T: JSONMappable>(inout left: Dictionary<String, T>?, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalObjectDictionary(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalObjectDictionary(left, map: right)
	default: ()
	}
}

/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
public func <-<T: JSONMappable>(inout left: Dictionary<String, T>!, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalObjectDictionary(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalObjectDictionary(left, map: right)
	default: ()
	}
}

/// Dictionary of Mappable objects <String, T: Mappable>
public func <-<T: JSONMappable>(inout left: Dictionary<String, [T]>, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.objectDictionaryOfArrays(&left, map: right)
	case .ToJSON:
		MappingToJSON.objectDictionaryOfArrays(left, map: right)
	default: ()
	}
}

/// Optional Dictionary of Mappable object <String, T: Mappable>
public func <-<T: JSONMappable>(inout left: Dictionary<String, [T]>?, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalObjectDictionaryOfArrays(left, map: right)
	default: ()
	}
}

/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable>
public func <-<T: JSONMappable>(inout left: Dictionary<String, [T]>!, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalObjectDictionaryOfArrays(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalObjectDictionaryOfArrays(left, map: right)
	default: ()
	}
}

// MARK:- Dictionary of Mappable objects with a transform - Dictionary<String, T: Mappable>

/// Dictionary of Mappable objects <String, T: Mappable> with a transform
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Dictionary<String, Transform.Object>, right: (JSONMap, Transform)) {
	let (map, transform) = right
	if let object = map.currentValue as? [String : AnyObject] where map.mappingType == .FromJSON && map.isKeyPresent {
		let value = fromJSONDictionaryWithTransform(object, transform: transform) ?? left
		MappingFromJSON.basicType(&left, object: value)
	} else if map.mappingType == .ToJSON {
		let value = toJSONDictionaryWithTransform(left, transform: transform)
		MappingToJSON.basicType(value, map: map)
	}
}

/// Optional Dictionary of Mappable object <String, T: Mappable> with a transform
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Dictionary<String, Transform.Object>?, right: (JSONMap, Transform)) {
	let (map, transform) = right
	if let object = map.currentValue as? [String : AnyObject] where map.mappingType == .FromJSON && map.isKeyPresent {
		let value = fromJSONDictionaryWithTransform(object, transform: transform) ?? left
		MappingFromJSON.optionalBasicType(&left, object: value)
	} else if map.mappingType == .ToJSON {
		let value = toJSONDictionaryWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(value, map: map)
	}
}

/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable> with a transform
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Dictionary<String, Transform.Object>!, right: (JSONMap, Transform)) {
	let (map, transform) = right
	if let dictionary = map.currentValue as? [String : AnyObject] where map.mappingType == .FromJSON && map.isKeyPresent {
		let transformedDictionary = fromJSONDictionaryWithTransform(dictionary, transform: transform) ?? left
		MappingFromJSON.optionalBasicType(&left, object: transformedDictionary)
	} else if map.mappingType == .ToJSON {
		let value = toJSONDictionaryWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(value, map: map)
	}
}

/// Dictionary of Mappable objects <String, T: Mappable> with a transform
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Dictionary<String, [Transform.Object]>, right: (JSONMap, Transform)) {
	let (map, transform) = right
	if let dictionary = map.currentValue as? [String : [AnyObject]] where map.mappingType == .FromJSON && map.isKeyPresent {
		let transformedDictionary = dictionary.map { (key, values) in
			return (key, fromJSONArrayWithTransform(values, transform: transform) ?? left[key] ?? [])
		}
		MappingFromJSON.basicType(&left, object: transformedDictionary)
	} else if map.mappingType == .ToJSON {
		let transformedDictionary = left.map { (key, values) in
			return (key, toJSONArrayWithTransform(values, transform: transform) ?? [])
		}

		MappingToJSON.basicType(transformedDictionary, map: map)
	}
}

/// Optional Dictionary of Mappable object <String, T: Mappable> with a transform
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Dictionary<String, [Transform.Object]>?, right: (JSONMap, Transform)) {
	let (map, transform) = right
	if let dictionary = map.currentValue as? [String : [AnyObject]] where map.mappingType == .FromJSON && map.isKeyPresent {
		let transformedDictionary = dictionary.map { (key, values) in
			return (key, fromJSONArrayWithTransform(values, transform: transform) ?? left?[key] ?? [])
		}
		MappingFromJSON.optionalBasicType(&left, object: transformedDictionary)
	} else if map.mappingType == .ToJSON {
		let transformedDictionary = left?.map { (key, values) in
			return (key, toJSONArrayWithTransform(values, transform: transform) ?? [])
		}

		MappingToJSON.optionalBasicType(transformedDictionary, map: map)
	}
}

/// Implicitly unwrapped Optional Dictionary of Mappable object <String, T: Mappable> with a transform
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Dictionary<String, [Transform.Object]>!, right: (JSONMap, Transform)) {
	let (map, transform) = right
	if let dictionary = map.currentValue as? [String : [AnyObject]] where map.mappingType == .FromJSON && map.isKeyPresent {
		let transformedDictionary = dictionary.map { (key, values) in
			return (key, fromJSONArrayWithTransform(values, transform: transform) ?? left?[key] ?? [])
		}
		MappingFromJSON.optionalBasicType(&left, object: transformedDictionary)
	} else if map.mappingType == .ToJSON {
		let transformedDictionary = left?.map { (key, values) in
			return (key, toJSONArrayWithTransform(values, transform: transform) ?? [])
		}

		MappingToJSON.optionalBasicType(transformedDictionary, map: map)
	}
}

// MARK:- Array of Mappable objects - Array<T: Mappable>

/// Array of Mappable objects
public func <-<T: JSONMappable>(inout left: Array<T>, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.objectArray(&left, map: right)
	case .ToJSON:
		MappingToJSON.objectArray(left, map: right)
	default: ()
	}
}

/// Optional array of Mappable objects
public func <-<T: JSONMappable>(inout left: Array<T>?, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalObjectArray(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalObjectArray(left, map: right)
	default: ()
	}
}

/// Implicitly unwrapped Optional array of Mappable objects
public func <-<T: JSONMappable>(inout left: Array<T>!, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalObjectArray(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalObjectArray(left, map: right)
	default: ()
	}
}

// MARK:- Array of Mappable objects with transforms - Array<T: Mappable>

/// Array of Mappable objects
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Array<Transform.Object>, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		if let transformedValues = fromJSONArrayWithTransform(map.currentValue, transform: transform) {
			MappingFromJSON.basicType(&left, object: transformedValues)
		}
	case .ToJSON:
		let transformedValues = toJSONArrayWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(transformedValues, map: map)
	default: ()
	}
}

/// Optional array of Mappable objects
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Array<Transform.Object>?, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let transformedValues = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		MappingFromJSON.optionalBasicType(&left, object: transformedValues)
	case .ToJSON:
		let transformedValues = toJSONArrayWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(transformedValues, map: map)
	default: ()
	}
}

/// Implicitly unwrapped Optional array of Mappable objects
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Array<Transform.Object>!, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		let transformedValues = fromJSONArrayWithTransform(map.currentValue, transform: transform)
		MappingFromJSON.optionalBasicType(&left, object: transformedValues)
	case .ToJSON:
		let transformedValues = toJSONArrayWithTransform(left, transform: transform)
		MappingToJSON.optionalBasicType(transformedValues, map: map)
	default: ()
	}
}

// MARK:- Array of Array of Mappable objects - Array<Array<T: Mappable>>

/// Array of Array Mappable objects
public func <-<T: JSONMappable>(inout left: Array<Array<T>>, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.twoDimensionalObjectArray(&left, map: right)
	case .ToJSON:
		MappingToJSON.twoDimensionalObjectArray(left, map: right)
	default: ()
	}
}

/// Optional array of Mappable objects
public func <-<T: JSONMappable>(inout left: Array<Array<T>>?, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalTwoDimensionalObjectArray(left, map: right)
	default: ()
	}
}

/// Implicitly unwrapped Optional array of Mappable objects
public func <-<T: JSONMappable>(inout left: Array<Array<T>>!, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalTwoDimensionalObjectArray(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalTwoDimensionalObjectArray(left, map: right)
	default: ()
	}
}

// MARK:- Array of Array of Mappable objects - Array<Array<T: Mappable>> with transforms

/// Array of Array Mappable objects with transform
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Array<Array<Transform.Object>>, right: (JSONMap, Transform)) {
	let (map, transform) = right
	if let original2DArray = map.currentValue as? [[AnyObject]] where map.mappingType == .FromJSON && map.isKeyPresent {
		let transformed2DArray = original2DArray.flatMap { values in
			fromJSONArrayWithTransform(values, transform: transform)
		}
		MappingFromJSON.basicType(&left, object: transformed2DArray)
	} else if map.mappingType == .ToJSON {
		let transformed2DArray = left.flatMap { values in
			toJSONArrayWithTransform(values, transform: transform)
		}
		MappingToJSON.basicType(transformed2DArray, map: map)
	}
}

/// Optional array of Mappable objects with transform
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Array<Array<Transform.Object>>?, right: (JSONMap, Transform)) {
	let (map, transform) = right
	if let original2DArray = map.currentValue as? [[AnyObject]] where map.mappingType == .FromJSON && map.isKeyPresent {
		let transformed2DArray = original2DArray.flatMap { values in
			fromJSONArrayWithTransform(values, transform: transform)
		}
		MappingFromJSON.optionalBasicType(&left, object: transformed2DArray)
	} else if map.mappingType == .ToJSON {
		let transformed2DArray = left?.flatMap { values in
			toJSONArrayWithTransform(values, transform: transform)
		}
		MappingToJSON.optionalBasicType(transformed2DArray, map: map)
	}
}

/// Implicitly unwrapped Optional array of Mappable objects with transform
public func <-<Transform: JSONTransformType where Transform.Object: JSONMappable>(inout left: Array<Array<Transform.Object>>!, right: (JSONMap, Transform)) {
	let (map, transform) = right
	if let original2DArray = map.currentValue as? [[AnyObject]] where map.mappingType == .FromJSON && map.isKeyPresent {
		let transformed2DArray = original2DArray.flatMap { values in
			fromJSONArrayWithTransform(values, transform: transform)
		}
		MappingFromJSON.optionalBasicType(&left, object: transformed2DArray)
	} else if map.mappingType == .ToJSON {
		let transformed2DArray = left?.flatMap { values in
			toJSONArrayWithTransform(values, transform: transform)
		}
		MappingToJSON.optionalBasicType(transformed2DArray, map: map)
	}
}

// MARK:- Set of Mappable objects - Set<T: Mappable where T: Hashable>

/// Set of Mappable objects
public func <-<T: JSONMappable where T: Hashable>(inout left: Set<T>, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.objectSet(&left, map: right)
	case .ToJSON:
		MappingToJSON.objectSet(left, map: right)
	default: ()
	}
}


/// Optional Set of Mappable objects
public func <-<T: JSONMappable where T: Hashable>(inout left: Set<T>?, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalObjectSet(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalObjectSet(left, map: right)
	default: ()
	}
}

/// Implicitly unwrapped Optional Set of Mappable objects
public func <-<T: JSONMappable where T: Hashable>(inout left: Set<T>!, right: JSONMap) {
	switch right.mappingType {
	case .FromJSON where right.isKeyPresent:
		MappingFromJSON.optionalObjectSet(&left, map: right)
	case .ToJSON:
		MappingToJSON.optionalObjectSet(left, map: right)
	default: ()
	}
}


// MARK:- Set of Mappable objects with a transform - Set<T: Mappable where T: Hashable>

/// Set of Mappable objects with transform
public func <-<Transform: JSONTransformType where Transform.Object: protocol<Hashable, JSONMappable>>(inout left: Set<Transform.Object>, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		if let transformedValues = fromJSONArrayWithTransform(map.currentValue, transform: transform) {
			MappingFromJSON.basicType(&left, object: Set(transformedValues))
		}
	case .ToJSON:
		let transformedValues = toJSONArrayWithTransform(Array(left), transform: transform)
		MappingToJSON.optionalBasicType(transformedValues, map: map)
	default: ()
	}
}


/// Optional Set of Mappable objects with transform
public func <-<Transform: JSONTransformType where Transform.Object: protocol<Hashable, JSONMappable>>(inout left: Set<Transform.Object>?, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		if let transformedValues = fromJSONArrayWithTransform(map.currentValue, transform: transform) {
			MappingFromJSON.basicType(&left, object: Set(transformedValues))
		}
	case .ToJSON:
		if let values = left {
			let transformedValues = toJSONArrayWithTransform(Array(values), transform: transform)
			MappingToJSON.optionalBasicType(transformedValues, map: map)
		}
	default: ()
	}
}

/// Implicitly unwrapped Optional set of Mappable objects with transform
public func <-<Transform: JSONTransformType where Transform.Object: protocol<Hashable, JSONMappable>>(inout left: Set<Transform.Object>!, right: (JSONMap, Transform)) {
	let (map, transform) = right
	switch map.mappingType {
	case .FromJSON where map.isKeyPresent:
		if let transformedValues = fromJSONArrayWithTransform(map.currentValue, transform: transform) {
			MappingFromJSON.basicType(&left, object: Set(transformedValues))
		}
	case .ToJSON:
		if let values = left {
			let transformedValues = toJSONArrayWithTransform(Array(values), transform: transform)
			MappingToJSON.optionalBasicType(transformedValues, map: map)
		}
	default: ()
	}
}

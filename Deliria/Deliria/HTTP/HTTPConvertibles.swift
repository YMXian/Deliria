//
//  HTTPConvertibles.swift
//
//  Copyright (c) 2014-2016 Alamofire Software Foundation (http://alamofire.org/)
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
//

import Foundation

// MARK: - URLStringConvertible

/**
    Types adopting the `URLStringConvertible` protocol can be used to construct URL strings, which are then used to
    construct URL requests.
*/
public protocol URLStringConvertible {
    /**
        A URL that conforms to RFC 2396.

        Methods accepting a `URLStringConvertible` type parameter parse it according to RFCs 1738 and 1808.

        See https://tools.ietf.org/html/rfc2396
        See https://tools.ietf.org/html/rfc1738
        See https://tools.ietf.org/html/rfc1808
    */
    var URLString: String { get }
}

extension String: URLStringConvertible {
    public var URLString: String {
        return self
    }
}

extension NSURL: URLStringConvertible {
    public var URLString: String {
        return absoluteString
    }
}

extension NSURLComponents: URLStringConvertible {
    public var URLString: String {
        return URL!.URLString
    }
}

extension NSURLRequest: URLStringConvertible {
    public var URLString: String {
        return URL!.URLString
    }
}

// MARK: - URLRequestConvertible

/**
    Types adopting the `URLRequestConvertible` protocol can be used to construct URL requests.
*/
public protocol URLRequestConvertible {
    /// The URL request.
    var URLRequest: NSMutableURLRequest { get }
}

extension NSURLRequest: URLRequestConvertible {
    public var URLRequest: NSMutableURLRequest {
        return self.mutableCopy() as! NSMutableURLRequest
    }
}

// MARK: - Convenience

func URLRequest(
    method: HTTPMethod,
    _ URLString: URLStringConvertible,
    headers: [String: String]? = nil)
    -> NSMutableURLRequest {
    let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string: URLString.URLString)!)
    mutableURLRequest.HTTPMethod = method.rawValue

    if let headers = headers {
        for (headerField, headerValue) in headers {
            mutableURLRequest.setValue(headerValue, forHTTPHeaderField: headerField)
        }
    }

    return mutableURLRequest
}

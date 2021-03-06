//
//  HMAC.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 13/01/15.
//  Copyright (c) 2015 Marcin Krzyzanowski. All rights reserved.
//

final public class HMAC: Authenticator {

    public enum Error: Swift.Error {
        case authenticateError
        case invalidInput
    }

    public enum Variant {
        case sha1, sha256, sha384, sha512, md5

        var digestSize: Int {
            switch (self) {
            case .sha1:
                return SHA1.digestSize
            case .sha256:
                return SHA2.Variant.sha256.digestSize
            case .sha384:
                return SHA2.Variant.sha384.digestSize
            case .sha512:
                return SHA2.Variant.sha512.digestSize
            case .md5:
                return MD5.digestSize
            }
        }

        func calculateHash(_ bytes: Array<UInt8>) -> Array<UInt8>? {
            switch (self) {
            case .sha1:
                return Digest.sha1(bytes)
            case .sha256:
                return Digest.sha256(bytes)
            case .sha384:
                return Digest.sha384(bytes)
            case .sha512:
                return Digest.sha512(bytes)
            case .md5:
                return Digest.md5(bytes)
            }
        }

        func blockSize() -> Int {
            switch self {
            case .md5:
                return MD5.blockSize
            case .sha1, .sha256:
                return 64
            case .sha384, .sha512:
                return 128
            }
        }
    }

    var key: Array<UInt8>
    let variant: Variant

    public init (key: Array<UInt8>, variant: HMAC.Variant = .md5) {
        self.variant = variant
        self.key = key

        if key.count > variant.blockSize() {
            if let hash = variant.calculateHash(key) {
                self.key = hash
            }
        }

        if key.count < variant.blockSize() {
            self.key = ZeroPadding().add(to: key, blockSize: variant.blockSize())
        }
    }

    //MARK: Authenticator

    public func authenticate(_ bytes: Array<UInt8>) throws -> Array<UInt8> {
        var opad = Array<UInt8>(repeating: 0x5c, count: variant.blockSize())
        for idx in key.indices {
            opad[idx] = key[idx] ^ opad[idx]
        }
        var ipad = Array<UInt8>(repeating: 0x36, count: variant.blockSize())
        for idx in key.indices {
            ipad[idx] = key[idx] ^ ipad[idx]
        }

        guard let ipadAndMessageHash = variant.calculateHash(ipad + bytes),
              let result = variant.calculateHash(opad + ipadAndMessageHash) else {
            throw Error.authenticateError
        }

        // return Array(result[0..<10]) // 80 bits
        return result
    }
}

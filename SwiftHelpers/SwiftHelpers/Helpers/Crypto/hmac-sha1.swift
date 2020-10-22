//
//  hmac-sha1.swift
//  SwiftHelpers
//
//  Created by vlad.kosyi on 22.10.2020.
//  Copyright © 2020 com.chisw. All rights reserved.
//

import Foundation
import CommonCrypto

// let hmacResult:String = "myStringToHMAC".hmac(HMACAlgorithm.SHA1, key: "myKey")

enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }

    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

extension String {
    
//    func hmac(key: String) -> String {
//        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
//        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), key, key.count, self, self.count, &digest)
//        let data = Data(bytes: digest)
//        return data.map { String(format: "%02hhx", $0) }.joined()
//    }
    
    func hmac(key: String) -> String {
        let algorithm = CryptoAlgorithm.SHA1
        let str = self.cString(using: String.Encoding.ascii)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.ascii))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.ascii)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.ascii))
        
        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)

        let hmacData = NSData(bytes: result, length: digestLen)
        let hmacBase64 = hmacData.base64EncodedString(options: NSData.Base64EncodingOptions.endLineWithLineFeed)
        return String(hmacBase64)
    }
}

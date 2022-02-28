import UIKit
import Foundation
import CryptoKit // 암호화 킷 iOS13 이상
import CommonCrypto

// CryptoKit
let text = "111111"
let saltKey = "123" // empSeq

let salt = saltKey + text
var saltData = salt.data(using: .utf8)
let sha512Salt = SHA512.hash(data: saltData!)

// 2. sha512Salt 에서 Data로 바로 빼서 base64 해야지만 hex로 됨
var shaData = Data()
sha512Salt.compactMap { indata in
    shaData.append(indata)
}

// 3. 최종 결과
let sha512SaltBase64String = shaData.base64EncodedString()
print("SHA512 -> Data -> Base64String : ")
print(sha512SaltBase64String)


// Common Crypto
func hash(_ input: String, salt: String) -> String {
    let toHash = input+salt

    // TODO: Calculate the SHA256 hash of "toHash" and return it
    // return sha256(toHash)
    let data = Data(toHash.utf8)
    var hash = [UInt8](repeating: 0,  count: Int(CC_SHA512_DIGEST_LENGTH))
    
    data.withUnsafeBytes { buffer in
        _ = CC_SHA512(buffer.baseAddress, CC_LONG(buffer.count), &hash)
    }
    
    return hash.map { String(format: "%02hhx", $0) }.joined()
    
}

print(hash("somedata", salt: "")) // Prints "somedata1m8f"

import Foundation
import CryptoSwift

class KeyRepository {

    func createKeys(for password: String) {
        let passwordData = password.data(using: .utf8) ?? Data()
        let salt = randomString(length: 16).bytes
        let iv = AES.randomIV(AES.blockSize)

        let privateKey = RSA(n: [2,0,4,8], e: [3])
        do {
            let publicKey = try privateKey.publicKeyExternalRepresentation()

            let cryptoKey = try Scrypt(password: passwordData.bytes,
                                        salt: salt,
                                        dkLen: 32,
                                        N: 2048,
                                        r: 8,
                                        p: 1)

            let aes = try AES(key: try cryptoKey.calculate(), blockMode: CBC(iv: iv))
            let cipherText = try aes.encrypt(passwordData.bytes)
            let block = salt + cipherText + iv
            let privateKey = Data(block).base64EncodedData()

            saveKeys(password: password, publicKey: publicKey, privateKey: privateKey)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }

    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }

    func getKeys(for password: String) -> KeyPayload? {
        if let publicKey = UserDefaults.standard.data(forKey: "public \(password)"),
           let privateKey = (try? Keychain().fetchKey(for: password)) {
            return KeyPayload(publicKey: publicKey.base64EncodedString(),
                              privateKey: privateKey.base64EncodedString())
        }
        return nil
    }

    func importKeys(for password: String, key: String) -> KeyPayload? {

        let keyData = Data(base64Encoded: key) ?? Data()
        do{
            let privateKey = try RSA(rawRepresentation: keyData)
            let publicKey = try privateKey.publicKeyExternalRepresentation()
            return KeyPayload(publicKey: publicKey.base64EncodedString(), privateKey: try privateKey.externalRepresentation().base64EncodedString())

        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }

    func savePayload(password: String, payload: KeyPayload) {
        if let publicKey = Data(base64Encoded: payload.publicKey),
           let privateKey = Data(base64Encoded: payload.privateKey) {
            saveKeys(password: password,
                     publicKey: publicKey,
                     privateKey: privateKey)
        }
    }

    func saveKeys(password: String, publicKey: Data, privateKey: Data) {
        UserDefaults.standard.set(publicKey, forKey: "public \(password)")
        let keychain = Keychain()
        try? keychain.addKey(privateKey, with: password)
    }

    func deleteKeys(for password: String) {
        try? Keychain().deleteKeyIfExists(for: password)
    }

}

struct KeyPayload {
    let publicKey: String
    let privateKey: String
}

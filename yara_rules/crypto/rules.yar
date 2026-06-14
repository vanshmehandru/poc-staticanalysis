rule CryptoIndicators {
    meta:
        description = "Detects AES/RSA cryptographic constants"
        category = "Crypto Indicators"
        severity = "LOW"
    strings:
        $aes_sbox = { 63 7c 77 7b f2 6b 6f c5 30 01 67 2b fe d7 ab 76 }
        $rsa1 = "CryptAcquireContext" ascii wide nocase
        $rsa2 = "CryptGenKey" ascii wide nocase
    condition:
        any of them
}

rule PackerDetection {
    meta:
        description = "Detects common packers like UPX and Themida"
        category = "Packers"
        severity = "MEDIUM"
    strings:
        $pack1 = "UPX0" ascii wide
        $pack2 = "UPX1" ascii wide
        $pack3 = "UPX!" ascii wide
        $pack4 = "Themida" ascii wide nocase
        $pack5 = "WinLicense" ascii wide nocase
    condition:
        any of them
}

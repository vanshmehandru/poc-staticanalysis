rule RansomwareIndicators {
    meta:
        description = "Detects shadow copy deletion commands"
        category = "Ransomware Indicators"
        severity = "CRITICAL"
    strings:
        $s1 = "vssadmin" ascii wide nocase
        $s2 = "delete shadows" ascii wide nocase
        $s3 = "/all" ascii wide nocase
        $s4 = "/quiet" ascii wide nocase
    condition:
        all of them
}

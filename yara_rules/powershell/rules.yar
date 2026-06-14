rule PowerShellAbuse {
    meta:
        description = "Detects hidden or encoded PowerShell execution"
        category = "PowerShell Abuse"
        severity = "HIGH"
    strings:
        $ps = "powershell" ascii wide nocase
        $flag1 = "-ExecutionPolicy Bypass" ascii wide nocase
        $flag2 = "-ep bypass" ascii wide nocase
        $flag3 = "-enc" ascii wide nocase
        $flag4 = "-EncodedCommand" ascii wide nocase
        $flag5 = "-WindowStyle Hidden" ascii wide nocase
        $flag6 = "-w hidden" ascii wide nocase
    condition:
        $ps and any of ($flag*)
}

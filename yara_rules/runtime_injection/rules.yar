rule RuntimeInjection {
    meta:
        description = "Detects process injection APIs"
        category = "Runtime Injection"
        severity = "CRITICAL"
    strings:
        $api1 = "CreateRemoteThread" ascii wide nocase
        $api2 = "VirtualAllocEx" ascii wide nocase
        $api3 = "WriteProcessMemory" ascii wide nocase
    condition:
        2 of them
}

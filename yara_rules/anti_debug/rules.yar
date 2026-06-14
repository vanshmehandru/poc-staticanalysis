rule AntiDebugging {
    meta:
        description = "Detects anti-debugging APIs"
        category = "Anti-Debugging"
        severity = "HIGH"
    strings:
        $api1 = "IsDebuggerPresent" ascii wide nocase
        $api2 = "CheckRemoteDebuggerPresent" ascii wide nocase
        $api3 = "NtQueryInformationProcess" ascii wide nocase
    condition:
        any of them
}

rule ProcessExecution {
    meta:
        description = "Detects process spawning APIs"
        category = "Process Execution"
        severity = "HIGH"
    strings:
        $api1 = "ShellExecute" ascii wide nocase
        $api2 = "WinExec" ascii wide nocase
        $api3 = "CreateProcess" ascii wide nocase
    condition:
        any of them
}

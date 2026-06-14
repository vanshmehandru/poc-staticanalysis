rule NetworkCommunication {
    meta:
        description = "Detects network communication APIs"
        category = "Network Communication"
        severity = "HIGH"
    strings:
        $api1 = "InternetOpen" ascii wide nocase
        $api2 = "InternetConnect" ascii wide nocase
        $api3 = "HttpSendRequest" ascii wide nocase
    condition:
        any of them
}

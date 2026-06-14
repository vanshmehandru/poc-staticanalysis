# Offline Static Malware Analysis System

A completely modular, offline, static analysis engine for triage of Windows PE files (`.exe`, `.dll`).

## Features

- **Intake Analysis**: Validates files, calculates MD5/SHA1/SHA256/SHA512 hashes, and extracts magic bytes.
- **PE Header Parsing**: Extracts machine types, compile timestamps, entry points, and validates DOS/COFF headers.
- **Security Mitigations**: Detects DEP (NX_COMPAT), ASLR (DYNAMIC_BASE), CFG, and SafeSEH.
- **Entropy Analysis**: Evaluates Shannon Entropy for every PE section, flagging sections >= 7.0 for potential packing/obfuscation.
- **Suspicious Imports**: Tracks high-risk APIs like `CreateRemoteThread`, `VirtualAllocEx`, and `InternetOpen`.
- **String & IOC Extraction**: Uses Regular Expressions to rip out IPv4/IPv6 addresses, URLs, Email Addresses, and Registry paths.
- **YARA Engine Integration**: Recursively loads `.yar` rules from `yara_rules/` and scans samples for packers, crypto constants, ransomware, and anti-debugging behaviors.
- **Manifest Extraction**: Parses embedded XML manifests to find requested execution levels.
- **Intelligent Risk Engine**: Aggregates all findings into a unified intelligence schema, applies a point-based severity score (0-100), and issues a final verdict (BENIGN, LOW RISK, MEDIUM RISK, HIGH RISK, CRITICAL RISK) with corresponding incident response recommendations.
- **PDF Reporting**: Generates a professional 15-section PDF report detailing the execution summary, key findings, and raw analyzer outputs using `ReportLab`.

## Installation

This system requires Python 3.12+.
It also requires `libmagic`. On Windows, the requirements file handles installing `python-magic-bin`.

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

## Usage

Run the `main.py` entrypoint located within the `malware_analyzer` directory and supply it with a PE file:

```bash
python malware_analyzer/main.py "C:\Path\To\Sample.exe"
```

The system will generate console output showing the execution status of the analyzers and save a detailed PDF report inside the `reports/` directory.

## Architecture

```
malware_analyzer/
├── main.py
├── analyzers/         # Independent analysis modules
├── intelligence/      # Risk engine and aggregator
├── reporting/         # ReportLab PDF generation
└── config/            # System settings
yara_rules/            # Drop your custom .yar rules here
reports/               # Generated PDFs appear here
```

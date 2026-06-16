# Offline Static Malware Analysis System (OMAS)

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
- **PDF Reporting & Embedded Metadata**: Generates a professional 15-section PDF report detailing the execution summary, key findings, and raw analyzer outputs using `ReportLab`. Forensic metadata is securely serialized and embedded inside the PDF file's native `Subject` metadata field (no separate sidecar `.json` files are required, making the output report fully self-contained).

## Installation

This project is set up for **Python 3.14.6**.
It also requires `libmagic`. On Windows, the dependency file uses `python-magic-bin`, which includes the required binaries.

### Offline installation summary

For a fully air-gapped system, use two machines:

1. **Online machine**: build a local wheel folder named `wheelhouse`.
2. **Offline machine**: create a virtual environment and install only from that local wheel folder.

If you need to rebuild the wheel folder on the online machine, install Microsoft Visual C++ Build Tools first. That is required because `yara-python` is built from source for Python 3.14.6.

Basic offline install flow:

```powershell
py -3.14 -m venv venv
.\venv\Scripts\Activate.ps1
python -m pip install --no-index --find-links=.\wheelhouse -r requirements.txt
```

If you are building the wheelhouse on the online machine, use:

```powershell
py -3.14 -m venv buildenv
.\buildenv\Scripts\Activate.ps1
python -m pip install -U pip setuptools wheel build
python -m pip wheel -r requirements.txt -w wheelhouse
```

## Usage

### 1. Graphical User Interface (GUI)
Launch the professional Qt/PySide6 forensic dashboard:
```bash
python malware_analyzer/gui/app.py
```
From the GUI, you can:
- Perform static analysis of binaries.
- Monitor analysis status dynamically.
- View a centralized Reports ledger.
- Filter historical reports by date range and verdict.
- Open PDF reports directly from the table.

### 2. Command Line Interface (CLI)
Run the headless static analysis engine:
```bash
python malware_analyzer/main.py "C:\Path\To\Sample.exe"
```

The system will generate console output showing the execution status of the analyzers and save a detailed PDF report inside the `reports/` directory.

## Offline & Air-Gapped Readiness
This system has been built from the ground up for **fully offline/air-gapped forensics workstations**:
- **Zero Cloud Calls**: No network connectivity or external APIs are used during static analysis.
- **Self-Contained Portability**: You can compress the workspace folder (`.zip`), move it via hard disk/USB drive to a disconnected analysis machine, and install everything from a local wheel folder.
- **Python Version**: The offline machine should use Python 3.14.6 so the wheel files match the interpreter.

## Architecture

```
malware_analyzer/
├── main.py
├── analyzers/         # Independent analysis modules
├── intelligence/      # Risk engine and aggregator
├── reporting/         # ReportLab PDF generation
├── config/            # System settings
└── gui/               # PySide6 Forensic GUI Views & Controllers
yara_rules/            # Drop your custom .yar rules here
reports/               # Generated PDF reports appear here
```

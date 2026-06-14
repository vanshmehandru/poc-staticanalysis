# OMAS Setup & Offline Deployment Walkthrough

This document provides step-by-step instructions on how to set up, install, and run the Offline Static Malware Analysis System (OMAS) on both online (connected) and completely offline (air-gapped) systems.

---

## Prerequisites

Before running the application, ensure the target system meets the following requirements:

### 1. System Requirements
- **Python**: Version 3.12 or higher.
- **Operating System**: Windows (tested on Windows 10/11), macOS, or Linux.
- **pip**: Python Package Installer (usually bundled with Python).

### 2. Dependency Notes
- **`libmagic`**: This project uses `python-magic` to inspect file signatures.
  - **Windows**: The `requirements.txt` installs `python-magic-bin` which includes the compiled binaries.
  - **macOS**: May require installing `libmagic` using Homebrew: `brew install libmagic`
  - **Linux**: May require installing `libmagic` using the system package manager: `sudo apt-get install libmagic1` (Debian/Ubuntu) or `sudo dnf install file-devel` (RedHat/Fedora).

---

## Online Setup: Cloning and Running

If the target workstation has access to the internet, follow these steps to clone and run the project:

### Step 1: Clone the Repository
Open a terminal (e.g., PowerShell on Windows, Terminal on macOS/Linux) and run:
```bash
git clone https://github.com/vanshmehandru/poc-staticanalysis.git
cd poc-staticanalysis
```

### Step 2: Install Dependencies
It is recommended to use a virtual environment to avoid conflicts with system-wide python packages:
```bash
# Create a virtual environment
python -m venv venv

# Activate the virtual environment
# On Windows (PowerShell):
.\venv\Scripts\Activate.ps1
# On macOS/Linux:
source venv/bin/activate

# Install the required packages
pip install -r requirements.txt
```

### Step 3: Run the Program

#### Option A: Command Line Interface (CLI)
To run a quick static analysis of a executable file:
```bash
python malware_analyzer/main.py "C:\Path\To\Sample.exe"
```
*The engine will display findings in the console and automatically save a PDF report inside the `reports/` folder.*

#### Option B: Graphical User Interface (GUI)
To launch the interactive forensic dashboard:
```bash
python malware_analyzer/gui/app.py
```

---

## Offline / Air-Gapped Setup (Sneakernet Deployment)

In a secure security operations center (SOC) or malware lab, the analysis machine is often completely disconnected from the internet. Follow this guide to transfer and install the application offline.

### Step 1: Download Dependencies (On an Online Machine)
Before transferring files to the offline system, you must download the offline package installers (wheel files) for all dependencies.

1. Create a temporary folder to store the packages:
   ```bash
   mkdir dependencies
   ```
2. Download all the required wheels matching your target offline machine's platform (e.g., Windows x64):
   ```bash
   pip download -r requirements.txt -d ./dependencies --only-binary=:all: --platform win_amd64 --python-version 312
   ```
   *(Adjust `--platform` and `--python-version` flags to match your target offline operating system and installed Python version).*

### Step 2: Compress and Transfer
1. Compress the repository folder (including the newly created `dependencies/` folder) into a `.zip` or `.tar.gz` archive.
2. Transfer the archive to the offline system via authorized offline media (e.g., USB drive, optical media, or secure internal file transfer).

### Step 3: Extract and Install (On the Offline Machine)
1. Extract the transferred archive to your directory of choice.
2. Open a terminal, navigate to the extracted directory, and activate your virtual environment if you wish to use one.
3. Install the packages locally without using the internet:
   ```bash
   pip install --no-index --find-links=./dependencies -r requirements.txt
   ```
   *This tells `pip` to look only in the local `./dependencies` directory for the installation packages and to ignore internet indexes like PyPI.*

### Step 4: Run the Program
Now, verify the installation by running the application offline:

```bash
# To run CLI:
python malware_analyzer/main.py "C:\Path\To\Sample.exe"

# To run GUI:
python malware_analyzer/gui/app.py
```
Since the app executes entirely locally, it will function with 100% features and zero network dependencies.

# OMAS Setup & Offline Deployment Walkthrough

This guide explains how to set up OMAS in a very simple way. It is written for a beginner who may only know how to copy folders and run a few PowerShell commands.

The setup uses **two computers**:

- **Online computer**: the machine that has internet access. You use it to download or build the Python package files.
- **Offline computer**: the air-gapped machine with no internet. You use it to run OMAS.

OMAS is designed for **Python 3.14.6** on Windows.

---

## What You Need

Before starting, make sure you have these items:

- Python **3.14.6** on both computers.
- The OMAS project folder.
- A USB drive or other safe transfer method.
- On the online computer only: **Microsoft Visual C++ Build Tools** with **Desktop development with C++** selected.

Why the Build Tools are needed: one package, `yara-python`, must be compiled on Python 3.14.6 because a ready-made wheel is not available.

---

## Part 1: Prepare the Package Files on the Online Computer

### Step 1: Open the project folder
Open PowerShell and go to the OMAS folder.

```powershell
cd C:\Users\HP\OneDrive\Desktop\CyberSec\exe-analysis
```

### Step 2: Create a build virtual environment
A virtual environment is like a clean box for Python packages. It keeps this project separate from other Python projects.

```powershell
py -3.14 -m venv buildenv
.\buildenv\Scripts\Activate.ps1
```

### Step 3: Install the tools needed to build packages

```powershell
python -m pip install -U pip setuptools wheel build
```

### Step 4: Build the offline wheel folder
This command downloads or builds all package files into a folder called `wheelhouse`.

```powershell
python -m pip wheel -r requirements.txt -w wheelhouse
```

When this finishes successfully, you should see a `wheelhouse` folder in the project directory.

### Step 5: Check the result
Open the `wheelhouse` folder and make sure it contains wheel files such as:

- `pefile`
- `lief`
- `reportlab`
- `python-magic-bin`
- `PySide6`
- `pillow`
- `charset_normalizer`
- `yara-python` or `yara_python`

If `yara-python` is missing, the build did not finish correctly and you must fix that before moving to the offline computer.

---

## Part 2: Copy Everything to the Offline Computer

### Step 6: Copy the project folder
Copy the whole OMAS project folder to a USB drive or another approved transfer medium.

Make sure the copied folder includes:

- `wheelhouse`
- `requirements.txt`
- the `malware_analyzer` folder
- the `yara_rules` folder
- the `docs` folder

### Step 7: Move it to the offline computer
Copy the transferred folder onto the air-gapped machine.

---

## Part 3: Install OMAS on the Offline Computer

### Step 8: Open the project folder on the offline computer
Open PowerShell and move into the copied OMAS folder.

```powershell
cd C:\Path\To\OMAS
```

### Step 9: Create a runtime virtual environment
This is the environment you will actually use to run OMAS.

```powershell
py -3.14 -m venv venv
.\venv\Scripts\Activate.ps1
```

### Step 10: Install the packages from the local wheel folder only
This step tells pip to stay offline and use only the files inside `wheelhouse`.

```powershell
python -m pip install --no-index --find-links=.\wheelhouse -r requirements.txt
```

If this command finishes without errors, the installation is complete.

---

## Part 4: Run OMAS

### Step 11: Run the command-line version
Use this if you want to analyze a file directly:

```powershell
python malware_analyzer/main.py "C:\Path\To\Sample.exe"
```

### Step 12: Run the GUI version
Use this if you want to open the desktop interface:

```powershell
python malware_analyzer/gui/app.py
```

---

## Simple Troubleshooting

If something goes wrong, check these common problems:

- **Python version mismatch**: make sure the machine is using Python 3.14.6.
- **Missing wheel files**: confirm the `wheelhouse` folder contains all package files.
- **`yara-python` build error**: install Microsoft Visual C++ Build Tools on the online computer and rebuild the wheel folder.
- **`pip` tries to use the internet**: make sure you used `--no-index --find-links=.\wheelhouse`.

---

## Short Version

If you only want the shortest possible summary:

1. Use the online computer to build `wheelhouse`.
2. Copy the whole project folder to the offline computer.
3. Create `venv` on the offline computer.
4. Install with `pip install --no-index --find-links=.\wheelhouse -r requirements.txt`.
5. Run `python malware_analyzer/gui/app.py` or `python malware_analyzer/main.py`.

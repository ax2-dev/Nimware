# NtRaiseHardError Bluescreen Trigger

This repository contains a Nim program that uses direct syscalls to invoke the Native API function `NtRaiseHardError` to trigger a system blue screen. **Warning:** Running this program will deliberately crash your system and may cause data loss or instability. Use it **at your own risk** and only in a controlled, safe environment.

## Overview

The program demonstrates how to bypass the standard Windows API by making direct system calls. Instead of using the usual Windows DLL functions, it directly calls `NtRaiseHardError` from the Native API to cause a blue screen on Windows systems.

## How Direct Syscalls Work

Direct syscalls allow a program to communicate directly with the operating system's kernel without going through the normal API layers.
- **Bypass:** They skip the regular safety checks provided by higher-level functions.
- **Direct Communication:** They send a direct message to the operating system to perform a critical operation.
- **Powerful & Risky:** This method is powerful but dangerous because it can trigger system-level actions (like crashing your system) without the usual safeguards.

## Usage

1. **Compilation:**  
   Make sure you have [Nim](https://nim-lang.org/) installed. Then, compile the program with the following command:

   ```
   nim c -r ntRaiseHardError.nim
   ```

2. **Execution:**  
   Run the resulting executable. **Remember:** Executing this program will cause a blue screen crash, so only run it in a test environment.

## Disclaimer

This code is provided for educational purposes only. The author is not responsible for any damage or data loss resulting from its use.

---

This readme was rewritten for clarity by AI.

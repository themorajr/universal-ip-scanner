# Universal IP Scanner

Universal IP Scanner is a versatile tool for scanning IP addresses across various devices using Windows Shell and Python. This utility aims to provide a simple yet powerful way to monitor and manage networked devices.

## How to Use

### Preparation
**Create an IP List:**
   - Change the name of your file to `ip.txt` (or create a new one) and list the IP addresses you want to scan within it.
   
### Windows PowerShell Instructions

1. **Bypass Execution Policy:**
   - To run PowerShell scripts, you need to bypass the execution policy. Open PowerShell as an administrator and execute the following commands:
     ```powershell
     Set-ExecutionPolicy RemoteSigned
     Set-ExecutionPolicy Unrestricted
     ```

2. **Running the Script:**
   - With the execution policy set, you can now run the IP Scanner script:
     ```powershell
     powershell -ExecutionPolicy Bypass -File <file>
     ```

### Python Instructions

1. **Install Required Packages:**
   - Ensure you have all the necessary Python packages installed. You can do this by running the following command in your terminal:
     ```bash
     pip install -r requirements.txt
     ```

2. **Run the Python Script:**
   - Execute the Python script to start scanning the IPs listed in `ip.txt`.

### Features
- **Cross-Platform Compatibility:** The scanner can be used on various operating systems where Python and PowerShell are available.
- **Ease of Use:** Simple setup with minimal configuration required.
- **Extensibility:** Easily add or modify the IP addresses to be scanned by editing the `ip.txt` file.

### Contribution
We welcome contributions! Please fork the repository and submit a pull request for any features or bug fixes you want to contribute.

---

With this tool, network administrators and IT professionals can effortlessly keep track of their devices' statuses across the network, making network management more efficient and streamlined.

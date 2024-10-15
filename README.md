---

# WSL-Scripts

This repository contains two useful shell scripts designed for users working in a WSL (Windows Subsystem for Linux) environment. These scripts allow you to interact with your Windows file system from within WSL.

## Scripts

1. **largest-file-searcher.sh**  
   This script helps you search for and list the top 10 largest files in specific Windows folders. You can choose from predefined folders like `Downloads`, `Desktop`, `Documents`, `Videos`, and `Pictures`.

2. **move-to-documents.sh**  
   This script moves the shell working directory to the Windows `Documents` folder for easy access to files within that directory.

---

## largest-file-searcher.sh

### Features:

- Dynamically retrieves the Windows username to access the correct directories.
- Prompts you to choose a folder to search in (`Downloads`, `Desktop`, `Documents`, `Videos`, or `Pictures`).
- Counts the number of files in the selected folder and estimates the time to find the largest files.
- Displays the top 10 largest files along with their sizes in a user-friendly format.

### How to Use:

1. Clone this repository:
   ```bash
   git clone https://github.com/your-repo/wsl-scripts.git
   ```

2. Make the script executable:
   ```bash
   chmod +x largest-file-searcher.sh
   ```

3. Run the script:
   ```bash
   ./largest-file-searcher.sh
   ```

4. Follow the on-screen prompts to select the folder you want to search in, and the script will display the top 10 largest files in that folder.

### Example:
```bash
Please select the folder you want to search in:
1) Downloads
2) Desktop
3) Documents
4) Videos
5) Pictures
Enter the number corresponding to your choice: 1

Searching in USER's Downloads folder: /mnt/c/Users/USER/Downloads
Total number of files: 1500
Estimated time for completion: 12.34 seconds

Search completed!
Top 10 largest files in USER's Downloads:
150M file1.zip
140M file2.mp4
...
```

---

## move-to-documents.sh

### Features:

- Dynamically retrieves the Windows username and moves your current shell working directory to the `Documents` folder in your Windows system.

### How to Use:

1. Make the script executable:
   ```bash
   chmod +x move-to-documents.sh
   ```

2. Run the script:
   ```bash
   ./move-to-documents.sh
   ```

3. After running the script, you will be automatically moved to the `Documents` directory of your Windows user.

---

## Requirements:

- WSL (Windows Subsystem for Linux) installed.
- Access to the Windows file system via `/mnt/c/`.

## Notes:

- These scripts are tested on Windows 10/11 with WSL 2.
- Make sure your WSL is properly set up to access the Windows file system.

## License:

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

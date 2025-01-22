# File Renaming Tool

This is a command-line tool written in Nim that renames all files in a specified directory using a user-provided base name. Each file will be renamed with the format `<base-name>-<counter><extension>`. It skips directories and files that already exist with the target name to prevent overwriting.

## Features
- Renames all files in a given directory with a consistent naming pattern.
- Retains the original file extensions.
- Skips files if the target name already exists.
- Provides feedback on success, skips, and failures.

## How to Run
1. Make sure you have Nim installed on your system. You can download it from [Nim's official website](https://nim-lang.org/).
2. Save the program in a file, e.g., `rename_files.nim`.
3. Open a terminal and navigate to the directory containing the file.
4. Compile the program using the Nim compiler:
   ```bash
   nim c -r rename_files.nim
   ```

## Usage
1. Run the compiled program. 
2. Enter the directory path where the files to be renamed are located.
3. Enter the new base name for the files.
4. The program will rename all files in the directory with the specified pattern.

## Example
**Input:**
```plaintext
Enter the directory path:
/path/to/your/files
Enter the new base name for files:
myfile
```

**Output:**
```plaintext
Renamed: /path/to/your/files/oldfile1.txt -> /path/to/your/files/myfile-1.txt
Renamed: /path/to/your/files/oldfile2.jpg -> /path/to/your/files/myfile-2.jpg
Error: Target file /path/to/your/files/myfile-2.jpg already exists. Skipping...
```

## Error Handling
- If the directory does not exist, the program will display:
  ```plaintext
  Error: Directory does not exist.
  ```
- If a file cannot be renamed, the program will display:
  ```plaintext
  Failed to rename: <file-path>
  ```
- If a target file already exists, the program will skip it and display:
  ```plaintext
  Error: Target file <target-path> already exists. Skipping...
  ```

## Notes
- This program only processes regular files. Directories within the target directory are ignored.
- File extensions are preserved in the renaming process.

---

This readme was rewritten for clarity by AI.

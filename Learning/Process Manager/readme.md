# Process Manager  

**Windows process management utility** combining Python's Tkinter GUI with Nim's native Windows API integration. Features:  
- 🔍 Process search by executable name  
- 📋 PID list display with multi-select  
- ⚡ Batch process termination  

## 🛠️ Installation  
**Prerequisites**  
- Python 3.9+ with Tkinter  
- Nim 1.6+ compiler  
- Windows 10/11 (64-bit)  

**Compile Nim Components**  
```
nim c --cpu:amd64 -d:release -d:mingw --opt:speed .\finder.nim
nim c --cpu:amd64 -d:release -d:mingw --opt:speed .\killer.nim
```

## 🚀 Launch Application  
```
py .\gui.py
```

## ⌨️ Usage Workflow  
1. Enter target process name (e.g., `chrome.exe`)
2. Click "Find Processes" to populate PID list
3. Select multiple PIDs using Ctrl+Click
4. Execute "Kill Selected" for batch termination

## 📚 Script Overview  
| File | Purpose | Key Features |
|------|---------|--------------|
| `gui.py` | Main interface | Tkinter GUI, process list management |
| `finder.nim` | Process discovery | Win32 API snapshot enumeration |
| `killer.nim` | Process termination | PID validation, handle cleanup |

## ⚙️ Technical Details  

### CreateToolhelp32Snapshot
```
HANDLE CreateToolhelp32Snapshot(
  [in] DWORD dwFlags,         // TH32CS_SNAPPROCESS (0x00000002)
  [in] DWORD th32ProcessID    // 0 for all processes
);
```
- Header: `TlHelp32.h`
- Returns snapshot handle or `INVALID_HANDLE_VALUE`
- Must be closed with `CloseHandle`

### Process32FirstW
```
BOOL Process32FirstW(
  [in]      HANDLE           hSnapshot,
  [in, out] LPPROCESSENTRY32W lppe
);
```
- Header: `TlHelp32.h`
- Requires initialized `dwSize` in `PROCESSENTRY32W`
- Returns `TRUE` on success, populates first process entry

### Process32NextW 
```
BOOL Process32NextW(
  [in]  HANDLE           hSnapshot,
  [out] LPPROCESSENTRY32W lppe
);
```
- Header: `TlHelp32.h`
- Returns `TRUE` while processes remain, `ERROR_NO_MORE_FILES` when complete
- Requires valid snapshot handle

### CloseHandle
```
BOOL CloseHandle(
  [in] HANDLE hObject  // Process/module handle
);
```  
- Header: `Winbase.h`
- Invalidates handle and decrements object count
- Critical for resource cleanup after API operations

### OpenProcess
```
HANDLE OpenProcess(
  [in] DWORD dwDesiredAccess,  // PROCESS_TERMINATE (0x0001)
  [in] BOOL  bInheritHandle,
  [in] DWORD dwProcessId
);
```
- Header: `processthreadsapi.h`
- Returns NULL on failure
- Requires `PROCESS_QUERY_INFORMATION` for PID validation

### TerminateProcess
```
BOOL TerminateProcess(
  [in] HANDLE hProcess,
  [in] UINT   uExitCode
);
```
- Header: `processthreadsapi.h`
- Force-kills process and all threads
- Handle requires `PROCESS_TERMINATE` access

---

This readme was rewritten for clarity by AI

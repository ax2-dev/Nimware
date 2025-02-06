import winim
import os
import strutils

proc findProcessPID(processName: string): seq[DWORD] =
  var
    hSnapshot: HANDLE
    pe32: PROCESSENTRY32
    pids: seq[DWORD] = @[]
  
  pe32.dwSize = DWORD(sizeof(PROCESSENTRY32))
  hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
  
  if hSnapshot == INVALID_HANDLE_VALUE:
    stderr.writeLine "SNAPSHOT_ERROR:" & $GetLastError()
    quit(1)

  if Process32FirstW(hSnapshot, addr pe32) == FALSE:
    stderr.writeLine "ENUM_ERROR:" & $GetLastError()
    CloseHandle(hSnapshot)
    quit(1)

  while true:
    let currentProcess = $cast[WideCString](addr pe32.szExeFile[0])
    if currentProcess.strip().toLowerAscii() == processName.toLowerAscii().strip():
      pids.add(pe32.th32ProcessID)
    
    if Process32NextW(hSnapshot, addr pe32) == FALSE:
      break

  CloseHandle(hSnapshot)
  if pids.len == 0:
    stderr.writeLine "NO_PROCESS"
    quit(1)
  return pids

when isMainModule:
  if paramCount() != 1:
    stderr.writeLine "USAGE: " & getAppFilename() & " <executable name>"
    quit(1)
  
  let targetProcess = paramStr(1)
  let pids = findProcessPID(targetProcess)
  echo pids.join(",")

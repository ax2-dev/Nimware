import winim
import os
import strutils

proc terminateProcessByPID(pid: DWORD): bool =
  let hProcess = OpenProcess(PROCESS_TERMINATE, FALSE, pid)
  if hProcess == INVALID_HANDLE_VALUE:
    stderr.writeLine "OPEN_ERROR:" & $GetLastError()
    return false
  
  if TerminateProcess(hProcess, 1) == 0:
    stderr.writeLine "TERMINATE_ERROR:" & $GetLastError()
    CloseHandle(hProcess)
    return false
  
  CloseHandle(hProcess)
  return true

when isMainModule:    
  if paramCount() != 1:
    stderr.writeLine "USAGE: " & getAppFilename() & " <PID1>,<PID2>,..."
    quit(1)
  
  let pidsStr = paramStr(1)
  try:
    for pidStr in pidsStr.split(','):
      let pid = parseUInt(pidStr).DWORD
      if not terminateProcessByPID(pid):
        quit(1)
  except ValueError:
    stderr.writeLine "INVALID_PID:" & pidsStr
    quit(1)

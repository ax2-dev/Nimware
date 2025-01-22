import os, strutils, strformat

var path: string
var name: string

proc renameFiles(dirPath: string, newName: string) =
  if not dirExists(dirPath):
    echo "Error: Directory does not exist."
    return

  var counter = 1

  for kind, file in walkDir(dirPath):
    if kind == pcFile:
      let (_, _, extension) = splitFile(file)
      let newFileName = newName & "-" & $counter & extension
      let newFilePath = joinPath(dirPath, newFileName)

      if fileExists(newFilePath):
        echo &"Error: Target file {newFilePath} already exists. Skipping..."
      else:
        try:
          moveFile(file, newFilePath)
          echo &"Renamed: {file} -> {newFilePath}"
        except:
          echo &"Failed to rename: {file}"
      
      inc(counter)

echo "Enter the directory path:"
path = readLine(stdin).strip()
echo "Enter the new base name for files:"
name = readLine(stdin).strip()

renameFiles(path, name)

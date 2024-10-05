#!/bin/bash

# Get the Windows username dynamically
WINDOWS_USER=$(powershell.exe '$env:UserName' | tr -d '\r')

# Define the path to the Documents folder / Default for WIN11
DOCUMENTS_PATH="/mnt/c/Users/$WINDOWS_USER/Documents"

# Check if the path exists
if [ -d "$DOCUMENTS_PATH" ]; then
    # Use exec to replace the current shell process and move to the Documents directory
    exec bash --rcfile <(echo "cd '$DOCUMENTS_PATH'; exec bash")
else
    echo "Documents directory not found: $DOCUMENTS_PATH"
    exit 1
fi


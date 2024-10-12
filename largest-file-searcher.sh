#!/bin/bash

# Get the Windows username dynamically
WINDOWS_USER=$(powershell.exe '$env:UserName' | tr -d '\r')

# Define available folders to choose from
folders=("Downloads" "Desktop" "Documents" "Videos" "Pictures")

# Function to prompt the user to select a folder
select_folder() {
    echo "Please select the folder you want to search in:"
    for i in "${!folders[@]}"; do
        echo "$((i+1))) ${folders[$i]}"
    done

    # Read user input
    read -p "Enter the number corresponding to your choice: " folder_choice

    # Validate the user input
    if ! [[ "$folder_choice" =~ ^[1-5]$ ]]; then
        echo "Invalid choice. Please select a number between 1 and 5."
        select_folder
    fi

    # Return the selected folder
    selected_folder="${folders[$((folder_choice-1))]}"
    echo -e "\nYou selected: $selected_folder"
}

# Prompt the user to select a folder
select_folder

# Define the path to the user's selected folder
FOLDER_PATH="/mnt/c/Users/$WINDOWS_USER/$selected_folder"

# Check if the selected folder exists for the current user
if [ -d "$FOLDER_PATH" ]; then
    echo -e "\nSearching in $WINDOWS_USER's $selected_folder folder: $FOLDER_PATH"
    
    # Step 1: Count the number of files
    total_files=$(find "$FOLDER_PATH" -type f 2>/dev/null | wc -l)
    
    if [ "$total_files" -eq 0 ]; then
        echo "No files found in $WINDOWS_USER's $selected_folder."
        exit 0
    fi
    
    echo -e "\nTotal number of files: $total_files"

    # Step 2: Measure how long it takes to search a small portion (e.g., 10% of the files)
    sample_size=$((total_files / 10))
    if [ "$sample_size" -lt 1 ]; then
        sample_size=1
    fi

    # Start time measurement
    start_time=$(date +%s.%N)
    
    # Search a sample of files to estimate time
    find "$FOLDER_PATH" -type f -exec du -h {} + 2>/dev/null | head -n "$sample_size" > /dev/null
    
    # End time measurement
    end_time=$(date +%s.%N)

    # Calculate elapsed time for the sample
    elapsed_time=$(echo "$end_time - $start_time" | bc)

    # Estimate total time for all files (scaling up the time based on the sample)
    estimated_total_time=$(echo "$elapsed_time * $total_files / $sample_size" | bc)
    
    # Format the estimated time
    estimated_total_time_rounded=$(printf "%.2f" "$estimated_total_time")

    echo -e "\nEstimated time for completion: $estimated_total_time_rounded seconds"

    # Step 3: Show progress animation during actual search
    spin() {
        spinner='|/-\'
        while :; do
            for i in {0..3}; do
                printf "\rSearching... %s" "${spinner:$i:1}"
                sleep 0.1
            done
        done
    }

    # Start the spinner in the background
    spin &
    SPIN_PID=$!

    # Step 4: Perform the actual search for the top 10 largest files
    largest_files=$(find "$FOLDER_PATH" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10)

    # Kill the spinner once the search is done
    kill $SPIN_PID
    printf "\rSearch completed!\n"

    # Step 5: Display the results
    if [ -n "$largest_files" ]; then
        echo -e "\nTop 10 largest files in $WINDOWS_USER's $selected_folder:\n"
        echo "$largest_files"
    else
        echo "No large files found."
    fi
else
    echo "$WINDOWS_USER's $selected_folder folder not found."
    exit 1
fi


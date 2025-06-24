import os

def rename_png_files():
    # Get the current directory
    current_dir = os.getcwd()
    
    # Counter for renamed files
    renamed_count = 0
    
    # Iterate through all files in the current directory
    for filename in os.listdir(current_dir):
        # Check if the file is a PNG and contains the specific substring
        if filename.endswith('.png'):
            # Create the new filename by removing the specific substring
            new_filename1 = filename.replace('_mapicon_dota2+gameasset', '')
            new_filename2 = new_filename1.replace('_', '')
            new_filename3 = f"CDOTA_Unit_Hero_{new_filename2}"
            
            # Get full file paths
            old_path = os.path.join(current_dir, filename)
            new_path = os.path.join(current_dir, new_filename3)
            
            # Rename the file
            os.rename(old_path, new_path)
            
            # Increment counter
            renamed_count += 1
            
            # Print confirmation of each rename
            print(f"Renamed: {filename} -> {new_filename3}")
    
    # Print total number of files renamed
    print(f"\nTotal files renamed: {renamed_count}")

# Run the renaming function
rename_png_files()
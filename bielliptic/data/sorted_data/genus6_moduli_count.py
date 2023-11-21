import os
import sys
import ast

def count_lines_in_file(file_path):
    with open(file_path, 'r') as file:
        lines = file.read().split('\n')
        sum = 0
        for line in lines[:-1]: 
            sum += 1/ast.literal_eval(line)[1]
        return sum

def sum_lines_in_directory(directory_path):
    total_lines = 0

    # Iterate through all files in the directory
    for filename in os.listdir(directory_path):
        file_path = os.path.join(directory_path, filename)

        # Check if the file is a text file
        if os.path.isfile(file_path) and filename.endswith('.txt'):
            total_lines += count_lines_in_file(file_path)

    return total_lines

# Replace 'your_directory_path' with the path to your directory
directory_path = sys.argv[1]
total_lines = sum_lines_in_directory(directory_path)

print(f'Total number of lines in all text files in {directory_path}: {total_lines}')

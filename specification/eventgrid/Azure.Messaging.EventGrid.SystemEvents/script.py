# Go into the SystemEvents.json file and find the definitions section
# Separate the definitions into individual files based on the starting name of the definition 
# i.e ApiManagement..ApiManagementApiCreatedEventData goes into ApiManagement.json

import json
import pathlib
import os

user_path = os.environ['USER_PATH'] +'/examples/2024-01-01/'
tsp_path = os.environ['USER_PATH']


# Get all the example models and store them according to their event
examples = {}

for filename in os.listdir(user_path):
        file_path = os.path.join(user_path, filename)

        # Check if it's a file (not a directory)
        with open(file_path, 'r') as file:
            content = json.load(file)
            examples[content['type']] = content

            print(f"File: {filename}\nContent:\n{content}\n")

for filename in os.listdir(tsp_path):
    folder = os.path.join(tsp_path, filename)

    if filename != 'examples':
        try:
            for file in os.listdir(folder):
                file_path = os.path.join(folder, file)
                
                if not "client" in file_path and not "main" in file_path and not "property" in file_path and not "README" in file_path and not "tsconfig" in file_path and not "script" in file_path:
                
                    

                    # Check if it's a file (not a directory)
                    with open(file_path, 'r') as file:
                        content = file.readlines()
                        new_content = content


                        # Check if an example can live in this file
                        for keys in examples.keys():
                                indexes = 0
                                for line in new_content:
                                
                                    if keys in line:
                                        print(f"Found {keys} in {line}")
                                        example_name = keys.replace(".", "")
                                        # model_name = 
                                        # this needs to update for each example
                                        new_content = new_content[0:indexes]
                                        new_content.append(f"const {example_name}Example: {new_content} = #{examples[keys]["data"]}; \n")
                                        new_content.append(f"@example({example_name}Example)")
                                        new_content.extend(new_content[indexes::])
                                    indexes += 1
                    with open(file_path, 'w') as file:
                        file.writelines(new_content)

                            

        except:
             print(filename + " is not a folder")
                
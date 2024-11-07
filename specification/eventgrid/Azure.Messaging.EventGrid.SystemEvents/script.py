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
                    # if "AppConfiguration.tsp" in file_path:
                       
                    

                        # Check if it's a file (not a directory)
                        with open(file_path, 'r') as file:
                            content = file.readlines()
                            new_content = content
                            tmp_content = content



                            # Check if an example can live in this file
                            first = True
                            for keys in examples.keys():
                                    indexes = 0
                                    for line in new_content:
                                    
                                        if keys in line:
                                            print(f"Found {keys} in {line}")
                                            example_name = keys.replace(".", "")
                                            if "model " in new_content[indexes+1]:
                                                 model_name = new_content[indexes+1]
                                            elif "model " in new_content[indexes+2]:
                                                model_name = new_content[indexes+2]
                                            elif "model " in new_content[indexes+3]:
                                                model_name = new_content[indexes+3]
                                            else:
                                                 model_name = new_content[indexes+4]

                                            model_name = model_name.split()[1]

                                            import re

                                            # Regex pattern splits on substrings "; " and ", "
                                            data = re.split(': |, ', json.dumps(examples[keys]["data"]))
                                            data = json.dumps(examples[keys]["data"]).split(",")
                                            list_index = 0
                                            new_data = []
                                            for i in data:
                                                split_entry = i.split(":")
                                                first_entry = split_entry[0].replace('"', "")
                                                new_data.append(first_entry + ":" + ":".join(split_entry[1::]))
        
                                                list_index += 1
                                            my_data = ",".join(new_data)
                                                
                                            # this needs to update for each example
                                            if "*/" in new_content[indexes] and not "/**" in new_content[indexes]:
                                                 tmp_content = new_content[0:indexes+1]
                                                 indexes +=1
                                            elif "*/" in new_content[indexes] and "/**" in new_content[indexes]:
                                                tmp_content = new_content[0:indexes]
                                            elif "*/" in new_content[indexes+1]:
                                                tmp_content = new_content[0:indexes+2]
                                                indexes +=2
                                            elif "*/" in new_content[indexes+2]:
                                                tmp_content = new_content[0:indexes+3]
                                                indexes +=3
                                            else:
                                                tmp_content = new_content[0:indexes]
                                            tmp_content.append(f" \n const {example_name}Example: {model_name} = #{my_data}; \n")
                                            tmp_content.append(f"@example({example_name}Example) \n")
                                            tmp_content.extend(new_content[indexes::])
                                            first = False
                                            new_content = tmp_content
                                        indexes += 1
                        with open(file_path, 'w') as file:
                            file.writelines(new_content)

                            

        except Exception as e:
             print(e)
             print(filename + " is not a folder")
                
| Short Link: | [aka.ms/azsdk/sdk-automation-faq](https://aka.ms/azsdk/sdk-automation-faq) |
|--|--|

# FAQ

## How to Download the Generated Artifacts

### Prerequisites
Ensure the SDK automation CI check succeeds. If the check fails, the artifacts might not have been generated.

### Steps to Download Artifacts
Let's take Python as an example. 

1. Navigate to `Checks` page: click on the `Checks` tab in the navigation pane of the pull request.
   ![image](https://github.com/user-attachments/assets/109f7d90-52f6-45ed-ac12-ce2ae3e49af8)

2. View the `python` SDK Automation Run result: click on the `SDK azure-sdk-for-python` item in the left CI check list.
   ![image](https://github.com/user-attachments/assets/d38a0b96-d584-46c1-96ed-eec747652962)

3. View Azure DevOps Build Pipeline Run: click on the `View Azure DevOps build log for more details` link.
   
   ![image](https://github.com/Azure/azure-rest-api-specs/assets/20296335/64ec1f22-37df-4597-8259-3dd581656faa)
   
4. Browse to Pipeline Run Result: click on the `left` arrow.
   
   ![image](https://github.com/Azure/azure-rest-api-specs/assets/20296335/726c2e8a-9a39-4af2-b745-0136d53bee6d)
   
5. Access Artifacts Page: click on the `artifacts` link.
 
   ![image](https://github.com/Azure/azure-rest-api-specs/assets/20296335/b2c4c307-a430-4dec-bb09-5ac7e659a418)
   
6. Locate Generated Artifacts:
   The generated artifacts for Python are located under the `SDK_Artifact_Python` folder.
   
   ![image](https://github.com/Azure/azure-rest-api-specs/assets/20296335/4cecb794-0ec9-4092-a0cc-b45214438e1e)
   

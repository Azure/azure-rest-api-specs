| Short Link: | [aka.ms/azsdk/sdk-automation-faq](https://aka.ms/azsdk/sdk-automation-faq) |
|--|--|

# FAQ

## How to Download the Generated Artifacts

### Prerequisites

Ensure the **spec-gen-sdk** CI check succeeds. If the check fails, the artifacts might not have been generated.

### Steps to Download Artifacts

Let's take Python as an example.

1. Navigate to `Checks` page: click on the **Checks** tab in the navigation pane of the pull request.
   ![image](https://github.com/user-attachments/assets/109f7d90-52f6-45ed-ac12-ce2ae3e49af8)

2. View the **spec-gen-sdk - python - pullrequest** check result: click on the `spec-gen-sdk - python - pullrequest` item in the left CI check list.
   ![image](https://github.com/user-attachments/assets/72fb239d-d36a-45ae-8d56-50a25c37239a)

3. View Azure DevOps Build Pipeline Run: click on the `Pipeline result` link.
   ![image](https://github.com/user-attachments/assets/69f552bf-e226-40a4-96a8-035a7ec65f2f)

4. Access Artifacts Page: click on the `artifacts` link.
   ![image](https://github.com/Azure/azure-rest-api-specs/assets/20296335/b2c4c307-a430-4dec-bb09-5ac7e659a418)

5. Locate Generated Artifacts:
   The generated artifacts for Python are located under the **Packages** folder.
   ![image](https://github.com/user-attachments/assets/a6f1d800-4b3a-42ff-863a-45b50c201047)

### Steps to View the Html Report of `spec-gen-sdk` Checks Result

1. Refer to the former `Steps to Download Artifacts` to download html report file.
    ![image](https://github.com/user-attachments/assets/a8dfc245-333c-497f-a0a2-f7e2451b3863)

2. The html report is like this screenshot:
    ![image](https://github.com/user-attachments/assets/b0c50b7f-6ce7-4276-a2fb-2fa55d3b69c7)

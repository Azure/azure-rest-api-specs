| Short Link: | [aka.ms/azsdk/sdk-automation-faq](https://aka.ms/azsdk/sdk-automation-faq) |
|--|--|

# FAQ

- [FAQ](#faq)
  - [How to Download the Generated Artifacts](#how-to-download-the-generated-artifacts)
    - [Prerequisites](#prerequisites)
    - [Steps to Download Artifacts](#steps-to-download-artifacts)
  - [How to View the Html Report of `SDK Validation` Checks Result](#how-to-view-the-html-report-of-sdk-validation-checks-result)
  - [How to View the Detailed SDK Generation Errors](#how-to-view-the-detailed-sdk-generation-errors)
  - [Locating an Automatically Generated SDK Pull Request from Your API Specs](#locating-an-automatically-generated-sdk-pull-request-from-your-api-specs)
  - [.NET SDK Generation Error Fix Guidance](#net-sdk-generation-error-fix-guidance)
    - [How to Fix Naming Violations for Management Plane SDK](#how-to-fix-naming-violations-for-management-plane-sdk)

## How to Download the Generated Artifacts

### Prerequisites

Ensure the **SDK Validation** CI check succeeds. If the check fails, the artifacts might not have been generated.

### Steps to Download Artifacts

Let's take Python as an example.

1. Navigate to `Checks` page: click on the **Checks** tab in the navigation pane of the pull request.
   ![image](https://github.com/user-attachments/assets/109f7d90-52f6-45ed-ac12-ce2ae3e49af8)

2. View the **SDK Validation - Python** check result: click on the `SDK Validation - Python` item
 in the left CI check list.
   ![image](https://github.com/user-attachments/assets/3beb796f-0d53-4ad7-8f4c-d01657f283b4)

3. View Azure DevOps Build Pipeline Run: click on the `Pipeline result` link.
   ![image](https://github.com/user-attachments/assets/ff4512be-e49d-4d48-bb13-0b9898258d0b)

4. Access Artifacts Page: click on the `artifacts` link.
   ![image](https://github.com/Azure/azure-rest-api-specs/assets/20296335/b2c4c307-a430-4dec-bb09-5ac7e659a418)

5. Locate Generated Artifacts:
   The generated artifacts for Python are located under the **Packages** folder.
   ![image](https://github.com/user-attachments/assets/a6f1d800-4b3a-42ff-863a-45b50c201047)

## How to View the Html Report of `SDK Validation` Checks Result

1. Refer to the former `Steps to Download Artifacts` to download html report file.
    ![image](https://github.com/user-attachments/assets/a8dfc245-333c-497f-a0a2-f7e2451b3863)

2. The html report is like this screenshot:
    ![image](https://github.com/user-attachments/assets/b0c50b7f-6ce7-4276-a2fb-2fa55d3b69c7)

## How to View the Detailed SDK Generation Errors

1. Open the Azure DevOps Build Pipeline Run: click the `Pipeline result` link.
   ![image](https://github.com/user-attachments/assets/64caa353-a54c-4ebb-b8fa-800d50ae5dfe)

2. Examine the Pipeline Run Log: click directly on the `error` entry directly.
   ![Image](https://github.com/user-attachments/assets/42627c1e-6610-4bb3-9cf4-c7c4209080d7)

3. Review Detailed Log Information: expand the log group immediately above the error summary group.
   ![Image](https://github.com/user-attachments/assets/d9ea22f3-bdd1-42a0-9610-c9cd0339b8e5)

## Locating an Automatically Generated SDK Pull Request from Your API Specs

For detailed instructions, please refer to [Using the SDK Generation Pipelines](https://aka.ms/azsdk/spec-gen-sdk-pipeline-doc).

## .NET SDK Generation Error Fix Guidance

### How to Fix Naming Violations for Management Plane SDK

If your pipeline run logs already outline the naming violations, simply locate the reported issues and proceed as follows:

1. **Review the Pipeline Logs:**
   Identify the naming violations highlighted in the log output.

2. **Consult Naming Conventions:**
   Familiarize yourself with the [Naming Conventions](https://github.com/Azure/azure-sdk-for-net/blob/main/doc/dev/Mgmt-Naming-Conventions.md)
    guidelines to understand the expected naming rules.

3. **Apply Polishing Configurations:**
   Use the [Polishing Configurations](https://github.com/Azure/azure-sdk-for-net/blob/main/doc/dev/Mgmt-Polishing-Configurations.md)
    as a reference to adjust your SDK naming as per the conventions.

4. **Update and Validate:**
   Modify the specs to correct the naming issues and run the CI checks again to confirm that all violations have been resolved.

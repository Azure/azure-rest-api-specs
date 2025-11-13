---
description: "Guide the user to define and update TypeSpec based API spec for an azure service"
---

# Goal

Help the user define or update TypeSpec API specifications using the `azure-sdk-mcp` tools.

## 🧩 Context
This instruction applies to all tasks involving **TypeSpec**, including:
- Writing new TypeSpec definitions: service, api version, resource, models, operations
- Editing or refactoring existing TypeSpec files, editing api version, service, resource, models, or operations
- versioning evolution: 
    Making a preview api stable, 
    Replacing a preview API with a new preview API
    Replacing a preview API with a stable API
    Replacing a preview API with a stable API and a new preview API
    Adding a preview API version
    Adding a stable API version
    and so on

- Resolving TypeSpec-related issues

## ⚙️ Workflow Guidance

**When the task is to add a new api version**
- first identify current api versions which are stable version, which are preview version ( the version with suffix '-preview', For preview versions, the format should be YYYY-MM-DD-preview; For stable versions, the format should be YYYY-MM-DD (e.g., 2025-12-01)). Give out summary of the service api version and put it as meta data
- prompt user to provide the api version name and choose if is stable version or preview version.
- verify if the api version name match the azure version rule: preview version suffix '-preview'. If not, prompt user to suggest an api version name
- when add a new preview api version, and there are previous preview api version, prompt user to ask if it want to replace the previous api version or add a new one
- when add a new stable api version, and the current latest api version is previous version, prompt user to ask if it want to replace the previous api version or not

When encountering a TypeSpec-related task, follow this process:

### Step 1: Call the `azure-sdk-mcp/azsdk_ai_qa_completion` tool

Use this tool to retrieve validated solutions, suggestions, or fixes for TypeSpec issues. Combine the user’s question with all provided metadata (such as context, role, service name, decorators, versioning details, and any additional parameters) to construct a comprehensive query. Ensure the query is precise, includes relevant technical terms, and targets authoritative sources for TypeSpec and Azure API guidance.

### Step 2: Extract the solution from the tool result

Parse the response from `azure-sdk-mcp/azsdk_ai_qa_completion` to identify the recommended fix or implementation.

### Step 3: Execute the solution

Apply the extracted solution to update the TypeSpec file accordingly.


### Step 4: Summary the solution

Summary the solution taken, and display the reference doc url from the response from `azure-sdk-mcp/azsdk_ai_qa_completion` tool

**When the task is to add a new api version, add following extra step:**

### Step 5: Suggestion follow up action

ask user whether he want to perform following actions:
- Add new operations (create, update, delete, list, etc.)
- Add new resource types or models
- Modify existing operations
- Add new properties to existing models


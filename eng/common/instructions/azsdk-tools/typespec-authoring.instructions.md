---
description: "Guide the user to define and update TypeSpec based API spec for an azure service"
---

# Goal

Help the user define or update TypeSpec API specifications using the `azure-sdk-mcp` tools.

## 🧩 Context
This instruction applies to all tasks involving **TypeSpec**, including:
- Writing new TypeSpec definitions: service, api version, resource, models, operations
- Editing or refactoring existing TypeSpec files, editing service, resource, models, or operations
- Resolving TypeSpec-related issues

## ⚙️ Workflow Guidance

When encountering a TypeSpec-related task, follow this process:

### Step 1: Call the `azure-sdk-mcp/azsdk_ai_qa_completion` tool

Use this tool to retrieve validated solutions, suggestions, or fixes for TypeSpec issues.

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


---
mode: 'agent'
tools: ['CheckServiceLabel', 'isValidCodeOwner', 'ValidateCodeOwnersForService', 'AddCodeownerEntry', 'AddCodeowner', 'DeleteCodeowner'] 
---

# Goal
- We need to check that a service label is valid and exists within the azure-sdk-tools repository before we can move onto verifying codeowners. Once we complete that and a service label is validated, verify that every associated codeowner in each SDK language repository for that service label is also valid.

## Prerequisites
- Ensure that the user has a valid service label for their service using the `CheckServiceLabel` tool.

## Step 1: Validate Existing Codeowners
- Using the `ValidateCodeOwnersForService` tool, check if all code owners for the service label in all SDK language repositories are valid.
- If all codeowners are valid, move to step 2.
- If any codeowner is invalid:
    - Inform the user why the codeowner(s) are invalid and provide guidance on how to fix them.
    - Each codeowner MUST be PUBLIC members of the Microsoft and Azure organizations with write access.


## Step 2: Modify Codeowners
- Prompt the user if they want to modify (add or delete) codeowners for the service label.
- If the user wants to add a codeowner:
    - Use the `isValidCodeOwner` tool to check if the codeowner they want to add is valid.
    - If valid:
        - Ask which language repository or repositories they want to add the codeowner to. (e.g., Python, Java, etc.)
        - Check if the service already exists in the codeowners file for the selected repository or repositories.
            - If service does not exist in the codeowners file, use the `AddCodeownerEntry` tool to add a new service entry along with its codeowner
            - If the service already exists, use the `AddCodeowner` tool to add the new codeowner to the existing entry.
    - If invalid, inform the user that the codeowner is invalid and provide guidance on how to fix it.
- If the user wants to delete a codeowner:
    - Ask which language repository or repositories they want to delete the codeowner from.
    - Use the `DeleteCodeowner` tool to remove the codeowner from the specified repository or repositories.
    - If the service entry would become empty after deletion, prompt the user that they must provide a new codeowner.
        - If the user does not provide a new codeowner, DO NOT delete the codeowner. Each service entry must have at least one codeowner.

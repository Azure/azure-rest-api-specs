---
mode: 'agent'
tools: ['CheckServiceLabel', 'isValidCodeOwner', 'ValidateCodeOwnersForService', 'AddCodeOwnerEntry', 'AddCodeOwners', 'DeleteCodeOwners'] 
---

# Goal
- We need to check that a service label is valid and exists within the azure-sdk-tools repository before we can move onto verifying code owners. Once we complete that and a service label is validated, verify that every associated code owner in each SDK language repository for that service label is also valid.

## Prerequisites
- Ensure that the user has a valid service label for their service using the `CheckServiceLabel` tool.

## Step 1: Validate Existing Code Owners
- Using the `ValidateCodeOwnersForService` tool, check if all code owners for the service label in all SDK language repositories are valid.
- If all code owners are valid, move to step 2.
- If any code owner is invalid:
    - Inform the user why the code owner(s) are invalid and provide guidance on how to fix them.
    - Each code owner MUST be PUBLIC members of the Microsoft and Azure organizations with write access.


## Step 2: Modify Code Owners
- Prompt the user if they want to modify (add or delete) code owners for the service label.
- If the user wants to add a code owner:
    - Use the `isValidCodeOwner` tool to check if the code owner they want to add is valid.
    - If valid:
        - Ask which language repository or repositories they want to add the code owner to. (e.g., Python, Java, etc.)
        - Check if the service already exists in the code owners file for the selected repository or repositories.
            - If service does not exist in the code owners file, use the `AddCodeOwnerEntry` tool to add a new service entry along with its code owner
            - If the service already exists, use the `AddCodeOwners` tool to add the new code owners to the existing entry.
    - If invalid, inform the user that the code owners are invalid and provide guidance on how to fix it.
- If the user wants to delete a code owner:
    - Ask which language repository or repositories they want to delete the code owner from.
    - Use the `DeleteCodeOwners` tool to remove the code owner from the specified repository or repositories.
    - If the service entry would become empty after deletion, prompt the user that they must provide a new code owner.
        - If the user does not provide a new code owner, DO NOT delete the code owner. Each service entry must have at least one code owner.

---
mode: 'agent'
tools: ['CheckServiceLabel',  'isValidCodeOwner', 'ValidateCodeOwnersForService', 'AddCodeOwnerEntry'] 
---

# Goal
- We need to check that a service label is valid and exists within the azure-sdk-tools repository before we can move onto verifying code owners. Once we complete that and a service label is validated, verify that every associated code owner in each SDK language repository for that service label is also valid.

## Prerequisites
- Ensure that the user has a valid service label for their service using the `CheckServiceLabel` tool.

## Validate Existing Code Owners
- If `CreateServiceLabel` was not used by the user and a new service label was NOT created (the service already exists within the CODEOWNERS file), use the `ValidateCodeOwnersForService` tool to check if all code owners for the existing service label in all SDK language repositories are valid.
- If all code owners are valid, user may skip remaining steps and proceed in the SDK release process.
- If any code owner is invalid:
    - Inform the user why the code owner(s) are invalid and provide guidance on how to fix them.
    - Each code owner MUST be PUBLIC members of the Microsoft and Azure organizations with write access.


## Modify Code Owners
- If `CreateServiceLabel` was used by the user and a new service label was created, use `AddCodeOwnerEntry` to add the new service to the CODEOWNERS file for all SDK language repositories.
    - The entry in CODEOWNERS file should follow the format: `/<service-path> @<code-owner-username>`. There can be multiple code owners for a service, but user must specify all of them.
    - Verify that the code owner usernames are all valid using `isValidCodeOwner` and follow the required format.
    - After changing the CODEOWNERS file, give the user a link to the pull request for review and merging. If they want to add additional fields for their service, they can do so in the pull request.
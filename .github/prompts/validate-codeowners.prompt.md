---
mode: 'agent'
tools: ['CheckServiceLabel',  'isValidCodeOwner', 'ValidateCodeOwnersForService', 'AddCodeOwnerEntry'] 
---

## Links
- [Joining Microsoft Organization](https://repos.opensource.microsoft.com/orgs/Microsoft)
- [Joining Azure Organization](https://repos.opensource.microsoft.com/orgs/Azure)
- [Visibility for Azure Org](https://github.com/orgs/Azure/people)
- [Visibility for Microsoft Org](https://github.com/orgs/Microsoft/people)
- [Requesting Write Acess](https://coreidentity.microsoft.com/manage/Entitlement/entitlement/azuresdkpart-heqj)

# Goal
- We need to check that a service label is valid and exists within the azure-sdk-tools repository before we can move onto verifying code owners. Once we complete that and a service label is validated, verify that every associated code owner in the specified SDK language repository for that service label is also valid.

## Prerequisites
- Ensure that the user has a valid service label for their service using the `CheckServiceLabel` tool.

## Validate Existing Code Owners
- If `CreateServiceLabel` was not used by the user and a new service label was NOT created (the service already exists within the CODEOWNERS file), use the `ValidateCodeOwnersForService` tool.
- If any users are invalid direct them to the below links based on their situation.
- If all code owners are valid, user may skip remaining steps and proceed in the SDK release process.
    - **For Missing Microsoft Organization Membership**: Direct them to [Joining Microsoft Organization] to join the organization and then [Visibility for Microsoft Org] to change their membership to public.
    - **For Missing Azure Organization Membership**: Direct them to [Joining Azure Organization] to join the organization and then [Visibility for Azure Org] to change their membership to public.
    - **For Missing Write Access**: Direct them to [Requesting Write Access] to request repository permissions
    - Inform the user why the code owner(s) are invalid and provide guidance on how to fix them.
    - Each code owner MUST be PUBLIC members of the Microsoft and Azure organizations with write access.

## Modify Code Owners
- If `CreateServiceLabel` was used by the user and a new service label was created, use `AddCodeOwnerEntry` to add the new service to the CODEOWNERS file for the specified SDK language repository.
    - The entry in CODEOWNERS file should follow the format: `/<service-path> @<code-owner-username>`. There can be multiple code owners for a service, but user must specify all of them.
    - Verify that the code owner usernames are all valid using `isValidCodeOwner` and follow the required format.
    - After changing the CODEOWNERS file, give the user a link to the pull request for review and merging. If they want to add additional fields for their service, they can do so in the pull request.
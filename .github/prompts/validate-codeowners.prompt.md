---
mode: 'agent'
tools: ['CheckServiceLabel', 'isValidCodeOwner', 'ValidateCodeOwners', 'AddCodeOwnerEntry'] 
---

# Validate Code Owners for SDK Services

## Goal
Validate that a service label exists and verify that all associated code owners in the specified SDK language repository for that service are valid GitHub users with proper permissions.

## Prerequisites
- User must have a valid service label for their service
- Service must be part of the Azure SDK ecosystem

## Process Overview
This process involves two main phases:
1. **Service Label Validation**: Verify the service label exists in common-labels.csv
2. **Code Owner Validation**: Ensure all code owners have proper GitHub permissions

---

## Step 1: Validate Service Label
- Use `CheckServiceLabel` tool to verify the service label exists in the azure-sdk-tools repository
- If the service label is **DoesNotExist**:
  - Inform the user that the service label doesn't exist
  - Direct them to create a new service label first before proceeding
  - Stop the validation process until service label is created
- If the service label is **NotAServiceLabel**:
  - Inform the user that the service label exists, but it is not a 'service' label.
  - Direct them to create a new service label first, but it can't be the one they just checked.
  - Stop the validation process until service label is created.
- If the service label is **Exists**:
  - Display the service label details to the user
  - Proceed to Step 2
- If the service label is **InReview**:
  - Inform the user that the service label is currently waiting for a PR approval.
  - Proceed to Step 2

## Step 2: Determine Repository and Validate Code Owners
- Ask the user to specify which SDK language repository they want to validate (e.g., "python", "net", "java", "js", "rest-api-specs")
or, if the user is in a SDK language repository, use that one instead. Ensure they provide either the serviceLabel or repoPath.
- Use `ValidateCodeOwners` tool with:
  - `repoName`: The specified SDK repository name.
  - `serviceLabel`: The validated service label from Step 1
  - `repoPath`: The service path (e.g., "/sdk/contoso/" or "/sdk/contoso_service/contoso_subservice/").This should be the path generated in step 7 within `typespec-to-sdk`.

## Step 3: Handle Validation Results
Based on the validation results:

### If ALL code owners are valid:
- Display success message: "All code owners for service '[service-label]' in repository '[repo-name]' are valid"
- Inform user they can proceed with the SDK release process
- End validation process

### If ANY code owners are invalid:
- Display which code owners are invalid and why
- Provide specific guidance based on the type of issue:

#### For Missing Microsoft Organization Membership:
- **Issue**: User is not a member of the Microsoft organization
- **Action**: Direct them to [Joining Microsoft Organization](https://repos.opensource.microsoft.com/orgs/Microsoft)
- **Follow-up**: After joining, visit [Microsoft Org Visibility](https://github.com/orgs/Microsoft/people) to change membership to public

#### For Missing Azure Organization Membership:
- **Issue**: User is not a member of the Azure organization  
- **Action**: Direct them to [Joining Azure Organization](https://repos.opensource.microsoft.com/orgs/Azure)
- **Follow-up**: After joining, visit [Azure Org Visibility](https://github.com/orgs/Azure/people) to change membership to public

#### For Missing Write Access:
- **Issue**: User lacks write permissions to the repository
- **Action**: Direct them to [Request Write Access](https://coreidentity.microsoft.com/manage/Entitlement/entitlement/azuresdkpart-heqj)

#### Requirements Summary:
Each code owner MUST:
- Be a PUBLIC member of both Microsoft and Azure organizations on GitHub
- Have write access to the specific SDK repository
- Have their GitHub profile visibility set to public in both organizations

## Step 4: Adding New Code Owners (If Applicable)
**Note**: This step only applies when a NEW service label was created and needs to be added to CODEOWNERS files.

If the user needs to add code owners for a new service:
- Use `AddCodeOwnerEntry` tool with:
  - `repo`: The target SDK repository.
  - `path`: The service path (e.g., "/sdk/contoso/" or "/sdk/contoso_service/contoso_subservice/").
  - `serviceLabel`: The created service label.
  - `serviceOwners`: Array of GitHub usernames.
  - `sourceOwners`: Array of GitHub usernames.

### Code Owner Types:
- **Service Owner**: Responsible for service-related issues and questions
- **Source Owner**: Responsible for generated SDK code and pull requests

### Multiple Code Owners:
- A service can have multiple code owners
- User must specify all code owners and their roles
- All code owners must meet the validation requirements from Step 3

## Step 5: Completion
- If adding new code owners, provide the user with the pull request link for review and merging
- Inform user that additional service fields can be added directly in the pull request if needed
- Confirm that code owner validation is complete

---

## Error Handling
- If `CheckServiceLabel` fails: Ask user to verify the service label spelling and try again
- If `ValidateCodeOwners` fails: Check repository name spelling and service label validity
- If `AddCodeOwnerEntry` fails: Verify all parameters are correct and user has necessary permissions

## Success Criteria
- Service label exists and is valid
- All code owners are valid GitHub users
- All code owners have proper organization memberships and permissions
- CODEOWNERS file is updated (if new service was added)
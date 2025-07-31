---
mode: 'agent'
tools: ['CheckServiceLabel', 'CheckServiceExistsInCodeowners', 'ValidateCodeOwnerEntryForService', 'AddCodeownerEntry'] 
---

# Validate Code Owners for SDK Services

## Goal
Validate that a service label exists and verify that all associated code owners in the specified SDK language repository for that service are valid GitHub users with proper permissions.

## Prerequisites
- User must have a valid service label for their service
- Service must be part of the Azure SDK ecosystem

## Process Overview
This process involves three main phases:
1. **Service Label Validation**: Verify the service label exists in common-labels.csv
2. **Service Existence Check**: Check if the service exists in the CODEOWNERS file
3. **Code Owner Validation or Creation**: Either validate existing code owners or create new entry

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

## Step 2: Determine Repository and Check Service Existence
- Ask the user to specify which SDK language repository they want to validate (e.g., "python", "dotnet", "java", "javascript", "rest-api-specs")
or, if the user is in a SDK language repository, use that one instead.
- Use `CheckServiceExistsInCodeowners` tool with:
  - `repoName`: The specified SDK repository name. **Should be one of the following: 'dotnet', 'cpp', 'go', 'java', 'javascript', 'python', 'rest-api-specs', 'rust'.**
  - `serviceLabel`: The validated service label from Step 1 (optional)
  - `repoPath`: The service path (e.g., "/sdk/contoso/" or "/sdk/contoso_service/contoso_subservice/"). This should be the path generated in step 7 within `typespec-to-sdk` (optional)

**Note**: You must provide either `serviceLabel` OR `repoPath` (or both). The tool will check if matching CODEOWNERS entries exist.

## Step 3: Branch Based on Service Existence

### If `CheckServiceExistsInCodeowners` returns `true` (Service EXISTS):
- Proceed to **Step 4A: Validate Existing Code Owners**

### If `CheckServiceExistsInCodeowners` returns `false` (Service DOES NOT EXIST):
- Proceed to **Step 4B: Create New Code Owner Entry**

---

## Step 4A: Validate Existing Code Owners
When the service exists in CODEOWNERS, validate all associated code owners:

- Use `ValidateCodeOwnerEntryForService` tool with:
  - `repoName`: The same repository name from Step 2
  - `serviceLabel`: The validated service label from Step 1 (optional)
  - `repoPath`: The service path (optional)

The tool returns a `ServiceCodeOwnerResult` object with:
- `Repository`: The full repository name (e.g., "azure-sdk-for-net")
- `Status`: Status of the validation
- `Message`: Descriptive message about the results
- `CodeOwners`: Array of code owner validation results

### Handle Validation Results:

#### If ALL code owners are valid:
- Display success message: "All code owners for service '[service-label]' in repository '[repo-name]' are valid"
- Show the list of validated code owners with their details
- Inform user they can proceed with the SDK release process
- End validation process

#### If ANY code owners are invalid:
- Display which code owners are invalid and why
- Show specific validation details for each code owner
- Provide specific guidance based on the type of issue:

##### For Missing Microsoft Organization Membership:
- **Issue**: User is not a member of the Microsoft organization
- **Action**: Direct them to [Joining Microsoft Organization](https://repos.opensource.microsoft.com/orgs/Microsoft)
- **Follow-up**: After joining, visit [Microsoft Org Visibility](https://github.com/orgs/Microsoft/people) to change membership to public

##### For Missing Azure Organization Membership:
- **Issue**: User is not a member of the Azure organization  
- **Action**: Direct them to [Joining Azure Organization](https://repos.opensource.microsoft.com/orgs/Azure)
- **Follow-up**: After joining, visit [Azure Org Visibility](https://github.com/orgs/Azure/people) to change membership to public

##### For Missing Write Access:
- **Issue**: User lacks write permissions to the repository
- **Action**: Direct them to [Request Write Access](https://coreidentity.microsoft.com/manage/Entitlement/entitlement/azuresdkpart-heqj)

##### Requirements Summary:
Each code owner MUST:
- Be a PUBLIC member of both Microsoft and Azure organizations on GitHub
- Have write access to the specific SDK repository
- Have their GitHub profile visibility set to public in both organizations

---

## Step 4B: Create New Code Owner Entry
When the service does NOT exist in CODEOWNERS, create a new entry:

- Inform the user: "No existing CODEOWNERS entry found for this service. Creating a new entry."
- Collect required information from the user:
  - **Service Owners**: GitHub usernames responsible for service-related issues
  - **Source Owners**: GitHub usernames responsible for generated SDK code and pull requests
- Use `AddCodeownerEntry` tool with:
  - `repo`: The target SDK repository (e.g., "dotnet", "python", etc.)
  - `path`: The service path (e.g., "/sdk/contosowidgetmanager/")
  - `serviceLabel`: The validated service label
  - `serviceOwners`: Array of GitHub usernames for service owners
  - `sourceOwners`: Array of GitHub usernames for source owners
  - `workingBranch`: (Optional) Existing branch name if adding to an existing SDK generation branch

### Code Owner Validation Before Adding:
The tool automatically validates all provided code owners before creating the entry:
- **Service owners validation**: Checks if users are valid but allows some flexibility
- **Source owners validation**: Requires at least one valid source owner with proper permissions
- **Service label validation**: Ensures the service label exists and is valid

### Multiple Code Owners:
- A service can have multiple service owners and source owners
- User must specify all code owners and their roles
- At least one source owner must be valid for the entry to be created

---

## Step 5: Completion
### For Validation (Step 4A):
- Display validation results summary
- Inform user they can proceed with the SDK release process (if all valid)
- Provide remediation steps (if any invalid code owners found)

### For Creation (Step 4B):
- The tool will:
  - Create or reuse an existing branch (if `workingBranch` provided)
  - Add the codeowner entry to the CODEOWNERS file
  - Create a pull request or update an existing one
  - Provide the user with the pull request link for review and merging
- Display the results including:
  - Branch information
  - Pull request URL
  - Any validation messages or warnings
- Inform user that additional service fields can be added directly in the pull request if needed

### Final Steps:
- Confirm that code owner validation/creation is complete
- User can proceed with the SDK release process

---

## Error Handling
- If `CheckServiceLabel` fails: Ask user to verify the service label spelling and try again
- If `CheckServiceExistsInCodeowners` fails: Check repository name spelling and service label/path validity
- If `ValidateCodeOwnerEntryForService` fails: Check repository name spelling and service label/path validity
- If `AddCodeownerEntry` fails: 
  - Check that all parameters are correct
  - Verify user has necessary permissions
  - Ensure at least one valid source owner is provided
  - Confirm service label exists and is valid

## Success Criteria
- Service label exists and is valid
- Service existence in CODEOWNERS is properly determined
- For existing services: All code owners are valid GitHub users with proper permissions
- For new services: CODEOWNERS file is updated with new entry and pull request created successfully
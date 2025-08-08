---
mode: 'agent'
tools: ['CheckServiceLabel', 'ValidateCodeOwnerEntryForService', 'UpdateCodeowners'] 
---
# Validate Code Owners for SDK Services
 
## Goal
Validate that a service label exists and verify that all associated code owners in the specified SDK language repository for that service are valid GitHub users with proper permissions.
 
## Prerequisites
- User must have a valid service label for their service
- Service must be part of the Azure SDK ecosystem
 
## Process Overview
1. **Service Label Validation**: Verify the service label exists in common-labels.csv
2. **Code Owner Validation**: Validate code owners for the service if they exist
3. **Code Owner Management**: Create new entries or update existing entries as needed
 
---
 
## Step 1: Validate Service Label
- Use `CheckServiceLabel` tool to verify the service label exists in the azure-sdk-tools repository and can be used for the SDK service.
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
- Ask the user to specify which SDK language repository they want to validate (e.g., "python", "dotnet", "java", "javascript", "rest-api-specs")
or, if the user is in a SDK language repository, use that one instead.
- Use `ValidateCodeOwnerEntryForService` tool with:
  - `repoName`: The specified SDK repository name. **Should be one of the following: 'dotnet', 'cpp', 'go', 'java', 'javascript', 'python', 'rest-api-specs', 'rust'.**
  - `serviceLabel`: The validated service label from Step 1 (optional)
  - `repoPath`: The service path (e.g., "/sdk/contoso/" or "/sdk/contoso_service/contoso_subservice/"). This should be the path generated in step 7 within `typespec-to-sdk` (optional)
 
**Note**: You must provide either `serviceLabel` OR `repoPath` (or both). The tool will check the validity of each codeowner for that SDK language.
 
### If `ValidateCodeOwnerEntryForService` finds a matching code owner entry:
- Proceed to **Step 3: Validate Existing Code Owners**
 
### If `ValidateCodeOwnerEntryForService` is unable to find a matching code owner entry:
- Proceed to **Step 4B: Create New Code Owner Entry**
 
---
 
## Step 3: Validate Existing Code Owners
When the service exists in CODEOWNERS, validate all associated code owners:
 
The `ValidateCodeOwnerEntryForService` tool returns a `ServiceCodeOwnerResult` object with:
- `Message`: Descriptive message about the results
- `CodeOwners`: Array of code owner validation results that contains information about each code owner's validity
 
### Handle Validation Results:
In order to be valid, each code owner MUST:
  - Be a PUBLIC member of both Microsoft and Azure organizations on GitHub
  - Have write access to the specific SDK repository
  - Have their GitHub profile visibility set to public in both organizations
 
#### If at least 2 code owners are valid:
- Display success message: "Service '[service-label]' in repository '[repo-name]' meets minimum requirements with [X] valid code owners"
- Show the list of validated code owners with their details (valid and invalid)
- **MINIMUM REQUIREMENTS MET**: Proceed to **Step 4A: Optional Code Owner Management**
 
#### If less than 2 code owners are valid:
- **MINIMUM REQUIREMENTS NOT MET**: Display validation results showing which code owners are valid/invalid and how they specifically failed validation
- **CRITICAL**: Inform the user that **at least 2 code owners must be valid before proceeding with the SDK release process**
- Present the following options to reach the minimum requirement:
  1. **Fix Invalid Code Owners**: Guide them to update permissions so there are at least 2 valid owners (recommended)
  2. **Add New Code Owners**: Add additional valid code owners to reach the minimum of 2 valid owners
  3. **Remove Invalid + Add New**: Remove invalid owners and add valid ones to ensure at least 2 valid owners remain
 
#### Reaching Minimum Requirements:
 
**Option 1: Fix Invalid Code Owners**
- Provide specific guidance based on the type of issue for each invalid owner
- After providing guidance, **re-run validation** using `ValidateCodeOwnerEntryForService` to confirm fixes
- Continue until at least 2 code owners are valid
 
**Option 2: Add New Valid Code Owners**
- Collect new GitHub usernames to add as service owners or source owners
- Use `UpdateCodeowners` with `isAdding: true` to add the new owners
- **Re-validate**: Use `ValidateCodeOwnerEntryForService` to confirm at least 2 owners are now valid
 
**Option 3: Remove Invalid + Add Valid Owners**
- Confirm which invalid owners to remove and which valid owners to add
- Execute removal first: `UpdateCodeowners` with `isAdding: false`
- Execute addition: `UpdateCodeowners` with `isAdding: true`
- **Re-validate**: Confirm at least 2 owners are valid after both operations
 
#### Guidance for Fixing Invalid Code Owners:
 
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
 
#### Validation Loop for Minimum Requirements:
After any fixes or changes:
1. **Re-run Validation**: Use `ValidateCodeOwnerEntryForService` to verify current status
2. **Check Results**:
   - If at least 2 code owners are valid → Proceed to **Step 4A: Optional Code Owner Management**
   - If less than 2 code owners are valid → Return to fixing/adding options above
3. **Repeat Until Minimum Met**: Continue this loop until at least 2 valid code owners exist
4. **No Progression**: Do not proceed to Step 4 until minimum requirements are satisfied
 
---
## Step 4: Code Owner Management
 
## Step 4A: Optional Code Owner Management
**PREREQUISITE**: At least 2 valid code owners exist (minimum requirements met from Step 3)
 
Now that minimum requirements have been satisfied, users can optionally add or remove additional code owners. This step is **OPTIONAL** - users can skip to the next step if no additional changes are needed.
 
### Optional CODEOWNERS Management:
Ask the user if they want to make additional changes to their service's code owners:
- If yes, use `UpdateCodeowners` tool to:
  - **Add New Code Owners**: Add additional valid code owners
  - **Remove Existing Code Owners**: Remove invalid or unnecessary code owners
- **MINIMUM PROTECTION**: Do NOT allow any add/remove operations that would result in less than 2 valid code owners
 
### After Optional Changes:
- Display final owner list and validation results
- Confirm at least 2 valid code owners exist
- Provide summary of any changes made

 
## Step 4B: Create New Code Owner Entry
**TRIGGER**: This step is reached when `ValidateCodeOwnerEntryForService` finds no matching code owner entry exists
 
When the service does NOT exist in CODEOWNERS, create a new entry with valid owners:
 
### Requirements for New Entry:
- **MINIMUM**: Must have at least 2 valid code owners from the start
- **NO EXCEPTIONS**: Cannot create entry with insufficient or invalid owners
 
### Process:
1. **Inform User**: "No existing CODEOWNERS entry found for this service. Creating a new entry requires at least 2 valid code owners."
2. **Collect Required Information**:
   - **Service Owners**: GitHub usernames responsible for service-related issues
   - **Source Owners**: GitHub usernames responsible for generated SDK code and pull requests
3. Use `UpdateCodeowners` tool with:
   - `repo`: The target SDK repository (e.g., "dotnet", "python", etc.)
   - `typeSpecProjectRoot`: The TypeSpec project root path (e.g., "specification/contosowidgetmanager/Contoso.WidgetManager/main.tsp")
   - `path`: The service path (e.g., "/sdk/contosowidgetmanager/")
   - `serviceLabel`: The validated service label
   - `serviceOwners`: Array of valid GitHub usernames for service owners
   - `sourceOwners`: Array of valid GitHub usernames for source owners
   - `isAdding`: `false`
   - `workingBranch`: (Optional) Existing branch name if adding to an existing SDK generation branch
4. Display the results including:
   - Pull request URL (if created)
   - Validation status of all owners
   - Any additional messages or warnings
 
---
 
### Final Steps:
- Confirm that code owner validation/management is complete
- Verify minimum requirements (2+ valid owners) are maintained
- User can proceed with the SDK release process
 
---
 
## Error Handling
- If `CheckServiceLabel` fails: Ask user to verify the service label spelling and try again
- If `ValidateCodeOwnerEntryForService` fails: Check repository name spelling and service label/path validity
- If `UpdateCodeowners` fails:
  - Check that all parameters are correct
  - Verify user has necessary permissions
  - For remove operations: Ensure at least 2 valid owners will remain
  - For add operations: Verify new owners meet validation requirements
  - Confirm service label exists and is valid
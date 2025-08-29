---
mode: 'agent'
tools: ['azsdk_check_service_label', 'azsdk_engsys_validate_codeowners_entry_for_service', 'azsdk_engsys_codeowner_update'] 
---

## Goal: 
Validate service label and ensure at least 2 valid code owners exist for SDK repositories.

## Step 1: Validate Service Label
Use `azsdk_check_service_label` to verify the service label exists:
- **DoesNotExist/NotAServiceLabel**: 
   - Direct user to create valid service label first. Stop validation process until service label is created.
   - Once a service label has been created, proceed to Step 2.

 - **Exists/InReview**:
   - Explicitly explain to the user that the service label was found and is valid before proceeding.
   - After explaing to the user, proceed to Step 2 immediately.

## Step 2: Validate Code Owners
Ask the user to specify the SDK repository to validate code owners for, or detect from context.

Repository name mapping:
- .NET/dotnet: "azure-sdk-for-net"
- Python: "azure-sdk-for-python"
- Java: "azure-sdk-for-java"
- JavaScript: "azure-sdk-for-js"
- Go: "azure-sdk-for-go"

Use `azsdk_engsys_validate_codeowners_entry_for_service` with either `serviceLabel`, `repoPath`, or both. At least one must be used. If one isn't provided, leave the parameter field empty.

**If a codeowners entry exists:**
- Always output the code owner details in the following format:
  - `<GitHub username>:`
    - Valid code owner: Yes/No
    - Microsoft organization: Valid/Invalid
    - Azure organization: Valid/Invalid
    - Write access: Yes/No
    - issues/reasons for invalidity (if any), see Fix Options.
- Proceed to Step 3.

**If no entry exists:**
- Proceed to Step 4.

## Step 3: Check Existing Code Owners
Valid code owners must:
- Be PUBLIC members of both Microsoft and Azure GitHub organizations
- Have write access to the SDK repository

**If at least 2 valid owners:**
- Success. Optionally prompt the user to add or delete additional owners.

**If less than 2 valid owners:**
- CRITICAL: Must fix before proceeding.

After any changes, re-validate with `azsdk_engsys_validate_codeowners_entry_for_service`.

## Step 4: Create New Code Owner Entry
When no CODEOWNERS entry exists yet:
1. Ensure you have the following information:
   - repo - **Required** - Repository name mapping:
      - .NET/dotnet: use "azure-sdk-for-net"
      - Python: use "azure-sdk-for-python" 
      - Java: use "azure-sdk-for-java"
      - JavaScript: use "azure-sdk-for-js"
      - Go: use "azure-sdk-for-go"
   - typeSpecProjectRoot - **Optional** This should be acquired only if the information is present in the previous chat history, if not, ignore and input `""`.
   - path - **Optional** only if there is a service label and we're not making a new entry - This should be acquired when creating a new code owner entry, if no information is present ask the user. Typically looks like `/sdk/projectpath`
   - serviceLabel - **Optional** only if there is a path and we're not making a new entry - This should be acquired from the previous step of Check or Create Service Label.
   - serviceOwners - **Optional** if no ServiceLabel is present. Can be either owners to add or delete, depending on isAdding.
   - sourceOwners - **Optional** if no path or PRLabel are present. Can be either owners to add or delete, depending on isAdding.
   - isAdding - **Required** Should be true if adding owners to an existing entry, false if deleting owners from an existing entry. Should also be false when adding a brand new entry.

2.
- Ask the user to provide the GitHub usernames for both service owners (for issues) and source owners (for PRs). Make it clear that at least 2 valid owners are required for each.
- If making a brand new entry, ensure that you ask for both the path AND service label.

3. Provide information to the user about what codeowners is for:
   - [Learn about CODEOWNERS](https://eng.ms/docs/products/azure-developer-experience/develop/supporting-sdk-customers/overview)
   - Service owners are mentioned on issues.
   - Source owners are mentioned in PRs.

4. Use `azsdk_engsys_codeowner_update` with the required parameters, including the provided service and source owners.
5. Must have at least 2 valid owners from the start.

### Updating Owners in an Existing CODEOWNERS Entry

To add or remove owners from an existing CODEOWNERS entry:

1. **Determine the change needed:**
   - Always explicitly ask the user if they want to add or remove owners.
   - Always explicitly ask the user whether the change is for service owners (issue owners) or source owners (PR owners). Do not proceed until the user has specified which type of owner to update. If the user does not specify, prompt them to clarify before proceeding.
   - Never assume the owner type. Always confirm with the user whether the change applies to service owners or source owners.
   - Only once you've recieved feedback from the user should you continue.
   - Collect the GitHub usernames to add or remove for the specified owner type.

2. **Add Owners:**
   - Use `azsdk_engsys_codeowner_update` with `isAdding: true` and provide the list of owners to add in the appropriate field (`serviceOwners` or `sourceOwners`).
   - After any code owner update, always display the pull request (PR) link for the change to the user. If a PR is not created, inform the user explicitly.
   - Confirm the update and re-validate code owners to ensure at least 2 valid owners remain.

3. **Remove Owners:**
   - Use `azsdk_engsys_codeowner_update` with `isAdding: false` and provide the list of owners to remove in the appropriate field (`serviceOwners` or `sourceOwners`).
   - After any code owner update, always display the pull request (PR) link for the change to the user. If a PR is not created, inform the user explicitly.
   - Confirm the update and re-validate code owners to ensure at least 2 valid owners remain.

4. **Guidance:**
   - If any owners are invalid, provide guidance on joining the required GitHub organizations, setting public visibility, and requesting write access:
     - Microsoft org: [Join here](https://repos.opensource.microsoft.com/orgs/Microsoft), set public visibility at [Microsoft Org Visibility](https://github.com/orgs/Microsoft/people?query={github_username})
     - Azure org: [Join here](https://repos.opensource.microsoft.com/orgs/Azure), set public visibility at [Azure Org Visibility](https://github.com/orgs/Azure/people?query={github_username})
     - Write access: [Request here](https://coreidentity.microsoft.com/manage/Entitlement/entitlement/azuresdkpart-heqj)
   - See [access instructions](https://aka.ms/azsdk/access).

5. **Documentation:**
   - For more details, see [CODEOWNERS documentation](https://eng.ms/docs/products/azure-developer-experience/develop/supporting-sdk-customers/codeowners).

## Requirements
- **MINIMUM**: At least 2 valid code owners at all times
- **NO EXCEPTIONS**: Cannot proceed with insufficient owners
- **RESPONSE HANDLING**: If any exception occurs during validation or creation, ALWAYS provide documentation link [CODEOWNERS documentation](https://eng.ms/docs/products/azure-developer-experience/develop/supporting-sdk-customers/codeowners)
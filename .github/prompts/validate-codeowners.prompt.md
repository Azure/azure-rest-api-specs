---
mode: 'agent'
tools: ['CheckServiceLabel', 'ValidateCodeOwnerEntryForService', 'UpdateCodeowners'] 
---

## Goal: 
Validate service label and ensure at least 2 valid code owners exist for SDK repositories.

## Step 1: Validate Service Label
Use `CheckServiceLabel` to verify the service label exists:
- **DoesNotExist/NotAServiceLabel**: Direct user to create valid service label first. Stop validation process until service label is created.
- **Exists/InReview**: Proceed to Step 2

## Step 2: Validate Code Owners  
Ask user to specify SDK repository they want to validate codeowners for (dotnet, python, java, javascript, etc.) or detect from context.

Use `ValidateCodeOwnerEntryForService` with either `serviceLabel` OR `repoPath` (or both, but at least one must be used).

**If entry exists**: Go to Step 3
**If no entry exists**: Go to Step 4

## Step 3: Check Existing Code Owners
Valid code owners must be:
- PUBLIC members of Microsoft and Azure GitHub organizations  
- Have write access to the SDK repository

**If at least 2 valid owners**: Success - optionally manage additional owners
**If less than 2 valid owners**: CRITICAL - must fix before proceeding:

### Fix Options:
1. **Fix invalid owners** - provide guidance:
   - Microsoft org: [Join here](https://repos.opensource.microsoft.com/orgs/Microsoft), set public visibility at [Microsoft Org Visibility](https://github.com/orgs/Microsoft/people)
   - Azure org: [Join here](https://repos.opensource.microsoft.com/orgs/Azure), set public visibility at [Azure Org Visibility](https://github.com/orgs/Azure/people)
   - Write access: [Request here](https://coreidentity.microsoft.com/manage/Entitlement/entitlement/azuresdkpart-heqj)
2. **Add new owners** using `UpdateCodeowners` with `isAdding: true`
3. **Remove invalid + add valid** owners using `UpdateCodeowners`

After any changes, re-validate with `ValidateCodeOwnerEntryForService` until at least 2 valid owners exist.

## Step 4: Create New Code Owner Entry
When no CODEOWNERS entry exists yet:
1. Collect service owners and source owners (GitHub usernames)
2. Use `UpdateCodeowners` with required parameters
3. Must have at least 2 valid owners from the start

## Requirements
- **MINIMUM**: At least 2 valid code owners at all times
- **NO EXCEPTIONS**: Cannot proceed with insufficient owners
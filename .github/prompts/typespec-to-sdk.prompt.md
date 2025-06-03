---
mode: 'agent'
description: 'Generate SDKs from TypeSpec'
---
Your goal is to guide user through the process of generating SDKs from TypeSpec projects.

## Pre-Flight Check
- Verify ${workspaceFolder} is not on main branch
- If on main branch, prompt user: "You are currently on the main branch. Please create a new branch using `git checkout -b <branch-name>` before proceeding."
- Wait for user confirmation before continuing

## Step 1: Identify TypeSpec Project
**Goal**: Locate the TypeSpec project root path
**Actions**:
1. Check if `tspconfig.yaml` or `main.tsp` files are open in editor
2. If found, use the parent directory as project root
3. If not found, prompt user: "Please provide the path to your TypeSpec project root directory"
4. Validate the provided path contains required TypeSpec files
**Success Criteria**: Valid TypeSpec project path identified

## Step 2: Validate TypeSpec Specification
**Goal**: Ensure TypeSpec specification compiles without errors
**Actions**:
1. Run `/validate-typespec` command
2. If validation succeeds, proceed to Step 3
3. If validation fails:
    - Display all compilation errors to user
    - Prompt: "Please fix the TypeSpec compilation errors before proceeding"
    - Wait for user to fix errors and re-run validation
**Success Criteria**: TypeSpec compilation passes without errors

## Step 3: Verify Authentication and Repository Status
**Goal**: Ensure user is authenticated and working in correct repository
**Actions**:
1. Run `GetGitHubUserDetails` to verify login status
2. If not logged in, prompt: "Please login to GitHub using `gh auth login`"
3. Once logged in, display user details to confirm identity
4. Run `CheckIfSpecInPublicRepo` to verify repository
5. If not in public repo, inform: "Please make spec changes in Azure/azure-rest-api-specs public repo to generate SDKs"
**Success Criteria**: User authenticated and working in public Azure repo

## Step 4: Review and Commit Changes
**Goal**: Stage and commit TypeSpec modifications
**Actions**:
1. Run `GetModifiedTypeSpecProjects` to identify changes
2. If no changes found, inform: "No TypeSpec projects were modified in current branch"
3. Display all modified files (excluding `.github` and `.vscode` folders)
4. Prompt user: "Please review the modified files. Do you want to commit these changes? (yes/no)"
5. If yes:
    - Verify current branch is not "main"
    - Run `git add <modified-files>`
    - Prompt for commit message
    - Run `git commit -m "<user-provided-message>"`
    - Run `git push -u origin <current-branch-name>`
**Success Criteria**: Changes committed and pushed to remote branch

## Step 5: Choose SDK Generation Method
**Goal**: Determine how to generate SDKs
**Actions**:
1. Present options: "How would you like to generate SDKs?"
    - Option A: "Generate SDK locally"
    - Option B: "Use SDK generation pipeline"
2. Based on selection:
    - If Option A: Run `/create-sdk-locally` and then proceed to Step 6
    - If Option B: Continue to Step 6
**Success Criteria**: SDK generation method selected

## Step 6: Create Specification Pull Request
**Goal**: Create PR for TypeSpec changes if not already created
**Actions**:
1. Check if spec PR already exists using `GetPullRequestForCurrentBranch`
2. If PR exists, display PR details and proceed to Step 7
3. If no PR exists:
    - Run `/create-spec-pullrequest`
    - Wait for PR creation confirmation
    - Display created PR details
**Success Criteria**: Specification pull request exists

## Step 7: Verify API Readiness
**Goal**: Ensure API specification PR is ready for SDK generation
**Actions**:
1. Run `/check-api-readiness` on the spec PR
2. If ready, proceed to Step 8
3. If not ready:
    - Display specific readiness issues
    - Inform user: "The following actions are required before SDK generation: [list issues]"
    - Wait for user to address issues
**Success Criteria**: API specification PR passes readiness checks

## Step 8: Generate SDKs via Pipeline
**Goal**: Create release plan and generate SDKs
**Actions**:
1. Run `/create-release-plan`
2. If SDK PRs exist, link them to the release plan
3. Run `/run-sdk-gen-pipeline` with the spec PR
4. Monitor pipeline status and provide updates
5. Display generated SDK PR links when available
**Success Criteria**: SDK generation pipeline initiated and SDKs generated

## Process Complete
Display summary of all created PRs and next steps for user.
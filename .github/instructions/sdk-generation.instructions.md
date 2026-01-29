## Prerequisites

- run `npm ci` to install the dependencies
- To use Azure MCP tool calls, the user must have PowerShell installed. Provide [PowerShell installation instructions](https://learn.microsoft.com/powershell/scripting/install/installing-powershell) if not installed, and recommend restarting the IDE to start the MCP server.
- When using Copilot from Visual Studio or VS Code (not applicable when using Coding Agent on Github.com):
  - **Always run** the [`azsdk_verify_setup`](../../eng/common/instructions/azsdk-tools/verify-setup.instructions.md) tool first to validate the user's development environment for SDK MCP tools.
  - **Do not proceed** with any other tool execution until this step is complete.
  - **Skip this check only** for queries that do not require tool execution.

## Basic Rules for SDK Generation from TypeSpec

1. **User Guidance**:
   - Assume the user is unfamiliar with the SDK release process. Provide clear, concise instructions for each step.

2. **File Handling**:
   - Do not overwrite `tspconfig.yaml` or `main.tsp`. Use existing files and suggest updates if necessary.
   - Use the path of the `tspconfig.yaml` file or the `.tsp` file path as the project root.
   - If no `.tsp` file or folder is in the current context, prompt the user to select a valid TypeSpec project root path.

3. **Process Visibility**:
   - Highlight all steps in the SDK generation process, showing completed and remaining steps.
   - Do not skip any main steps. Ensure all steps are completed before moving to the next.

4. **Git Operations**:
   - Avoid using the `main` branch for pull requests. Prompt the user to create or switch to a new branch if necessary.
   - Display git commands (e.g., `git checkout`, `git add`, `git commit`, `git push`) with a "Run" button instead of
     asking the user to copy and paste.
   - Do not run `git diff`

5. **Azure-Specific Rules**:
   - Always use `Azure` as the repo owner in MCP tool calls.
   - Confirm with the user if they want to change the repo owner or target branch, and prompt for new values if needed.

6. **Exclusions**:
   - Exclude changes to the `.gitignore` file and contents within the `.github` and `.vscode` folders from API spec and SDK pull requests.

7. **Working Branch Rule**:
   - If the typespec pull request already exists or is merged stay on the `main` branch, otherwise ensure the TypeSpec project repository and the current working repository are not on the `main` branch:
     - Check the current branch name for the cloned GitHub repository:
       - If the current branch is `main`, prompt the user to create a new branch using
         `git checkout -b <branch name>`.
       - If the current branch is not `main`, prompt the user to either select an existing branch or create a
         new one.
     - For branch switching:
       - If a branch already exists and differs from the current branch, prompt the user to switch using
         `git checkout <branch name>`.
   - GitHub pull requests cannot be created from the `main` branch. Ensure all changes are made on a non-`main` branch.

8. **Language Exclusion Policy**:
   - **CRITICAL**: Mark a language as excluded in a release plan **ONLY** when the language emitter configuration is intentionally missing or not configured in the `tspconfig.yaml` file.
   - **DO NOT** mark a language as excluded if:
     - SDK generation pipeline fails due to compilation errors, validation errors, or other technical issues
     - The language emitter is configured in `tspconfig.yaml` but the pipeline encounters runtime errors
     - There are temporary infrastructure or service issues causing pipeline failures
   - **DO** mark a language as excluded if:
     - The language emitter configuration is intentionally missing from `tspconfig.yaml`
     - The service team has made a deliberate decision not to support a particular language
     - The user provides explicit justification for not including a language in the release
   - **When SDK generation fails**:
     - Investigate the pipeline failure logs to identify the root cause
     - Help the user fix compilation errors, configuration issues, or other problems
     - Re-run the SDK generation pipeline after fixes are applied
     - Only suggest language exclusion if the user explicitly states the language will not be supported

By following these rules, the SDK release process will remain clear, structured, and user-friendly.

## Steps to generate SDK from TypeSpec API specification

Follow below steps to generate and release SDK from TypeSpec API specification. The process is divided into several steps, each with specific actions to ensure a smooth SDK generation and release process.
Do not skip the step that choose SDK generation method to ensure the user selects the appropriate method for SDK generation, either locally or using the SDK generation pipeline. Do not repeat the steps. Before using tools, check if user has Powershell installed.

Your goal is to guide the user through the process of generating SDKs from TypeSpec projects. **Before starting**, show all the high level steps to the user and ask:

> "Would you like to begin the SDK generation process now? (yes/no)"

Wait for the user to respond with a confirmation before proceeding to Step 1. Use the provided tools to perform actions and gather information as needed.

### Verify API spec

Step 1: Identify TypeSpec Project
**Goal**: Locate the TypeSpec project root path
**Actions**:

1. Check if `tspconfig.yaml` or `main.tsp` files are open in editor
2. If found, use the parent directory as project root
3. If not found, prompt user: "Please provide the path to your TypeSpec project root directory"
4. Validate the provided path contains required TypeSpec files main.tsp and tspconfig.yaml
5. Run `azsdk_typespec_check_project_in_public_repo` to verify repository
6. If not in public repo, inform: "Please make spec changes in Azure/azure-rest-api-specs public repo to generate SDKs". User can still generate SDKs locally from private repo but they should not push the changes to public SDK repo.
   **Success Criteria**: Valid TypeSpec project path identified

Step 2: Identify API spec status
**Goal**: Determine if the TypeSpec spec is already merged or if it's being modified.
**Actions**:

1. Prompt user to confirm if the TypeSpec spec is already merged in the main branch of https://github.com/Azure/azure-rest-api-specs : "Is your TypeSpec specification already merged in the main branch of repository(https://github.com/Azure/azure-rest-api-specs)? (yes/no)"
2. If already merged, follow the steps in [typespec to sdk](../../eng/common/instructions/azsdk-tools/typespec-to-sdk.instructions.md) to generate the SDK
3. If no, proceed to Step 3 to review and commit changes
   **Success Criteria**: User decision on spec readiness obtained

Step 3: Validate TypeSpec Specification
**Goal**: Ensure TypeSpec specification compiles without errors. Provide a complete summary after running the tool. Highlight any errors and help user fix them.
**Condition**: Only if the spec is not already merged (from Step 2)
**Message to user**: "TypeSpec validation takes around 20 - 30 seconds."
**Actions**:

1. Run `azsdk_run_typespec_validation` to validate the TypeSpec project.
2. If validation succeeds, proceed to Step 4
3. If validation fails: - Display all compilation errors to user - Agent should provide suggestions to fix them and prompt the user to verify the fixes. If agent cannot resolve the errors, then prompt the user to fix compilation errors" - Wait for user to fix errors and re-run validation. Provide detailed information about all the changes done by copilot and prompt the user before rerunning the validation.
   **Success Criteria**: TypeSpec compilation passes without errors

Step 4: Review and Commit Changes
**Goal**: Stage and commit TypeSpec modifications
**Condition**: Only if the TypeSpec validation succeeds (from Step 3)
**Actions**:

1. Run `azsdk_get_modified_typespec_projects` to identify changes
2. If no changes found, inform: "No TypeSpec projects were modified in current branch" and go to SDK generation mentioned in [typespec to sdk](../../eng/common/instructions/azsdk-tools/typespec-to-sdk.instructions.md).
3. Display all modified files (excluding `.github` and `.vscode` folders)
4. Prompt user: "Please review the modified files. Do you want to commit these changes? (yes/no)"
5. If yes: - If on main branch, prompt user: "You are currently on the main branch. Please create a new branch using `git checkout -b <branch-name>` before proceeding." - Wait for user confirmation before continuing - Run `git add <modified-files>` - Prompt for commit message - Run `git commit -m "<user-provided-message>"` - Run `git push -u origin <current-branch-name>`
   **Success Criteria**: Changes committed and pushed to remote branch

Step 5: Create Specification Pull Request
**Goal**: Create PR for TypeSpec changes if not already created
**Condition**: Only if there are committed changes (from Step 4)
**Actions**:

1. Prompt the user to confirm if a pull request already exists for API spec changes. If answer is no or unsure then check if spec PR already exists using `azsdk_get_pull_request_link_for_current_branch`
2. If PR exists, display PR details and proceed to next steps in SDK generation.
3. If no PR exists:
   - Inform user: "No pull request found for the current branch. Proceeding to create a new pull request."
   - Create a pull request using `azsdk_create_pull_request_for_current_branch`
   - Prompt for PR title and description
   - Display PR creation progress
   - Wait for PR creation confirmation
   - Display created PR details
4. Inform the user to follow the instructions on spec PR to get approval from API reviewers and merge the spec PR.
   **Success Criteria**: Specification pull request exists

Follow the steps in [typespec to sdk](../../eng/common/instructions/azsdk-tools/typespec-to-sdk.instructions.md) to generate the SDK.

## SDK customizations in TypeSpec projects

TypeSpec supports making client-specific customizations to a TypeSpec project to change how an SDK is generated. When making client-specific changes, read the [typespec client customizations reference](../../eng/common/knowledge/customizing-client-tsp.md) to understand the types of customizations supported and how to apply them.

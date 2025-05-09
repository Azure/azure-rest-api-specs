# SDK generation from TypeSpec

## Agent context for TypeSpec and SDK process 
- Check all open files in the editor and check if `main.tsp` or `tspconfig.yaml` are open in the editor. If either of 
these files are open, then use the parent path of the `main.tsp` or `tspconfig.yaml` as default TypeSpec project root 
path.
- If `main.tsp` and `tspconfig.yaml` are not open in the editor, then check if there are any TypeSpec project paths in 
the context. If there are no TypeSpec project paths in the context, then prompt user to select a TypeSpec project path 
from the list of paths. If user does not have a TypeSpec project, then prompt user to create a new TypeSpec project.


### Pre-requisites
- User should have a GitHub account and should be logged in to GitHub account using GitHub CLI `gh auth login`.


### Basic Rules for SDK Generation from TypeSpec

1. **User Guidance**:
    - Assume the user is unfamiliar with the SDK release process. Provide clear, concise instructions for each step.

2. **File Handling**:
    - Do not overwrite `tspconfig.yaml` or `main.tsp`. Use existing files and suggest updates if necessary.
    - Use the path of the `tspconfig.yaml` file already open in the editor or the `.tsp` file path as the project root.
    - If no `.tsp` file or folder is in the current context, prompt the user to select a valid TypeSpec project root path.

3. **Pull Request Management**:
    - Always start by checking if a pull request exists for spec changes before proceeding with validation or SDK 
    generation.
    - Use `GetPullRequestForCurrentBranch` to query pull requests instead of the `gh` CLI.
    - Provide a detailed pull request summary, including:
      - Title, link, author, assignee, status (open, closed, merged), and mergeability.
      - Check statuses (success or failure) with links and detailed failure reasons.
      - API views for generated SDKs under the heading `API View for Generated SDK APIs`.
      - Comments and action items for the user.

4. **Process Visibility**:
    - Highlight all steps in the SDK release process, showing completed and remaining steps.
    - Do not skip any main steps. Ensure all steps are completed before moving to the next.

5. **Git Operations**:
    - Avoid using the `main` branch for pull requests. Prompt the user to create or switch to a new branch if necessary.
    - Display git commands (e.g., `git checkout`, `git add`, `git commit`, `git push`) with a "Run" button instead of 
    asking the user to copy and paste.

6. **Azure-Specific Rules**:
    - Always use `Azure` as the repo owner in MCP tool calls.
    - Confirm with the user if they want to change the repo owner or target branch, and prompt for new values if needed.

7. **Exclusions**:
    - Exclude changes in `.github` and `.vscode` folders from API spec and SDK pull requests.

8. **Working Branch Rule**:
    - Ensure the TypeSpec project repository and the current working repository are not on the `main` branch:
        - Check the current branch name for the cloned GitHub repository:
            - If the current branch is `main`, prompt the user to create a new branch using 
            `git checkout -b <branch name>`.
            - If the current branch is not `main`, prompt the user to either select an existing branch or create a 
            new one.
        - For branch switching:
            - If a branch already exists and differs from the current branch, prompt the user to switch using 
            `git checkout <branch name>`.
    - GitHub pull requests cannot be created from the `main` branch. Ensure all changes are made on a non-`main` branch.

By following these rules, the SDK release process will remain clear, structured, and user-friendly.

## Steps to generate and release SDK from TypeSpec API specification

### Step 1: Identify the TypeSpec Project Root Path
- Locate the TypeSpec project root path for files in the current context.

### Step 2: Validate the TypeSpec Project
- Run TypeSpec validation to ensure there are no validation errors.
    - If validation fails, highlight the issues for the user to fix.
    - Provide a detailed summary of validation results:
        - Inform the user to address errors and re-run the validation command.
        - Notify the user about warnings and suggest addressing them.
        - Confirm successful validation if there are no errors or warnings.

### Step 3: Review and Commit Changes
- Display the list of changed files in the repository and prompt the user to confirm the changes. Ignore uncommitted 
changes in `.github` and `.vscode` folders.
    - If the user confirms:
        - Prompt the user to commit the changes:
            - Run `git add <changed files>` to stage the changes.
            - Run `git commit -m "<commit message>"` to commit the changes.
            - Push the changes to the GitHub remote, ensuring the branch name is not "main."
                - Run `git push -u origin <branch name>` to push the changes.
                - If the push fails due to authentication, prompt the user to run `gh auth login` and retry the push command.
                - If the user does not confirm, prompt them to fix the changes and re-run validation.

### Step 4: Manage Pull Requests
- Check if a pull request exists for the current branch:
    - If a pull request exists, inform the user and display its details.
    - If no pull request exists:
        - Ensure the current branch name is not "main." If it is, prompt the user to create a new branch using 
        `git checkout -b <branch name>`.
        - Push the changes to the remote branch. If the branch does not exist on GitHub, create it and push the changes.
        - Generate a title and description for the pull request based on the changes. Prompt the user to confirm or 
        edit them.
        - Prompt the user to select the target branch for the pull request, defaulting to "main."
        - Create the pull request with the specified project, target branch, title, and description.
- Retrieve and display the pull request summary, including its status, checks, and comments. Highlight any action items.
    - Retrieve API review links and display their details. Inform the user to check APIView for generated SDK APIs.

### Step 5: Prepare the Release Plan
- Check if the API spec is ready to generate the SDK. Provide the TypeSpec project root path and pull request number.
- Verify if a release plan exists for the API spec pull request:
    - If no release plan exists, create one. Prompt the user to provide the following details:
        - Select the target lifecycle of the API specification:
            - Options: Private Preview, Public Preview, GA.
            - Inform the user that SDK generation and release are required only for Public Preview or GA.
            - If Private Preview, inform the user that merging the SPEC PR completes the process.
        - Provide the following details for the release plan:
            - Service tree ID for the service.
            - Product service tree ID for the product.
            - Expected release timeline (e.g., Month YYYY).
            - API version.
        - If the user lacks details, suggest using the release planner. More details are available [here](https://eng.ms/docs/products/azure-developer-experience/plan/release-plan-create).

### Step 6: Generate SDKs
- Retrieve the release plan and check if SDK generation has already occurred or if an SDK pull request exists for a language:
    - If an SDK pull request exists, display its details.
    - If no pull request exists or regeneration is needed, proceed with SDK generation.
- Run SDK generation for Python, .NET, JavaScript, Java, and Go:
    - Execute the SDK generation pipeline if the API spec is ready. Required parameters include:
        - TypeSpec project root path.
        - Pull request number (if the API spec is not merged to the main branch).
        - API version.
        - SDK release type (beta for preview API versions, stable otherwise).
        - Language options: `Python`, `.NET`, `JavaScript`, `Java`, `Go`.
        - Release plan work item ID.
    - Keep checking the status of SDK generation pipeline status every 2 minutes until pipeline succeeded or failed.
    - Get SDK pull request link from pipeline and show all details once pipeline is in completed status.
    - Highlight the language name for each SDK generation task when displaying details to the user.
    - Once the SDK pull request URL is available, inform the user of the successful SDK generation and display the pull 
    request details.


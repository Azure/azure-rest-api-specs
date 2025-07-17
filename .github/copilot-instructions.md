
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
- run `npm ci` to install the dependencies


### Basic Rules for SDK Generation from TypeSpec

1. **User Guidance**:
    - Assume the user is unfamiliar with the SDK release process. Provide clear, concise instructions for each step.

2. **File Handling**:
    - Do not overwrite `tspconfig.yaml` or `main.tsp`. Use existing files and suggest updates if necessary.
    - Use the path of the `tspconfig.yaml` file already open in the editor or the `.tsp` file path as the project root.
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
    - Exclude changes in `.github` and `.vscode` folders from API spec and SDK pull requests.

7. **Working Branch Rule**:
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

## Steps to generate SDK from TypeSpec API specification
Follow `/typespec-to-sdk` prompt to generate and release SDK from TypeSpec API specification. The process is divided into several steps, each with specific actions to ensure a smooth SDK generation and release process.
Do not skip the step that choose SDK generation method to ensure the user selects the appropriate method for SDK generation, either locally or using the SDK generation pipeline. Do not repeat the steps.

1. **Identify TypeSpec Project**: Locate the TypeSpec project root path by checking for `tspconfig.yaml` or `main.tsp` files.
2. **Validate TypeSpec Specification**: Ensure the TypeSpec specification compiles without errors.
3. **Verify Authentication and Repository Status**: Ensure user is authenticated and working in the correct public Azure repository.
4. **Review and Commit Changes**: Stage and commit TypeSpec modifications, ensuring the current branch is not "main". Do not create pull request yet.
5. **Create Specification Pull Request**: Create a pull request for TypeSpec changes if not already created. This is required only if there are TypeSpec changes in current branch.
6. **Choose SDK Generation Method**: Determine how to generate SDKs (locally or via pipeline). Only Python is supported for local SDK generation at this time.
7. **Generate SDKs via Pipeline**:  Generate SDKs using `/run-sdk-gen-pipeline` prompt, monitor the pipeline status and displaying generated SDK PR links.
8. **Show generated SDK PR**: Display the generated SDK pull request links for review.
9. **Create a release plan**: Create a release plan for the generated SDKs using spec pull request.
10. **Prompt user to change spec pull request to ready for review from draft status**: Update spec pull request to change it to ready for review.
11. **Release package**: Release the SDK package using `ReleaseSdkPackage` tool.


## Release readiness of SDK and information about the release pipeline
Run `/check-package-readiness` prompt to check the release readiness of an SDK package. This prompt will collect the required information from the user, execute the readiness check, and present the results.
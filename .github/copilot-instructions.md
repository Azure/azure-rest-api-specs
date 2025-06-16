
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
    - Highlight all steps in the SDK generation process, showing completed and remaining steps.
    - Do not skip any main steps. Ensure all steps are completed before moving to the next.

5. **Git Operations**:
    - Avoid using the `main` branch for pull requests. Prompt the user to create or switch to a new branch if necessary.
    - Display git commands (e.g., `git checkout`, `git add`, `git commit`, `git push`) with a "Run" button instead of 
    asking the user to copy and paste.
    - Do not run `git diff`

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

## Steps to generate SDK from TypeSpec API specification
Follow `/typespec-to-sdk` prompt to generate and release SDK from TypeSpec API specification. The process is divided into several steps, each with specific actions to ensure a smooth SDK generation and release process.
Do not skip the step that choose SDK generation method to ensure the user selects the appropriate method for SDK generation, either locally or using the SDK generation pipeline. Do not repeat the steps.
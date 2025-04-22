# Rules for SDK release process and Spec readiness to generate and release SDK
- If a Spec project path is not available, prompt user to provide or select the Spec project root
- Verify whether spec project root is TypeSpec project. This guidelines to support spec to SDK release is currently 
 supported only for TypeSpec
 - Follow the steps below for SDK release process from TypeSpec specification

## SDK release process from TypeSpec

### Pre-requisites
- User should have a GitHub account and should be logged in to GitHub account using GitHub CLI `gh auth login`.

- Check the current branch name for the cloned GitHub repo. Prompt user to select a branch or create new branch if they already does not have a branch
    - GitHub pull request cannot be creatd from main branch. If the current branch is main, then prompt user to create a new branch for TypeSpec changes.
    - If the current branch is not main, then prompt user to select a branch name from the list of branches in the repo or create a new branch.
    - If a branch needs to be created then prompt user to run command: `git checkout -b <branch name>`.
    - If a branch already exists and if it is not same as current branch then prompt user to run command `git checkout <branch name>` to switch to the branch.

### Steps to generate and release SDK from TypeSpec API specification
- Check if main.tsp and tspconfig.yaml is open in editor and use the parent path of the main.tsp or tspconfig.yaml as default TypeSpec project root path.
- If a TypeSpec project root path is not available, then prompt user to select the TypeSpec project root path.
- Run TypeSpec validation and make sure there are no TypeSpec validation errors.
    - If there are any TypeSpec validation failures, then highlight the failures to fix them.
    - Show a details summary of validation status for successful and failed validation checks.
        - If there are any validation errors, then inform user to fix the issues and re-run the TypeSpec validation command.
        - If there are any validation warnings, then inform user to fix the issues and re-run the TypeSpec validation command.
        - If there are no validation errors or warnings, then inform user that TypeSpec validation is successful.
- If TypeSpec validation is successful, show list of changed files in the repo and prompt user to confirm if the changes are correct. Ignore uncommitted changes in .github folder and .vscode folder.
    - If the user confirms, then proceed with the next steps.
        - If there are uncommitted changes, then prompt user to commit the changes with a commit message. 
            - Prompt user to Run `git add <changed files in the TypeSpec project>` command to add the changes to the staging area.
            - Prompt user to Run `git commit -m "<commit message>"` command to commit the changes.
    - If the user does not confirm the changes, then prompt user to fix the changes in the files and run TypeSpec validation again.
- Check if there are any uncommitted changes in the repo for TypeSpec project. Ignore uncommitted changes in .github folder and .vscode folder.
    - Push the changes to GitHub remote. Make sure that remote branch name is not "main".
        - Run `git push -u origin <branch name>` command to push the changes to GitHub remote.
        - if git push command fails with authentication errorm, then prompt user to run `gh auth login` command to login to GitHub account and then run `git push -u origin <branch name>` command again.
- Check if a pull request already exists for the current branch. If a pull request already exists, then inform user that a pull request already exists and show the details of the pull request.
    - If a pull request exists, then show the status of the pull request.
        - If the pull request is open, then inform user that the pull request is open and show the details of the pull request. Show the check status of the pull request
        - If the pull request is closed, then inform user that the pull request is closed and Move to next step to create a new pull request.
        - If the pull request is merged, then inform user that the pull request is merged and show the details of the pull request.
- Create Pull request for changes if a pull request does not exists for the branch.
    - Check the current branch name. Branch name must not be "main" to create a pull request for TypeSpec changes.
    - If branch name is "main", then prompt user to create a new branch for TypeSpec changes. command: `git checkout -b <branch name>`. prompt user to provide a branch name or ask them to select the branch name if branch already exists.
        - Push the changes to the remote branch in GitHub repo. If the branch is not present in GitHub, then create a new branch with the same name as local branch and push the changes to GitHub.
    - Generate a title and description based on the changes. Prompt the user to confirm or provide a different title and description for the pull request.
    - Prompt user to select the the target branch for pull request.  Default target branch is "main".
    - Create pull requet for changes in TypeSpec project, target branch, title and descriptions
- Get Pull request status and show the details of the pull request. Use full path to cloned repo as project root path.
    - Get pull request details for the current branch and show the details of the pull request.
        - Pull request details include:
            - Pull request title
            - Pull request description
            - Pull request URL
            - Pull request status (open, closed, merged)
- Get Pull request checks and show the status of the checks. Use full path to cloned repo as project root path.
    - If any of the checks are failed, then inform user to fix the issues and re-run the checks.
    - If pull request checks are in progress status, then inform user about checks and ask him wait until those checks are completed.
    - If all the checks are passed, then inform user that all the checks are passed and show the details of the checks.
- Get pull request comments and check if there is any action item for the user. Use full path to cloned repo as project root path.
- Create release plan work item before generating the SDK or get a URL for existing release plan work item.
    - Prompt user to select the target lifecycle of API specification.
        - Target lifecycle is the lifecycle of the API specification. Show below list of options and prompt user to select one of the options.
            - Target lifecycle options:
                - `Private Preview`
                - `Public Preview`
                - `GA`
            - SDK needs to be generated and released only if target life sycle is Public Preview or GA.
            - If target lifecycle is Private Preview, then inform user that SDK generation and release is not required for Private Preview.
    - Prompt user to provide the following details for the release plan work item:
        - Service Tree ID for the Service
        - Product Service tree ID for the Product
        - Expected release timeline in Month and Year (e.g., Month YYYY)
        - API version
    - Check if there is a release plan work item in Azure DevOps for TytpeSpec API specification for given product, service and API version.
        - If there is a release plan work item which is in progress status, then inform user that SDK release plan exists and show details of the release plan work item.
    - If there is no release plan work item, then create a release plan work item in Azure DevOps for TypeSpec API specification for given product, service and API version.

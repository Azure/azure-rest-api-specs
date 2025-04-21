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
- Step 1: Verify if the user has a TypeSpec project path for API specification.
    - If not, then prompt user to create a TypeSpec for API specification.
    - If user has a TypeSpec project path, then prompt user to provide TypeSpec project name and  then verify if the path is a valid TypeSpec project.
- Step 2: Run TypeSpec validation and make sure there are no TypeSpec validation
    - If there are any TypeSpec validation failures, then highlight the failures to fix them.
- Step 3: Show list of changed files in the repo and prompt user to confirm if the changes are correct. 
    - If the user confirms, then proceed with the next steps.
    - If the user does not confirm the changes, then prompt user to fix the changes in the files and run TypeSpec validation again.
- Step 4: Verify user has a GitHub account and is logged in to GitHub account using GitHub CLI `gh auth login`.
    - if GitHub login fails then prompt user to make sure to install GitHub CLI and login to GitHub account using `gh auth login` command.
    - If user is logged in to GitHub account, then proceed with the next steps.
- Step 5: Create Pull request for changes.
    - Check if there are any uncommitted changes in the repo for TypeSpec project.    
        - If there are uncommitted changes, then prompt user to commit the changes with a commit message. 
            - Prompt to run `git add <changed files in the TypeSpec project>` command to add the changes to the staging area.
            - Prompt to run `git commit -m "<commit message>"` command to commit the changes.
    - Push the changes to GitHup remote. Make sure that remote branch name is not "main"
        - Prompt user to run `git push -u origin <branch name>` command to push the changes to GitHub remote.
    - Next step is to create a pull request for the branch. This step will either creates a new pull request or find the existing pull request for the branch.
        - Check the current branch name. Branch name must not be "main" to create a pull request for TypeSpec changes.
        - If branch name is "main", then prompt user to create a new branch for TypeSpec changes. command: `git checkout -b <branch name>`. prompt user to provide a branch name or ask them to select the branch name if branch already exists.
            - Push the changes to the remote branch in GitHub repo. If the branch is not present in GitHub, then create a new branch with the same name as local branch and push the changes to GitHub.
        - Generate a title and description based on the changes. Prompt the user to confirm or provide a different title and description for the pull request.
        - Prompt user to select the the target branch for pull request.  Default target branch is "main".
        - Create pull requet for changes in TypeSpec project, target branch, title and descriptions
- Step 6: Get TypeSpec pull request details for current branch and show the details of the pull request.
- Step 7: Get pull request comments and check if there is any action item for the user.
- Step 8: Verify target lifecycle of API specification.
    - Target lifecycle is the lifecycle of the API specification. Show below list of options and prompt user to select one of the options.
        - Target lifecycle options:
            - Private Preview
            - Public Preview
            - GA
        - SDK needs to be generated and released only if target life sycle is Public Preview or GA.
        - If target lifecycle is Private Preview, then inform user that SDK generation and release is not required for Private Preview.
- Step 9: Create release plan work item before generating the SDK or get a URL for existing release plan work item.
    - Prompt user to provide the following details for the release plan work item:
        - Service Tree ID for the Service
        - Service Name
        - Product Service tree ID for the Product
        - Product Name
        - Expected release timeline in Month and Year (e.g., Month YYYY)
        - API version        
    - Check if there is a release plan work item in Azure DevOps for TytpeSpec API specification for given product, service and API version.
        - If there is a release plan work item which is in progress status, then inform user that SDK release plan exists and show details of the release plan work item.
    - If there is no release plan work item, then create a release plan work item in Azure DevOps for TypeSpec API specification for given product, service and API version.

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

- Prompt user to check if they have a TypeSpec for API specification. If not, then prompt user to create a TypeSpec for API specification.
    - If user has a TypeSpec for API specification, then prompt user to select the TypeSpec project name and find the TypeSpec project path
       with that name in the repo. This should be a nested folder within the specification folder.    
- Verify if specification path is a TypeSpec project
- Run TypeSpec validation and make sure there are no TypeSpec validation
- If there are any TypeSpec validation failures, then highlight the failures to fix them.
- After succesful TypeSpec validation, Show list of changed files in the repo and prompt user to confirm if the changes are correct. 
    - If the user confirms, then proceed with the next steps.
    - If the user does not confirm the changes, then prompt user to fix the changes in the files and run TypeSpec validation again.
- Check if there are any uncommitted chanages in the repo for TypeSpec project.    
        - If there are uncommitted changes, then prompt user to commit the changes with a commit message. 
            - Prompt to run `git add <changed files in the TypeSpec project>` command to add the changes to the staging area.
            - Prompt to run `git commit -m "<commit message>"` command to commit the changes.
        - If there are no uncommitted changes, then proceed with the next steps.
- Push the changes to GitHup remote. Make sure that remote branch name is not "main"
    - Prompt user to run `git push origin <branch name>` command to push the changes to GitHub remote.
- Check if there is a pull request for TypeSpec changes in current branch.
    - If yes, show pull request details.
- If there is no pull request then:
    - Get user's GitHub user details and verify connection to GitHub account. 
    - If there is any github login error, then ask user to install GitHub CLI and login to GitHub account using GitHub CLI `gh auth login`. 
    - Check the current branch name. Branch name must not be "main" to create a pull request for TypeSpec changes.
    - If branch name is "main", then prompt user to create a new branch for TypeSpec changes. command: `git checkout -b <branch name>`. prompt user to provide a branch name or ask them to select the branch name if branch already exists.
    - commit the changes to the branch with commit message. Prompt user tio provide a commit message if the commit message is not provided.
    - Push the changes to the remote branch in GitHub repo. If the branch is not present in GitHub, then create a new branch with the same name as local branch and push the changes to GitHub.
    - Create a pull request for the branch. Generate a title and description based on the changes and prompt user to provide a title and description for the pull request.
    - Prompt user to select the the target branch for pull request.  Default target branch should be "main".
    - Create pull requet for the branch and show the pull request details to the user.
- Get pull request for current branch. If there is a pull request, then get the pull request details and show the details to the user.
    - If there is no pull request, then inform user that there is no pull request found and prompt user to provide pr number to get the pull request details.
    - Get pull request details and show details: Pull request link, pull request status, Any details of failed checks,
      Pull request mergeability.
    - Show any comments in the pull request and summarize any action item for pull request author.
    - Show all check statuses if a pull request is presnt and highlight any failed checks.
    - If there are any failed checks, then show the details of the failed checks and prompt user to fix the issues in the pull request.
-Prompt user to select Target lifecycle of API specification. Otpions are:
    - Private Preview
    - Public Preview
    - GA
- SDK needs to be generated and released only if target life sycle is Public Preview or GA.
- If target lifecycle is Private Preview, then inform user that SDK generation and release is not required for Private Preview.
- Prompt user with a yes or no question to confirm if their TypeSpec API specification is ready for SDK generation and release or they have more API specification changes to be done.
    - If user confirms, then proceed with the next steps.
    - If user does not confirm, then inform user taht SDK release process can be rerun when API specification is ready for SDK generation.
- Check if there is a release plan work item in Azure DevOps for TytpeSpec API specification.
    - If there is a release plan work item, then inform user that SDK release plan exists and show details of the release plan work item.
- If there is no release plan work item, then prompt user to provife following detailss:
    - Service Tree ID for the Service
    - Service Name
    - Product Service tree ID for the Product
    - Product Name
    - Expected release timeline in Month and Year (e.g., Month YYYY)
    - Any additional notes or requirements for the SDK release



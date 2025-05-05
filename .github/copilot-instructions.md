# Context rules for TypeSpec and SDK process 
- Check all open files in the editor and check if `main.tsp` or `tspconfig.yaml` are open in the editor. If either of these files are open, then use the parent path of the `main.tsp` or `tspconfig.yaml` as default TypeSpec project root path.
- If `main.tsp` and `tspconfig.yaml` are not open in the editor, then check if there are any TypeSpec project paths in the context. If there are no TypeSpec project paths in the context, then prompt user to select a TypeSpec project path from the list of paths. If user does not have a TypeSpec project, then prompt user to create a new TypeSpec project.


## SDK release process from TypeSpec

### Pre-requisites
- User should have a GitHub account and should be logged in to GitHub account using GitHub CLI `gh auth login`.
- Check the current branch name for the cloned GitHub repo. Prompt user to select a branch or create new branch if they are in main branch.
    - GitHub pull request cannot be creatd from main branch. If the current branch is main, then prompt user to create a new branch for TypeSpec changes.
    - If the current branch is not main, then prompt user to select a branch name from the list of branches in the repo or create a new branch.
    - If a branch needs to be created then prompt user to run command: `git checkout -b <branch name>`.
    - If a branch already exists and if it is not same as current branch then prompt user to run command `git checkout <branch name>` to switch to the branch.

### Basic Rules
- Do not assume that user is an expert in SDK release process. User may not be familiar with the steps to be performed 
for SDK release process.
- Provide clear and concise instructions to user about the steps to be performed for SDK release process.
- Do not overwrite tspconfig.yaml file or main.tsp file. Use existing files and suggest user to update the files if 
required.
- Do not search for tspconfig.yaml file in the repo. Always use the path of tspconfig.yaml file which is already open 
in the editor or use the path of tsp file as tspproject.
- Do not pick a random TypeSpec folder that contains main.tsp and tspconfig.yaml as project root. If current context 
does not contain any .tsp file or folder, prompt user to select a valid TypeSpec project root path.
- Do not use gh cli to get the pull request for current branch. Use GetPullRequestForCurrentBranch to query the pull 
request for the current branch. 
- Highlight the steps to be performed for SDK release with simple step name without too much text to confuse the user.
- Show completed step and remaining steps in the process to user.
- Do not skip any main steps in the process. Show all the steps to user in the process.
- Always make sure to run all the steps before moving to next step in the relese process.
- Always start with checking if there is a pull request for spec changes when asking status about pull rquest or SDK 
generation.
- Always use `Azure` as repo owner in MCP tool calls.
- If a git command needs to be run then show the command and run button. Do not ask user to copy and paste the command 
in terminal.
- Always show detailed pull requet summary view when pull request is created or retrieved. Pull request summary view 
should include the following details:
    - Pull request title
    - Pull request link (URL)
    - Author
    - Assigned to user
    - Pull request status (open, closed, merged)
    - Mergeabilty status (yes, no)
    - Pull request checks status (success (green check sign), failure (Red X mark)) and links to the checks
    - Provide additional details for each failed checks and highjlight them with X mark in red.
    - Show all API views created for the pull request and suggest user to view them to see how thier generated SDK APIs
     look like. Use the heading `API View for generated SDK APIs` to hightlight the API views.
    - Pull request comments and action items for user if there is any.
- If pull request has links to API views then highlight them and suggest user to access API view to see how their 
generated SDK APIs look
- GitHub MCP tools: Always inform about the repo owner and target branch(if applicable) passed to tool and confirm if 
user wants to change to different repo owner or target branch. If user wants to change the repo owner or target branch,
then prompt user to provide the new repo owner and target branch name.
- Do not start with TypeSpec validation if a pull request already exists for current brnach and if there are no more 
uncommitted change. If a pull request exists, then start by getting pr details and move to next step.
- Do not include changes in .github and .vscode


### Steps to generate and release SDK from TypeSpec API specification
- Find TypeSpec project root path for files in the context.
- Run TypeSpec validation and make sure there are no TypeSpec validation errors for the TypeSpec project.
    - If there are any TypeSpec validation failures, then highlight the failures to fix them.
    - Show a detailed summary of validation status for successful and failed validation checks.
        - If there are any validation errors, then inform user to fix the issues and re-run the TypeSpec validation 
        command.
        - If there are any validation warnings, then inform user to fix the issues and re-run the TypeSpec validation 
        command.
        - If there are no validation errors or warnings, then inform user that TypeSpec validation is successful.
- If TypeSpec validation is successful, show list of changed files in the repo and prompt user to confirm if the 
changes are correct. Ignore uncommitted changes in .github folder and .vscode folder.
    - If the user confirms, then proceed with the next steps.
        - If there are uncommitted changes, then prompt user to commit the changes with a commit message. 
            - Prompt user to Run `git add <changed files in the TypeSpec project>` command to add the changes to the staging area.
            - Prompt user to Run `git commit -m "<commit message>"` command to commit the changes.
    - If the user does not confirm the changes, then prompt user to fix the changes in the files and run TypeSpec validation again.
- Check if there are any uncommitted changes in the repo for TypeSpec project. Ignore uncommitted changes in .github folder and .vscode folder.
    - Push the changes to GitHub remote. Make sure that remote branch name is not "main".
        - Run `git push -u origin <branch name>` command to push the changes to GitHub remote.
        - if git push command fails with authentication errorm, then prompt user to run `gh auth login` command to login to GitHub account and then run `git push -u origin <branch name>` command again.
- Check if a pull request already exists for the current branch. Pass Current repo root path as param to find the pull request. If a pull request already exists, then inform user that a pull request already exists and show the details of the pull request.
- Create Pull request for changes if a pull request does not exists for the branch.
    - Check the current branch name. Branch name must not be "main" to create a pull request for TypeSpec changes.
    - If branch name is "main", then prompt user to create a new branch for TypeSpec changes. command: `git checkout -b <branch name>`. prompt user to provide a branch name or ask them to select the branch name if branch already exists.
        - Push the changes to the remote branch in GitHub repo. If the branch is not present in GitHub, then create a new branch with the same name as local branch and push the changes to GitHub.
    - Generate a title and description based on the changes. Prompt the user to confirm or provide a different title and description for the pull request.
    - Prompt user to select the the target branch for pull request.  Default target branch is "main".
    - Create pull request for changes in TypeSpec project, target branch, title and descriptions
- Get pull request summary and show the details of the pull request. Show the status and checks for the pull request. Show the comments for the pull request and highlight action items for the user if there is any.
  - Get API review links in the summary and show the details of the API review links. Inform user to check APIView to see generated APIs for each language from spec pull request.
    - APIView shows public SDK API signatures for each language so that user can see how thier generated APIs look like.
- Check if API spec is ready to generate SDK. Provide TypeSpec project root path and pull request number.
- Release plan:
  - A release plan is required to generate and release SDK from TypeSpec API specification if user is ready to generate the SDK.
  - Check if there is a release plan already created for the API spec pull request. 
  - If a release plan work item does not exist, create a release plan. User needs to provide following details to create a release plan:
        - Prompt user to select the target lifecycle of API specification.
            - Target lifecycle is the lifecycle of the API specification. Show below list of options and prompt user to select one of the options.
                - Target lifecycle options: Private Preview, Public Preview, GA
            - SDK needs to be generated and released only if target lifecycle is Public Preview or GA.
            - If target lifecycle is Private Preview, then inform user that SDK generation and release is not required for private preview and merging the SPEC PR completes the process. 
            - If target lifecycle is Public Preview or GA, then proceed with the next steps.
        - Prompt user to provide the following details for the release plan work item.
            - Service tree ID for the service
            - Product service tree ID for the product
            - Expected release timeline in Month and Year (e.g., Month YYYY)
            - API version
        - If user does not have the details, then suggest user to use release planner to create a release plan. 
          More details about release planner is [here](https://eng.ms/docs/products/azure-developer-experience/plan/release-plan-create).            
- Get release plan and check if it already ran SDK generation and SDK pull request exist for a language.
    - If SDK pull request is available for a language, then show the details of the SDK pull request.
    - If SDK pull request is not available or want to regenerate then proceed with the next steps.
- Run SDK generation step for Python and .NET:    
    - Run SDK generation pipeline if API spec is ready to generate SDK. Following are the required parameters for SDK generation:
        - TypeSpec project root path
        - Pull request number only if API spec is not merged to main branch.
        - API version
        - SDK release Type: beta or stable
        - Language: 
            Options: `Python`, `.NET`
        - Release plan work item ID
    - Highlight the language name for each SDK generation task when showing details to user.
    - When SDK pull request URL is available from SDK generation pipeline, show successful message to user that SDK generation is completed and show the details of the SDK pull request.
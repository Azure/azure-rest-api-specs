## Converting a specification from swagger to typespec

Users can convert a specification from swagger to typespec by using `tsp-client` a CLI designed to help developers throughout various stages of typespec development.

### Instructions for converting a specification from swagger to typespec

1. Install the dependencies specified in the package.json at the root of this repository. Command:

```
npm ci
```

2. `tsp-client` is installed as part of the dependencies specified at the root of this repository. To convert a swagger to typespec, run the following command: `npx tsp-client convert --swagger-readme <path to your readme>`
3. Now that you have a newly converted typespec project, you should go through all files to verify the accuracy of the converted spec when compared to the original swagger definitions.
4. For both data plane and management plane specifications, you should update the implementation according to the information provided under the [Initial migration checklist](#initial-migration-checklist) section.

### Initial migration checklist

The swagger converter will not be able to accurately represent every part of every API in TypeSpec. This document outlines some common changes you may need to make to a converted TypeSpec to make it conform to your existing service API, pass validation checks, and follow best practices.

- Avoid extensive refactoring of the converted spec. The goal is to get a working spec that can compile successfully and then iteratively improve it.

- DO ensure your `@service` and `@server` definitions are correct in main.tsp
- DO use the built-in [url][url-type] for endpoint specification. Example:

```tsp
@server(
  "{endpoint}/widget",
  "Contoso Widget APIs",
  {
    /**
      * Supported Widget Services endpoints (protocol and hostname, for example:
      * https://westus.api.widget.contoso.com).
      */
    endpoint: url,
  }
)
```

- DO ensure that you have a security definition (`@useAuth`) specified for your service. See: [Security definitions in TypeSpec][security-definitions]. The @useAuth decorator should only be defined ONCE in the entire specification above the @server definition.
- AVOID adding new namespaces.
- Make sure the versions enum is declared under the existing namespace defined in main.tsp. Avoid adding it anywhere else. Ensure the `@versioned` decorator is specified over the namespace in main.tsp. Pass the versions enum to the `@versioned` decorator. Example of a typical structure for versioning:

```tsp
// this is the main.tsp file


@versioned(Versions)
namespace Contoso.WidgetManager;
/** Service api versions **/
enum Versions {
  /** The 2023-11-01 api version **/
  v2023_11_01: "2023-11-01",
}
```

- All models, enums, unions, and operations should be added under the main namespace declared in the project.
- Avoid having models, enums, unions, operations, and other types declared outside of a namespace.
- If any files are using any of the versioning decorators, such as `@added`, `@removed`, `@changedType`, make sure to import the `@typespec/versioning` library and add a using statement. Example:

```tsp
import "@typespec/versioning";

using TypeSpec.Versioning;
```

- DO review all enum and union definitions and add documentation over each enum or union member. See: [Documentation in TypeSpec][docs]. Example of a properly documented enum:

```tsp
/** The color of a widget. */
union WidgetColor {
  string,

  /** Red Widget Color */
  Red: "Red",

  /** Green Widget Color */
  Green: "Green",

  /** Blue Widget Color */
  Blue: "Blue",
}
```

- DO ensure that all models, properties, operations, parameters, enums, unions, and alias definitions have documentation over them. TypeSpec convention recommends using the doc comment format `/** <docs go here> */` to add documentation, example:

```tsp
/** The color of a widget. */
model Widget {
  /** Widget name */
  name: string
}
```

- DO define your visibility decorators with the appropriate value from the Lifecycle class.
- Avoid suppressing warnings
- Operation names should be camel case
- DO use `union` instead of `enum` to define Azure enums. For more information about how to define enums for Azure services see the following documentation: [Defining enums for Azure services][no-enum].
- DO make client customizations in a `client.tsp` file
- Avoid importing or using `@azure-tools/typespec-client-generator-core` in other files aside from client.tsp.
- DO run `tsp compile .` on your specification and make one attempt to address all warnings. Do not attempt to address warnings more than once even if they aren't resolved.
- Attempt to address any FIXME or TODO comments in the spec. If you are unable to address them, leave them untouched

#### Additional considerations

- DO ensure you pull in the latest `main` from the Azure/azure-rest-api-specs repo to stay up to date with latest dependencies
- DO run `npm ci` to get a clean install of the package.json dependencies
- Avoid modifying the package.json or package-lock.json files at the root of the azure-rest-api-specs repo
- Avoid adding your own package.json or package-lock.json files in your project directory
- Avoid adding multiple tspconfig.yaml files for your service specification
- DO consult [ci-fix.md][ci-fix] for fixes to common CI errors reported

## Troubleshooting tsp compile errors and warnings

Examples of common errors and warnings that should be addressed after running the `tsp compile` command:

- If you see an error with a message like: "referencing types from versioned namespace 'Azure.Core.Foundations' but didn't specify which versions with @useDependency", you should add the @useDependency decorator over each api version entry in your api versions enum. Example of a properly configured api versions enum:

```
/** Service api versions **/
enum Versions {
  /** The 2023-11-01 api version **/
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_11_01: "2023-11-01",
}

```

- If you see an invalid-ref or unknown identifier error you are most likely missing an import to the library that declares that decorator. To find supported libraries and decorators search through the documentation of the following sites: https://azure.github.io/typespec-azure/docs/intro/ and https://typespec.io/docs/ Search through the list of supported decorators, interfaces, and other types per library until you find the correct library to import and/or include a using statement in your typespec files.
- In order to address warnings raised by the @azure-tools/typespec-azure-core search through this page for relevant solutions to apply: https://azure.github.io/typespec-azure/docs/intro/
- camelCase fixes only apply to the typespec property names, any corresponding string values you should left as is.
- String values in typespec files should be left untouched.

<!-- LINKS -->

[contoso-widget-manager]: ../specification/contosowidgetmanager/Contoso.WidgetManager/
[tspconfig]: ../specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml
[security-definitions]: https://azure.github.io/typespec-azure/docs/reference/azure-style-guide#security-definitions
[versioning]: https://typespec.io/docs/libraries/versioning/guide#implementing-versioned-apis
[docs]: https://typespec.io/docs/language-basics/documentation
[ci-fix]: ../documentation/ci-fix.md
[url-type]: https://typespec.io/docs/language-basics/built-in-types#string-types
[no-enum]: https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum


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

## Steps to generate and release SDK from TypeSpec API specification

### Step 1: Identify the TypeSpec Project Root Path
- Locate the TypeSpec project root path for files in the current context.

### Step 2: Validate the TypeSpec Project
- Before running, inform user that TypeSpec validation takes around 20 - 30 seconds.
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

### Step 4: Create SDK locally from TypeSpec
- Currently supported for Python only. SDK for all other languages is generated using the Azure DevOps pipeline.
- Always prompt user to check if they want to generate SDK locally for Python.
    - If the user wants to generate SDK locally:
        - Prompt the user to provide the path to cloned azure-sdk-for-python repository.
        - If the user provides a path to the azure-sdk-for-python repository, check if the repository exists:
            - If the repository exists, start a new process to open vscode in the cloned azure-sdk-for-python repository.
        - If the user does not have the
        repository, provide instructions to clone it.
           - Go to parent directory of current repo root path.
           - Fork https://github.com/Azure/azure-sdk-for-python repository to the user's GitHub account.
           - Clone the forked repository to the local machine.
            ```bash
            git clone https://github.com/<github-username>/azure-sdk-for-python.git
            ```
           - Consider cloned path as the path to the azure-sdk-for-python repository.
        - Do not ask the user to run tsp compile. Instead ask user to open azure-sdk-for-python repository in vscode and use agent
         suport in python repo to generate the SDK.
        - Prompt user to open vscode in the cloned azure-sdk-for-python repository. 
        - Inform user to use prompt like below to start SDK generation using GitHub copilot agent.
          "Help me generate SDK for Python from TypeSpec API specification for project < path to TypeSpec project root >."
- Inform user to provide link to SDK pull request if they generate DSK locally and created a pull request for it. SDK generation
step below will skip it for the language and reuse the pull request link provided by the user.
- In some cases, user will come back and make more changes to TypeSpec so start the process from step 1 again.
- If user provides a link to SDK pull request then link SDK pull request to release plan if a release plan already exists and skip SDK generation for that language.
- If a release plan does not exits then link the SDK pull request when release plan is created.

### Step 5: Manage Pull Requests
- Check if a pull request for TypeSpec exists for the current branch:
    - If a pull request exists, inform the user and display its details.
    - If no pull request exists for TypeSpec:
        - Ensure the current branch name is not "main." If it is, prompt the user to create a new branch using 
        `git checkout -b <branch name>`.
        - Push the changes to the remote branch. If the branch does not exist on GitHub, create it and push the changes.
        - Generate a title and description for the pull request based on the changes. Prompt the user to confirm or 
        edit them.
        - Prompt the user to select the target branch for the pull request, defaulting to "main."
        - Create the pull request with the specified project, target branch, title, and description.
- Retrieve and display the pull request summary, including its status, checks, and comments. Highlight any action items.
    - Retrieve API review links and display their details. Inform the user to check APIView for generated SDK APIs.

### Step 6: Prepare the Release Plan
- Check if the API spec is ready to generate the SDK. Provide the TypeSpec project root path and pull request number.
- Verify if a release plan exists for the API spec pull request:
    - If no release plan exists, create one. Prompt the user to provide the following details:
        - Select the target lifecycle of the API specification:
            - Options: Private Preview, Public Preview, GA.
            - Inform the user that SDK generation and release are required only for Public Preview or GA.
            - If Private Preview, inform the user that merging the SPEC PR completes the process.
        - Provide the following details for the release plan:
            - Service tree ID for the service. This is GUID type of ID for the service in service tree.
            - Product service tree ID for the product. This is a GUID type of ID for the product in Service tree.
            - Expected release timeline (e.g., Month YYYY).
            - API version.
            - SDK release type (beta for preview API versions, stable otherwise).
        - If the user lacks details, suggest using the release planner. More details are available [here](https://eng.ms/docs/products/azure-developer-experience/plan/release-plan-create).
- If a release plan already exists, retrieve it and display its details to the user. If ReleasePlanLink is not empty, then show the link to user.

### Step 7: Generate SDKs
- If SDK pull request exists from local SDK generation, then skip SDK generation for that language. Link SDK pull request to release plan.
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
# New TypeSpec projects

Before creating or initializing a TypeSpec project, you must know your org name, service name, and the type of service: data-plane or control-plane (ARM).

Then create a new project directory under the `specification/<orgName>/resource-manager/<RPNamespace>/<ServiceName>` or `specification/<orgName>/data-plane/<ServiceName>` path, following the guidelines below.

```
specification/
└── <orgName1>/
    ├── cspell.yaml
    └── resource-manager/
        ├── readme.md			ß NOTE: For ARM schema validation; see bullet #2 below
        └── <RPNamespace>/		ß NOTE: Control-plane only (not data-plane)
            └── <ServiceName1>/	ß Customer-facing service name; each version gets Documentation & SDK package
                ├── tspconfig.yaml	ß TypeSpec files
                ├── main.tsp
                ├── models.tsp
                ├── readme.md		ß autorest readme with YAML blocks
                └── examples/		ß TypeSpec example folder
                    └── <api-version>/	ß One folder per service version described in TypeSpec
                        └── <example .json files>
                └── preview/ and stable/
                    └── <api-version>/	ß One folder per service version described in OpenAPI. These folders are created and populated by compiling the TypeSpec folder for the service.
                        ├── <OpenAPI .json files>
                        └── examples/	ß OpenAPI example folder
                            └── <example .json files>
            └── <ServiceName2>/	// Customer-facing service name; contents identical to above structure
    └── data-plane/
        └── <ServiceName3>/	// Customer-facing service name; contents identical to above structure
```

Use the `./specification/widget` directory as a reference for creating your own project directory.

Only after the project directory is created according to the above guidelines may you run the `azsdk_init_typespec_project` tool to initialize the project.

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
  v2023_11_01: "2023-11-01",
}

```

- If you see an invalid-ref or unknown identifier error you are most likely missing an import to the library that declares that decorator. To find supported libraries and decorators search through the documentation of the following sites: https://azure.github.io/typespec-azure/docs/intro/ and https://typespec.io/docs/ Search through the list of supported decorators, interfaces, and other types per library until you find the correct library to import and/or include a using statement in your typespec files.
- In order to address warnings raised by the @azure-tools/typespec-azure-core search through this page for relevant solutions to apply: https://azure.github.io/typespec-azure/docs/intro/
- camelCase fixes only apply to the typespec property names, any corresponding string values you should left as is.
- String values in typespec files should be left untouched.

## Up-to-date TypeSpec documentation

Follow [typespec docs](../eng/common/instructions/azsdk-tools/typespec-docs.instructions.md) to get the most up-to-date documentation for TypeSpec, including best practices for writing TypeSpec for Azure.

<!-- LINKS -->

[contoso-widget-manager]: ../specification/contosowidgetmanager/Contoso.WidgetManager/
[tspconfig]: ../specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml
[security-definitions]: https://azure.github.io/typespec-azure/docs/reference/azure-style-guide#security-definitions
[versioning]: https://typespec.io/docs/libraries/versioning/guide#implementing-versioned-apis
[docs]: https://typespec.io/docs/language-basics/documentation
[ci-fix]: ../documentation/ci-fix.md
[url-type]: https://typespec.io/docs/language-basics/built-in-types#string-types
[no-enum]: https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum
[typespec-structure-guidelines]: ../documentation/typespec-structure-guidelines.md

# SDK generation from TypeSpec

## Agent context for TypeSpec and SDK process

- Check all open files in the editor and check if `main.tsp` or `tspconfig.yaml` are open in the editor. If either of
  these files are open, then use the parent path of the `main.tsp` or `tspconfig.yaml` as default TypeSpec project root
  path.
- If `main.tsp` and `tspconfig.yaml` are not open in the editor, then check if there are any TypeSpec project paths in
  the context. If there are no TypeSpec project paths in the context, then prompt user to select a TypeSpec project path
  from the list of paths. If user does not have a TypeSpec project, then prompt user to create a new TypeSpec project.

### Prerequisites

- User should have a GitHub account and should be logged in to GitHub account using GitHub CLI `gh auth login`.
- run `npm ci` to install the dependencies
- To use Azure MCP tool calls, the user must have PowerShell installed. Provide [PowerShell installation instructions](https://learn.microsoft.com/powershell/scripting/install/installing-powershell) if not installed, and recommend restarting the IDE to start the MCP server.

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
6. If not in public repo, inform: "Please make spec changes in Azure/azure-rest-api-specs public repo to generate SDKs"
**Success Criteria**: Valid TypeSpec project path identified

Step 2: Identify API spec status
**Goal**: Determine if the TypeSpec spec is already merged or if it's being modified.
**Actions**:
1. Prompt user to confirm if the TypeSpec spec is already merged in the main branch of  https://github.com/Azure/azure-rest-api-specs : "Is your TypeSpec specification already merged in the main branch of repository(https://github.com/Azure/azure-rest-api-specs)? (yes/no)"
2. If already merged, follow the steps in [typespec to sdk](..\eng\common\instructions\azsdk-tools\typespec-to-sdk.instructions.md) to generate the SDK
3. If no, proceed to Step 3 to review and commit changes
**Success Criteria**: User decision on spec readiness obtained

Step 3: Validate TypeSpec Specification
**Goal**: Ensure TypeSpec specification compiles without errors. Povide a complete summary after running the tool. Highlight any errors and help user fix them.
**Condition**: Only if the spec is not already merged (from Step 2)
**Message to user**: "TypeSpec validation takes around 20 - 30 seconds."
**Actions**:
1. Run `azsdk_run_typespec_validation` to validate the TypeSpec project.
2. If validation succeeds, proceed to Step 4
3. If validation fails:
    - Display all compilation errors to user
    - Agent should provide suggestions to fix them and prompt the user to verify the fixes. If agent cannot resolve the errors, then prompt the user to fix compilation errors"
    - Wait for user to fix errors and re-run validation. Provide detailed information about all the changes done by copilot and prompt the user before rerunning the validation.
**Success Criteria**: TypeSpec compilation passes without errors

Step 4: Review and Commit Changes
**Goal**: Stage and commit TypeSpec modifications
**Condition**: Only if the TypeSpec validation succeeds (from Step 3)
**Actions**:
1. Run `azsdk_get_modified_typespec_projects` to identify changes
2. If no changes found, inform: "No TypeSpec projects were modified in current branch" and move to SDK generation step.
3. Display all modified files (excluding `.github` and `.vscode` folders)
4. Prompt user: "Please review the modified files. Do you want to commit these changes? (yes/no)"
5. If yes:
    - If on main branch, prompt user: "You are currently on the main branch. Please create a new branch using `git checkout -b <branch-name>` before proceeding."
    - Wait for user confirmation before continuing
    - Run `git add <modified-files>`
    - Prompt for commit message
    - Run `git commit -m "<user-provided-message>"`
    - Run `git push -u origin <current-branch-name>`
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
**Success Criteria**: Specification pull request exists

Follow the steps in [typespec to sdk](..\eng\common\instructions\azsdk-tools\typespec-to-sdk.instructions.md) to generate the SDK.

# Release readiness of SDK and information about the release pipeline

Run [check package readiness](..\eng\common\instructions\azsdk-tools\check-package-readiness.instructions.md) to check the release readiness of an SDK package. This prompt will collect the required information from the user, execute the readiness check, and present the results.

# Instructions for GitHub coding agent to generate SDKs using GitHub.com

Run only SDK generation step and Update SDK details back in issue description and release plan. Do not run TypeSpec validation, or service label check. This is applicable only when GitHub copilot coding agent is used to generate SDK and if a Release Plan is available in the context. Run SDK generation tool even if release plan already has SDK generation pipeline URL to support regenerating SDK.
Coding agent must wait until all SDK generation pipeline are in completed status and then fetch the SDK details from pipeline run. This is applicable only when a GitHub issue is assigned to GitHub coding agent to generate SDK from a TypeSpec project. This is not applicable when running Copilot from Visual Studio and VS Code.

## Additional instructions:

- Run SDK generation pipeline for the given TypeSpec path for all languages mentioned in the description.
- Identify absolute path of TypeSpec project root path and send it to Run SDK generation MCP tool call.
- Keep checking the pipeline status until pipeline is in completed or failed status.
- Find SDK pull request links from the pipeline run.

## Constraints:

- Do not invoke other steps.
- Do not modify main.tsp file or any files in TypeSpec project.
- Do not add API version to an existing main.tsp if input API version is not present.

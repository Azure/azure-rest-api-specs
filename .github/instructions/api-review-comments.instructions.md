# Basic Rules for Addressing API Review Comments

## User Guidance
- Assume the user is unfamiliar with TypeSpec. Follow TypeSpec conventions and best practices when to update relevant TSP files.

## User Input
- Request a comments markdown file in this format if it's not already provided:
```md
**TSP Folder Location**: specification/<yourservice>/<YourPackage>/

**TSP Git Branch**: <branch name>

**Comments:**
- <API To Change>: <Review comment>
- <API To Change>: <Review comment>
- etc.
```
- Check that the file includes ALL information listed. Prompt for any missing information.
- **Note**: The comments in this file address API for clients generated from the specified TypeSpec.
    - **TSP Folder Location**: The folder in which all files and changes should exist. Confirm with the user before making changes outside this folder.
    - **TSP Git Branch**: The branch that contains the relevant TypeSpec files that the comments address.
    - `<API To Change>`: TSP-generated client library API.
    - `<Review comment>`: The comment that describes the change to be made.

## Git Operations
- Avoid using the `main` branch for pull requests.
    - If the provided branch in the markdown file is `main`, prompt the user to create or switch to a new branch using `git checkout -b <YourPackage>_revisions main`.
    - If the provided branch is NOT `main`, confirm whether the provided branch should be used for pull requests or a new branch targeting the provided branch should be created.
        - If using the provided branch, prompt to check that the current branch is the provided branch or checkout the branch using `git checkout <branch name>`.
        - If using a new branch, prompt the user to create a new branch targeting the provided branch using `git checkout -b <branch name>_revisions <branch name>`.
- Display git commands (e.g., `git checkout`, `git add`, `git commit`, `git push`) with a "Run" button instead of 
asking the user to copy and paste.
- GitHub pull requests cannot be created from the `main` branch. Ensure all changes are made on a non-`main` branch.

## Process Visibility
- Show ALL planned changes in a list of concise bullet-points and confirm BEFORE making any changes.
- If a provided comment does not seem applicable, explain clearly why the comment cannot be applied.
- If many comments do not seem applicable, confirm with the user that the working repository and current branch is correct.

## Language-Specific API Conversions
- If the `<API To Change>` or `<Review comment>` use snake_case, convert to CamelCase to identify the TypeSpec element to change. The snake_case indicates Python generated client API.

## Create or update `client.tsp`
- Create or update a `client.tsp` IF:
  - a comment says to make a name or namespace change for specific language(s).
  - an existing `typespec-client-generator-core` decorator is NOT in the client.tsp and should be moved there.
- Review the `.github/instructions/client-customizations.instructions.md` file for in-depth client customization scenarios and syntax.

## Update existing `main.tsp`, `routes.tsp`, `models.tsp` or other NON-`client.tsp` files
- Update existing `main.tsp`, `routes.tsp`, `models.tsp` or other non-client TSP files IF:
  - a comment says to make a name or namespace change without specifying a language.

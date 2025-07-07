# Steps for Addressing API Review Comments

Follow these steps in EXACTLY the following order. Do not skip any part of the process. If you are unsure about any step, ask for clarification before proceeding.
Make sure to explain the next step clearly before taking the step.

1. Review the `.github/instructions/api-review-comments.instructions.md` file thoroughly before proceeding. CONFIRM that you have reviewed and understood the instructions by concisely summarizing the instruction file.
2. Ensure that the current working branch is the correct branch.
3. Review the provided API review comments markdown file. For each comment, identify the TypeSpec file(s) and object that need to be updated by referring to the relevant section in the `api-review-comments.instructions.md` file.
- Example:
  **Comment:**
    ```md
    - azure.mynamespace.WidgetModelsForMyNamespaceClient: WidgetModelsForMyNamespaceClient is too long and redundant for Python and JS. How about WidgetModelsClient?
    ```
  **Updated client.tsp:**
    ```tsp
    using Azure.MyNamespace.WidgetModelsForMyNamespace
    @@clientName(WidgetModelsForMyNamespace, "WidgetModels", "python,javascript");
    ```
- Example:
  **Comment:**
  ```md
  - azure.mynamespace.DataClient: DataClient seems too general. Would WidgetModelsClient work here?
  ```
  **Before updating main.tsp:**
  ```tsp
  @service(#{ title: "Azure MyNamespace Data" })
  namespace Azure.MyNamespace.Data;
  ```
  **Change made in main.tsp:**
  ```tsp
  namespace Azure.MyNamespace.WidgetModels;
  ```
4. Write a list for ALL planned changes and confirm with the user before continuing.
5. Execute the plan fully and only pause when asking for necessary user input.
6. After making the changes, run `/validate-typespec` and resolve any compilation errors.
7. Generate the SDKs using the command `npx tsp-client generate --languages <languages>`. Prompt the user for a comma-separated list of target `<languages>` (e.g., `python,javascript`).

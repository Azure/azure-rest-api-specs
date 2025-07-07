# Steps for Addressing API Review Comments

1. Review the `.github/instructions/api-review-comments` instructions thoroughly before proceeding.
2. For each comment, identify the TypeSpec file(s) that need(s) and object that need to be updated. Examples:
- Comment:
    ```md
    - azure.mynamespace.MyNamespaceWidgetModelsClient: MyNamespaceWidgetModelsClient is too redundant for Python and JS. How about WidgetModelsClient?
    ```
  Change made in client.tsp:
    ```tsp
    @@clientName(MyNamespaceWidgetModels, "WidgetModels", "python,javascript");
    ```
- Comment:
  ```md
  - MyNamespace.DataClient: DataClient seems too general. Would WidgetModelsClient work here?
  ```
  Change made in main.tsp:
  ```tsp
  interface WidgetModels
  ```
3. Write a list for ALL planned changes and confirm with the user before continuing.
4. Execute the plan fully and only pause when asking for necessary user input.
5. After making the changes, run `/validate-typespec` and resolve any compilation errors.
6. Generate the SDKs using the command `npx tsp-client generate --languages <languages>`. Prompt the user for a comma-separated list of target `<languages>` (e.g., `python,javascript`).

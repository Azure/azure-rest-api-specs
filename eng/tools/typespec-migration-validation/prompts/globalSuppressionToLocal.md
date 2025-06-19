# Remove global suppressions

As a GitHub Copilot assistant, follow this guide to remove all the global suppressions and specify them locally.

## Understanding User Input

When users request help with converting global suppressions to inline suppressions in TypeSpec and Swagger specifications, and adding appropriate justifications for all suppressions, they typically provide a {TypeSpec-folder} in the format `{ServiceName}.Management` (where ServiceName examples include: `Compute`, `Network`, `Storage`) or a `tspconfig.yaml` file.

When the user provides a service folder name, look for the `tspconfig.yaml` under that folder and base subsequent work on the content of that file.

If the user provides a `tspconfig.yaml` file, use the information in that file directly to guide the migration. In this case, {TypeSpec-folder} is the folder containing that file.

If the user does not provide this information, be sure to ask. Use this information to customize your guidance, especially in the following cases:
- Selecting appropriate conversion commands
- Providing service-type-related examples

## Migration Steps

## Step 1: Locate the tspconfig.yaml file

1. **Check the `tspconfig.yaml` file**
   - Location: `{ServiceName}.Management/tspconfig.yaml` or the `tspconfig.yaml` file provided directly by the user

2. **Check the disable section in the tspconfig.yaml file**
   - Look for all configurations under `disable:`, for example:
    ```yaml
    linter:
      extends:
        - "@azure-tools/typespec-azure-rulesets/resource-manager"
      disable:
        "@azure-tools/typespec-azure-core/no-nullable": "backward-compatibility"
    ```
   - These configurations represent global suppressions that you need to convert to inline suppressions.

## Step 2: Migrate global suppressions to inline suppressions

1. Remove the `disable:` section from the `tspconfig.yaml` file, and remember all the warning types that were suppressed by the removed global suppressions.

2. Recompile the tsp files to generate new Swagger files while reproducing the warnings that were previously globally suppressed.

```powershell
cd {TypeSpec-folder}
npx tsp compile .
```

3. For warnings that appear during the compilation process, you need to categorize the warnings according to the warning types from the previously removed global suppressions and add inline suppressions in the corresponding TypeSpec files. The format for inline suppressions is as follows:

```typespec
#suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@operationId("WebPubSubCustomDomains_Get")
get is ArmResourceRead<CustomDomain>;
```

Note that inline suppressions need to be placed above the relevant code, especially above all decorators. You cannot intermix #suppress with decorators, as this will cause TypeSpec validation to fail. You also need to provide clear justification statements. The justification statement "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details" in the example is a good justification. However, I hope you can provide more detailed and appropriate justification statements based on specific situations.

4. After adding all inline suppressions, you need to check that all inline suppressions have clear justification statements. Note the two common error formats:

1. Missing justification

```typespec
#suppress "@azure-tools/typespec-azure-core/no-openapi" // This is an incorrect example, missing justification
```

2. Empty justification

```typespec
#suppress "@azure-tools/typespec-azure-core/no-openapi" "" // This is an incorrect example, empty justification
```

You can use the "findstr /s /n "#suppress" *.tsp" command to find all inline suppressions and check if they have justification statements. You can also use more detailed commands to find all inline suppressions and check if the justification statements are empty or missing, and correct them to ensure each inline suppression has a clear and meaningful justification statement.

## Step 3: Validation and Testing

1. **Validate inline suppressions**:
   - Ensure all inline suppressions have been correctly added with clear and meaningful justification statements.
   - Recompile TypeSpec files to ensure there are no new warnings or errors.

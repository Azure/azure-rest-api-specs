# Swagger to TypeSpec Migration Instructions - Validation Steps

Follow these steps to guide users through comparing Swagger and TypeSpec specifications after initial conversion to validate the migration result:

## Understanding User Input
When a user asks for help with comparing Swagger and TypeSpec specifications, they will typically provide the name of the service folder under `specification/` (e.g., `compute`, `network`, `storage`). Always ask for this information if it's not provided.

1. First, determine the absolute path to the generated Swagger files. Examine the `tspconfig.yaml` file in the TypeSpec folder:
   - Look for the `emitter` configurations, particularly the `@azure-tools/typespec-autorest` emitter
   - Find the `output-file` option which specifies where Swagger files are generated
   - The value of {version} is determined from the `main.tsp` file:
     - Look for an enum named `Versions` or `ApiVersions` in the main.tsp file
     - The enum values represent the API versions supported by the service
     - For example: `enum Versions { v2023_01_01 = "2023-01-01" }` 
     - The string value (e.g., "2023-01-01") is what will be substituted for {version} in the output path
   - The value of {version-status} is either stable or preview
   - The value of {service-name} is determined from the `main.tsp` file:
     - The namespace of the main TypeSpec file.
     - For example: `namespace Microsoft.Compute;`
     - The service name is `Microsoft.Compute` in this case.

2. Second, determine the location of the original Swagger folder:
   - The original Swagger is typically located at `sparse-spec\specification\{service-folder-name}`
   - Use the innermost folder (e.g., `sparse-spec\specification\storageactions\resource-manager\Microsoft.StorageActions\stable\2023-01-01`) as the original Swagger folder path
   - Check if this folder exists by running:
     ```powershell
     Test-Path sparse-spec\specification\{service-folder-name}
     ```
   - If the folder doesn't exist, instruct the user to run:
     ```powershell
          {root}\eng\tools\typespec-migration-validation\scripts\download-main.ps1 {absolute/path/to/generated/swagger}
     ```
   - After running the download script, determine the location of the original Swagger folder again, which should now be available at the innermost folder of `sparse-spec\specification\{service-folder-name}`.

Till now you have gathered the following information:
- `{TypeSpec-folder}`: The absolute path to the TypeSpec folder containing the generated Swagger files
- `{original/swagger/folder}`: The absolute path to the original Swagger folder
- `{generated/swagger/file}`: The absolute path to the generated Swagger file

## Iterative Comparison and Refinement Process

Follow this iterative process until the TypeSpec-generated Swagger achieves acceptable compatibility with the original:

1. **Run TypeSpec Migration Validation Tool**:
   ```powershell
   npx tsmv {original/swagger/folder} {generated/swagger/file} {outputFolder}
   ```
This command will output suggested prompts in the console, starting with `Considering these suggested prompts for the diff:`.

2. **Modify TypeSpec Files**:
   - Put all .tsp files in the `{TypeSpec-folder}` into GitHub Copilot's context
   - Use the suggested prompts from the previous step as GitHub Copilot's user instructions. 
   - Apply targeted changes to the TypeSpec files

3. **Recompile TypeSpec**:
   ```powershell
   cd {TypeSpec-folder}
   npx tsp compile .
   ```
   - This generates updated Swagger files with your changes

4. **Repeat Validation**:
   - Re-run the Migration Validation Tool with the same parameters
   - Verify if your changes resolved the targeted differences
   - If significant differences remain, return to step 2

Continue this cycle until you've addressed the most important differences or achieved satisfactory compatibility. Remember to document the changes made in each iteration, as this will help track progress and identify patterns for future migrations.

### Recommended Iteration Strategy

- **Iteration 1**: Focus on critical path/route differences
- **Iteration 2**: Address model/definition naming issues
- **Iteration 3**: Fix property types and required fields
- **Iteration 4**: Refine documentation and metadata

At each step, run the complete cycle of validate → modify → compile → re-validate before moving to the next category of differences.
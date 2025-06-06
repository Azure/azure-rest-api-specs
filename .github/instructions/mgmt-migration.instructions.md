# ARM Swagger to TypeSpec Migration Instructions

As a GitHub Copilot agent, follow these instructions when assisting with migrating Swagger specifications to TypeSpec.

## Understanding User Input

When a user asks for help with Swagger to TypeSpec migration, they will typically provide the name of the service folder under `specification/` (e.g., `compute`, `network`, `storage`)

Always ask for this information if it's not provided. Use it to customize your guidance, especially when:
- Selecting the appropriate conversion command
- Providing examples relevant to the service type

When a user provides this information, acknowledge it and adapt your assistance accordingly. For example:
- "Great, I see you're working with the `compute` service. Let's proceed with the migration steps tailored for that service."
- "Thanks for sharing the service name. I'll guide you through migrating the `storage` service to TypeSpec."

## Prerequisites

When helping users migrate Swagger to TypeSpec, first check if they already have the required dependencies installed:

1. Ask the user if they have already run `npm install` in the repository root.
2. If they confirm dependencies are already installed, you can proceed to the next step.
3. If they're unsure or haven't installed dependencies, recommend running this PowerShell command in the repository root:

```powershell
npm install
```

Users who frequently work with the repository may already have dependencies installed and can skip this step.

## Step 1: Generate TypeSpec with Converter

Guide users through these steps to generate TypeSpec from their Swagger specification, using the service information they provided:

1. Navigate to the specific service folder in the repository, based on the user's input:

```powershell
cd specification/{service-folder-name}
```

Replace `{service-folder-name}` with the actual service name provided by the user (e.g., `compute`, `storage`, `cognitiveservices`).

2. Help users create a directory for TypeSpec files. For determining the TypeSpec folder name:

 1. Look in the `specification/{service-folder-name}` directory for a folder that starts with "Microsoft."
 2. The TypeSpec folder name should be `{ServiceName}.Management` where {ServiceName} is:
   - If a Microsoft.* folder exists: The second part after "Microsoft." (e.g., "Microsoft.Compute" → "Compute.Management")
   - Otherwise: The service folder name in PascalCase (e.g., "compute" → "Compute.Management")

  For example:
  - If `specification/compute` contains `Microsoft.Compute` folder, the TypeSpec folder should be `Compute.Management`
  - If `specification/cdn` contains `Microsoft.Cdn` folder, the TypeSpec folder should be `Cdn.Management`

3. Run this command in the folder {TypeSpec-folder} created in the previous step.

   ```powershell
   npx tsp-client convert --swagger-readme {path/to/readme.md} --arm --fully-compatible
   ```

Replace placeholders with actual file paths from the user's workspace. The `{path/to/readme.md}` should point to the `readme.md` file in the service folder, which is typically located at `specification/{service-folder-name}/resource-manager/readme.md`.

## Step 2: Review and Adjust the TypeSpec

Help users review and adjust their TypeSpec files with these steps:

1. Compile TypeSpec files to generate Swagger:

```powershell
cd {TypeSpec-folder}
npx tsp compile .
```

When you need to determine the absolute path to the generated Swagger files. Examine the `tspconfig.yaml` file in the TypeSpec folder:
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

2. Download the latest specification as a baseline by running the following command:

```powershell
{root}\eng\tools\typespec-migration-validation\scripts\download-main.ps1 {absolute/path/to/generated/swagger}
```
Extract the next command from its output (it will start with "Your next command:"), and then run that extracted command, substituting {outputFolder} for the output folder parameter.

3. For detailed instructions on comparing original and generated Swagger files and fixing differences, refer to:

<!-- INSTRUCTIONS IMPORT: .github/instructions/comparison.instructions.md -->

This import provides step-by-step guidance for:
- Running the TypeSpec Migration Validation tool
- Comparing original and generated Swagger files
- Making iterative improvements to your TypeSpec files
- Prioritizing which differences to address first
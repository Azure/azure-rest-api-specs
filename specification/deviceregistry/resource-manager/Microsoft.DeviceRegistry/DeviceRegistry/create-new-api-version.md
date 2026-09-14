# Create New API Version for Azure Resource Provider

This prompt helps create a new API version for an Azure Resource Provider service that uses TypeSpec.

## Context Variables
- `{SERVICE_NAME}`: The name of the service (e.g., deviceregistry, storage, compute)
- `{NEW_API_VERSION}`: The new API version to create (e.g., 2025-12-01, 2026-01-01-preview)
- `{PREVIOUS_API_VERSION}`: The most recent existing API version to copy from
- `{PROVIDER_NAMESPACE}`: The Microsoft provider namespace (e.g., Microsoft.DeviceRegistry)

## Instructions

This repository represents Azure Resource Provider services API schema in the form of TypeSpec which is then used to generate JSON.

Our service is located under `specification/{SERVICE_NAME}` with multiple folders:
- The `{SERVICE_NAME}.Management` folder hosts the TypeSpec files and JSON examples
- The `resource-manager` folder hosts the generated JSON files as well as copied over examples

When creating a new API version, follow these steps:

### 1. Add New Version to TypeSpec
- Add the new version `{NEW_API_VERSION}` to the `Versions` enum in `specification/{SERVICE_NAME}/{SERVICE_NAME}.Management/main.tsp`
- Include appropriate documentation and ARM common types version

### 2. Copy and Update Examples
- Copy examples from the `{PREVIOUS_API_VERSION}` folder to a new `{NEW_API_VERSION}` folder under `specification/{SERVICE_NAME}/{SERVICE_NAME}.Management/examples/`
- Replace all references of `{PREVIOUS_API_VERSION}` with `{NEW_API_VERSION}` in all example files

### 3. Compile TypeSpec
- Run `tsp compile .` at the TypeSpec path (`specification/{SERVICE_NAME}/{SERVICE_NAME}.Management/`)
- This generates new JSON files for the new API version under `specification/{SERVICE_NAME}/resource-manager/`

### 4. Verify No Existing Files Modified
- Ensure that no existing files for older API versions are modified during compilation
- Only new files for `{NEW_API_VERSION}` should be created

### 5. Update Resource Manager readme.md
- Add new version configuration to `specification/{SERVICE_NAME}/resource-manager/readme.md`
- Create a new tag section (e.g., `package-{VERSION_SHORT}`) 
- Copy existing suppressions from the previous version if applicable
- Update the global settings tag to point to the new version

### 6. Run Validation
- Run `npx tsv` on folder with main.tsp file
- Run `npx prettier --write {SERVICE_NAME} folder`
- Fix any errors.

## Example Usage

To create version `2025-12-01` for DeviceRegistry service:
- SERVICE_NAME: `deviceregistry`
- NEW_API_VERSION: `2025-12-01`
- PREVIOUS_API_VERSION: `2025-10-01`
- PROVIDER_NAMESPACE: `Microsoft.DeviceRegistry`

## Validation Checklist
- [ ] New version added to TypeSpec Versions enum
- [ ] Examples copied and API version references updated
- [ ] TypeSpec compiles successfully
- [ ] No existing files modified
- [ ] readme.md updated with new tag configuration
- [ ] Global settings updated to new version
- [ ] TSV validation passes on all JSON files

## Notes
- Use semantic versioning patterns (YYYY-MM-DD for stable, YYYY-MM-DD-preview for preview)
- Ensure ARM common types version is appropriate for the API version
- Maintain consistency with existing patterns in the service specification
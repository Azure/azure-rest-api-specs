# ARM Leases - Design Discussion Period

## Overview

This directory contains lease files that establish a time-limited design discussion period for Resource Providers (RPs) in the Azure REST API specifications repository. ARM leases provide a structured timeframe for Product Managers (PMs) and RP owners to collaborate on API design, review specifications.

**Important**: Only Product Managers (PMs) are authorized to add lease.yaml files to this directory. Lease files should be added after conducting office hours discussions with RP owners. The reviewer field should contain the GitHub alias of a PM who has reviewed and approved the lease.

## Code Owners and Contribution Guidelines

This directory is intended to be governed via CODEOWNERS to ensure proper governance:

- **Product Managers (PMs)**: Can add and modify `lease.yaml` files after office hours discussions with RP owners
- **Engineers**: Can enhance and improve the validation workflow and related automation
- **Approvals**: All changes should be reviewed and approved by designated code owners (PMs and engineers listed in CODEOWNERS, when configured)

**Adding New PMs**: To grant a new PM access to add lease files, they should be added to the CODEOWNERS file for the `.github/arm-leases/` directory path when CODEOWNERS protection is configured.

## Lease File Structure

Each lease must be placed in the following directory structure:

```
.github/arm-leases/<orgName>/<rpNamespace>/[<serviceName> (optional)]/lease.yaml
```

### Path Requirements:

- `<orgName>`: lowercase alphanumeric only (e.g., testservice, widgetservice)
- `<rpNamespace>`: alphanumeric with dots, case-sensitive (e.g., Microsoft.TestRP, Azure.Widget)
- `<serviceName>`: (optional) customer-facing service name within an RP (e.g., DiskRP, ComputeRP). Must not start with "stable" or "preview"

### Lease File Format

The `lease.yaml` file must follow this format:

```yaml
lease:
  resource-provider: Microsoft.TestRP # Must match the rpNamespace folder name
  startdate: 2026-01-07 # ISO 8601 format (YYYY-MM-DD)
  duration: P180D # ISO 8601 duration (max 180 days, e.g., P180D, P90D, P5M)
  reviewer: "@evanhissey" # GitHub alias of the approving reviewer
```

### Copy-Paste Template

Create a file at `.github/arm-leases/<orgName>/<rpNamespace>/<serviceName>(optional)/lease.yaml` with the following content (replace the placeholder values):

```yaml
lease:
  resource-provider: <rpNamespace>
  startdate: <YYYY-MM-DD>
  duration: P180D
  reviewer: "@your-github-alias"
```

## Validation Rules

All lease files are automatically validated with the following requirements:

### 1. File Location

- Only `lease.yaml` files are allowed in the `.github/arm-leases/` directory
- Must follow the folder structure: `<orgName>/<rpNamespace>/[<serviceName> (optional)]/lease.yaml`

### 2. Resource Provider Name

- Must match the `<rpNamespace>` folder name exactly
- Example: If folder is `Microsoft.TestRP`, then `resource-provider` must be `Microsoft.TestRP`

### 3. Start Date

- Must be in ISO 8601 format: `YYYY-MM-DD`
- Must be a valid calendar date

### 4. Duration

- Required field that cannot be empty
- Must be a valid ISO 8601 duration (e.g., `P180D`, `P90D`, `P5M`)
- **Maximum duration is 180 days**
- Supports day-based (`P90D`), month-based (`P5M`), and combined formats

### 5. Reviewer

- Required field that cannot be empty
- Must be a GitHub alias starting with `@` (e.g., `@githubUsername`)

## Troubleshooting

If your PR check **"ARM Lease Validation"** is failing, review the error messages in the check output and fix the issues in your `lease.yaml` file. Common causes include:

- **Invalid folder structure**: Ensure the path follows `<orgName>/<rpNamespace>/[<serviceName>]/lease.yaml` with lowercase org name
- **Resource provider mismatch**: The `resource-provider` value must match the `<rpNamespace>` folder name exactly
- **Past start date**: The `startdate` must be a valid date in `YYYY-MM-DD` format
- **Invalid duration**: Use a valid ISO 8601 duration that does not exceed 180 days (e.g., `P180D`, `P90D`, `P5M`)
- **Missing or empty fields**: All fields (`resource-provider`, `startdate`, `duration`, `reviewer`) are required
- **Disallowed files**: Only `lease.yaml` and `README.md` files are permitted in `.github/arm-leases/`

## Automation Scripts

Scripts are located in `eng/scripts/`. Run from the repository root.

### Single Resource Provider

**Syntax:**
```bash
# Without service groups
node eng/scripts/generate-lease-files.js --orgName <orgName> --rpNamespace <rpNamespace> --reviewer "@youralias" --startdate <YYYY-MM-DD> --duration <P#D>

# With service groups
node eng/scripts/generate-lease-files.js --orgName <orgName> --rpNamespace <rpNamespace> --reviewer "@youralias" --startdate <YYYY-MM-DD> --duration <P#D> --serviceName "<serviceName1>,<serviceName2>"
```

**Examples:**
```bash
# Without service groups
node eng/scripts/generate-lease-files.js --orgName storage --rpNamespace Microsoft.Storage --reviewer "@johndoe" --startdate 2026-05-01 --duration P90D

# With service groups
node eng/scripts/generate-lease-files.js --orgName compute --rpNamespace Microsoft.Compute --reviewer "@janesmith" --startdate 2026-05-01 --duration P180D --serviceName "DiskRP,ComputeRP,GalleryRP"
```

### Bulk Generation

**Syntax:**
```bash
# Generate resource provider list
node eng/scripts/fetch-resource-providers.js --with-service-groups --output <filename>

# Generate lease files from list
node eng/scripts/generate-lease-files.js --input <filename> --reviewer "@youralias" --startdate <YYYY-MM-DD> --duration <P#D>
```

**Examples:**
```bash
# Generate resource provider list
node eng/scripts/fetch-resource-providers.js --with-service-groups --output rps-groups.txt

# Generate lease files from list
node eng/scripts/generate-lease-files.js --input rps-groups.txt --reviewer "@johndoe" --startdate 2026-04-16 --duration P180D
```

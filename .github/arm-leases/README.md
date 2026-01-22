# ARM Leases - Design Discussion Period

## Overview

This directory contains lease files that establish a time-limited design discussion period for Resource Providers (RPs) in the Azure REST API specifications repository. ARM leases provide a structured timeframe for Product Managers (PMs) and RP owners to collaborate on API design, review specifications.

**Important**: Only Product Managers (PMs) are authorized to add lease.yaml files to this directory. Lease files should be added after conducting office hours discussions with RP owners. The reviewer field in the lease file must also be a PM who has reviewed and approved the lease.

## Code Owners and Contribution Guidelines

This directory is protected by CODEOWNERS to ensure proper governance:

- **Product Managers (PMs)**: Can add and modify `lease.yaml` files after office hours discussions with RP owners
- **Engineers**: Can enhance and improve the validation workflow and related automation
- **Approvals**: All changes require approval from code owners (PMs and engineers listed in CODEOWNERS)

**Adding New PMs**: To grant a new PM access to add lease files, they must be added to the CODEOWNERS file for the `.github/arm-leases/` directory path.

## Lease File Structure

Each lease must be placed in the following directory structure:
```
.github/arm-leases/<servicename>/<namespace>/[<servicegroup> (optional)]/lease.yaml
```

### Path Requirements:
- `<servicename>`: lowercase alphanumeric only (e.g., testservice, widgetservice)
- `<namespace>`: alphanumeric with dots, case-sensitive (e.g., Microsoft.TestRP, Azure.Widget)
- `<servicegroup>`: (optional) logical grouping within an RP (e.g., DiskRP, ComputeRP). Must not start with "stable" or "preview"

### Lease File Format

The `lease.yaml` file must follow this format:

```yaml
lease:
  resource-provider: Microsoft.TestRP    # Must match the namespace folder name
  startdate: 2026-01-07                  # ISO 8601 format (YYYY-MM-DD)
  duration: 180 days                     # Maximum allowed is 180 days
  reviewer: Evan Hissey                  # Name of the approving reviewer
```

## Validation Rules

All lease files are automatically validated with the following requirements:

### 1. File Location
- Only `lease.yaml` files are allowed in the `.github/arm-leases/` directory
- Must follow the exact folder structure: `<servicename>/<namespace>/lease.yaml`

### 2. Resource Provider Name
- Must match the namespace folder name exactly
- Example: If folder is `Microsoft.TestRP`, then `resource-provider` must be `Microsoft.TestRP`

### 3. Start Date
- Must be in ISO 8601 format: `YYYY-MM-DD`
- Cannot be in the past (must be today or a future date)

### 4. Duration
- Required field that cannot be empty
- Must be in the format: `X days` (e.g., `90 days`, `180 days`)
- **Cannot exceed 180 days** (maximum lease period)
- Must be greater than 0 days

### 5. Reviewer
- Required field that cannot be empty
- Must contain the name of the PM who approved the lease
- Only PMs can be listed as reviewers

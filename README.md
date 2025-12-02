# Lease File Setup Guide

This document explains how to create a **lease file** and organize it in the correct folder structure for the Lease RP service.

## Folder Structure
```
lease/
└── RP/
    └── service/
        └── lease.yaml
```

- **lease/**: Root directory for all lease-related files.
- **RP/**: Resource Provider folder.
- **service/**: Specific service under RP.
- **lease.yaml**: Configuration file for the lease.

## Steps to Create Lease File
1. Navigate to the `lease` directory.
2. Create subfolders for:
   - `RP` (Resource Provider)
   - `service` (specific service name)
3. Inside the `service` folder, create a file named **`lease.yaml`**.

## Example `lease.yaml` Content
```yaml
lease:
  resource-provider: Microsoft.Contoso
  startdate: 2025-12-02        # ISO 8601 format (YYYY-MM-DD)
  duration: 180 days            # Maximum allowed is 180 days
  reviewer: Vikeshi Tiwari
```

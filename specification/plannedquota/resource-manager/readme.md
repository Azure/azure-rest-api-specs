# plannedquota

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.PlannedQuota resource provider.

## Configuration

### Basic Information

```yaml
openapi-type: arm
tag: 2024-06-24-preview
```

### Tag: 2023-08-22-preview

These settings apply only when `--tag=2023-08-22-preview` is specified on the command line.

```yaml $(tag) == '2023-08-22-preview'
input-file:
  - Microsoft.PlannedQuota/preview/2023-08-22-preview/*
```

### Tag: 2023-08-22

These settings apply only when `--tag=2023-08-22` is specified on the command line.

```yaml $(tag) == '2023-08-22'
input-file:
  - Microsoft.PlannedQuota/stable/2023-08-22/*
```

### Tag: 2024-06-24-preview

These settings apply only when `--tag=2024-06-24-preview` is specified on the command line.

```yaml $(tag) == '2024-06-24-preview'
input-file:
  - Microsoft.PlannedQuota/preview/2024-06-24-preview/*
```

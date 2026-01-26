# Nginx

> see https://aka.ms/autorest

This is the AutoRest configuration file for Nginx.

---

## Getting Started

To build the SDK for Nginx, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Nginx API.

``` yaml
title: NginxManagementClient
openapi-type: arm
openapi-subtype: rpaas
tag: package-2025-11-01
```

### Tag: package-2021-05-01-preview

These settings apply only when `--tag=package-2021-05-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2021-05-01-preview'
input-file:
- Nginx.NginxPlus/preview/2021-05-01-preview/swagger.json
```

### Tag: package-2022-08-01

These settings apply only when `--tag=package-2022-08-01` is specified on the command line.

``` yaml $(tag) == 'package-2022-08-01'
input-file:
- Nginx.NginxPlus/stable/2022-08-01/swagger.json
```

### Tag: package-2022-11-01-preview

These settings apply only when `--tag=package-2022-11-01-preview` is specified on the command line.

``` yaml $(tag) == 'package-2022-11-01-preview'
input-file:
- Nginx.NginxPlus/preview/2022-11-01-preview/swagger.json
```

### Tag: package-2023-04-01

These settings apply only when `--tag=package-2023-04-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-04-01'
input-file:
- Nginx.NginxPlus/stable/2023-04-01/swagger.json
```

### Tag: package-2023-09-01

These settings apply only when `--tag=package-2023-09-01` is specified on the command line.

``` yaml $(tag) == 'package-2023-09-01'
input-file:
- Nginx.NginxPlus/stable/2023-09-01/swagger.json
```

### Tag: package-preview-2024-01

These settings apply only when `--tag=package-preview-2024-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-01'
input-file:
  - Nginx.NginxPlus/preview/2024-01-01-preview/swagger.json
```

### Tag: package-preview-2024-06-01

These settings apply only when `--tag=package-preview-2024-06-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-06-01'
input-file:
  - Nginx.NginxPlus/preview/2024-06-01-preview/swagger.json
```

### Tag: package-preview-2024-09-01

These settings apply only when `--tag=package-preview-2024-09-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-09-01'
input-file:
  - Nginx.NginxPlus/preview/2024-09-01-preview/swagger.json
```


### Tag: package-preview-2024-11-01

These settings apply only when `--tag=package-preview-2024-11-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-11-01'
input-file:
  - Nginx.NginxPlus/preview/2024-11-01-preview/swagger.json
```


### Tag: package-preview-2025-03-01

These settings apply only when `--tag=package-preview-2025-03-01` is specified on the command line.

```yaml $(tag) == 'package-preview-2025-03-01'
input-file:
  - Nginx.NginxPlus/preview/2025-03-01-preview/swagger.json
```

### Tag: package-2025-11-01

These settings apply only when `--tag=package-2025-11-01` is specified on the command line.

```yaml $(tag) == 'package-2025-11-01'
input-file:
  - Nginx.NginxPlus/stable/2025-11-01/swagger.json
```
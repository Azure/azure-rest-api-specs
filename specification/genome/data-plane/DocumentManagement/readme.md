# Genome API

> see https://aka.ms/autorest

This is the AutoRest configuration file for Genome API.

## Getting Started

To build the SDK for Genome API, simply [Install AutoRest](https://aka.ms/autorest/install) and in this folder, run:

> `autorest`

To see additional help and options, run:

> `autorest --help`

---

## Configuration

### Basic Information

These are the global settings for the Genome API.

``` yaml
title: GenomeClient
description: Genome API Client
openapi-type: data-plane
tag: package-2025-11-11-preview
```

### Tag: package-2025-11-11-preview

These settings apply only when `--tag=package-2025-11-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-11-11-preview'
input-file:
  - preview/2025-11-11-preview/openapi.json
```

---

## Suppression

``` yaml
directive:
  - suppress: DefinitionsPropertiesNamesCamelCase
    from: openapi.json
    reason: Existing service uses PascalCase for property names
```
# Genome Data Plane API

## Description
This directory contains the TypeSpec and OpenAPI specifications for Genome data plane APIs.

## Services
This directory contains the following data plane services:

- **SupplyChain** - Supply chain management and entity tracking APIs
- **Action** - Action execution and workflow management APIs
- **CaseManagement** - Case and supplier management APIs
- **ConfigurationManagement** - Configuration settings management APIs
- **DataIngestion** - Customer source data upload APIs
- **DocumentManagement** - Document upload and retrieval APIs

## TypeSpec Projects
Each service is defined using TypeSpec in its respective directory:
- `specification/genome/data-plane/Action/`
- `specification/genome/data-plane/CaseManagement/`
- `specification/genome/data-plane/ConfigurationManagement/`
- `specification/genome/data-plane/DataIngestion/`
- `specification/genome/data-plane/DocumentManagement/`
- `specification/genome/data-plane/SupplyChain/`

## Instructions
All services follow TypeSpec naming conventions and structure as per the main repository guidelines.

## API Versions
- **2025-11-11-preview** - Preview version for all services

## AutoRest Configuration

> see https://aka.ms/autorest

``` yaml
openapi-type: data-plane
tag: package-2025-11-preview
```

### Tag: package-2025-11-preview

These settings apply only when `--tag=package-2025-11-preview` is specified on the command line.

``` yaml $(tag) == 'package-2025-11-preview'
input-file:
  - Action/preview/2025-11-11-preview/openapi.json
  - CaseManagement/preview/2025-11-11-preview/openapi.json
  - ConfigurationManagement/preview/2025-11-11-preview/openapi.json
  - DataIngestion/preview/2025-11-11-preview/openapi.json
  - DocumentManagement/preview/2025-11-11-preview/openapi.json
  - SupplyChain/preview/2025-11-11-preview/openapi.json
```

# Service Fabric Migration REST APIs

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Service Fabric migration resource provider.

The migration resource orchestrates the migration of a classic Azure Service Fabric cluster (`Microsoft.ServiceFabric/clusters`) to an Azure Service Fabric managed cluster (`Microsoft.ServiceFabric/managedClusters`).

[Azure Service Fabric](http://aka.ms/ServiceFabric) is a distributed systems platform that makes it easy to package, deploy, and manage scalable and reliable microservices.

---

## Getting Started

To build the SDKs for ServiceFabricMigrationManagementClient, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the ServiceFabricMigrationManagementClient API.

```yaml
title: ServiceFabricMigrationManagementClient
description: Service Fabric Migration Management Client
openapi-type: arm
tag: package-2026-06-preview
```

### Tag: package-2026-06-preview

These settings apply only when `--tag=package-2026-06-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-06-preview'
input-file:
  - preview/2026-06-01-preview/servicefabricmigration.json
```

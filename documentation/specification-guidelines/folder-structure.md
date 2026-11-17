# Table of Contents
- [Overview](#overview)
- [Versions](#versions)
  - [Version 2](#version-2)
  - [Version 1](#version-1)

# Overview
Specifications in this repository must organize their files and folders according to strict guidelines.

On March 23 2026, new specs were required to start with v2.  Root-level suppressions were added for all existing v1 specs in main and RPSaaSMaster [#39549](https://github.com/Azure/azure-rest-api-specs/pull/39549) [#27531](https://github.com/Azure/azure-rest-api-specs-pr/pull/27531).

In June 2025, the guidelines were updated to version 2.  New specs were encouraged to start with v2, and existing specs were encouraged to convert to v2 when convenient.  The [widget](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/widget) sample uses v2.

Prior to June 2025, all specs were using v1.  The [contosowidgetmanager](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/contosowidgetmanager) sample uses v1.

# Versions

## Version 2
Release Date: June 2025

### Spec
[Azure Service Versioning](./azure-service-versioning-guide.md)
[Folder Structure Guideline](https://aka.ms/azsdk/spec-dirs)

### Sample
https://github.com/Azure/azure-rest-api-specs/tree/main/specification/widget

### Documentation changes

When migrating an existing service that has documentation on learn.microsoft.com to Folder Structure v2, `readme.md` files used for docs may be affected. If the location of such `readme.md` files do change, visit https://aka.ms/publish-on-docs/reference and click the **Onboard reference content** link. In the issue, note that the location of the `readme.md` file has changed and onboarding information may need to be updated.

## Version 1

### Sample
https://github.com/Azure/azure-rest-api-specs/tree/main/specification/contosowidgetmanager

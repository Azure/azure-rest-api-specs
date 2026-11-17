# Table of Contents
- [Overview](#overview)
- [Fixing Errors](#fixing-errors)
- [Running Locally](#running-locally)
- [Known Issues](#known-issues)
  - [MULTIPLE_API_VERSION](#multiple_api_version)
- [Future Plans](#future-plans)

# Overview
Check "Swagger Avocado" is a thin wrapper around package `@azure/avocado`, which is hosted in its own repo and published to npmjs.

Repo: https://github.com/Azure/avocado

Package: https://www.npmjs.com/package/@azure/avocado

# Fixing Errors
https://github.com/Azure/avocado?tab=readme-ov-file#how-to-solve-errors

# Running Locally
Complete the Node.js and pnpm setup in [Contributing](../contributing/toolchain-setup.md) first, then change to the repository root and run:

```sh
$ cd azure-rest-api-specs
$ pnpm ci
$ pnpm avocado --excludePaths common-types -d specification/contosowidgetmanager
```

# Known Issues
Workaround is for PR reviewer to apply label `Approved-Avocado` until tool issues are fixed.

1. [Allow specs with readme.md in sub-folders under resource-manager](https://github.com/Azure/azure-rest-api-specs/issues/32445)
2. [[MISSING_APIS_IN_DEFAULT_TAG] False positive on deprecated APIs](https://github.com/Azure/avocado/issues/150)

## MULTIPLE_API_VERSION
Rule [MULTIPLE_API_VERSION](https://github.com/Azure/avocado?tab=readme-ov-file#multiple_api_version) was changed from a warning to an error on 7/1/2025. As this issue is a blocker to TypeSpec conversion which is an Azure wide effort to drive the API first design pattern among all Azure services.

If your PR is blocked due to this error, please check out this [Uniform Versioning Violation Guide](./uniform-versioning-violation-guide.md) on how to resolve this.

Please check with azversioning@service.microsoft.com to see if your service can have one-time suppression if you are not sure.

# Future Plans
* Move code for check and package to specs repo (https://github.com/Azure/azure-rest-api-specs/issues/32398)

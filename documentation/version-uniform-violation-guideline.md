
# Version Uniform Violation Guidelines

This document provides guidance for service teams on how to handle version uniform violations.

## What is a Version Uniform Violation?

A version uniform violation occurs when a service's `readme.md` file contains multiple API versions of Swagger files within its default tag. This violates the [uniform versioning principle](./uniform-versioning.md), which requires that all components of a service version uniformly.

### Example of a Version Uniform Violation

Below is an example from the Compute service where the default tag `package-2025-03-01` contains five different Swagger files with five different API versions:

~~~
```yaml
title: ComputeManagementClient
description: Compute Client
openapi-type: arm
tag: package-2025-03-01
``` 
...

### Tag: package-2025-03-01

These settings apply only when `--tag=package-2025-03-01` is specified on the command line.

``` yaml $(tag) == 'package-2025-03-01'
input-file:
  - Microsoft.Compute/ComputeRP/stable/2024-11-01/ComputeRP.json
  - Microsoft.Compute/DiskRP/stable/2025-01-02/DiskRP.json
  - Microsoft.Compute/Skus/stable/2021-07-01/skus.json
  - Microsoft.Compute/GalleryRP/stable/2024-03-03/GalleryRP.json
  - Microsoft.Compute/CloudserviceRP/stable/2024-11-04/cloudService.json
```
~~~


## How to Resolve Version Uniform Violations

To completely resolve this violation, you have two options:

### Option 1: Maintain Single Service Pattern

Stay within the existing single service pattern but ensure uniform versioning for all resource types going forward. This approach requires:

- All resource types within the service must adopt the same API version for each release
- Future API versions must include all resource types with consistent versioning
- Coordinate releases across all resource types within the service

**Pros:** 
- Simpler organizational structure
- Single SDK package for all resource types

**Cons:** 
- Requires coordination across potentially different teams
- All resource types must release together

### Option 2: Split into Multiple Independent Services

Split the service into multiple independent services, allowing each service to have its own versioning lifecycle. All resource types within each new service must still version uniformly.

This approach provides service teams with more flexibility to control their own lifecycle, especially beneficial for large teams managing different resource types.

#### Recommended Folder Structure for Option 2

```
specification/
└── <orgName1>/	ß NOTE: Today this has no clear definition (Org name? Service name?)
    ├── cspell.yaml
    └── resource-manager/
        ├── readme.md			ß NOTE: For ARM schema validation; see bullet #2 below
        └── <RPNamespace>/		ß NOTE: Control-plane only (not data-plane) 
            └── <ServiceName1>/	ß CX-facing service name; each version gets Docs & SDK package
                ├── tspconfig.yaml	ß TypeSpec files go here (examples below)
                ├── main.tsp
                ├── models.tsp
                ├── readme.md		ß autorest readme with YAML blocks
                └── examples/		ß TypeSpec example folder
                    └── <api-version>/	ß One folder per service version described in TypeSpec
                        └── <example .json files> 
                └── preview/ and stable/
                    └── <api-version>/	ß One folder per service version described in Swagger
                        ├── <swagger .json files>
                        └── examples/	ß Swagger example folder
                            └── <example .json files>
            └── <ServiceName2>/	// CX-facing service name; contents identical to above structure
    └── data-plane/
        └── <ServiceName3>/	// CX-facing service name; contents identical to above structure

```
**Pros:**
- Independent versioning for each service
- Better team autonomy
- Faster release cycles for individual services

**Cons:**
- More complex organizational structure
- Multiple SDK packages
- Requires restructuring existing specifications

## CI Validation 

We have enabled a Swagger-Avocado error check [`MULTIPLE_API_VERSION`](https://github.com/azure/avocado?tab=readme-ov-file#multiple_api_version) in the specification PR CI pipeline. This check prevents new specifications from introducing version uniform violations early in the development process.

## How to Suppress Version Uniform Violations

⚠️ **Important:** We strongly encourage you to contact us as soon as possible when you encounter this error in your PR to avoid being blocked in the subsequent SDK release process.

We understand that some services may have historical version uniform issues that require significant effort to resolve. We provide both one-time and permanent suppression options to unblock PRs while working toward resolution.

### One-Time Suppression

You can add the `Approved-Avocado` label to your PR to bypass this check, but this is only allowed if:
- There is an ongoing discussion about resolving the version uniform issue within your service
- You have a clear plan and timeline for resolution

**If you are unaware of any ongoing discussions about this issue, please reach out to us immediately!**

### Permanent Suppression

You can add the following suppression to your `readme.md` file to permanently suppress this error, but only if your team has provided a clear ETA and resolution plan:

```yaml
# Add this suppression block to your readme.md
suppression:
  - rule: MULTIPLE_API_VERSION
    reason: <Brief explanation of why suppression is needed>
    # Include ETA and resolution plan in the reason
```

**Note:** If discussions are ongoing and no clear actions have been taken by your team, please use the one-time suppression approach instead.

## SDK Release Impact

⚠️ **Important:**  We will block all language SDK releases for services that do not take action to resolve version uniform violations. 

## ETA Follow-up

We will reach out to service teams that have provided an ETA but have taken no action when the deadline is reached. Regular follow-ups ensure:

- Accountability for resolution commitments
- Timely resolution of version uniform issues
- Continuous improvement in API specification quality

## Getting Help

For assistance or guidance on the EngSys tooling, please contact:
- @mikeharder

For assistance or guidance on resolving version uniform violations, please contact:
- @qiaozha
- @JeffreyRichter

For assistance or guidance on the SDK release, please contact:
- @josefree

You can also:
- Create an issue in the [azure-rest-api-specs repository](https://github.com/Azure/azure-rest-api-specs/issues)
- Reach out via Teams or email for urgent matters
- Review the [uniform versioning documentation](./uniform-versioning.md) for detailed guidelines

## Related Documentation

- [Uniform Versioning Guidelines](./uniform-versioning.md)

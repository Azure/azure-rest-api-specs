# Azure REST API Specifications

## Description

This repository is the canonical source for REST API specifications for Microsoft Azure.

## Getting started
If you're a Microsoft employee looking for information about all of the repositories and steps in the pipeline, go to our [documentation](https://github.com/Azure/adx-documentation-pr/wiki) repository. Make sure to [join the Github Azure organization](http://aka.ms/azuregithub) to get access to that repo. 

<b>Latest improvement:</b><i> Microsoft employees can try out our new experience at [OpenAPI Hub](https://aka.ms/openapihub) - online experience for using our validation tools and finding your workflow.</i>

External Contributors can get started [here](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/Getting%20started%20with%20OpenAPI%20specifications.md)

Please check the [announcements page](https://github.com/Azure/azure-rest-api-specs/wiki/Announcements) for any new updates since your last visit.

## Directory Structure

The structure of the directory should strictly follow these rules:

1. **Profile**: The profile holder contains the profiles' definition MD files. these files will contain information and references to the snapshots of the RPs' Resource types or Dataplane API versions that represent a specific profile.

1. **Specification**: This folder is the root folder for all Specs (Management and Dataplane) related docs.

1. **{RP-Name} Folders** - each RP will have a separate folder

1. **'resource-manager' and 'data-plane' Folders**: the RPs can put specs in one of two categories: `resource-manager` (for ARM resources) and `data-plane` (for everything else) . The autorest configuration file (`readme.md`) for the RP should be inside this folder

1. **'preview' and 'stable' Folders**: Varying levels of stability exist in our repository. Each API Version folder should be categorized as either still accepting breaking changes, or no longer accepting breaking changes. This is not a direct analog for whether or not an API Version has the "-preview" suffix or not. SDKs that are generated from 'preview' folder items should indicate to their customers in the most idiomatic way that breaking changes may still be coming.

1. **API versions**: this folder will be the direct child of the category folder. there will be one such folder per resource type or dataplane service version. This folder will contain the OpenAPI validation Specs (Swaggers previously) and the examples folder.

1. **Examples**: the example folder will contain the x-ms-examples files. it will reside under the APIs or Resources' version folders as different APIs or Resource types version can have different examples.

1. **Notes**:
    - folder names should be singular (ie, 'profile' not 'profiles' ) -- this removes ambiguity for some non-english speakers.
    - generic folder names should be lower-case
    - proper-name/product name/namespace folders can be PascalCased (ie, "KeyVault")
    - files are whatever case you think is good for your soul.


The structure should appear like so:
```bash
.
\---specification
|    +---automation
|    |   \---resource-manager
|    |       \---Microsoft.Automation
|    |           \---stable
|    |               \---2015-10-31
|    |                   \---examples
|    +---batch
|    |   +---data-plane
|    |   |   \---Microsoft.Batch
|    |   |       +---stable
|    |   |       |   +---2015-12-01.2.2
|    |   |       |   +---2016-02-01.3.0
|    |   |       |   +---2016-07-01.3.1
|    |   |       |   +---2017-01-01.4.0
|    |   |       |       \---examples
|    |   |       \---preview
|    |   |           \---2017-05-01.5.0
|    |   \---resource-manager
|    |       \---Microsoft.Batch
|    |           +---stable
|    |           |   +---2015-12-01
|    |           |   +---2017-01-01
|    |           |       \---examples
|    |           \---2017-05-01
|    |               \---examples
|    +---billing
|        \---resource-manager
|            \---Microsoft.Billing
|                \---stable
|                |   +---2017-02-27-preview
|                |       \---examples
|                +---preview
|                    \---2017-04-24-preview
|                        \---examples
\--- readme.md
```

Currently, the specifications are expected to be in Swagger JSON format

## Next steps
The next step in the process after a spec is completed is to generate SDKs and API reference documentation. Go to the [Azure Developer Experience guide](https://github.com/Azure/adx-documentation-pr) for more information.

---
_This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments._

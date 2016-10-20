[![Repo Status](http://img.shields.io/travis/Azure/azure-rest-api-specs/master.svg?style=flat-square&label=repo-status)](https://travis-ci.org/Azure/azure-rest-api-specs)

# Azure REST API Specifications

## Description

This repository is the canonical source for REST API specifications for Microsoft Azure.

## Basics
In the Azure Developer Experience workflow, you are at Step 3:

[API Design Review](https://github.com/Azure/adx-documentation-pr#begin-api-design-review) -> [Engage with ADX team](https://github.com/Azure/adx-documentation-pr/blob/master/README.md#engage-with-adx-team) -> _**[Swagger specification](https://github.com/Azure/adx-documentation-pr#create-swagger-specification)**_ -> [SDKs](https://github.com/Azure/adx-documentation-pr#sdks) -> [CLIs](https://github.com/Azure/adx-documentation-pr#clis)

If you're a spec author looking for information about all of of the repositories and steps in the pipeline, go back to the [adx-documentation-pr](https://github.com/Azure/adx-documentation-pr) repository. Make sure to [join the Github Azure organization](http://aka.ms/azuregithub) to get access to that repo.

## Getting started
- Our [Contribution guidelines](./.github/CONTRIBUTING.md) walks you through the process of contributing to this repository.
- The [/documentation](./documentation/) folder contains reference documentation for all aspects of Swagger and our recommended patterns. Start with the [Creating Swagger](./documentation/creating-swagger.md) page.
- If you are using **Swashbuckle** to generate a swagger spec from your .NET WEB API then please take a look at this [repo]( https://github.com/Azure/swashbuckle-resource-provider).

## Directory Structure

The structure of the directory should strictly follow these rules:
- The top level folder must be the service name
- The second level must be the API versions
- The third level must be the format of the specification
- The fourth level must be the specifications

The structure should appear like so:
```bash
.
├── arm-authorization
│   └── 2015-01-01
│       └── swagger
│           └── authorization.json
├── arm-compute
│   └── 2015-06-15
│       └── swagger
│           └── service.json
├── arm-features
│   └── 2014-08-01-preview
│       └── swagger
│           └── features.json
├── arm-network
│   └── 2015-05-01-preview
│       └── swagger
│           └── service.json
├── arm-resources
│   └── 2014-04-01-preview
│       └── swagger
│           └── service.json
├── arm-storage
│   └── 2015-05-01-preview
│       └── swagger
│           └── service.json
├── arm-subscriptions
│   └── 2014-04-01-preview
│       └── swagger
│           └── service.json
├── arm-web
├── documentation
└── readme.md
```

Currently, the specifications are expected to be in Swagger JSON format

## Next steps
The next step in the process after a spec is completed is to generate SDKs. Go to the [SDKs section](https://github.com/Azure/adx-documentation-pr#sdks) of the Azure Developer Experience guide for more information.

---
_This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments._
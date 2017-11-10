[![Repo Status](http://img.shields.io/travis/Azure/azure-rest-api-specs/master.svg?style=flat-square&label=repo-status)](https://travis-ci.org/Azure/azure-rest-api-specs)

# Azure REST API Specifications

## Description

This repository is the canonical source for REST API specifications for Microsoft Azure.

## Basics
If you're a spec author looking for information about all of of the repositories and steps in the pipeline, go to the [adx-documentation-pr](https://github.com/Azure/adx-documentation-pr) repository. Make sure to [join the Github Azure organization](http://aka.ms/azuregithub) to get access to that repo.

## Getting started
- Our [Contribution guidelines](./.github/CONTRIBUTING.md) walks you through the process of contributing to this repository.
- The [/documentation](./documentation/) folder contains reference documentation for all aspects of Swagger and our recommended patterns. Start with the [Creating Swagger](./documentation/creating-swagger.md) page.

## Directory Structure

The structure of the directory should strictly follow these rules:
- If the Rest end point is for management plane(going through ARM end point) then the top level folder must be the "arm-<service_name>". Else top folder name must be "<service_name>".
- The second level must be the API versions
- The third level must be the format of the specification (ex. swagger)
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

## New Directory structure (effective July 10th 2017)

Re-organization is being done to support upcoming profiles work and Data Plane swagger specs. The new structure will appear like below
 
```bash
.

Specification
└──
   ├──automation
   |   └── resource-manager
   |       └── Microsoft.Automation
   |           └── 2015-10-31
   |               └── examples
   ├──batch
   |   └── data-plane
   |   |   └── Microsoft.Batch
   |   |       └── 2015-12-01.2.2
   |   |       └── 2016-02-01.3.0
   |   |       └── 2016-07-01.3.1
   |   |       └── 2017-01-01.4.0
   |   |       |   └── examples
   |   |       └── 2017-05-01.5.0
   |   └── resource-manager
   |       └── Microsoft.Batch
   |           └──2015-12-01
   |           └──2017-01-01
   |           |   └──examples
   |           └──2017-05-01
   |               └──examples
   └── billing
   |   └── resource-manager
   |       └── Microsoft.Billing
   |           └── 2017-02-27-preview
   |           |   └── examples
   |           └── 2017-04-24-preview
   |               └── examples
   └── readme.md
```
### Changing the representation of composite swagger metadata

Currently composite swagger metadata is captured in a .json file. The problem with the current representation is that it does not provide a way to track what versions of swagger specs were used in earlier releases. With the upcoming changes, we will be able to keep track of multiple versions of composition. The metadata will be captured in readme.md file under resource-manager folder. There won’t be a need for .json file. New structure in readme.md file looks like below. 
Tag: package-2017-03
These settings apply only when --tag=package-2017-03 is specified on the command line.
input-file:
- Microsoft.Compute/2017-03-30/compute.json
- Microsoft.Compute/2017-03-30/disk.json
- Microsoft.Compute/2017-03-30/runCommands.json
- Microsoft.ContainerService/2017-01-31/containerService.json

Please take a look at this [readme.md](https://github.com/Azure/azure-rest-api-specs/tree/reorg/specification/compute/resource-manager) (Acessible by Azure github org members only) to understand how the complete structure looks like.


## Specs Format
Currently, the specifications are expected to be in Swagger JSON format

## Next steps
The next step in the process after a spec is completed is to generate SDKs and API reference documentation. Go to the [Azure Developer Experience guide](https://github.com/Azure/adx-documentation-pr) for more information.

---
_This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments._

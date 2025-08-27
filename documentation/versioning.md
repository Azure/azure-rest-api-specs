# Azure Service Versioning Guide

This document defines what an Azure service is, the rules that govern the service’s versioning, and all the benefits that flow from this.  
The end of this document describes the problems that arise from Azure services that do not follow the service versioning rules and why they must now adopt these rules to greatly improve the Azure customer experience as well as the Azure engineering experience.  
For questions related to Azure Service Versioning, contact azversioning@service.microsoft.com  

## What Is an Azure Service?

An Azure service is a set of operations that version uniformly (in perpetuity).  
- A customer client app is expected to use only one version of a service at any given point in time.  
- This means that any public or private preview service version must be a superset of that last GA service version (unless a preview version introduces a breaking change).  
- Services can version & be retired independently from each other. This allows services to be agile and removes coordination between sub-teams.  
- Customers consciously select and target specific service versions.
    - This is important for the public cloud customers as all datacenters may not have the same service versions deployed. 
    - It is also important for Azure Stack, government cloud, and other air-gapped/non-public cloud customers which also may not have the same service versions deployed.  

## An Azure Resource Provider and its 1+ Azure Services

A single Azure Resource Provider (RP) has an RP namespace. This RP namespace can contain 1+ control-plane services and 0+ data-plane service; each service versions as described above. Today, we want the GitHub specs repo to be structured as follows for control-plane & data-plane contracts:
```
specification/
└── <orgName1>/
    ├── cspell.yaml
    └── resource-manager/
        ├── readme.md			ß NOTE: For ARM schema validation; see bullet #2 below
        └── <RPNamespace>/		ß NOTE: Control-plane only (not data-plane) 
            └── <ServiceName1>/	ß Customer-facing service name; each version gets Documentation & SDK package
                ├── tspconfig.yaml	ß TypeSpec files
                ├── main.tsp
                ├── models.tsp
                ├── readme.md		ß autorest readme with YAML blocks
                └── examples/		ß TypeSpec example folder
                    └── <api-version>/	ß One folder per service version described in TypeSpec
                        └── <example .json files> 
                └── preview/ and stable/
                    └── <api-version>/	ß One folder per service version described in OpenAPI. These folders are created and populated by compiling the TypeSpec folder for the service.
                        ├── <OpenAPI .json files>
                        └── examples/	ß OpenAPI example folder
                            └── <example .json files>
            └── <ServiceName2>/	// Customer-facing service name; contents identical to above structure
    └── data-plane/
        └── <ServiceName3>/	// Customer-facing service name; contents identical to above structure
```
In this structure, Azure services are presented as an RPNamespace that is used to manage services (both with customer-facing names). Each service has versions (some preview and some GA) and each version has its own API contract, documentation, and (beta/stable) SDK package(s).   

To enforce these rules, here are some notes about the repo structure:

1.	In the resource-manager folder, if it's a RPaaS service, there must be just 1 readme.md file, and 1+ service name folders under resource-manager/RPnamespace folder, but the resource types within each service folder must not duplicate except for operations, locations, checkNameAvailability etc. Which is required by RPaaS for HTTP request schema validation.
2.	In the data-plane folder there must be no files and at least 1 service name folder.
3.	The ServiceName folder must have only readme.*, tspconfig.yaml and *.tsp files in it. 
    - In the readme.md file, the latest package tag value (which represents a service version) must refer to OpenAPI files that are all in the exact same folder. Also, if the tag value is suffixed with “-preview” then all the OpenAPI paths must refer to files in the preview subfolder; else all OpenAPI paths must refer to files in the stable subfolder.
    - If 2+ services want to “share” some TypeSpec/OpenAPI files, these files must be explicitly copied into a consuming service’s folder on its desired timeline. We do not allow multiple services to reference a single copy of a service contract because it is too dangerous to allow one service to change a shared contract, forcing other services to pick up this shared contract instantly, especially if the shared contract introduces breaking changes. Each service must be in control of its own destiny.
4.	The ServiceName folder must have examples, preview and stable subfolders. Additional subfolders are allowed to help organize *.tsp files. The rules should ensure that only the tspconfig.yaml  and *.tsp files are in the ServiceName folder.  
5.	The examples folder should only have a subfolder for each api-version and each api-version folder can contain only example *.json files for this api-version.
6.	The preview and stable folders must only have subfolders whose name match this format: YYYY-MM-DD-preview in the preview folder and YYYY-MM-DD in the stable folder. All the files in the YYYY-MM-DD(-preview) folders must be json (OpenAPI) files.
7.	Each YYYY-MM-DD(-preview) folder must have an examples folder containing only example *.json files for this api-version.
8.	It is illegal for a preview and GA version to share the same date. For example, if there is a 2024-04-01-preview, then there can never be a 2024-04-01 GA.
9. Each new control plane api-version should be unique across all the control plane service folders for an RP Namespace. 
10.	Each service name folder must duplicate the special "list operations" API. 
    - While this RP (not service) operation requires an api-version query parameter, the response data is not specific to this api-version; the response is api-version neutral. In addition, the response is always the same regardless of tenant/subscription. Whenever any other service in the RP gets a new api-version, the TypeSpec/OpenAPI for the operations service must also be updated to match this new api-version.

## POSITIVE CONSEQUENCES OF THE AZURE SERVICE DEFINITION

From the above definition, many processes and assets naturally flow, providing both Azure engineering teams and customers with great experiences:
- Each service version is documented separately allowing a customer to reference the specific version of the service they are targeting.
- Each service version gets its own SDK package version allowing a customer to import the SDK package version corresponding to the service version they wish to target.
    - GA versions of a service get a stable SDK package and preview versions of a service get a beta SDK package. Each SDK package version must clearly document which service version it targets .
    - When any preview or GA version of a service is retired, the corresponding SDK package version is deprecated (without affecting any other SDK packages). Note that Azure retires preview service versions regularly; GA service versions are retired when breaking changes are introduced or on other rare occasions. See [Azure SDK lifecycle and support policy](https://azure.github.io/azure-sdk/policies_support.html#azure-sdk-lifecycle-and-support-policy).
    - When a service is retired in its entirety, all SDK packages for this service are deprecated (without affecting any other services’ SDK packages).
    - A service version introducing a breaking change will likely break that service’s SDK package in the next version causing the new SDK package version to increment its major number as per semantic versioning. This also causes old preview and GA service versions and their corresponding SDK package versions to be retired/deprecated.
- The above service and SDK package versioning rules simplify the usage and ongoing maintenance of downstream consumers such as the Azure Portal, Azure CLI/PowerShell, Azure Developer CLI, ARM templates, Bicep, 3rd party libraries that wrap our Azure REST APIs and SDK packages (such as Terraform/Pulumi), etc.  

The following diagram summarizes how Azure internal teams and customers should think about Azure service abstractions and their relationship to each other. 
- The RP namespace identifies the Resource Provider that customers must use to manage some Azure resource(s). The namespace itself has no code and therefore never versions. 
- Within an RP namespace is 1+ control plane services and 0+ data-plane services which version uniformly over time. 
    - Private preview versions don’t have corresponding SDK package versions
    - Public preview versions do have corresponding beta SDK package versions
    - GA versions do have corresponding stable SDK package versions. Beta SDK package versions may also exist if the SDK package has rich functionality requiring customer testing/feedback before releasing the stable SDK package version.
 
<img width="600" height="400" alt="image" src="https://github.com/user-attachments/assets/7b079665-2328-4524-8784-476e52e57343" />

 
 
## What If Your Azure Team Currently Violates the Above Rules?

In the past, Azure never had a clear/formal definition for an Azure Service. Therefore, some teams have unconsciously violated the rules above adopting different patterns causing pain for other Azure teams and their customers. The main problem is that some teams version parts of their service independently of other parts. This causes many problems:
- To complete a customer solution, the customer is required to use multiple versions simultaneously.
    - For any given operation, the customer must know what version(s) are supported and choose a version. This increases the cognitive burden on customers significantly.
    - When a new version of some operations ship, a customer trying to adopt the new version must review and modify every operation in their code to see if it is impacted. 
        - NOTE: Any new operations adopting a breaking change force customers to adopt the new version – they have no choice.
- Today, some SDK packages combine GA and preview operations in a single SDK package calling the package GA. 
    - This makes customers think that all operations supported by the SDK package are GA quality when, in fact, this is not true – we should not misrepresent ourselves to customers like this. The teams doing this must fix their service versioning and SDK package versioning to get out of this state.
- Today, some SDK packages are monolithic combining operations from multiple independently-versioning services together (for example, combining their control-plane service and data-plane service). This prevents a customer from selecting a specific version of one service and a specific version of the other service. 
    - A customer importing a new SDK package version must update their code for all services combined in the new monolithic SDK package; the customer can’t decide on their own schedule which service they want to upgrade.
        - A customer may take a new SDK package version to leverage a new feature in a new service version, but this new SDK package version may also include a breaking change to another service forcing the customer to update their code now for all services combined in that one SDK package version.
    - Customers have trouble targeting any cloud (public, Azure Stack, government, air-gapped/private) where some (but not all) of the services’ operation versions may not yet be deployed.
    - Retiring a service in its entirety breaks just the next new SDK package version when we should just be deprecating all versions of the SDK package for that one retiring service.
- Today, some SDK packages combine multiple versions of the same service into a single package and customers complain about the sheer size of the SDK package. Here’s an example.
- Today, the Azure Engineering Systems team has github repo tooling with heuristics that attempt to decipher a service team’s intentions with regards to versioning, breaking change detection, SDK packaging, etc. In the past, our repo structure didn’t force teams to adhere to the service versioning rules. The various teams (ARM, API Stewardship, Breaking Change, and EngSys) have worked together to define a new repo structure. Not only does this force service teams to adhere to the versioning rules but it allows the EngSys team to remove their error-prone heuristic code and have their tools produce better, predictable results.  

The bottom line is that all operations within a service must version uniformly and each service version must have a 1:1 relationship to its API contract (TypeSpec/OpenAPI), customer docs, SDK packages (and other apps/packages that depend on them [Azure CLI/PowerShell, Terraform Modules, etc.]), and the lifecycle of these things (as described earlier in this document). Customers MUST be able to mix and match service versions as they see fit as services evolve by introducing/retiring preview versions as well as GA/broken versions. A customer using one service should NOT be impacted by another service. Combining multiple services and/or service versions in a single SDK package version complicates this for Azure engineering and customers causing all the problems I mention in this section.  

## Splitting a Monolithic SDK Package into Service-Specific Packages

For service teams violating the above service versioning rules, their current monolithic SDK package must be split into separate service-specific SDK packages. The good news is that this 1-time break for customers is fairly simple for them.  

First, a customer can continue to use the SDK package they’re using today but this SDK package may never version ever again (more about this later).   

When a service introduces a new version, that service will now get its own/new SDK package that hereafter versions 1:1 with the service itself. A customer that wants to leverage the new service version will have to import a new SDK package that they never imported before. However, all the structures, classes, & methods in this new package are identical to what they were called in the old monolithic package. Depending on the language, some customers may just have to import a new namespace or rename a package name in their code; the code that actually references the structures, classes, & methods requires no change.  

The last service to split-off from the monolithic SDK package may either get its own/new SDK package and name (as described in the previous paragraph) or it may stay in a new version of the original SDK package (same name as before). But, in this new package version, everything related to the already split-out services no longer exists. This latter scenario reduces some customer pain, but the name of the package may not accurately reflect the name of the remaining service. We’ll have to decide on the package name on a case-by-case basis.  

The Azure Breaking Change and Azure SDK Architecture Boards are aware of this scenario and have agreed to approve these 1-time breaks related to splitting a monolithic SDK package into multiple service-specific packages so that engineering and customers can get on a long-term sustainable future. The Azure API Stewardship and ARM review Boards are also aware of this.  

Currently, several Azure service teams have already decided to split their monolithic SDK package into service specific SDK packages: Compute, Monitor, Container Registry, Observability, AI Language, AI Speech, and more.  


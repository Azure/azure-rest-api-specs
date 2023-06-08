# Azure Rest API, SDK development process with TypeSpec

## Table Of Content
1. Introduction
2. Repo setup & Pre-requisits
3. Setting up
4. 

### Introduction

This document describes the processes of developing Azure Rest APIs and SDKs with TypeSpec language. The steps below assumes that you are developing TypeSpec API specifications in the `azure-rest-api-specs` repos. 

If you are developing within your own ADO repo first and then submitting into `azure-rest-api-specs` repos for review and release, you can either manually copy those files over OR leverage `API First (aka: Shift-left)` pipelines to simplify the process. Please contact Azure SDK team for additional details.

### Repo setup & Pre-requisits

- The main repos for Azure rest-api are [azure-rest-api-specs](https://github.com/azure/azure-rest-api-specs) and [azure-rest-api-specs-pr](https://github.com/azure/azure-rest-api-specs-pr) repos. The `-pr` repo contains `RPSaaSMaster` and `RPSaaSDev` branches for ProviderHub based ARM service specs.

	For general information on Azure SDK team and other detailed information, please visit our team's [internal wiki page](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/10/Welcome-Service-Partners!).

- You would also need to install Node.js 16 LTS and ensure you are able to run the npm command in a command prompt:
```
	npm --version
```
	
	It is recommended to have npm 7+. To update npm run:

```
	npm install -g npm.
```
- Run following command in the repo root. This should install required packages such as TypeSpec compilers and Azure Library packages.
```
   npm install
```
- You should then be able to run TypeSpec compiler within the repo folders.
```
   tsp --version 
```

- We recommend you install TypeSpec VisualStudio or VSCode extensions to get syntex highlighting, tool tips in IDE:
```
  tsp code install
``` 
OR
```
  tsp vs install
```

### TypeSpec project setup

Please first review recommended folder structure detailed in [this document](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/typespec-structure-guidelines.md).

1. Create your service(RP) folders directly under `specifications` if doesn't exist
2. Create your service component folder under the RP folder. For example, `Sphere.Management` or `Azure.OpenAI`.
3. Change into the newly created folder and run following command and go thru the wizard to a new project with sample TypeSpecs.
```
   tsp init https://aka.ms/typespec/azure-init
```
4. You can now compile the TypeSpec project with following command. The generated swagger files would be correctly placed in `data-plane` or `resource-manager` folders follwoing the naming conventions.
```
   tsp compile .
```
5. Next step is to replace the sample TypeSpec with your own TypeSpec code. When the project is ready, you can submit a PR on the changes in service folder.


### Generate SDKs (First-time & subsequent update)

The section discribe the process for data-plane SDKs. Management-plane SDKs still follow the `autorest` process.

#### With your local cloned language SDK repos
This assumes you have cloned language SDKs into your local folder. The script you will be calling is located in the `rest-api-specs` repository's `./eng/script/TypeSpec-Generate-Sdk.ps1` file. This script will generate the necessary SDK folder and project structure if it does not already exist, and then regenerate the SDK source code.

Scenarios:
- You just want to test generate SDK project and code based on the local TypeSpec changes in your `rest-api-specs` repo. Please note this cannot be used to submit a SDK PR as it does not contain a valid commit id.
```
   cd specifications/contoso/contoso.widgetmanager
   ..\..\..\eng\script\TypeSpec-Generate-Sdk.ps1 -SdkRepoRootDirectory C:\Github\fork\azure-sdk-for-java\
```

- You are generate/refresh SDK code for submitting a PR. The following command will update tsp-location.yaml with commit id and repo info so the build can be generated and verified by the CI and release pipeline.
```
   cd specifications/contoso/contoso.widgetmanager
   ..\..\..\eng\script\TypeSpec-Generate-Sdk.ps1 -SdkRepoRootDirectory C:\Github\fork\azure-sdk-for-java\ [commit id] Azure/azure-rest-api-specs
```
 
#### With Docker container

We provide a docker container that contains all language toolsets, which can be used to generate code, run mock test. This docker image can be used for local development, and running in pipeline. We also included additional helper scripts to help easily generate/update SDK code for all languages at once.

The following command starts the docker container in interactive mode.
```

```




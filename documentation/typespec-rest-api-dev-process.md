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

- You should also install TypeSpec VisualStudio or VSCode extensions:
```
  tsp code install
  tsp vs install
```

### First-time setup

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

### Continue developing REST API with TypeSpec


### Submitting PRs


### Generate SDKs (First-time & subsequent update)

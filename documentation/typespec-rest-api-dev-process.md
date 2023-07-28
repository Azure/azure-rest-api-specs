# Azure Rest API, SDK development process with TypeSpec

## Table Of Content

1. Introduction
2. Repo setup & prerequisites
3. Setting up
4. Generate or Refresh SDK code from a TypeSpec project

### 1. Introduction

This document describes the processes of developing Azure Rest APIs and SDKs with TypeSpec language. The steps below assumes that you are developing TypeSpec API specifications in the `azure-rest-api-specs` and `azure-rest-api-specs-pr`repos.

If you are developing within your own ADO repo first and then submitting into `azure-rest-api-specs` repos for review and release, you will need to copy the TypeSpec files over.

### 2. Repo setup & prerequisites

- The main repos for Azure rest-api are [azure-rest-api-specs](https://github.com/azure/azure-rest-api-specs) and [azure-rest-api-specs-pr](https://github.com/azure/azure-rest-api-specs-pr) repos. The `-pr` repo contains `RPSaaSMaster` and `RPSaaSDev` branches for ProviderHub based ARM service specs.

#### 2.1 With local machine development

- [Node.js LTS](https://nodejs.org/en) version 16 or above. Ensure you can run the npm command in a command prompt:
```
  npm --version
```

- Run following command in the **repository root folder**. This will install required packages such as TypeSpec compilers and Azure Library packages.

```
   npm install
```

- Ensure you can run TypeSpec command within the repo folders.

```
   npx tsp --version 
```

- One-time set up: Install TypeSpec VisualStudio or VSCode extensions to get syntex highlighting, tool tips in IDE:
  
```
  npx tsp code install
``` 
OR
```
  npx tsp vs install
```

#### 2.2  VSCode with local docker .devcontainer

All prerequisites have been installed in the dev container. You should to have `Docker Desktop` and `WSL2` running if you are on Windows machine.

To start, you just need to install `Dev Containers` VS code extension, then open the repo path. 

- VSCode will detect the .devcontainer and prompt you to reopen the workspace.

- Alternatively, you can use Command Palette -> Dev Containers: Reopen in Container.
  
Once VSCode reopened in Container, you can run any of the program below in the VSCode integrated terminal.

#### 2.2 VSCode in browser via github codespaces

Github codespaces leverage the same dev container in the repo. The difference is it is hosted in cloud with VSCode in browser. 

To start, you just need to browse to the `azure-rest-api-specs` repo, select `<> Code` drop down and follow `Codespaces` instructions. 


### 3. Creating a new TypeSpec project

Please first review recommended folder structure detailed in [this document](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/typespec-structure-guidelines.md).

1. Under `[reporoot]\specifications`, create service folder directly.
2. Create your service component folder under the service folder. For example, `Sphere.Management` or `Azure.OpenAI`.
3. Create a new TypeSpec project based on Azure template with command:

```cli
   npx tsp init https://aka.ms/typespec/azure-init
```
4. Select `(rest-api-spec repo) ARM` or `(rest-api-spec repo) Data-plane` and answer appropriate naming questions.
5. Compile the generated TypeSpec project with command:

```cli
  npx tsp compile .
```
  The generated swagger files should be correctly placed in `data-plane` or `resource-manager` folders follwoing the naming conventions.

5. Now the project has been set up. You can modify the sample and develop your own APIs with TypeSpec


### 4. Generate or Refresh SDK code from a TypeSpec project

The section describe the process for data-plane SDKs. Management-plane SDKs still follow separate existing `autorest` process.

This assumes you have cloned language SDKs into your local folder at same level of `azure-rest-api-spec`.
```
 \-
   azure-rest-api-specs/
   azure-rest-api-specs-pr/
   azure-sdk-for-java/
   azure-sdk-for-js/
   azure-sdk-for-net/
   azure-sdk-for-python/
``````

 You can then run `./eng/script/TypeSpec-Generate-Sdk.ps1` script to generate the necessary SDK folder and project structure if it does not already exist, and then regenerate the SDK source code.

Scenarios:

1. Test generation of SDK project and code with local TypeSpec changes in your `azure-rest-api-specs` repo. Please note this cannot be used to submit a SDK PR as it does not contain a valid commit id for the TypeSpec file.

```cli
   cd specifications/contoso/contoso.widgetmanager
   ..\..\..\eng\script\TypeSpec-Generate-Sdk.ps1 -SdkRepoRootDirectory C:\Github\fork\azure-sdk-for-java\
```

2. Generate/refresh SDK code for PR submission. The following command will update tsp-location.yaml with commit id and repo info so the build can be generated and verified by the CI and release pipeline.

```
   cd specifications/contoso/contoso.widgetmanager
   ..\..\..\eng\script\TypeSpec-Generate-Sdk.ps1 -SdkRepoRootDirectory C:\Github\fork\azure-sdk-for-java\ [commit id] Azure/azure-rest-api-specs
```

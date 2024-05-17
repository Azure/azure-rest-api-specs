# Azure Rest API, SDK development process with TypeSpec

## Table Of Content

1. Introduction
2. Repo setup & prerequisites
3. Creating a new TypeSpec project
4. Prepare and submit a Pull Request for reviewing
5. Generate or Refresh SDK code from a TypeSpec project

### 1. Introduction

This document describes the processes of developing Azure Rest APIs and SDKs with TypeSpec language. The steps below assumes that you are developing TypeSpec API specifications in the `azure-rest-api-specs` and `azure-rest-api-specs-pr`repos.

If you are developing within your own ADO repo first and then submitting into `azure-rest-api-specs` repos for review and release, you will need to copy the TypeSpec files over.

### 2. Repo setup & prerequisites

- The main repos for Azure rest-api are [azure-rest-api-specs](https://github.com/azure/azure-rest-api-specs) and [azure-rest-api-specs-pr](https://github.com/azure/azure-rest-api-specs-pr) repos. The `-pr` repo contains `RPSaaSMaster` and `RPSaaSDev` branches for ProviderHub based ARM service specs.

#### 2.1 With local machine development

- [Node.js LTS](https://nodejs.org/en) version 18 or above (LTS Recommended). Ensure you can run the npm command in a command prompt:
```
  npm --version
```

- Run following command in the **repository root folder**. This will install required packages such as TypeSpec compilers and Azure Library packages.

```
   npm ci
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

### 4. Prepare and submit a Pull Request for reviewing

1. Create a branch in your local repository for your changes.

2. Create or update the TypeSpec files for your service.

3. Add or update 'examples' files for each operation of your OpenAPI file.

   The [oav](https://github.com/Azure/oav) provides two ways to generate Swagger examples:

   1. Generating basic examples and then manually modify the values. It will generate two examples for each operation: one contains minimal properties set, the other contains the maximal properties set. Since the auto-generated examples consist of random values for most types, you need replace them with meaningful values.

   ```bash
   oav generate-examples openapi.json
   ```

   2. (**Recommended**) Generating high quality examples from API Scenario test. Refer to [API Test section](getstarted/providerhub/step03-api-testing.md). It will validate the API quality and generate Swagger examples from live traffic in API Scenario test.

   ```bash
   oav run <scenario-file> --spec <spec-file> --generateExample
   ```

    Note, latest OAV tool should automatically generate the following. However, if you are generating the examples manually, please ensure you have:
    - include `title` field and make sure it is descriptive and unique for each operation.
    - include `operationId`. This is used to match with declared operations in TypeSpec and correctly output in swagger.

4. Add/update the `readme.md` file in either the 'resource-manager' or 'data-plane' folder to specify the version and location of the OpenAPI files. The `readme.md` is needed for both management-plane and data-plane services for REST API Docs generation. For management-plane services, the `readme.md` is also needed for SDK generation -- see [generating client with autorest](https://github.com/Azure/autorest/blob/main/docs/generate/readme.md#keeping-your-options-in-one-place-the-preferred-option). The `readme.md` may contain generation options for multiple languages, separated into high-level sections.

   Example:[sample-readme](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/samplefiles/samplereadme.md)

5. Generate swagger files:
   - sync with the target branch in the azure-rest-api-specs repo
      ```
       git pull upstream <target-branch>
      ```
   - in the root directory, run `npm install`
   - in the project directory, `npx tsp compile`. This will generate swagger files under `resource-manager` or `data-plane` folders.

6. Ensure all generated files under `resource-manager` or `data-plane` have been added to PR.

7. Send a pull request .

   - commit all your changes.
   - push your branch to your fork of the repo.
   - send a pull request to the original repo from your forked repo.

   See the ARM Wiki for information on the [supported repos and branches for management-plane services](https://armwiki.azurewebsites.net/rpaas/swaggeronboarding.html#supported-github-reposbranches).

#### 4.1 Fix the errors of PR reviewing CI checks

The CI checks result will be commented on the PR. you can refer to the [CI fix Guide](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/ci-fix.md).

Note:
Since the OpenAPI is generated from TypeSpec, to change the OpenAPI, you must update the TypeSpec file and regenerate the OpenAPI and avoid updating OpenAPI directly to keep the consistency between OpenAPI and TypeSpec.
For support & help, you can post a message to [TypeSpec parters - teams channel](https://teams.microsoft.com/l/channel/19%3a2d4efc54d99e4d00a568da7cf0643c1b%40thread.skype/TypeSpec%2520Partners?groupId=3e17dcb0-4257-4a30-b843-77f47f1d4121&tenantId=72f988bf-86f1-41af-91ab-2d7cd011db47).

### 5. Generate or Refresh SDK code from a TypeSpec project

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

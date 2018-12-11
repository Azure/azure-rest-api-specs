# Contributing to azure-rest-api-specs
First, thank you for contributing to Azure specs repository! Swagger specs are the basis for generating Azure SDKs in multiple different languages, Azure CLIs for interacting with the services, and can provide documentation for these services.

## Basics
If you're a spec author looking for information about all of the repositories and steps in the pipeline, go to the [adx-documentation-pr](https://github.com/Azure/adx-documentation-pr) repository. Make sure to [join the Github Azure organization](http://aka.ms/azuregithub) to get access to that repo.

## Table of Contents
[Before starting](#before-starting)
- [Onboarding](#onboarding)
- [Github basics](#github-basics)
- [Code of Conduct](#code-of-conduct)

[Making changes](#making-changes)
- [Documentation](#documentation)
- [Filenames and folder structure](#filenames-and-folder-structure)
- [Tools for writing Swagger](#tools-for-writing-swagger)
- [Tools for validating Swagger](#tools-for-validating-swagger)

[Submitting a PR](#submitting-a-pr)

[Review process](#review-process)
- [SLA](#sla)
- [Review Criteria](#review-criteria)

## Before starting

### Onboarding
Make sure that your Github account is part of the Azure organization. [Use this page](http://aka.ms/azuregithub) to link your account.

Before cloning this repository, please make sure you have started in our [documentation repository adx-documentation-pr](https://github.com/Azure/adx-documentation-pr) (you will only have access to that page if you are part of the Azure organization).

### Github basics

#### GitHub workflow
If you don't have experience with Git and Github, some of the terminology and process can be confusing. [Here's a guide to understanding Github](https://guides.github.com/introduction/flow/).

#### Forking the Azure/azure-rest-api-specs repository
Unless you are working with multiple contributors on the same file, we ask that you fork the repository and submit your Pull Request from there. [Here's a guide to forks in Github](https://guides.github.com/activities/forking/).

### Code of Conduct
This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Making changes
Swagger files are simply JSON files that follow the [OpenAPI Specification](http://swagger.io/specification/). This specification is extensible, and there are extensions that are used by AutoRest when your SDK is generated. Additionally, there are patterns and standards that are necessary for generating quality SDKs and CLIs.

### Documentation
The [/documentation](../documentation/) folder contains many resources for writing Swagger files.

The [Swagger Checklist](../documentation/swagger-checklist.md) page is intended as a guide for different scenarios. If you know the service behavior that you're trying to model (e.g. PUT/PATCH/GET responses and request schemas, or modeling long running operations), that document is structured to make it easy to find our recommendations.

The [Reference Documentation](../documentation/creating-swagger.md) page contains lots of information about each part of a Swagger file and how to structure it correctly for code generation. If you're looking for an explanation on what a part of Swagger relates to your service or how it's used to generate code, that document is the right place to go.

### Filenames and folder structure
- Swagger spec for every api-version should be in a separate folder named with the api-version.
  - It is time consuming to review the file line by line for every api-version. When you are creating the swagger spec for the new api-version, please copy the swagger spec from the previous version in to the new api-versioned folder and commit it. After that overwrite it with the changes for the new api-version. This makes it easy for us to review the changes.

### Tools for writing Swagger
As JSON files, specs can be modified in any text editor that you choose. We have some recommendations that can make editing these files easier.

- _**Recommended**_ Visual Studio Code.
- Visual Studio Code can provide a nice experience for editing JSON, though it takes extra work to use the JSON schema that defines Swagger files. 

### Tools for validating Swagger
There are some tools that can help you make sure your spec conforms to guidelines. The more of these issues that are caught before the PR is sent, the quicker the turnaround to merging the PR will be. 

- _**Recommended**_ Please take a look at the [validation tools for swagger checklist](https://github.com/Azure/azure-rest-api-specs/blob/master/documentation/swagger-checklist.md#validation-tools-for-swagger-checklist) section. 
- The [OpenAPI Initiative Swagger editor](http://editor.swagger.io/#/) will help find basic issues in a Swagger file. However, we apply a higher bar than this validator - just because this site doesn't show errors doesn't mean the spec is ready to merge. 
- Similarly, this online [schema validator](https://json-schema-validator.herokuapp.com/) can help find basic errors. Again, we apply a higher bar than this validator - just because this site doesn't show errors doesn't mean the spec is ready to merge. 
  * In the upper left box, paste the [swagger schema from here](https://github.com/swagger-api/swagger-spec/blob/master/schemas/v2.0/schema.json)
  * In the lower left box, paste your swagger json
  * Upon clicking the validate button, you should either see errors or success.

## Submitting a PR

Please send a [GitHub Pull Request to Azure REST API Specs](https://github.com/azure/azure-rest-api-specs/pull/new/master) with a clear list of what you've done (read more about [pull requests](http://help.github.com/pull-requests/)). When you send a pull request, we will love you forever if you include additions to the documentation for your given service. We can always use more documentation and beautiful markdown. Please follow make sure all of your commits are atomic (one feature per commit).

Always write a clear log message for your commits. One-line messages are fine for small changes, but bigger changes should look like this:

    $ git commit -m "A brief summary of the commit
    >
    > A paragraph describing what changed and its impact."
    
Please be kind with your pull requests and ensure you keeping them as focused and cohesive as possible. Keep your pull
request free of merge commits, code review fixes and anything that may take away from the essence of your contribution.
Use the git tools you have available to you, such as amend, rebase, etc.


## Review process
We review spec PRs to maintain a high bar of quality for all products that will be generated from these specs (including SDKs in all languages, CLIs and documentation). It's critical that spec files are both syntactically and semantically correct, as well as conform to common patterns that make it possible to generate SDKs and CLIs that are usable for customers. Since specs are the base input for all of these products, the review process starts with PRs to this repository. Please refer to [Swagger Review Process](https://github.com/Azure/adx-documentation-pr/wiki/Swagger-Review-Process) for more details.

The expectation is that every spec in a PR will be correct JSON, syntactically correct, will semantically agree with the service it applies to, and will follow the recommended patterns.

#### Basic JSON correctness
A spec file must be valid JSON, according to the [JSON specification](https://tools.ietf.org/html/rfc7159). It must also be a valid Swagger file, according to the [OpenAPI Specification](http://swagger.io/specification/). Finally, it must also conform to the [schema that AutoRest applies](https://raw.githubusercontent.com/Azure/autorest/master/schema/swagger-extensions.json).

#### Semantic correctness
Your spec file must correctly represent your service. Even if a spec passes all of the rules listed above, it might not accurately describe the service that it is intended to describe. This could include 
- Incorrect schemas for responses or requests (both missing and superfluous properties)
- Missing operations
- Missing parameters (especially required ones)
- etc (this list is not comprehensive)

Making sure that the spec is correct from a semantic point of view requires domain knowledge and careful comparison of your spec file with your actual service. We will do our best to point out inconsistencies between spec and service if we can infer them, but you are responsible for making sure your spec and service agree.

**Recommendation**: Check each operation, parameter, schema, property to make sure it accurately models the service API. Refer back to the [Reference documentation](../documentation/creating-swagger.md) for more details on every part of Swagger.


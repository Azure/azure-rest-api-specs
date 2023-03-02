# Contributing

This file provides general guidance for developers that are creating or updating REST API definitions for Azure.

## Table of Contents
<!--
  You should regenerate the TOC using the `markdown-toc` node package after making changes to this file.

      npx markdown-toc -i --maxdepth 4 CONTRIBUTING.md
  -->

<!-- toc -->

- [Reporting Problems](#reporting-problems)
- [Avoid Breaking Changes](#avoid-breaking-changes)
- [Design Guidelines](#design-guidelines)
  * [Exceptions for Consistency within a Service](#exceptions-for-consistency-within-a-service)
- [Coding Style](#coding-style)
- [Directory Structure](#directory-structure)
- [Pull Requests](#pull-requests)
- [Pull Request Checks](#pull-request-checks)
- [Internal Contribution Guide](#internal-contribution-guide)

<!-- tocstop -->

## Reporting Problems

If you discover a problem with a REST API document in this repo, feel free to [open an issue](https://github.com/Azure/azure-rest-api-specs/issues/new). But please do not report issues with service behavior / functionality in this repo.

When opening an issue, please clearly describe the problem including which REST API definition is in error and what elements of the definition are incorrect or missing.

## Avoid Breaking Changes

The first rule for Azure REST APIs is to avoid breaking changes in Generally Available (GA'd) APIs. The [Azure Breaking Changes Policy](https://aka.ms/AzBreakingChangesPolicy) is a formal description of what changes are considered breaking changes. This rule trumps adherence to Design Guidelines, Coding Style, etc.

## Design Guidelines

Azure REST APIs should conform to the [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md).

There is a [YouTube video series](https://www.youtube.com/watch?v=9Ng00IlBCtw) by Jeffrey Richter that describes the guidelines in detail.

Another resource is the [Considerations for Service Design](https://github.com/microsoft/api-guidelines/blob/vNext/azure/ConsiderationsForServiceDesign.md), which is an introduction to REST API design mainly for services that are just getting started.

### Exceptions for Consistency within a Service

There are situations where a service has GA'd their API with design patterns that do not follow our guidelines and it would be a breaking change to adopt the API design in the guidelines.
Because the first rule is to avoid breaking changes and because we want APIs to be consistent within a service, these design patterns are considered the standard for that service and should be followed in all subsequent (non-breaking) versions of that service's REST API.

## Coding Style

REST APIs for Azure should be defined using the [OpenAPI v2](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/2.0.md) or [Cadl](https://aka.ms/cadl/rpaas-start)format.

The REST API should also adhere to the conventions documented in the [Azure API Style Guide](https://github.com/Azure/azure-api-style-guide/blob/main/openapi-style-guide.md).

You can use the [Spectral linter](https://meta.stoplight.io/docs/spectral/674b27b261c3c-overview) with our [Spectral ruleset](https://github.com/Azure/azure-api-style-guide#how-to-use-the-spectral-ruleset) to check conformance with OpenAPI v2 and the Style Guide.

## Directory Structure

See the [README.md](./README.md) for a description of the directory structure to use when adding files to this repo.

## Pull Requests

If you want to contribute to the repository, follow these steps:
  1. Fork the repository and create a new branch for your changes.
  2. If you are introducing a new api-version, create a new directory for that api-version and copy all the files from the previous version into the new directory. Make this the very first commit in your branch and then make your changes in subsequent commits.
  3. Use the [linting tools](#coding-style) to check your changes for compliance with the OpenAPI v2 standard, the Azure REST API Guidelines and that Azure API Style Guide.
  4. Push the changes to the branch in your fork until the branch is ready to be integrated.
  5. Rebase your branch if needed to incorporate any changes to **main** and submit a pull request to the **main** branch using either the "control plane" or "data plane" PR template -- the main PR template lets you select which one.
  5. Resolve any issues flagged by the [Pull Request checks](#pull-request-checks).
  6. Contact the ARM API Review board or Azure API Stewardship team to request PR review. 

Microsoft employees can try out the experience at [OpenAPI Hub](https://aka.ms/openapihub) for [adding a new API version using OpenAPI Hub](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/208/OpenAPI-Hub-Adding-new-API-version).

## Pull Request Checks

Every PR in this repo will go through a series of PR checks, including:

- Breaking Changes - checks for incompatible changes in an existing api-version
- Breaking Changes (Cross-Version) - checks for changes in a new api-version that are incompatible with prior versions
- LintDiff - checks the new or changed portions of the API for compliance with the Azure REST API Guidelines and API Style Guide
- Avocado - checks that new or changed files comply with the directory structure convention for this repo.
- Model Validation -
- Semantic Validation -
- LintRPaaS -
- ApiReadiness -
- PoliCheck -
- CredScan -
- SpellCheck -
- PrettierCheck - 
- SDK Breaking Change -

When any of these PR checks fails it will post a comment to the PR with links to information on how to resolve the problem.
There is also the [CI Fix Guide](https://aka.ms/ci-fix) that describes how to fix common PR check failures.

## Internal Contribution Guide
For management plane, please refer to https://aka.ms/rpguidelines; 

For data-plane, please refer to [Guide to design and creation of Data Plane REST API and Client Libraries](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/591/Guide-to-design-and-creation-of-Data-Plane-REST-API-and-Client-Libraries); 

For contribution access to spec repos, please refer to [Public repo vs. Private repo: To get write access](https://dev.azure.com/azure-sdk/internal/_wiki/wikis/internal.wiki/202/Overall-Process-of-Management-Plane-SDK-Onboarding?anchor=2.-create/update-the-openapi-specifications%2C-and-launch-swagger-pr-review)

# Contributing

This file provides general guidance for developers that are creating or updating REST API definitions for Azure.

## Table of Contents
<!--
  You should regenerate the TOC using the `markdown-toc` node package after making changes to this file.

      npx markdown-toc -i --maxdepth 4 CONTRIBUTING.md
  -->

<!-- toc -->

- [Design Guidelines](#design-guidelines)
- [Coding Style](#coding-style)
- [Directory Structure](#directory-structure)
- [Pull Requests](#pull-requests)
- [Adding a new service](#adding-a-new-service)
- [Running tests](#running-tests)
  * [Unit tests](#unit-tests)
  * [Integration tests](#integration-tests)
- [Developer's Certificate of Origin 1.1](#developers-certificate-of-origin-11)
- [Additional Resources](#additional-resources)

<!-- tocstop -->

## Reporting problems

If you discover a problem with a REST API document in this repo, feel free to [open an issue](https://github.com/Azure/azure-rest-api-specs/issues/new). But please do not report issues with service behavior / functionality in this repo.

When opening an issue, please clearly describe the problem including which REST API definition is in error and what elements of the definition are incorrect or missing.

## Avoid Breaking Changes

The first rule for Azure REST APIs is to avoid breaking changes in Generally Available (GA'd) APIs. The [Azure Breaking Changes Policy](https://aka.ms/AzBreakingChangesPolicy) is a formal description of what changes are considered breaking changes. This rule trumps adherence to Design Guidelines, Coding Style, etc.

## Design Guidelines

Azure REST APIs should conform to the [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md).

There is a [YouTube video series](https://www.youtube.com/watch?v=9Ng00IlBCtw) by Jeffrey Richter that describes the guidelines in detail.

Another resource is the [Considerations for Service Design](https://github.com/microsoft/api-guidelines/blob/vNext/azure/ConsiderationsForServiceDesign.md), which is an introduction to REST API design mainly for services that are just getting started.

### Exceptions for consistency within a service

There are situations where a service has GA'd their API with design patterns that do not follow our guidelines and it would be a breaking change to adopt the API design in the guidelines.
Because the first rule is to avoid breaking changes and because we want APIs to be consistent within a service, these design patterns are considered the standard for that service and should be followed in all subsequent (non-breaking) versions of that service's REST API.

## Coding Style

REST APIs for Azure should be defined using the [OpenAPI v2](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/2.0.md) format.

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

## Pull Request checks

Every PR in this repo will go through a series of PR checks, including:

- Breaking Changes - checks for incompatible changes in an existing api-version
- Cross Version Breaking Changes - checks for changes in a new api-version that are incompatible with prior versions
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

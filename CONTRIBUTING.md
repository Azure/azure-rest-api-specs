# Contributing

<!-- cspell:ignore Poli tocstop -->

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
  - [Exceptions for Consistency within a Service](#exceptions-for-consistency-within-a-service)
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

All new services should use [TypeSpec](https://aka.ms/typespec/azure) to create their REST API definition. If you are working on an existing service, you should consider converting your existing REST API definition to TypeSpec. Services that use TypeSpec to describe their REST API should include both the TypeSpec source and generated OpenAPI in the specs repo.

## Directory Structure

See the [README.md](./README.md) for a description of the directory structure to use when adding files to this repo.

## Pull Requests

Repository label definitions are maintained through pull requests. See
[repository labels](./eng/README.md#repository-labels) for validation and synchronization guidance.

If you want to contribute to the repository, follow these steps:

1. Fork the repository and create a new branch for your changes.
2. Push the changes to the branch in your fork until the branch is ready to be integrated.
3. Rebase your branch if needed to incorporate any changes to **main** and submit a pull request to the **main** branch using either the "control plane" or "data plane" PR template -- the main PR template lets you select which one.
4. Resolve any issues flagged by the [Pull Request checks](#pull-request-checks).

**Note:** Microsoft employees can use tooling for adding a new API version available [here](https://eng.ms/docs/products/azure-developer-experience/design/api-specs/api-specs), specially if not working with TypeSpec.

## Pull Request Checks

Every PR in this repo will go through a series of PR checks, including:

- Format - checks formatting of repository tooling in `.github` and `eng/tools` using Oxfmt. Run `pnpm format` from the repository root to fix issues.
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
- Contributor readiness - reports required contributor access for PRs that change `specification/`.

Internal contributors need **Azure organization membership and repository write access** for the PR workflow to work correctly. Microsoft organization membership is not required by the contributor-readiness check. Without repository write access, a PR author cannot run Azure DevOps pipelines for the PR, and a reviewer cannot provide an approval that counts toward required reviews (GitHub's green approval check). The reviewer must set up or renew their own access. Other GitHub approval rules still apply.

The contributor-readiness report separates access issues from their PR impact. It checks PR authors, commit authors/committers, and reviewers with an `APPROVED` review; comments and other review states do not add reviewer participants. When findings exist, a collapsed section shows contributors with verified public Azure membership and repository write access. The check does not inspect Azure DevOps roles, and private membership or unavailable lookups do not prove missing write access. This check is non-blocking; external fork contributions remain allowed. Internal contributors can [set up or renew required access](https://aka.ms/azsdk/access), then comment `/azsdk check-access` on the PR to refresh the report.

When any of these PR checks fails it will post a comment to the PR with links to information on how to resolve the problem.
There is also the [CI Fix Guide](https://aka.ms/ci-fix) that describes how to fix common PR check failures.

## Internal Contribution Guide

[Create high-level Azure REST API design](https://eng.ms/docs/products/azure-developer-experience/design/api-design)

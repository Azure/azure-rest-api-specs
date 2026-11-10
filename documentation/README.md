# Specification documentation

This directory contains documentation specific to the Azure REST API specifications repository.

## Getting started

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [Getting started with TypeSpec specifications](./Getting-started-with-TypeSpec-specifications.md) | Repository checklist and starting points for TypeSpec specification projects. | Specification authors | TypeSpec |
| [Getting started with OpenAPI specifications](./Getting%20started%20with%20OpenAPI%20specifications.md) | Starting points for maintaining hand-authored OpenAPI specifications. | Specification authors maintaining existing OpenAPI | OpenAPI |

## Contributor workflow and toolchain

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [Toolchain setup](./contributing/toolchain-setup.md) | Node.js and pnpm prerequisites, installation, and toolchain updates. | Contributors | TypeSpec and OpenAPI |
| [Dependencies](./contributing/dependencies.md) | Workspace package management, dependency ownership, and shared versions. | Contributors and tooling maintainers | Repository tooling |
| [TypeSpec development process](./contributing/typespec-development-process.md) | End-to-end setup, authoring, pull request, and SDK development workflow. | Specification authors | TypeSpec |
| [API specification review FAQ](./contributing/api-spec-review-faq.md) | Where to get help with review queues, checks, and documentation publishing. | Pull request authors | TypeSpec and OpenAPI |
| [Spec model](./contributing/spec-model.md) | Running the repository's specification model locally and diagnosing errors. | Contributors and tooling maintainers | TypeSpec and OpenAPI |

## Specification structure and lifecycle

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [Folder structure versions](./specification-guidelines/folder-structure.md) | Overview of the current and legacy specification layouts. | Specification authors | TypeSpec and OpenAPI |
| [Specification folder structure guide](./specification-guidelines/specification-folder-structure-guide.md) | Detailed directory layout, naming, and migration requirements. | Specification authors | TypeSpec and OpenAPI |
| [Specification glossary](./specification-guidelines/specification-glossary.md) | Definitions of services, organizations, resource types, and provider namespaces. | Specification authors and reviewers | TypeSpec and OpenAPI |
| [Azure service versioning guide](./specification-guidelines/azure-service-versioning-guide.md) | Service boundaries, versioning, and service-specific SDK packages. | Service teams | TypeSpec and OpenAPI |
| [Uniform versioning](./uniform-versioning.md) | Requirements for versioning a service, its specifications, documentation, and SDKs together. | Specification authors and reviewers | TypeSpec and OpenAPI |
| [Common types](./specification-guidelines/common-types.md) | Usage guidance for shared resource-management types. | Management-plane specification authors | TypeSpec and OpenAPI |
| [Deprecating preview APIs](./specification-guidelines/deprecating-preview-apis.md) | Policies and steps for removing retired preview API versions. | Service teams | TypeSpec and OpenAPI |
| [Resolving folder migration conflicts](./specification-guidelines/resolving-folder-migration-conflicts.md) | Updating an in-flight pull request after a folder migration. | Pull request authors | TypeSpec and OpenAPI |

## Pull request checks

Start with the [CI fix guide](./ci-fix.md) to identify a failing check, then use its detailed reference below.

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [API documentation preview](./validation/api-doc-preview.md) | Documentation onboarding, preview pipeline behavior, and troubleshooting. | Specification authors | TypeSpec and OpenAPI |
| [ARM auto sign-off](./validation/arm-auto-signoff.md) | Queries and implementation references for automatic ARM sign-off. | Reviewers and tooling maintainers | Management-plane specifications |
| [SDK breaking changes](./validation/sdk-breaking-changes.md) | Suppressing and reviewing SDK breaking changes. | Specification authors and SDK reviewers | TypeSpec and OpenAPI |
| [SDK validation](./validation/sdk-validation.md) | Re-running checks, downloading artifacts, and diagnosing SDK generation errors. | Pull request authors | TypeSpec and OpenAPI |
| [Summarize impact](./validation/summarize-impact.md) | Change classification and suppression-review troubleshooting. | Reviewers and tooling maintainers | TypeSpec and OpenAPI |
| [Swagger Avocado](./validation/swagger-avocado.md) | Running specification structure checks and handling known errors. | Pull request authors | TypeSpec and OpenAPI |
| [Swagger breaking change troubleshooting](./validation/swagger-breaking-change.md) | Diagnosing AutoRest exceptions in breaking-change checks. | Pull request authors | OpenAPI |
| [Swagger LintDiff](./validation/swagger-lintdiff.md) | Scoped suppressions and TypeSpec-generated OpenAPI troubleshooting. | Specification authors | TypeSpec and OpenAPI |
| [TypeSpec requirement](./validation/typespec-requirement.md) | TypeSpec adoption checks, suppressions, and renamed specifications. | Specification authors | TypeSpec and OpenAPI |
| [TypeSpec validation](./validation/typespec-validation.md) | Local validation, rule behavior, and suppression configuration. | Specification authors | TypeSpec |
| [Uniform versioning violation guide](./validation/uniform-versioning-violation-guide.md) | Resolving version mixing and its SDK release implications. | Service teams | TypeSpec and OpenAPI |

## Validation and rule references

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [CI fix guide](./ci-fix.md) | Troubleshooting entry point for pull request validation checks. | Pull request authors | TypeSpec and OpenAPI |
| [OpenAPI authoring automated guidelines](./openapi-authoring-automated-guidelines.md) | Reference for automated OpenAPI validation rules and their TypeSpec mappings. | Specification authors and reviewers | TypeSpec and OpenAPI |
| [OpenAPI authoring manual guidelines](./openapi-authoring-manual-guidelines.md) | Reference for OpenAPI authoring rules that require manual verification. | Specification authors and reviewers | OpenAPI |
| [Semantic and model violations reference](./Semantic-and-Model-Violations-Reference.md) | Reference for OAV semantic and model validation errors. | OpenAPI authors | OpenAPI |
| [Breaking change and OAD rules mapping](./BreakingChange-Oad-Rules-Mapping.md) | Mapping between OAD rule identifiers and breaking change categories. | Specification authors and reviewers | OpenAPI |
| [x-ms-examples](./x-ms-examples.md) | Repository reference for operation request and response examples in OpenAPI. | OpenAPI authors | OpenAPI |

## Review tooling

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [ARM API Reviewer agent](./api-reviewer-agent.md) | User and maintainer documentation for the repository's ARM API review agent. | Specification authors, reviewers, and agent maintainers | TypeSpec and OpenAPI |
| [Backlog triage](./backlog-triage.md) | Automatic oldest-first issue investigation, cleanup criteria, and maintainer controls. | Issue reporters and repository maintainers | Repository issues |

## SDK and release automation implementation

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [Official SDK release guide](https://aka.ms/azsdk/releases/partnerinfo) | Process for requesting and releasing an official Azure SDK. | Service teams | TypeSpec and OpenAPI |
| [Release plan auto-generation](./release-plan-auto-generation.md) | Implementation details for automatic release plan discovery and creation. | Tooling maintainers | TypeSpec |
| [SDK automation customization](./sdkautomation/README.md) | Configuration and protocol reference for SDK automation. | Tooling maintainers | TypeSpec and OpenAPI |

## Specification testing

| Document set | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [API Scenario](./api-scenario/README.md) | Authoring and reference documentation for API Scenario tests. | Service teams and test authors | OpenAPI-based scenarios |
| [RESTler](./restler/QuickStart.md) | Setup and recording guidance for RESTler API testing. | Service teams and test authors | OpenAPI |

## Legacy OpenAPI samples

| Document set | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [Resource Manager sample files](./samplefiles/ABOUT.md) | Legacy sample OpenAPI specifications and AutoRest configuration files. | Authors maintaining existing OpenAPI | OpenAPI |
| [Data-plane sample files](./samplefiles-dp/ABOUT.md) | Legacy single-client and multi-client OpenAPI samples. | Authors maintaining existing OpenAPI | OpenAPI |

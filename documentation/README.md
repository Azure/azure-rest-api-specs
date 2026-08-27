# Specification documentation

This directory contains documentation specific to the Azure REST API specifications repository.

## Getting started

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [Getting started with TypeSpec specifications](./Getting-started-with-TypeSpec-specifications.md) | Repository checklist and starting points for TypeSpec specification projects. | Specification authors | TypeSpec |
| [Getting started with OpenAPI specifications](./Getting%20started%20with%20OpenAPI%20specifications.md) | Starting points for maintaining hand-authored OpenAPI specifications. | Specification authors maintaining existing OpenAPI | OpenAPI |

## Validation and rule references

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [CI fix guide](./ci-fix.md) | Troubleshooting entry point for pull request validation checks. | Pull request authors | TypeSpec and OpenAPI |
| [OpenAPI authoring automated guidelines](./openapi-authoring-automated-guidelines.md) | Reference for automated OpenAPI validation rules and their TypeSpec mappings. | Specification authors and reviewers | TypeSpec and OpenAPI |
| [Semantic and model violations reference](./Semantic-and-Model-Violations-Reference.md) | Reference for OAV semantic and model validation errors. | OpenAPI authors | OpenAPI |
| [Breaking change and OAD rules mapping](./BreakingChange-Oad-Rules-Mapping.md) | Mapping between OAD rule identifiers and breaking change categories. | Specification authors and reviewers | OpenAPI |
| [x-ms-examples](./x-ms-examples.md) | Repository reference for operation request and response examples in OpenAPI. | OpenAPI authors | OpenAPI |

## Review tooling

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
| [ARM API Reviewer agent](./api-reviewer-agent.md) | User and maintainer documentation for the repository's ARM API review agent. | Specification authors, reviewers, and agent maintainers | TypeSpec and OpenAPI |

## SDK and release automation implementation

| Document | Purpose | Audience | Applies to |
| --- | --- | --- | --- |
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

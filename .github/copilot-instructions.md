<!-- This file provides repository-level instructions for GitHub Copilot Chat.
     It is automatically loaded when users interact with Copilot in this repo
     (VS Code, GitHub.com, etc.) to guide responses for TypeSpec authoring,
     SDK generation, API reviews, and other repo-specific workflows.

     For GitHub Copilot Code Review (the feature that posts inline PR comments),
     see copilot-review-instructions.md in this same directory.
     Docs: https://docs.github.com/en/copilot/concepts/agents/code-review -->

# New TypeSpec projects

Refer to [new-typespec-project.instructions.md](./instructions/typespec-project.instructions.md) for detailed steps on:

- how to create a new TypeSpec project.
- converting a specification from swagger to typespec
- troubleshooting tsp compile errors

# Adding Language Emitters to Existing TypeSpec Projects

Refer to [language-emitter.instructions.md](./instructions/language-emitter.instructions.md) for detailed steps on how to add language emitters to an existing `tspconfig.yaml` file in a TypeSpec project.

# When to invoke the azure-typespec-author skill

The `azure-typespec-author` skill **must** be invoked immediately in all modes (including plan mode) for any task that involves creating and modifying TypeSpec (`.tsp`) files except for `client.tsp` under the specification directory in this repository. This includes but is not limited to:

- Adding, bumping, or promoting API versions (preview, stable)
- Adding or modifying resources, operations, models, properties, or decorators
- Changing visibility, constraints, breaking changes, LRO patterns, or suppressions
- Defining or updating operationId, spread models, or extension resources
- Converting Swagger to TypeSpec (post-conversion edits)

**If you are unsure whether a user request involves TypeSpec authoring, ask the user to confirm before proceeding.** For example, if the request mentions API changes, versioning, resource definitions, or spec modifications but does not explicitly mention TypeSpec, prompt the user:

> "This request may involve TypeSpec specification changes. Would you like me to use the azure-typespec-author skill to help with this?"

If the user confirms, invoke the `azure-typespec-author` skill immediately. Do **not** build typespec authoring related plan or attempt to make `.tsp` file changes without invoking this skill first.

**Do NOT use this skill for:** SDK generation, releasing SDK packages, `client.tsp` or code customization, or standalone MCP tool calls that do not involve editing `.tsp` files.

# SDK generation from TypeSpec

You must use Azure SDK MCP server to generate SDK from TypeSpec.

Refer to [sdk-generation.instructions.md](./instructions/sdk-generation.instructions.md) for additional instructions to generate SDK from TypeSpec.

# Instructions for GitHub coding agent to generate SDKs using GitHub.com

Follow [github-codingagent.instructions.md](./instructions/github-codingagent.instructions.md) for instructions to run SDK generation using pipeline in GitHub coding agent.

# Release readiness of SDK and information about the release pipeline

Run [check package readiness](../eng/common/instructions/azsdk-tools/check-package-readiness.instructions.md) to check the release readiness of an SDK package. This prompt will collect the required information from the user, execute the readiness check, and present the results.

# Up-to-date TypeSpec documentation

Follow [typespec docs](../eng/common/instructions/azsdk-tools/typespec-docs.instructions.md) to get the most up-to-date documentation for TypeSpec, including best practices for writing TypeSpec for Azure.

# ARM Api Copilot Review Instructions

Follow [armapi-review.instructions.md](./instructions/armapi-review.instructions.md) and [openapi-review.instructions.md](./instructions/openapi-review.instructions.md) for instructions to review ARM API specifications. GitHub Code review agent must prioritize these instructions over any other instruction files while performing code reviews.

Cross-cutting review rules (secret detection, property mutability, naming conventions, enum best practices, provisioning state, tracked resource lifecycle) are in the shared [azure-api-review skill](./skills/azure-api-review/SKILL.md). These are referenced by the instruction files and should not be duplicated elsewhere.

# GitHub Actions Development

Follow [github-actions.instructions.md](./instructions/github-actions.instructions.md) for instructions on developing and maintaining GitHub Actions code in this repository. This includes workflows, composite actions, and shared utilities.

<!-- LINKS -->

[contoso-widget-manager]: ../specification/contosowidgetmanager/Contoso.WidgetManager/
[tspconfig]: ../specification/contosowidgetmanager/Contoso.WidgetManager/tspconfig.yaml
[security-definitions]: https://azure.github.io/typespec-azure/docs/reference/azure-style-guide#security-definitions
[versioning]: https://typespec.io/docs/libraries/versioning/guide#implementing-versioned-apis
[docs]: https://typespec.io/docs/language-basics/documentation
[ci-fix]: ../documentation/ci-fix.md
[url-type]: https://typespec.io/docs/language-basics/built-in-types#string-types
[no-enum]: https://azure.github.io/typespec-azure/docs/libraries/azure-core/rules/no-enum
[typespec-structure-guidelines]: ../documentation/typespec-structure-guidelines.md

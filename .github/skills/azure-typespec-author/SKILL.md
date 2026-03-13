---
name: azure-typespec-author
license: MIT
metadata:
  version: "0.0.1"
description: "Author or modify Azure TypeSpec API specifications. USE FOR: Any task that creates, modifies, or troubleshoots .tsp files or TypeSpec API specifications — including but not limited to API versioning evolution(add new preview version, add new stable version), ARM resource type(tracked, proxy, extension, child resources) or data-plane resource definitions, resource operations (CRUD, PATCH, custom actions, paging, async/Long Running Operations), models, enums, unions, properties, decorators, constraints, parameters, and swagger-to-TypeSpec conversion. DO NOT USE FOR: SDK generation from TypeSpec, releasing SDK packages, single MCP tool calls that do not require multi-step workflows. TOOLS/COMMANDS: azure-sdk-mcp:azsdk_typespec_generate_authoring_plan, azure-sdk-mcp:azsdk_run_typespec_validation"
compatibility: >-
  Requires: azure-sdk-mcp server with azure-sdk-mcp:azsdk_typespec_generate_authoring_plan and azure-sdk-mcp:azsdk_run_typespec_validation tools.
---

# Azure TypeSpec Author

## MCP Prerequisites

Requires `azure-sdk-mcp` server with TypeSpec authoring and validation tools.

## MCP Tools

| Tool                                     | Purpose                              |
| ---------------------------------------- | ------------------------------------ |
| `azure-sdk-mcp:azsdk_typespec_generate_authoring_plan` | Generate grounded authoring plan     |
| `azure-sdk-mcp:azsdk_run_typespec_validation`          | Validate TypeSpec compilation + lint |

## Principles

1. **Mandatory for ALL `.tsp` edits** — even a single `?` change can be breaking.
2. **Minimal, scoped edits** — only change what the request requires.
3. **Always validate** — run `azure-sdk-mcp:azsdk_run_typespec_validation` after every edit.
4. **Always cite references** — provide links that justify the approach.

## Task Classification

Classify every request into exactly one of the two types below before proceeding.

- **API Version Evolution** = adding a brand-new API version string (e.g. `2025-06-01-preview`) to the service. This is *only* about creating a new version entry and carrying over / excluding features. It is **not** about adding `@added`/`@removed` decorators to individual properties or operations within an existing version — that falls under General Authoring.
- **General Authoring** = everything else that modifies `.tsp` files.

| Type                  | Description                                                       | Examples                                               |
| --------------------- | ----------------------------------------------------------------- | ------------------------------------------------------ |
| **API Version Evolution (ARM only)** | Adding a new preview or stable API version to an existing ARM service. Data-plane API version evolution is not fully supported yet. | "Add a new preview API version 2026-01-01-preview for widget resource manager" |
| **General Authoring** | Any other TypeSpec authoring task that modifies `.tsp` files      | "Add an ARM resource named Asset with CRUD operations" |

## Steps

All tasks follow a 5-step workflow. Steps 2–3 branch by task type; the rest are shared.

1. **Analyze Project** — Follow the [project analysis guide](references/analyze-project.md) to collect project context and determine task type.

2. **Intake & Clarification**
   - *API Version Evolution:* determine the versioning scenario from Step 1, use [agentic search](references/agentic-search.md) in the document with the scenario URL below to collect information from user. Be sure to use a user-friendly way to collect required inputs from user. e.g., list the existing features (resources, operations, properties) from the latest version and then ask the user which to carry over or exclude, instead of asking for raw input.

     | Latest  | Target  | URL to fetch                                                                          |
     | ------- | ------- | ------------------------------------------------------------------------------------- |
     | preview | preview | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/02-preview-after-preview/` |
     | preview | stable  | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/03-stable-after-preview/`  |
     | stable  | preview | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/04-preview-after-stable/`  |
     | stable  | stable  | `https://azure.github.io/typespec-azure/docs/howtos/versioning/arm/05-stable-after-stable/`   |

   - *General Authoring:* follow [intake guide](references/general-authoring-intake.md).

3. **Retrieve Solution**
   - *API Version Evolution:* search the downloaded guide content for implementation steps via [agentic search](references/agentic-search.md) and generate solution. No MCP tool call needed.
   - *General Authoring:* invoke `azure-sdk-mcp:azsdk_typespec_generate_authoring_plan` MCP tool with the following parameters:

     | Parameter                 | Value                                                                                        |
     | ------------------------- | -------------------------------------------------------------------------------------------- |
     | `request`                 | User request (verbatim)                                                                      |
     | `additionalInformation`   | All content gathered from Steps 1–2 (intake analysis, user answers, relevant `.tsp` code read from the project) |
     | `typeSpecProjectRootPath` | TypeSpec project root path                                                                   |

     Do not proceed without a grounded plan from this tool.

4. **Apply Changes** — Confirm uncertainties with user, make minimal `.tsp` edits, prefer official templates from retrieved context.

5. **Validate** — Follow the [validation guide](references/validation.md).
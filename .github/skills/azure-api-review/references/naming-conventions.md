<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-04-15
     Derived from:
       - Azure REST API Guidelines (vNext) — Naming
       - ARM Wiki: api_contracts/guidelines/api_best_practices_and_design_choices.md (RPC-BestPractice-01)
     The upstream documents always take precedence if there is a conflict. -->

# Naming Conventions for Azure API Specifications

Consistent naming across Azure APIs ensures a uniform developer experience in SDKs, documentation, and tooling.

**Authoritative references:**

- [Azure REST API Guidelines -- JSON](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#json)
- [Azure REST API Guidelines -- URLs](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#uniform-resource-locators-urls)
- [Azure Resource Provider Contract -- Resource API Reference](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/resource-api-reference.md)

---

## Property and Model Naming

| Element                    | Casing                    | Examples                                                |
| -------------------------- | ------------------------- | ------------------------------------------------------- |
| JSON property names        | camelCase                 | `resourceId`, `provisioningState`, `virtualMachines`    |
| Model / definition names   | PascalCase                | `VirtualMachine`, `StorageAccount`, `ErrorResponse`     |
| Enum / union member values | PascalCase                | `Succeeded`, `Failed`, `InProgress`                     |
| Operation names (TypeSpec) | camelCase                 | `createOrUpdate`, `listByResourceGroup`                 |
| Operation IDs (OpenAPI)    | `{ResourceType}_{Action}` | `VirtualMachines_Get`, `StorageAccounts_CreateOrUpdate` |

### Acronym Handling

- **DO NOT** uppercase acronyms in property names: use `resourceId` not `resourceID`, `vmName` not `VMName`.
- **DO** uppercase acronyms in descriptions: use "URL" not "Url", "ID" not "Id", "VM" not "Vm".
- Property names **MUST** be treated as case-sensitive.

### Resource Type Names in URL Paths

- **MUST** be camelCase (e.g., `virtualMachines`, not `VirtualMachines`)
- **MUST** be plural (e.g., `virtualMachines`, not `virtualMachine`)
- **MUST** be specific -- avoid generic names like `resourceName` or `childResourceName`
- **MUST NOT** collide with well-known Azure concepts (e.g., `subscriptions`, `resourceGroups`)
- **MUST NOT** repeat the resource provider namespace (e.g., `contosoHttpsServices` is redundant under `Microsoft.Contoso`)

### Path Parameter Names

- **SHOULD** use the full resource name, not abbreviations (`{virtualMachineName}` not `{vmName}`)
- **MUST** be descriptive of the resource they identify (`{syncSetName}` not `{childResourceName}`)

---

## Azure Terminology in Client-Facing Text

These rules apply to property names, descriptions, enum values, and
doc comments -- anything that propagates into SDKs and customer-facing
documentation.

| Incorrect                                      | Correct                             | Rule                              |
| ---------------------------------------------- | ----------------------------------- | --------------------------------- |
| "ARM" (standalone)                             | "Azure" or "Azure Resource Manager" | Use official product names        |
| `armResourceId`                                | `monitorAccountResourceId`          | No "ARM" prefix in property names |
| "AAD"                                          | "Microsoft Entra ID"                | Use current product name          |
| Unexpanded acronyms (IAM, SRA, WORM, LRS, GRS) | Full term + acronym on first use    | "Locally Redundant Storage (LRS)" |

### RP Namespace Names

- **MUST NOT** be code names, product abbreviations, or temporary names
- RP names are permanent and visible in resource IDs, SDKs, and documentation
- Choose a descriptive name that conveys what the RP does

---

## Common Property Names

The [Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/ConsiderationsForServiceDesign.md#common-names)
define preferred names for frequently used properties. Using these names
ensures consistency across Azure SDKs and documentation.

| Preferred name   | Purpose                                       | Antipatterns to flag                                          |
| ---------------- | --------------------------------------------- | ------------------------------------------------------------- |
| `createdAt`      | Date/time the resource was created            | `createTime`, `creationTime`, `timeCreated`, `createdDate`    |
| `lastModifiedAt` | Date/time the resource was last modified      | `lastModifiedTime`, `timeLastModified`, `modifiedDate`        |
| `deletedAt`      | Date/time the resource was deleted            | `deleteTime`, `deletionTime`, `timeDeleted`                   |
| `kind`           | Discriminator value for polymorphic resources | `type` (inside properties bag), `discriminator`, `objectType` |
| `etag`           | Entity tag for optimistic concurrency control | `eTag`, `ETag`, `e_tag`                                       |

### Resource Identifier Properties

- Properties that reference another ARM resource **MUST** use the suffix
  `Id` (e.g., `storageAccountId`, `poolResourceId`).
- **DO NOT** use suffix `Uri` or `Url` for ARM resource IDs -- these
  are not URIs/URLs, they are ARM resource paths.
- **DO NOT** use suffix `Name` alone when the full resource ID is
  needed. A resource ID enables linked access checks and is unambiguous
  across subscriptions.

### Date/Time Format

All date/time properties **MUST** use RFC 3339 format with
`"format": "date-time"` (OpenAPI) or `utcDateTime` (TypeSpec). Do not
use Unix timestamps, custom date formats, or unformatted strings for
date/time values.

---

## Plural vs. Singular

- Properties that are **arrays** MUST have **plural** names (`scopes`, `rules`, `addresses`)
- Properties that are **scalars** (string, object, boolean) SHOULD use **singular** names
- A plural name on a non-array type (e.g., `deploymentErrors: string`) is confusing and should be flagged

---

## Description Quality

- Every operation, parameter, property, model, enum value, and union
  member **MUST** have a non-empty description or doc comment.
- Descriptions **MUST NOT** simply repeat the element name (e.g., `"name": { "description": "name" }` is not acceptable).
- Descriptions **SHOULD** start with a capital letter and end with a period.
- Specify units for quantifiable properties (e.g., "The timeout in seconds.", "The size in megabytes.").
- PUT operation descriptions **MUST NOT** imply non-idempotent behavior. Use "Creates or updates..." not "Creates a new...".
- Avoid: "Gets or sets...", "Gets...", "Sets..." in property descriptions -- describe what the property represents.

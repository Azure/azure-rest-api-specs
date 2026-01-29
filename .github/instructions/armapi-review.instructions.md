---
applyTo: "**/specification/**/resource-manager/*.json"
---

# ARM OpenAPI (Swagger) Review Instructions

When reviewing Azure Resource Manager (ARM) OpenAPI specifications, ensure compliance with Microsoft API
Guidelines and Azure RPC contracts. Prioritize Azure RPC requirements when conflicts arise.

## Critical Requirements

### 1. API Guidelines Compliance

- **MUST** follow [Azure REST API Guidelines]
  (https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)
- **MUST** conform to [Azure RPC contracts]
  (https://github.com/cloud-and-ai-microsoft/resource-provider-contract)
- Azure RPC takes precedence over general guidelines in case of conflicts

### 2. Breaking Changes Prevention

- **NO breaking changes** in GA (stable) API versions per
  [Azure Breaking Changes Policy](https://aka.ms/AzBreakingChangesPolicy)
- Verify no removal/renaming of properties, operations, or parameters in existing versions
- Check property types remain unchanged (e.g., boolean → string is breaking)
- Ensure enum values are not removed or renamed
- New required properties or parameters require new API version
- URL path format changes require new API version

### 3. ARM Resource Model Requirements

- Resource model name **MUST** match singular form of resource type (e.g., `VirtualMachine` for `virtualMachines`)
- Top-level resources **MUST** have `ListByResourceGroup` and `ListBySubscription` operations
- Tracked resources **MUST** have GET, PUT, PATCH (update), and DELETE operations
- All resources **MUST** include `systemData` property (read-only) with type from common-types
- Nested resources **MUST** have List operation

### 4. Common Types Usage

- **MUST** reference appropriate common-types version (v3, v4, or v5) for standard ARM types:
  - `Resource`, `TrackedResource`, `ProxyResource`, `ExtensionResource`
  - `ErrorResponse`, `ErrorDetail`
  - Standard parameters: `SubscriptionIdParameter`, `ResourceGroupNameParameter`, `ApiVersionParameter`
- Use `$ref` to common-types instead of redefining standard ARM structures

### 5. API Versioning

- API version **MUST** follow `YYYY-MM-DD` format
- Version **MUST** be in path:
  `/subscriptions/{subscriptionId}/providers/Microsoft.{Namespace}/...?api-version=YYYY-MM-DD`
- Stable versions in `/stable/` directory, preview in `/preview/`

### 6. Security & Authentication

- **MUST** define `securityDefinitions` with OAuth2 Azure AD authentication
- **MUST** apply `security` requirement to all operations
- Scopes should use `user_impersonation` for management plane

### 7. Property & Parameter Correctness

- Mark required parameters as `"required": true` - incorrect marking breaks customers
- Mark read-only properties as `"readOnly": true` (e.g., `id`, `name`, `type`, `systemData`)
- Use `x-ms-mutability` to specify create/read/update behavior
- Collections **MUST** support multiple elements, not artificially limited to one
- Only define operations/properties/parameters actually supported by the service

### 8. Naming Conventions

- Properties and parameters: **camelCase** (e.g., `resourceGroupName`)
- Resource types in path: **camelCase** (e.g., `/virtualMachines/{virtualMachineName}`)
- Resource provider namespace: **PascalCase** (e.g., `Microsoft.Compute`)
- Model definitions: **PascalCase** (e.g., `VirtualMachine`)
- Enum values: **PascalCase** preferred
- Avoid abbreviations in names unless industry-standard
- Use resource name, not abbreviations, in path parameters: `{virtualMachineName}` not `{vmName}`

### 9. Operations & Operation IDs

- OperationId format: `{ResourceType}_{Action}` (e.g., `VirtualMachines_Get`, `VirtualMachines_CreateOrUpdate`)
- Operations **MUST** have unique `operationId`
- Use standard verbs: GET → `Get/List`, PUT → `CreateOrUpdate`, PATCH → `Update`, DELETE → `Delete`, POST → action name
- Include `x-ms-examples` referencing example JSON files
- DELETE operations: return 200 (with body), 202 (async), or 204 (no content)
- Long-running operations: use `x-ms-long-running-operation: true` and return 201 or 202

### 10. Pagination & Collections

- List operations **MUST** use `x-ms-pageable` with `nextLinkName`
- Collection models **MUST** have `value` array property and optional `nextLink` string

### 11. Documentation Quality

- Every operation, parameter, property, and model **MUST** have clear description
- Start operation descriptions with verb (e.g., "Gets the virtual machine.")
- Start with capital letter, end with period
- Specify units for quantifiable properties (MB, seconds, etc.)
- Use correct acronym capitalization: "URL" not "Url", "ID" not "Id"
- Avoid: "Gets or sets...", "Gets...", "Sets..." in property descriptions
- Document all HTTP status codes in responses

### 12. Error Handling

- Default error response **MUST** reference common-types `ErrorResponse`
- Include "default" response for all operations
- Use `x-ms-error-response: true` for error responses

### 13. Extensions & Special Features

- **REQUIRED**: `x-ms-parameter-location: "method"` for common parameters
  (subscriptionId, resourceGroupName, apiVersion)
- Use `x-ms-enum` with `modelAsString: true` for extensible enums (allows new values without breaking)
- Use `x-ms-discriminator-value` for polymorphic types
- Private/internal operations: mark with `x-ms-visibility: "internal"`

### 14. Customer Usability

Think as a customer: Are parameter names intuitive? Is required vs. optional clear? Are default values
documented? Can developers understand how to use this API from the specification alone?

### 15. Examples & Testing

- **MUST** include `x-ms-examples` for all operations
- Example files in `examples/` directory
- **MUST** test all operations before PR submission
- Examples **MUST** validate against specification

## Review Checklist Summary

✓ No breaking changes in existing versions  
✓ Follows Azure RPC contracts  
✓ Common-types properly referenced  
✓ Naming conventions (camelCase properties, PascalCase types)  
✓ Required/readOnly correctly marked  
✓ Security definitions present  
✓ Standard ARM operations implemented  
✓ Pagination on list operations  
✓ Operation IDs follow pattern  
✓ Examples provided and valid  
✓ Descriptions clear and complete  
✓ API version format correct

Flag violations clearly with line numbers and specific guidance for fixes.
Once completed always add the following comment : "Copilot used the entire file : .github/instructions/armapi-review.instructions.md for arm api reviews."

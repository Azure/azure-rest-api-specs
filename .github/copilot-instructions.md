# New TypeSpec projects

Refer to [new-typespec-project.instructions.md](./instructions/typespec-project.instructions.md) for detailed steps on:
 - how to create a new TypeSpec project.
 - converting a specification from swagger to typespec
 - troubleshooting tsp compile errors

# Adding Language Emitters to Existing TypeSpec Projects

Refer to [language-emitter.instructions.md](./instructions/language-emitter.instructions.md) for detailed steps on how to add language emitters to an existing `tspconfig.yaml` file in a TypeSpec project.

# SDK generation from TypeSpec

You must use Azure SDK MCP server to generate SDK from TypeSpec.

Refer to [sdk-generation.instructions.md](./instructions/sdk-generation.instructions.md) for additional instructions to generate SDK from TypeSpec.

# Instructions for GitHub coding agent to generate SDKs using GitHub.com

Follow [github-codingagent.instructions.md](./instructions/github-codingagent.instructions.md) for instructions to run SDK generation using pipeline in GitHub coding agent.

# Release readiness of SDK and information about the release pipeline

Run [check package readiness](../eng/common/instructions/azsdk-tools/check-package-readiness.instructions.md) to check the release readiness of an SDK package. This prompt will collect the required information from the user, execute the readiness check, and present the results.

# Up-to-date TypeSpec documentation

Follow [typespec docs](../eng/common/instructions/azsdk-tools/typespec-docs.instructions.md) to get the most up-to-date documentation for TypeSpec, including best practices for writing TypeSpec for Azure.

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

# Copilot Instructions for Azure REST API Specs PR Reviews

## Purpose

This document provides guidance for GitHub Copilot to conduct thorough manual-style reviews of pull requests (PRs) submitted to the [azure-rest-api-specs](https://github.com/Azure/azure-rest-api-specs) repository. The goal is to ensure all OpenAPI specifications and ARM Resource Provider (RP) contracts comply with the **Azure REST API Guidelines** and **Azure REST Design Guidelines v3.0**, reducing the need for manual reviewer intervention.

---

## Review Objectives

When reviewing PRs in this repository, Copilot should:

1. **Verify compliance** with the GitHub-hosted Azure REST API Guidelines and Azure REST Design Guidelines v3.0
2. **Identify guideline violations** in OpenAPI specifications (Swagger/OpenAPI 2.0 and 3.x)
3. **Check ARM RP contract adherence** for management plane APIs
4. **Flag breaking changes** that could impact existing customers
5. **Ensure consistency** across API versions and service specifications
6. **Validate documentation quality** and completeness

---

## Primary Guideline References

### Core Guidelines (MUST Follow)
- **[Microsoft Azure REST API Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)** - Comprehensive data plane API design guidance
- **[Azure REST API Versioning Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/VersioningGuidelines.md)** - API versioning and compatibility requirements
- **[Azure Resource Manager Resource Provider Contract (RPC)](https://github.com/AzureExpert/azure-resource-manager-rpc)** - Management plane (ARM) API contracts

### Repository-Specific Guidelines (SHOULD Follow)
- **[OpenAPI Authoring Manual Guidelines](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/openapi-authoring-manual-guidelines.md)** - Repository-specific OpenAPI authoring standards
- **[Swagger Checklist](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/swagger-checklist.md)** - Pre-submission checklist for specs
- **[Breaking Changes Guidelines](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Breaking%20changes%20guidelines.md)** - Guidance on avoiding breaking changes

---

## Review Categories and Key Checks

### 1. **API Versioning and Compatibility**

**Guideline Reference:** [Azure Versioning Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/VersioningGuidelines.md)

#### What to Check:
- ✅ **API version format**: Must use `YYYY-MM-DD` or `YYYY-MM-DD-preview` format
- ✅ **Non-breaking changes**: Ensure changes don't break existing client code
  - Adding optional properties is safe
  - Removing required properties is breaking
  - Changing property types is breaking
  - Changing response status codes is breaking
- ✅ **Version consistency**: All operations within a spec should use the same API version
- ✅ **Stable vs preview versioning**: Preview versions should use `-preview` suffix

#### Example Violations:
❌ Changing a required property to optional in a stable API version  
❌ Using version format like `v1` or `2024.01` instead of `2024-01-01`  
❌ Removing a property from a response model in an existing version

---

### 2. **HTTP Methods and Resource URIs**

**Guideline Reference:** [Azure REST API Guidelines - Building Blocks](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#building-blocks-http-rest--json)

#### What to Check:
- ✅ **URI structure**: Follow RESTful patterns (`/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{namespace}/{resourceType}/{resourceName}`)
- ✅ **HTTP verb usage**:
  - `GET` for retrieval (must be idempotent, no side effects)
  - `PUT` for create/replace (idempotent)
  - `PATCH` for partial updates
  - `POST` for actions, non-idempotent creates
  - `DELETE` for resource deletion
- ✅ **Case sensitivity**: Resource names should be case-insensitive
- ✅ **Plural vs singular**: Collection endpoints use plurals, item endpoints use singular

#### Example Violations:
❌ Using `POST` for resource retrieval  
❌ Using `GET` with a request body  
❌ URI paths like `/getUsers` or `/createResource` (not RESTful)  
❌ Inconsistent casing in paths (`/resourceGroups` vs `/ResourceGroups`)

---

### 3. **ARM Resource Provider (RP) Contracts**

**Guideline Reference:** [ARM RPC](https://github.com/AzureExpert/azure-resource-manager-rpc)

#### What to Check for ARM Management Plane APIs:
- ✅ **Standard operations**: All Tracked Resources must support:
  - `GET` (read)
  - `PUT` (create/update)
  - `PATCH` (for tags at minimum)
  - `DELETE`
  - `LIST` (by resource group and by subscription)
- ✅ **Common headers**: Include standard ARM headers:
  - `x-ms-correlation-request-id`
  - `x-ms-client-request-id`
  - `x-ms-return-client-request-id`
- ✅ **Subscription lifecycle**: Implement required subscription registration endpoints
- ✅ **Error response format**: Follow standard Azure error schema
- ✅ **Long-running operations (LROs)**: Must use standard patterns with `Azure-AsyncOperation` or `Location` headers

#### Example Violations:
❌ Tracked Resource missing `PATCH` operation for tags  
❌ Missing required ARM headers in operation definitions  
❌ LRO not returning `202 Accepted` with proper location headers  
❌ Non-standard error response structure

---

### 4. **Request and Response Schemas**

**Guideline Reference:** [Azure REST API Guidelines - JSON](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)

#### What to Check:
- ✅ **Property naming**: Use camelCase for JSON properties
- ✅ **Read-only properties**: Mark server-generated fields as `readOnly: true`
- ✅ **Required vs optional**: Clearly distinguish required from optional properties
- ✅ **Enums**: Use consistent enum values (avoid changing existing enum members)
- ✅ **Date-time format**: Use RFC3339/ISO8601 format for dates (`date-time` format)
- ✅ **Resource envelope**: ARM resources must include `id`, `name`, `type`, `location` (for tracked resources)

#### Example Violations:
❌ Using `snake_case` or `PascalCase` for JSON property names  
❌ Missing `readOnly: true` for properties like `id`, `provisioningState`  
❌ Adding new required properties to existing models  
❌ Inconsistent enum casing (e.g., `Running` vs `running`)

---

### 5. **Error Handling and Status Codes**

**Guideline Reference:** [Azure REST API Guidelines - Error Response](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)

#### What to Check:
- ✅ **Standard error format**: All errors must use the Azure error schema:
  ```json
  {
    "error": {
      "code": "ErrorCode",
      "message": "Human-readable error message",
      "target": "PropertyName",
      "details": [],
      "innererror": {}
    }
  }
  ```
- ✅ **HTTP status codes**: Use appropriate codes:
  - `200 OK` - Successful GET, synchronous PUT/PATCH/DELETE
  - `201 Created` - Resource successfully created
  - `202 Accepted` - Long-running operation started
  - `204 No Content` - Successful DELETE with no response body
  - `400 Bad Request` - Invalid request
  - `401 Unauthorized` - Authentication required
  - `403 Forbidden` - Authorization failed
  - `404 Not Found` - Resource doesn't exist
  - `409 Conflict` - Conflict with current state
  - `412 Precondition Failed` - Conditional request failed
  - `429 Too Many Requests` - Rate limiting
  - `500 Internal Server Error` - Server error
  - `503 Service Unavailable` - Service temporarily unavailable

#### Example Violations:
❌ Returning `200 OK` for errors with error object in body  
❌ Using custom error response structure instead of standard Azure format  
❌ Missing error definitions for operations  
❌ Using `500` for client errors (should be 4xx)

---

### 6. **Long-Running Operations (LROs)**

**Guideline Reference:** [Azure REST API Guidelines - LRO](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)

#### What to Check:
- ✅ **Initial response**: Return `202 Accepted` for async operations
- ✅ **Location headers**: Include one or both:
  - `Azure-AsyncOperation` - status monitor endpoint
  - `Location` - final result endpoint
- ✅ **Retry-After header**: Include recommended polling interval
- ✅ **Status monitor response**: Should include `status` field with terminal states: `Succeeded`, `Failed`, `Canceled`
- ✅ **x-ms-long-running-operation**: Extension must be set to `true`
- ✅ **Polling pattern**: Clearly document polling behavior

#### Example Violations:
❌ Async operation not returning `202 Accepted`  
❌ Missing `Azure-AsyncOperation` or `Location` header  
❌ Status monitor returning non-standard status values  
❌ Missing `x-ms-long-running-operation: true` extension

---

### 7. **Pagination and Collections**

**Guideline Reference:** [Azure REST API Guidelines - Collections](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)

#### What to Check:
- ✅ **List operations**: Should return collection with `value` array
- ✅ **Next link**: Include `nextLink` for paginated results
- ✅ **x-ms-pageable extension**: Must be present with `nextLinkName` property
- ✅ **Page size**: Support `$top` query parameter (optional but recommended)
- ✅ **Stable pagination**: Results should remain consistent during pagination

#### Example Violations:
❌ List operation returning array directly instead of object with `value` property  
❌ Missing `x-ms-pageable` extension  
❌ Using custom property name instead of `nextLink`  
❌ Not handling continuation tokens properly

---

### 8. **Conditional Requests and Concurrency**

**Guideline Reference:** [Azure REST API Guidelines - Conditional Requests](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)

#### What to Check:
- ✅ **ETag support**: Resources should support ETags for optimistic concurrency
- ✅ **If-Match header**: Support for conditional updates
- ✅ **If-None-Match header**: Support for conditional reads
- ✅ **412 Precondition Failed**: Return when conditional check fails
- ✅ **304 Not Modified**: Return for conditional GET when content unchanged

#### Example Violations:
❌ Missing ETag in response headers  
❌ Not supporting `If-Match` for PUT/PATCH operations  
❌ Not validating ETags properly  
❌ Missing `304 Not Modified` support for GET operations

---

### 9. **Authentication and Authorization**

**Guideline Reference:** [Azure REST API Guidelines - Security](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)

#### What to Check:
- ✅ **OAuth 2.0**: All operations must require Bearer token authentication
- ✅ **Security definitions**: OpenAPI spec must include `azure_auth` security scheme
- ✅ **Scopes**: Define appropriate OAuth scopes
- ✅ **Authorization failures**: Return `401 Unauthorized` or `403 Forbidden` appropriately

#### Example Violations:
❌ Missing security definitions in spec  
❌ Operations not requiring authentication  
❌ Using custom authentication schemes  
❌ Incorrect use of 401 vs 403 status codes

---

### 10. **Documentation and Descriptions**

**Guideline Reference:** [OpenAPI Authoring Manual Guidelines](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/openapi-authoring-manual-guidelines.md)

#### What to Check:
- ✅ **Operation summaries**: Clear, concise descriptions of what each operation does
- ✅ **Parameter descriptions**: Document purpose and constraints of all parameters
- ✅ **Response descriptions**: Explain what each response code means
- ✅ **Property descriptions**: Document all schema properties
- ✅ **Examples**: Include `x-ms-examples` for all operations
- ✅ **Deprecation notices**: Mark deprecated operations/properties with `deprecated: true` and explanation

#### Example Violations:
❌ Missing descriptions for operations, parameters, or properties  
❌ Generic or placeholder descriptions ("TODO", "Description here")  
❌ Missing examples for operations  
❌ Deprecated elements without clear guidance for alternatives

---

### 11. **OpenAPI Extensions**

**Guideline Reference:** [Swagger Extensions](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/swagger-extensions.md)

#### What to Check:
- ✅ **x-ms-examples**: Every operation should have examples
- ✅ **x-ms-pageable**: Required for list operations
- ✅ **x-ms-long-running-operation**: Required for async operations
- ✅ **x-ms-azure-resource**: Mark ARM resources appropriately
- ✅ **x-ms-parameter-location**: For client-level parameters
- ✅ **x-ms-client-name**: When property names should differ in SDK
- ✅ **x-ms-enum**: For enums with additional metadata
- ✅ **x-ms-discriminator-value**: For polymorphic types

#### Example Violations:
❌ Missing required extensions for ARM operations  
❌ Incorrect extension usage or values  
❌ Using deprecated extension patterns

---

### 12. **Breaking Changes Detection**

**Guideline Reference:** [Breaking Changes Guidelines](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Breaking%20changes%20guidelines.md)

#### What to Check:
**Breaking Changes (❌ DO NOT ALLOW in stable APIs):**
- Removing or renaming operations
- Removing or renaming parameters or properties
- Changing parameter/property types
- Making optional parameters required
- Removing enum values
- Changing HTTP methods
- Changing resource URIs
- Changing response status codes

**Safe Changes (✅ ALLOWED):**
- Adding new operations
- Adding optional parameters or properties
- Adding new enum values (at the end)
- Adding new error codes
- Clarifying documentation

#### Example Breaking Changes to Flag:
❌ Removing a property from response model  
❌ Renaming an operation or parameter  
❌ Changing property from `string` to `integer`  
❌ Making optional property required

---

## Review Process

### Step 1: Initial Assessment
1. **Identify the API type**: Management plane (ARM) vs Data plane
2. **Check API version**: New version or modification to existing version
3. **Determine stability**: Preview vs stable API

### Step 2: Specification Structure Review
1. **Validate OpenAPI format**: Ensure valid OpenAPI 2.0/3.x JSON/YAML
2. **Check file organization**: Follows repository structure guidelines
3. **Review metadata**: Correct `info` section with version, title, description

### Step 3: Detailed Compliance Review
For each operation in the specification:
1. **Review URI patterns** against section 2
2. **Validate HTTP methods** against section 2
3. **Check request/response schemas** against section 4
4. **Verify error responses** against section 5
5. **Validate ARM RP compliance** (if management plane) against section 3
6. **Review LRO patterns** (if applicable) against section 6
7. **Check pagination** (for list operations) against section 7
8. **Verify extensions** against section 11

### Step 4: Breaking Changes Analysis
1. **Compare with previous versions** (if modifying existing API)
2. **Flag any breaking changes** per section 12
3. **Recommend alternative approaches** for necessary changes

### Step 5: Documentation Quality Check
1. **Verify descriptions** per section 10
2. **Check examples** per section 11
3. **Review consistency** across operations

### Step 6: Generate Review Summary
Provide structured feedback with:
- **Critical Issues**: Must be fixed before merge
- **Warnings**: Should be addressed but not blocking
- **Suggestions**: Improvements for consideration
- **Compliant Items**: Highlight what's done well

---

## Review Comment Template

When providing feedback, use this structure:

```markdown
## Review Summary

### Critical Issues (Must Fix)
1. **[Category]** [Brief description]
   - **Location**: `path/to/file.json#/paths/.../operationId`
   - **Issue**: [Detailed explanation]
   - **Guideline**: [Link to specific guideline section]
   - **Fix**: [Specific remediation steps]

### Warnings (Should Fix)
[Same structure as Critical Issues]

### Suggestions (Consider)
[Same structure as Critical Issues]

### Compliant Items ✅
- [List of things done correctly]

### Additional Resources
- [Relevant guideline links]
- [Example specifications that follow best practices]
```

---

## Key Compliance Summary Table

| Review Category | Guideline Reference | Key Checks |
|----------------|-------------------|-----------|
| **Versioning** | [Azure Versioning Guidelines](https://github.com/microsoft/api-guidelines/blob/vNext/azure/VersioningGuidelines.md) | `YYYY-MM-DD` format, non-breaking changes, stable vs preview |
| **HTTP Methods** | [Azure REST Guidelines - HTTP](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) | Correct verb usage, idempotency, RESTful URIs |
| **ARM RP Contracts** | [ARM RPC](https://github.com/AzureExpert/azure-resource-manager-rpc) | Standard operations, ARM headers, subscription lifecycle |
| **Schemas** | [Azure REST Guidelines - JSON](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) | camelCase properties, readOnly fields, resource envelopes |
| **Error Handling** | [Azure REST Guidelines - Errors](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) | Standard error format, appropriate status codes |
| **LRO Patterns** | [Azure REST Guidelines - LRO](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) | `202 Accepted`, location headers, status monitors |
| **Pagination** | [Azure REST Guidelines - Collections](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) | `value` array, `nextLink`, `x-ms-pageable` |
| **Concurrency** | [Azure REST Guidelines - ETags](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) | ETag support, conditional headers, optimistic concurrency |
| **Authentication** | [Azure REST Guidelines - Security](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md) | OAuth 2.0, security definitions, proper 401/403 usage |
| **Documentation** | [OpenAPI Manual Guidelines](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/openapi-authoring-manual-guidelines.md) | Complete descriptions, examples, deprecation notices |
| **Extensions** | [Swagger Extensions](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/swagger-extensions.md) | Required x-ms-* extensions, correct usage |
| **Breaking Changes** | [Breaking Changes Guidelines](https://github.com/Azure/azure-rest-api-specs/blob/main/documentation/Breaking%20changes%20guidelines.md) | No breaking changes in stable APIs, safe evolution patterns |

---

## Common Patterns and Best Practices

### ✅ Good Examples

**Good ARM Resource PUT Operation:**
```json
{
  "operationId": "Widgets_CreateOrUpdate",
  "summary": "Creates or updates a widget resource",
  "parameters": [
    {
      "name": "resourceGroupName",
      "in": "path",
      "required": true,
      "type": "string"
    },
    {
      "name": "widgetName",
      "in": "path",
      "required": true,
      "type": "string"
    },
    {
      "name": "api-version",
      "in": "query",
      "required": true,
      "type": "string"
    }
  ],
  "responses": {
    "200": {
      "description": "Successfully updated existing widget",
      "schema": { "$ref": "#/definitions/Widget" }
    },
    "201": {
      "description": "Successfully created new widget",
      "schema": { "$ref": "#/definitions/Widget" }
    }
  },
  "x-ms-long-running-operation": true
}
```

**Good Error Response Schema:**
```json
{
  "error": {
    "code": "InvalidResourceName",
    "message": "The resource name 'test@name' is invalid. Resource names must contain only alphanumeric characters and hyphens.",
    "target": "widgetName",
    "details": [
      {
        "code": "InvalidCharacter",
        "message": "The character '@' is not allowed in resource names."
      }
    ]
  }
}
```

### ❌ Common Mistakes to Flag

**Bad HTTP Verb Usage:**
```json
// ❌ BAD: Using GET with request body
{
  "operationId": "Widgets_Search",
  "method": "GET",
  "parameters": [
    {
      "name": "searchCriteria",
      "in": "body",
      "schema": { "$ref": "#/definitions/SearchRequest" }
    }
  ]
}
// ✅ GOOD: Use POST for searches with complex request bodies
```

**Bad Property Naming:**
```json
// ❌ BAD: Mixed casing
{
  "widget_name": "string",  // snake_case
  "WidgetStatus": "string",  // PascalCase
  "createdAt": "string"      // camelCase (correct)
}
// ✅ GOOD: Consistent camelCase
{
  "widgetName": "string",
  "widgetStatus": "string",
  "createdAt": "string"
}
```

---

## Automated Checks vs Manual Review

While automated linters catch many issues, your manual review should focus on:

### Automated Linter Coverage (already checked by CI):
- JSON/YAML syntax validation
- OpenAPI schema validation
- Basic naming convention violations
- Missing required fields
- Some extension usage

### Your Manual Review Focus (not fully automated):
- ✅ **Semantic correctness**: Does the API make sense?
- ✅ **Design patterns**: Are RESTful principles followed?
- ✅ **Breaking changes**: Context-aware compatibility checks
- ✅ **Documentation quality**: Are descriptions clear and helpful?
- ✅ **Business logic**: Do operations align with service capabilities?
- ✅ **User experience**: Is the API intuitive and consistent?
- ✅ **Performance considerations**: Are pagination and LRO patterns appropriate?
- ✅ **Security implications**: Are there authorization or data exposure concerns?

---

## Prioritization Guide

When multiple issues are found, prioritize feedback as follows:

### P0 - Critical (Must Fix Before Merge)
1. Breaking changes in stable APIs
2. Incorrect HTTP status codes
3. Missing required ARM operations
4. Security vulnerabilities
5. Malformed error responses
6. Invalid API version formats

### P1 - High Priority (Should Fix)
1. Missing or incomplete documentation
2. Incorrect HTTP verb usage
3. Missing pagination support
4. Improper LRO implementation
5. Missing ETag support for concurrency
6. Inconsistent naming patterns

### P2 - Medium Priority (Recommended)
1. Missing optional best practices
2. Documentation improvements
3. Additional examples needed
4. Optimization opportunities

### P3 - Low Priority (Nice to Have)
1. Style consistency improvements
2. Enhanced descriptions
3. Additional metadata

---

## Response Tone and Approach

- **Be specific**: Point to exact line numbers, operation IDs, or property names
- **Be constructive**: Explain why something violates guidelines and how to fix it
- **Be educational**: Include links to relevant guideline sections
- **Be encouraging**: Acknowledge what's done well
- **Be consistent**: Apply the same standards across all reviews
- **Be pragmatic**: Understand that some legacy patterns may have valid suppressions

---

## Special Considerations

### Preview APIs
- More flexibility with breaking changes
- Must use `-preview` suffix in version
- Can iterate more rapidly
- Still require high-quality documentation

### Grandfathered Patterns
- Some older services may have approved deviations
- Check for suppression files in the repo
- Note if pattern conflicts with current guidelines but is intentionally allowed

### TypeSpec-Generated Specs
- TypeSpec is the source of truth
- OpenAPI specs are generated
- Review focus should be on TypeSpec authoring if both are present
- Reference TypeSpec Azure guidelines for these cases

---

## Final Checklist

Before completing your review, confirm:

- [ ] All critical compliance issues are identified
- [ ] Breaking changes are flagged (if applicable)
- [ ] ARM RP contract requirements are verified (if management plane)
- [ ] Documentation quality is assessed
- [ ] Specific, actionable feedback is provided
- [ ] Guideline references are included
- [ ] Priority levels are assigned
- [ ] Positive aspects are acknowledged
- [ ] Always add a comment that says "I am using the co pilot instructions from the root of the folder"


---

## Additional Resources

- **[Azure REST API Guidelines (Main)](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md)**
- **[Azure REST API Versioning](https://github.com/microsoft/api-guidelines/blob/vNext/azure/VersioningGuidelines.md)**
- **[Considerations for Service Design](https://github.com/microsoft/api-guidelines/blob/vNext/azure/ConsiderationsForServiceDesign.md)**
- **[ARM Resource Provider Contract](https://github.com/AzureExpert/azure-resource-manager-rpc)**
- **[OpenAPI Specification 2.0](https://swagger.io/specification/v2/)**
- **[OpenAPI Specification 3.0](https://swagger.io/specification/)**
- **[Azure REST API Specs Repository](https://github.com/Azure/azure-rest-api-specs)**

---

## Contact and Escalation

For complex or ambiguous cases:
- Reference the Azure API Stewardship Board guidance
- Check for existing GitHub issues or discussions in the repo
- Consult the repository's CONTRIBUTING.md for escalation paths
- When in doubt, err on the side of caution and flag potential issues

---

*Last Updated: 2025-12-26*
*Version: 1.0*

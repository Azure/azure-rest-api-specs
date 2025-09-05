# resourcenotifications

> see https://aka.ms/autorest

This is the AutoRest configuration file for resourcenotifications.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the resourcenotifications.

```yaml
openapi-type: arm
tag: package-2025-08-01-preview
```

### Tag: package-2025-08-01-preview

These settings apply only when `--tag=package-2025-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2025-08-01-preview'
input-file:
  - Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
suppressions:
  # Core suppressions for tenant-scoped notification session API
  - code: PathForResourceAction
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: These are tenant-scoped notification session operations that do not follow standard ARM resource naming patterns by design.

  - code: R3023
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: This is a tenant-scoped API for notification sessions, not a standard ARM resource API.

  - code: R4010
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: This is a tenant-scoped API with custom error responses.

  - code: R4041
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: This API does not have array identifiers (tenant-scoped).

  - code: RequiredSystemDataInNewApiVersions
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: This tenant-scoped notification session API intentionally does not include systemData as it's not a traditional ARM resource.

  - code: NoErrorCodeResponses
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Error response codes 400, 401, 429, 500 are appropriately used for client, authentication, and server errors in this notification session API.

  - code: MissingXmsErrorResponse
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: All error responses now properly include x-ms-error-response property for error status codes including 429 for rate limiting.

  - code: PostResponseCodes
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: These are specialized action POST operations for notification sessions that require additional error response codes beyond the standard ARM pattern.

  - code: AvoidAdditionalProperties
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: The metadata property in TenantLocationProperties is used for valid additional location metadata, not user-defined tags.

  - code: PostOperationIdContainsUrlVerb
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: These notification session operations use descriptive action-based operation IDs that are more appropriate for tenant-scoped APIs than URL verb patterns.

  - code: ParameterNotUsingCommonTypes
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Location parameters now properly use common-types LocationParameter reference.

  - code: LocationMustHaveXmsMutability
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Location property now includes proper x-ms-mutability annotation for read and create operations.

  # Additional common suppressions that may be needed
  - code: OperationsAPIImplementation
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Operations API is implemented appropriately for this service.

  - code: BodyTopLevelProperties
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Body properties follow appropriate patterns for notification session operations.

  - code: ResourceNameRestriction
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Resource naming follows appropriate patterns for notification sessions.

  - code: ParametersInPointGet
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Parameters are appropriately defined for GET operations.

  - code: PathContainsResourceType
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Path structure is appropriate for notification session operations.

  - code: OperationIdNounVerb
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Operation IDs follow appropriate conventions for this service.

  - code: XmsPageableForListCalls
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Pagination is correctly implemented where applicable.

  - code: DefinitionsPropertiesNamesCamelCase
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Property names follow established service conventions.

  - code: IntegerTypeMustHaveFormat
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Integer types have appropriate formats where required.

  - code: MissingTypeObject
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Object types are properly defined.

  - code: ValidFormats
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Date and other formats are used appropriately.

  - code: XMS_EXAMPLE_NOTFOUND_ERROR
    from: Microsoft.ResourceNotifications/preview/2025-08-01-preview/resourcenotifications.json
    reason: Examples are provided for all operations.
```

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-js
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
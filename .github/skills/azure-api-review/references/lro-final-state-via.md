<!-- Upstream alignment: 2026-09-10
     This date is for maintainers of this file only -- it records when
     rules were last verified against upstream docs. No action is needed
     by spec authors or PR reviewers. -->

# ARM LRO Headers, Results, and `final-state-via`

This reference explains how ARM long-running operations model initial response
headers, logical results, polling, and final result retrieval. It also clarifies
the generated `x-ms-long-running-operation-options` and `final-state-via`
metadata.

**Authoritative references:**

- [Azure REST API Guidelines -- Long-Running Operations](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#long-running-operations--jobs)
- [Azure Resource Provider Contract -- Async Operations](https://eng.ms/docs/products/arm/api_contracts/resource-provider-contract/v10/async-api-reference)
- [TypeSpec Azure -- Customizing ARM Long-Running Operations](https://azure.github.io/typespec-azure/docs/howtos/arm/long-running-operations/)
- [AutoRest LRO Extension docs](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-long-running-operation)

---

## TypeSpec Source of Truth

Use an asynchronous `Azure.ResourceManager` operation template to model an ARM
LRO. The templates provide the correct defaults and expose an `LroHeaders`
template parameter when the service contract requires different initial
response headers. Do not add raw OpenAPI extensions to reproduce generated
`x-ms-long-running-operation` metadata.

The available ARM header models are:

| Header model                               | Initial response headers              |
| ------------------------------------------ | ------------------------------------- |
| `ArmAsyncOperationHeader<FinalResult = T>` | `Azure-AsyncOperation`                |
| `ArmLroLocationHeader<FinalResult = T>`    | `Location`                            |
| `ArmCombinedLroHeaders<FinalResult = T>`   | `Azure-AsyncOperation` and `Location` |

When overriding `LroHeaders`, include
`Azure.Core.Foundations.RetryAfterHeader` and set `FinalResult` to the logical
result returned when the operation completes. The result is the resource or
action response type when the operation produces one, and `void` when it does
not. It is not automatically the status-monitor response type.

### ARM Template Defaults

| Operation                                                                | Default LRO headers       | Logical final result |
| ------------------------------------------------------------------------ | ------------------------- | -------------------- |
| PUT `ArmResourceCreateOrReplaceAsync` / `ArmResourceCreateOrUpdateAsync` | `ArmAsyncOperationHeader` | Resource type        |
| PATCH `ArmResourcePatchAsync` / `ArmCustomPatchAsync`                    | `ArmLroLocationHeader`    | Resource type        |
| DELETE `ArmResourceDeleteWithoutOkAsync`                                 | `ArmLroLocationHeader`    | `void`               |
| POST `ArmResourceActionAsync`                                            | `ArmLroLocationHeader`    | Action response type |
| POST `ArmResourceActionNoResponseContentAsync`                           | `ArmLroLocationHeader`    | `void`               |

Use a non-default header model only when the service contract or ARM policy
requires it. For example, an async POST action that returns both polling
headers and a response model can override the template as follows:

```tsp
op startMigration is ArmResourceActionAsync<
  MyResource,
  MigrationRequest,
  MigrationResponse,
  LroHeaders = ArmCombinedLroHeaders<FinalResult = MigrationResponse> &
    Azure.Core.Foundations.RetryAfterHeader
>;
```

ARM header requirements still apply independently of library defaults. Starting
January 2025, new RP namespace implementations must include
`Azure-AsyncOperation` on async PUT responses. Greenfield RP namespaces must
return both `Location` and `Azure-AsyncOperation` for async PATCH, DELETE, and
POST operations; brownfield namespaces are strongly recommended to add
`Azure-AsyncOperation`. Because the PATCH, DELETE, and POST templates default to
`Location` only, greenfield APIs must override them with
`ArmCombinedLroHeaders`. Validate the actual response contract before
recommending an override.

`@pollingOperation` and `@finalOperation` describe polling and final-operation
links for Azure.Core or custom status-monitor patterns. They are not blanket
replacements for ARM operation templates or their `LroHeaders` parameter.

---

## What `final-state-via` Actually Does

`final-state-via` is SDK-generation metadata, not an ARM response-header
requirement. Its effect on final-result retrieval depends on the HTTP method
and the SDK implementation. Do not infer the final response schema or
retrieval URL from this value alone.

In the inspected .NET and Python ARM polling implementations, polling endpoint
selection uses runtime response headers. For PUT/PATCH polled through
`Azure-AsyncOperation`, specifying `azure-async-operation` does not suppress
the normal final resource GET. After successful polling, these implementations
use `resourceLocation`, when provided, or the original resource URI. Their
skip-final-GET behavior for this option is restricted to POST.

For ordinary status-only DELETE operations with a void logical result,
completion does not require retrieving the deleted resource. For POST
operations, select final-result behavior that matches the service: use
`location` when the result comes from the Location endpoint, or
`azure-async-operation` when the completed status-monitor response is itself
the intended result.

## When to Specify `final-state-via`

| Scenario                                                                              | Review guidance                                                                                                                                                                                                        |
| ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **PUT/PATCH** -- standard ARM resource LRO                                            | Generated metadata is permitted. Verify the template, response headers, logical result, and any demonstrated SDK incompatibility; do not require the status monitor to contain the resource based on this value alone. |
| **DELETE** -- ordinary status-only operation with a void logical result               | Generated metadata is permitted. Verify the polling contract and void result; do not flag the metadata solely because it is present.                                                                                   |
| **POST action** -- returns `202` with response schema on `Location` header completion | Specify `"final-state-via": "location"` so the SDK deserializes from the Location URL. (Also enforced by: `LongRunningOperationsOptionsValidator` linter rule R2010)                                                   |
| **POST action** -- returns `202` and the status monitor itself contains the result    | Specify `"final-state-via": "azure-async-operation"`. This is rare.                                                                                                                                                    |

Standard Azure.ResourceManager templates may emit `final-state-via` for PUT,
PATCH, and DELETE. Its presence alone is not a review finding. Verify the async
template, declared response headers, logical `FinalResult`, and any
demonstrated SDK incompatibility. Do not require the status monitor to contain
the resource merely because a PUT emits `azure-async-operation`.

These implementation observations are not a guarantee that every option is
ignored outside POST or that all SDK versions behave identically.

### Implementation Evidence

Verified 2026-09-27:

- [.NET `NextLinkOperationImplementation`](https://github.com/Azure/azure-sdk-for-net/blob/a7e5ce4f39570b66be4aa2d211a33a2368a67ffc/sdk/core/Azure.Core/src/Shared/NextLinkOperationImplementation.cs)
  selects polling from runtime headers and restricts the
  `AzureAsyncOperation` skip-final-GET path to POST.
- [Python ARM polling](https://github.com/Azure/azure-sdk-for-python/blob/1053b0652a66b30d3d51844320b54af22600b50b/sdk/core/azure-mgmt-core/azure/mgmt/core/polling/arm_polling.py)
  likewise restricts that behavior to POST.
- [Python base polling](https://github.com/Azure/azure-sdk-for-python/blob/1053b0652a66b30d3d51844320b54af22600b50b/sdk/core/azure-core/azure/core/polling/base_polling.py)
  performs normal PUT/PATCH final retrieval from `resourceLocation` or the
  original request URL.

---

## Format-Specific Guidance

### OpenAPI JSON

When a POST LRO's final result comes from the Location endpoint:

```json
"x-ms-long-running-operation": true,
"x-ms-long-running-operation-options": {
  "final-state-via": "location"
}
```

Standard ARM PUT/PATCH/DELETE operations do not generally require a manually
supplied `final-state-via` override. Omission is acceptable when the default
behavior matches the contract; presence is not inherently incorrect. Preserve
valid TypeSpec-generated metadata. Do not hand-edit generated OpenAPI, remove
required polling headers, or require `emit-lro-options: none` solely to omit
this property. Preserve applicable POST LRO linter requirements.

### TypeSpec

Use the matching ARM async operation template. When its default headers do not
match the service contract, override `LroHeaders` and preserve the correct
logical result. For example, a DELETE operation that uses
`Azure-AsyncOperation` has no final response body:

```tsp
op delete is ArmResourceDeleteWithoutOkAsync<
  MyResource,
  LroHeaders = ArmAsyncOperationHeader<FinalResult = void> &
    Azure.Core.Foundations.RetryAfterHeader
>;
```

Do not override standard operations when their defaults already match the
service and ARM policy:

```tsp
createOrUpdate is ArmResourceCreateOrReplaceAsync<MyResource>;
delete is ArmResourceDeleteWithoutOkAsync<MyResource>;
```

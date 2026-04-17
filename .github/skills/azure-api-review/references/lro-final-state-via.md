<!-- Upstream alignment: 2026-04-15 -->

# LRO Polling and `final-state-via` Guidance

This reference clarifies the behavior of `x-ms-long-running-operation-options`
and `final-state-via`, and provides guidance on when (and when not) to specify
them.

**Authoritative references:**

- [Azure REST API Guidelines -- Long-Running Operations](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#long-running-operations--jobs)
- [Azure Resource Provider Contract -- Async Operations](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/master/v1.0/async-api-reference.md)
- [AutoRest LRO Extension docs](https://github.com/Azure/autorest/blob/master/docs/extensions/readme.md#x-ms-long-running-operation)

---

## What `final-state-via` Actually Does

`final-state-via` does **NOT** affect polling behavior. It only
determines **where** the SDK makes a final GET call to deserialize the
completed operation result.

Specifically:

1. **Polling** is determined by response headers at runtime -- if the
   `Azure-AsyncOperation` header is present the SDK polls on that URL;
   otherwise, if a `Location` header is present it polls there;
   otherwise it polls the resource URL via GET. The `final-state-via`
   property has **no influence** on this.
2. **After polling completes**, `final-state-via` tells the SDK where to
   make the final GET to retrieve the result object:
   - `"location"` -- GET the URL from the `Location` response header
   - `"azure-async-operation"` -- deserialize the status monitor
     response directly (no final GET)
   - `"original-uri"` -- GET the original resource URL

## When to Specify `final-state-via`

| Scenario                                                                              | Recommendation                                                                                                                                                       |
| ------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **PUT** (create/replace) -- returns `200`/`201` with `provisioningState`              | Do **NOT** specify `final-state-via`. Default behavior (GET on resource URL) is correct.                                                                             |
| **PATCH/DELETE** -- returns `202` with `Location` and `Azure-AsyncOperation`          | Do **NOT** specify `final-state-via`. Default behavior is correct for services following ARM RPC async guidelines.                                                   |
| **POST action** -- returns `202` with response schema on `Location` header completion | Specify `"final-state-via": "location"` so the SDK deserializes from the Location URL. (Also enforced by: `LongRunningOperationsOptionsValidator` linter rule R2010) |
| **POST action** -- returns `202` and the status monitor itself contains the result    | Specify `"final-state-via": "azure-async-operation"`. This is rare.                                                                                                  |

## Anti-Pattern: Specifying `"azure-async-operation"` on PUT

Setting `"final-state-via": "azure-async-operation"` on a PUT operation
is **incorrect** for most ARM resource providers. It instructs the SDK
to deserialize the operation status monitor as the final result instead
of the resource itself, which produces an incorrect return type.

**Do NOT** specify `"final-state-via": "azure-async-operation"` on PUT
or PATCH operations unless the service has a documented exception and
the status monitor response intentionally contains the full resource
representation.

## Anti-Pattern: Always Specifying `final-state-via`

For services following proper ARM LRO guidelines (PUT returns
`200`/`201` with `provisioningState`; PATCH/DELETE return `202` with
`Location` header), the default SDK behavior is already correct. Adding
`final-state-via` in these cases is unnecessary and can introduce
confusion.

**Rule of thumb:** Only specify `final-state-via` when the default
behavior would produce incorrect results -- typically only for POST
LROs with a response schema.

---

## Format-Specific Guidance

### OpenAPI JSON

When `final-state-via` is needed (POST LRO with response schema):

```json
"x-ms-long-running-operation": true,
"x-ms-long-running-operation-options": {
  "final-state-via": "location"
}
```

When it is NOT needed (PUT, PATCH, DELETE following standard ARM patterns):

```json
"x-ms-long-running-operation": true
```

Do not add `x-ms-long-running-operation-options` -- the default is correct.

### TypeSpec

When `final-state-via` is needed:

```tsp
@pollingOperation(GetOperationStatus)
@finalLocation(MyResource)
op myAction(...): AcceptedResponse;
```

When it is NOT needed (standard ARM resource operations):

```tsp
// ARM operation templates handle LRO correctly by default
createOrUpdate is ArmResourceCreateOrReplaceAsync<MyResource>;
delete is ArmResourceDeleteAsync<MyResource>;
```

# Cost Management Price Estimation

> see https://aka.ms/autorest

## Configuration

```yaml
openapi-type: arm
tag: package-2026-10-preview
```

### Tag: package-2026-10-preview

```yaml $(tag) == 'package-2026-10-preview'
input-file:
  - preview/2026-10-01-preview/openapi.json
suppressions:
  - code: BodyTopLevelProperties
    from:
      - openapi.json
    where:
      - $.definitions["EstimateResult"]
    reason: False alarm. EstimateResult is the final result of the estimatePrices POST action, not a resource. It appears in a GET only as the terminal 200 of that action's Location polling URL (estimatePricesOperationResults), which ARM requires to return the same body as the action's synchronous result.
  - code: RequiredPropertiesMissingInResourceModel
    from:
      - openapi.json
    where:
      - $.definitions["EstimateResult"]
    reason: False alarm. EstimateResult is an action result with no resource identity (no PUT, PATCH, DELETE or list); id, name and type do not apply. It appears in a GET only as the terminal 200 of the estimatePrices Location polling URL.
```

## Review scope

This is the public-preview, asynchronous `estimatePrices` API contract for the existing Non-RPaaS
`Microsoft.CostManagement` provider, using API version `2026-10-01-preview`. The specification targets the public
repository's `main` branch and is published under `preview/2026-10-01-preview`; this is not a GA release. It supersedes
the earlier `estimateCosts` draft (azure-rest-api-specs-pr#30664), which was renamed to `estimatePrices` and made
long-running.

The only new business operation is a subscription-scoped long-running action:

```http
POST /subscriptions/{subscriptionId}/providers/Microsoft.CostManagement/estimatePrices?api-version=2026-10-01-preview
```

The standard provider Operations listing is included for ARM tooling. This specification introduces no new resource
provider and does not change the existing CostManagement project's versions, operations, models or examples. The
implementation host is the existing pricing service. SDK emitter and package settings are included in
`tspconfig.yaml`; package names require the standard SDK architect approval. The default compilation emits OpenAPI.

## Long-running behavior

ARM's control-plane latency target requires a first response within one second, and pricing takes several seconds,
so the action follows the ARM asynchronous pattern with `final-state-via: location`:

1. The POST validates the whole request synchronously. Invalid input fails the POST itself with HTTP 400 and is never
   priced.
2. A valid request returns HTTP 202 with no response body, an absolute ARM `Location` polling URL, and `Retry-After`.
   The specification examples use `Retry-After: 30` seconds.
3. Clients wait for the `Retry-After` interval before polling `Location`. While pricing runs, polling returns HTTP
   202 with no response body, `Location`, and `Retry-After`. On completion, it returns HTTP 200 with the estimate, or
   an ARM error such as `AuthorizationFailed` (403), `PriceSourceUnavailable` or `EstimationTimeout` (503), or
   `EstimationInterrupted` (500, resubmit).
4. Only the principal that started the operation can read it; results are retained for 30 minutes, after which the
   poll returns 404.

The polling URL is served by the provider at
`/subscriptions/{subscriptionId}/providers/Microsoft.CostManagement/estimatePricesOperationResults/{operationId}`.

## Discovery

Resource types and per-type input profiles are discovered through anonymous, cacheable pricing-metadata GETs outside
ARM. Discovery contains only subscription-independent metadata: no customer prices, inventory, entitlements or
billing currency. It offers keyword search over resource types, a full JSON Schema profile, contextual choices, and an
applicable view that returns only the inputs that apply to a partly known configuration with the defaults the server
would use. Cached discovery neither authorizes estimation nor replaces server validation.

## Inputs

Each entry names a supported resource type and source resource API version and supplies two typed named inputs:
`resource`, an allowlisted subset of the native ARM resource with exact ARM property names, and `usage`, consumption
and purchase assumptions such as hours, GB, operations and `purchaseOption`. Values are explicitly typed strings,
numbers, booleans, named object members or array items. Templates, expressions, customer resource names, deployed
resource IDs, tags, credentials and secrets are rejected. Omitted inputs with an applicable advertised default are
completed by the server; explicit values, including zero and false, always win.

Each charge is submitted once. Callers project inline managed disks to separate disk entries and deduplicate shared
dependencies. Identical entries are independently charged.

## Results

Prices apply to the authorized subscription and its billing currency; unavailable customer pricing never falls back
to retail prices. Monthly and upfront charges remain separate at every level. `Complete` requires `amount`; `Partial`
requires only `knownAmount`; `Unavailable` contains neither. Missing prices are reported as issues, not zeros.

Each result returns the effective `configuration`, including `defaultedFields`, the configuration defaults the server
applied; `assumedUsageFields`, usage quantities the caller omitted and the server assumed (for example
`/usage/storedGB`); and typed `appliedValues` for every field the server set or changed. Every other priced value is
exactly what the caller submitted. A non-empty `assumedUsageFields` means the price rests on quantities the caller
did not state.

Calculations use decimal arithmetic. Component amounts are rounded once to six fractional places, midpoint away from
zero; entry and request totals sum those amounts. Examples use deterministic illustrative prices, not live quotes.

### Numeric and result limits

Integer-valued inputs may have magnitude up to `9007199254740991` (the IEEE 754 safe-integer limit).
Non-integer inputs may have magnitude up to `1000000000` and at most six fractional decimal places.
The same rules apply to defaults and returned applied values. These limits preserve supported decimal values
through double-based SDK serialization; they do not make client floating-point arithmetic exact.
Every monetary amount and known subtotal is between zero and `1000000000`, with at most six fractional places.
Individually valid amounts do not guarantee a valid aggregate: two components costing `600000000` each exceed
the entry limit when summed.

All of the following limits apply together, across the entire estimate:

| Limit                                                                 | Maximum                  |
| --------------------------------------------------------------------- | ------------------------ |
| Request body                                                          | 512 KiB serialized UTF-8 |
| Resource entries                                                      | 100                      |
| Submitted typed values                                                | 10000                    |
| Typed values after default completion / returned applied typed values | 20000 each               |
| Nested object/array levels                                            | 8                        |
| Components / planned billing charges                                  | 10000 each               |
| Diagnostics, including issues and assumptions at every level          | 1000                     |
| Combined `defaultedFields` and `assumedUsageFields` pointers          | 20000                    |
| Serialized UTF-8 final HTTP 200 response body                         | 4194304 bytes (4 MiB)    |

Object members and array items retain their per-value limits of 128 and 1024. Input names are limited to 128
characters and string values to 1024. Returned JSON Pointers are limited to 4096 characters, component/diagnostic
codes and names to 128, diagnostic messages to 1024, and each component's meter-ID list to 128 IDs of at most
36 characters. The byte limit includes JSON escaping, property names and every server-added value; meeting count
limits does not guarantee that the serialized body fits.

Completed configurations are checked after defaults and canonicalization and before pricing. The final result is
count-checked and serialized through a bounded UTF-8 writer before it is marked successful or stored. Exceeding a
result limit returns `400 EstimateResultTooLarge`, before acceptance when known during preparation or as a terminal
polling error otherwise. No results, applied values, assumptions or pricing issues are silently truncated.
Stored results are revalidated when polled, without rewriting their JSON, so earlier workers cannot bypass the
current response or numeric limits.

Checked decimal calculations and each component, entry and request aggregation independently enforce the monetary
ceiling for monthly and upfront charges, including partial known subtotals. Arithmetic overflow or a ceiling violation
fails the whole estimate with `400 EstimateAmountOutOfRange`; failures discovered during pricing are terminal polling
errors. Known costs are never clamped, reclassified as unavailable, or independently rounded at aggregate levels.

## Errors

An accepted request can still fail during pricing. If a calculated quantity, amount or aggregate exceeds the
supported range, polling returns HTTP 400 with code `EstimateAmountOutOfRange`, even though the POST returned 202.
Callers must reduce the requested quantities and submit a new estimate.

Errors use the standard ARM error response. Every invalid entry is reported in one response; with more than one, the
top-level code is `MultipleInputErrors` and each error is listed in `details`, in request order. Targets are request
positions and never echo submitted values. An `additionalInfo` entry of type `InputField` names the affected input
when the profile declares it, with its allowed values or a choice lookup path where applicable:

```json
{
  "error": {
    "code": "MultipleInputErrors",
    "message": "2 input errors were found. Every error is listed in details; correct them all before retrying.",
    "details": [
      {
        "code": "InvalidInput",
        "message": "The numeric input is outside the supported range.",
        "target": "/resources/1/inputs/1/value/members/2/value/value",
        "additionalInfo": [
          { "type": "InputField", "info": { "field": "/usage/hoursPerMonth" } }
        ]
      },
      {
        "code": "UnsupportedSelector",
        "message": "The selector is not supported by this pricing profile.",
        "target": "/resources/2/inputs/0/value/members/1/value/members/1/value/members/0/value/members/0/value/value",
        "additionalInfo": [
          {
            "type": "InputField",
            "info": {
              "field": "/resource/properties/storageProfile/osDisk/osType",
              "allowedValues": ["Windows", "Linux"]
            }
          }
        ]
      }
    ]
  }
}
```

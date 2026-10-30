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
```

## Review scope

This is an in-development contract for the existing Non-RPaaS `Microsoft.CostManagement` provider. There are no
customers yet; the intended first release is private preview. It supersedes the earlier `estimateCosts` draft
(azure-rest-api-specs-pr#30664), which was renamed to `estimatePrices` and made long-running.

The only new business operation is a subscription-scoped long-running action:

```http
POST /subscriptions/{subscriptionId}/providers/Microsoft.CostManagement/estimatePrices?api-version=2026-10-01-preview
```

The standard provider Operations listing is included for ARM tooling. This specification introduces no new resource
provider and does not change the existing CostManagement project's versions, operations, models or examples. The
implementation host is the existing pricing service. SDK packaging requires SDK and service-owner review; this
configuration emits OpenAPI only.

## Long-running behavior

ARM's control-plane latency target requires a first response within one second, and pricing takes several seconds,
so the action follows the ARM asynchronous pattern with `final-state-via: location`:

1. The POST validates the whole request synchronously. Invalid input fails the POST itself with HTTP 400 and is never
   priced.
2. A valid request returns HTTP 202 with `Location` and `Retry-After`.
3. Polling `Location` returns 202 while pricing runs, then HTTP 200 with the estimate, or an ARM error such as
   `AuthorizationFailed` (403), `PriceSourceUnavailable` or `EstimationTimeout` (503), or `EstimationInterrupted`
   (500, resubmit).
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

Each result returns the effective `configuration`: the decoded, default-completed inputs; `defaultedFields`, the
configuration defaults the server applied; and `assumedUsageFields`, usage quantities the caller omitted and the server
assumed (for example `/usage/storedGB`). A non-empty `assumedUsageFields` means the price rests on quantities the
caller did not state.

Calculations use decimal arithmetic. Component amounts are rounded once to six fractional places, midpoint away from
zero; entry and request totals sum those amounts. Examples use deterministic illustrative prices, not live quotes.

## Errors

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

## Suppressions

`EstimateEffectiveConfiguration.inputs` is a `Record<unknown>` (`arm-no-record`): the decoded configuration is
resource-type specific, its schema is published per resource type and API version by the discovery profiles, and it
mirrors the typed inputs the caller submitted.

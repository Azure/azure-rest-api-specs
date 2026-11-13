# Observability Agent Identity Access

> see https://aka.ms/autorest

This specification describes the advisory identity role inspection actions independently
of the observability agent CRUD API. It does not redefine or change that API.

## Configuration

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-08-01-preview
```

### Tag: package-2026-08-01-preview

```yaml $(tag) == 'package-2026-08-01-preview'
input-file:
  - preview/2026-08-01-preview/identityAccess.json
```

### Tag: package-2026-05-01-preview

```yaml $(tag) == 'package-2026-05-01-preview'
input-file:
  - preview/2026-05-01-preview/identityAccess.json
```

### Emitter selection

The default `emit` list generates only OpenAPI, following the repository's
[ARM widget template](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/widget/resource-manager/Microsoft.Widget/Widget/tspconfig.yaml).
SDK pipelines select a language emitter explicitly with `--emit`; its settings
are supplied by the corresponding `options` block. Those options are retained
for pipeline use and do not request local SDK generation during spec compilation.
Package names still require SDK owner and architect approval.

## Behavior

Both operations are synchronous POST actions named
`locations/{location}/validateObservabilityAgentIdentityAccess`, below
`Microsoft.Monitor` at either subscription or resource-group scope.
Use resource-group scope when the resource group exists, and subscription scope
when it has not yet been created. Neither route requires an agent name.
The manifest maps the action to `Microsoft.Monitor/observabilityAgents/read`;
the caller needs that permission at the selected scope or an ancestor.

The service declares OAuth2 authentication explicitly. Its authentication-only
`azure_auth` model retains the scheme name required by ARM's
`SecurityDefinitionsStructure` rule. Two narrowly scoped style suppressions
preserve that required name and the TypeSpec HTTP `authorizationUrl`
configuration field; neither represents a serialized SDK payload property.

The request always includes `userAssignedIdentityResourceId`. The optional
`monitoringAccountId` and `monitoredResourceIds` add target subscriptions;
the latter accepts at most 10 entries. The route subscription is always checked.
The identity's hosting subscription is not automatically a target. Both optional
properties accept null as omission, and the resource list also accepts an empty
array. Null or blank array entries and an empty account ID are invalid.

All resource IDs must be subscription-scoped, start with `/`, contain a valid
subscription GUID and nonempty resource name, and be at most 2048 characters.
Double slashes, backslashes, query strings, fragments, and `.` or `..` path
segments are invalid. A trailing slash is removed. Identity IDs must reference
`Microsoft.ManagedIdentity/userAssignedIdentities`; account IDs must reference
`Microsoft.Monitor/accounts`. Resource type comparisons are case insensitive.

The service resolves identity metadata and inspects role assignments using the
caller's delegated authorization, without an application-only fallback. It looks
for the Monitoring Contributor role
(`749f88d5-cbae-40b8-bcfc-e573ddc772fa`) at each target subscription or an
applicable inherited scope. It does not accept a grant confined to a resource
group or individual resource as a subscription-level grant.

HTTP 200 carries `RecommendedRolePresent`, `RecommendedRoleMissing`, or
`UnableToVerify`. The overall status prioritizes unverifiable over missing over
present. Conditional assignments are not evaluated. When no unconditional match
has been found, incomplete listing after 20 pages is unverifiable. There is no
fixed overall 30-second completion guarantee.

This is not an effective-permissions evaluator. Other roles may provide sufficient
permissions even when the recommended role is missing, and finding that role is
not a guarantee of success for later operations. The API does not create an
agent, grant roles, or enforce agent creation.

### Why the contract uses POST

This provider-level action evaluates a proposed set of inputs before an agent
exists; it does not read a stored validation result or an agent property.
The request includes an identity ID, an optional account ID, and up to ten
monitored resource IDs, each up to 2048 characters. Keeping this structured
input in the body avoids a potentially very long query string and reliance
on a GET request body.

The result is calculated using current identity and role-assignment information
and the caller's delegated authorization. The same inputs can therefore produce
different outcomes as permissions or the caller change. There is no agent
creation-time result to reuse, particularly when the agent or resource group
has not yet been created. This describes the result's semantics, not an
assertion about HTTP cache-control headers.

The implemented operation completes in the original response; it does not
provide a 202 response, polling URL, or persisted validation resource.
Changing only the specification to GET or an asynchronous POST would describe
a contract the service does not implement.

POST is proposed here as a request-scoped validation action, not as a secret
retrieval operation or a latency-based exception. No measured equivalent-GET
P99 latency or ARM exception approval is claimed. ARM reviewers must confirm
this classification or require a coordinated contract change.

## Errors and compatibility

Each action example includes success and default-error response shapes for
validation coverage. Flat default errors illustrate HTTP 400 for malformed
input, not the expected result for the valid request shown in that example.
The subscription-scope present example instead illustrates a wrapped ARM
authorization error for a caller without invocation permission. These errors
use the `default` example key to match the OpenAPI response declaration; this
key is not a literal HTTP status code. Examples use canonical resource IDs;
the service also accepts and trims a trailing slash.

Both `2026-05-01-preview` and `2026-08-01-preview` expose the same preflight
contract, matching the service routes and resource-type registration. The August
version is the active TypeSpec preview. May OpenAPI and examples were emitted
from the same definitions before advancing the source version and are retained
as Swagger, without changing the separate May agent CRUD specification.
Publishing these operation/version combinations requires ARM review; this is
not a request to silently revise an approved public contract.

Invalid input returns HTTP 400 with the resource provider's existing flat
`code` and `message` body; `code` is `InvalidIdentityPreflightRequest`.
Both actions declare only `200` and `default`, as required by ARM OpenAPI rules.
The default error model composes the common ARM `ErrorResponse` with optional
top-level `code` and `message`. Invalid-input responses include both top-level
fields and omit `error`; ARM gateway failures use the common `error` envelope
and omit the top-level fields. The shared schema leaves these fields optional
because they belong to different error shapes, not because a new empty or
combined error response is being introduced.
Approval of the flat service error format is required from ARM reviewers; this
specification does not assert that an exception has been approved.

Unsupported content types are rejected before inspection. A disconnected caller
may not receive a response; the controller handles caller cancellation as an
empty 499 response. That cancellation is distinct from a dependency timeout,
which can produce HTTP 200 with `UnableToVerify` and `ValidationTimedOut`.

The legacy nonregional resource-provider alias is not a public route in this
specification. Availability requires the corresponding regional service routes
and approved manifest publication. Adding this specification is not proof of
deployment or ARM sign-off.

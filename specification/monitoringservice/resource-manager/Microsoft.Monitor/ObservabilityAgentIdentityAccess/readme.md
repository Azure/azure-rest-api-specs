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

## Behavior

Both operations are synchronous POST actions named
`locations/{location}/validateObservabilityAgentIdentityAccess`, below
`Microsoft.Monitor` at either subscription or resource-group scope.
Use resource-group scope when the resource group exists, and subscription scope
when it has not yet been created. Neither route requires an agent name.
The manifest maps the action to `Microsoft.Monitor/observabilityAgents/read`;
the caller needs that permission at the selected scope or an ancestor.

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

## Errors and compatibility

Each action example includes success and invalid-body response shapes for
validation coverage. The 400 response illustrates a malformed request body, not
the expected result for the valid request shown in that example. Examples use
canonical resource IDs; the service also accepts and trims a trailing slash.

Both `2026-05-01-preview` and `2026-08-01-preview` expose the same preflight
contract, matching the service routes and resource-type registration. The August
version is the active TypeSpec preview. May OpenAPI and examples were emitted
from the same definitions before advancing the source version and are retained
as Swagger, without changing the separate May agent CRUD specification.
Publishing these operation/version combinations requires ARM review; this is
not a request to silently revise an approved public contract.

Invalid input returns HTTP 400 with the resource provider's existing flat
`code` and `message` body; `code` is `InvalidIdentityPreflightRequest`.
The explicit 400 schema represents that behavior rather than claiming an ARM
`error` envelope. ARM gateway failures use the standard default error response.
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

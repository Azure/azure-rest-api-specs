# Microsoft.NetworkSecurity NeuroShield

> see https://aka.ms/autorest

This is the AutoRest configuration file for the Microsoft.NetworkSecurity NeuroShield management service.

## API contract

This project declares only `2026-10-01-preview`. The complete contract contains
25 operations, including the existing shared provider Operations catalog, with
35 authoring examples mirrored into the generated OpenAPI examples directory.
The Operations catalog has both a reference-contract example and the existing
public example; these illustrate the same GET endpoint, not separate APIs.

### Protected-resource target identity

Optional, non-null `properties.targetIdentity` describes the identity of the
target virtual machine or virtual machine scale set. It is not an identity
provisioned for the NeuroShield child resource. There is no root `identity` or
`properties.identity` alias.

When the object is supplied, `type` is required. The target identity and its
principal, tenant, and client identifiers are create inputs returned on read,
not writable update fields. Identifiers are pattern-constrained strings in
canonical, 36-character hyphenated GUID form, accepting either hexadecimal case.
The schema does not use `format: uuid` or independently establish ownership.

The documented conditional service contract is:

- `SystemAssigned` requires nonzero `principalId` and `tenantId`.
- `UserAssigned` requires exactly one non-null `userAssignedIdentities` entry,
  keyed by its Azure resource ID, containing nonzero `principalId` and `clientId`.
  Top-level identity IDs are omitted for this identity kind.
- Omission and explicit `None` are accepted on create. The shared identity type
  enum also declares the combined system/user-assigned value, but the operation
  documents that value as unsupported.
- Omission on update preserves the stored identity. A supplied identity must be
  unchanged; explicit `None` cannot clear an existing identity. Changing identity
  requires deleting and recreating the protected resource.

Conditional nonzero/cardinality rules and target association must be enforced
by the service. They are not unconditional schema `required` entries: the GUID
pattern itself accepts the zero GUID. No Resource Graph lookup is specified.
Backend input/output mapping and client payloads must implement this wire path;
this specification does not implement or prove a deployment or those adapters.

### Fleet summary

`GET .../neuroShields/{neuroShieldName}/summary/default` returns the read-only
`NeuroShieldSummary` singleton. Its standard proxy-resource envelope has `id`,
`name` (`default`), `type`, optional read-only `systemData`, and required
`properties` containing 14 required nonnegative `int32` counters.

`GET .../neuroShields/{neuroShieldName}/summary` returns a `value` array of summary
resources and optional `nextLink`. Optional `top` accepts 1 through 50; there is
no `skipToken` on this collection. Summary properties contain neither a redundant
parent `resourceId` nor a fabricated `provisioningState`. No summary create,
update, or delete operation is declared.

### Properties and paging

- Full PUT requests require `responseMode`, advertising `Auto` and `Manual`,
  with no default. PATCH mode remains optional; omission preserves the value.
- Full PUT omission of severity and description is documented to resolve to
  `Low` and an empty string respectively. PATCH omission preserves stored
  values. These are service semantics and example behavior, not emitted schema
  defaults; no mode default is introduced.
- Description is limited to 512 characters. Description and PATCH tag values
  reject control characters other than tab, line feed, and carriage return.
  PATCH tag values are limited to 256 characters. Shared ARM tags are unchanged;
  additional map/key limits are not invented in the schema.
- NeuroShield and protected-resource names use a 1–64-character grammar with
  alphanumeric first and last characters. Finding and mitigation IDs retain
  their 1–128-character grammar.
- Finding and mitigation response `properties` are required. Optional output
  fields are omitted rather than made nullable.
- All seven existing domain list operations accept optional `top` from 1
  through 50 and optional `skipToken`; there is no page-size default or `$top`
  alias. The summary list has its separate top-only parameter.

### Operations, ETags, and asynchronous work

The standard `Operations_List` endpoint is
`GET /providers/Microsoft.NetworkSecurity/operations`. It describes the shared
provider catalog rather than a new NeuroShield-specific controller. The live
catalog must support this API version and enumerate the supported operations
and actions; representative examples do not implement that catalog.

NeuroShield CRUD and finding/mitigation actions retain their synchronous
response contracts. Protected-resource PUT and DELETE remain asynchronous:
PUT uses `Azure-AsyncOperation` and `Retry-After` on its 201 response; DELETE uses
`Azure-AsyncOperation`, `Location`, and `Retry-After` on its 202 response. Both
use `azure-async-operation` as the final-state mechanism. The existing public
subscription/location operation-status GET is retained.

Existing ETag responses and parent PUT/PATCH `If-Match` remain unchanged.
Protected-resource PUT and DELETE also accept optional `If-Match`. Runtime
forwarding, precondition enforcement, identity retention, catalog coverage,
and asynchronous behavior require live verification, not internal-response
assumptions or exposure of internal storage ETags.

### Review and validation

Finding, mitigation, and summary properties each retain a narrowly scoped
TypeSpec provisioning-state exception because these are service-computed
resources without a separate ARM provisioning lifecycle. Destination public
ARM/API and TypeSpec suppression approval is required; no prior or private
approval is assumed. There are no AutoRest suppressions for this package.

From the project directory, compile and run the focused regression suite:

```text
pnpm exec tsp compile . --warn-as-error
node --test tests\protected-resource-identity.test.mjs tests\summary.test.mjs tests\versions.test.mjs tests\main-properties.test.mjs
```

The tests compile the source independently, pin the authoritative October
contract and original examples, preserve the approved public Operations example,
and reject removed-version declarations or artifacts. Compilation and these
tests do not replace repository validation, API review, or live service testing.

## Getting Started

To build the SDKs for Microsoft.NetworkSecurity NeuroShield, install AutoRest via `npm` and run:

> `autorest readme.md`

## Configuration

### Basic Information

```yaml
openapi-type: arm
openapi-subtype: rpaas
tag: package-2026-10-01-preview
```

### Tag: package-2026-10-01-preview

These settings apply when `--tag=package-2026-10-01-preview` is specified.

```yaml $(tag) == 'package-2026-10-01-preview'
input-file:
  - preview/2026-10-01-preview/neuroShield.json
```

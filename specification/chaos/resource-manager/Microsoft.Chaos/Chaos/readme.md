# chaos

> see https://aka.ms/autorest

This is the AutoRest configuration file for chaos.

## Workspace customer-managed keys in 2026-11-01

Workspace PUT, PATCH, GET, and list responses support `properties.encryption`.
Changes use `Microsoft.Chaos/workspaces/write`. Reads use
`Microsoft.Chaos/workspaces/read`. Full CMK PUT and CMK-changing PATCH also
require caller `Microsoft.KeyVault/vaults/read` on the effective referenced
vault. This existing permission is separate from the Storage application's
key-use grant. There is no custom CMK action or operator role.

Set `encryption.customerManagedKeyEncryption.keyEncryptionKeyUrl` and its
required sibling `keyVaultResourceId` to request a customer-managed key.
The URL must be a versionless HTTPS Key Vault key URL in
the supported cloud and Workspace tenant. Do not supply a key version, query
string, or fragment. Absence of `customerManagedKeyEncryption` means
Microsoft-managed protection. There is no writable protection-mode enum or
alternate key-setting shape.

The ID must be the full
`/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName}`
reference. It names the customer vault, not a key child, Managed HSM, internal
service resource, or arbitrary URL. Child/extension paths, queries, and
fragments are invalid. The vault must be in the Workspace tenant, but need
not be in the same subscription.

### Supported key stores

Workspace CMK supports Azure Key Vault RSA keys and Premium Key Vault RSA-HSM
keys, with Storage-supported sizes of 2048, 3072, or 4096 bits. The separate
Azure Managed HSM service is not supported in this GA release.
Premium-vault RSA-HSM keys use the same vault URL and onboarding flow as RSA
keys. A key URL does not identify its cryptographic type; do not infer the type
from its name or reject a vault key because its name contains `HSM`.

For a supported RSA-HSM key in a Premium vault, the request fragment is:

```json
{
  "properties": {
    "encryption": {
      "customerManagedKeyEncryption": {
        "keyEncryptionKeyUrl": "https://contoso-premium.vault.azure.net/keys/workspace-rsa-hsm",
        "keyVaultResourceId": "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/customer-keys/providers/Microsoft.KeyVault/vaults/contoso-premium"
      }
    }
  }
}
```

In this example the key is provisioned as RSA-HSM in Premium Key Vault; the
URL alone does not prove that fact. The service validates vault hosts against
the supported cloud's allowlist. A URL such as
`https://contoso-hsm.managedhsm.azure.net/keys/workspace-key` is a separate
Managed HSM endpoint and is rejected before LRO acceptance or any state change.
The existing HTTP 400 error response is:

```json
{
  "error": {
    "code": "InvalidEncryptionConfiguration",
    "message": "Azure Managed HSM is not supported. Use Azure Key Vault; RSA-HSM keys in Premium Key Vault are supported.",
    "target": "properties.encryption.customerManagedKeyEncryption.keyEncryptionKeyUrl"
  }
}
```

This restriction adds no public field or role. Portal key selection, SDK
documentation, onboarding, support guidance, and release notes must use the
same boundary. Key-store acceptance tests must exercise a real Premium-vault
RSA-HSM key; schema tests only verify the URL shape and documented scope.

This uses the preferred key names from the
[ARM common CMK contract](https://github.com/cloud-and-ai-microsoft/resource-provider-contract/blob/b32b6e22b3a151049fdfd5275eb0c748185a94bc/v1.0/common-api-contracts.md#customer-managed-key-encryption).
The identity-selection object is omitted because Chaos owns the shared Storage
identity, application, and federated credential. Customers select a key, not
that identity. [Health Data Services](https://github.com/Azure/azure-rest-api-specs/blob/84fc656cd2945daa4a7b1ef306c02e2b157e9f60/specification/healthcareapis/resource-manager/Microsoft.HealthcareApis/HealthcareApis/models.tsp#L978-L994)
provides a direct GA precedent for these preferred names without selectable
encryption identity. Redis Enterprise and Mongo Cluster are additional adapted
precedents, not sources for Chaos removal, rotation, or identity semantics.
These precedents do not replace ARM review of Chaos lifecycle behavior.
The vault resource ID is a Chaos addition for caller-bound metadata validation,
not a field inherited from the Health Data Services naming precedent.

### Replacement and partial updates

| Request | Result |
| --- | --- |
| PUT with a CMK object | Require both non-null `keyEncryptionKeyUrl` and `keyVaultResourceId`. Authorize and validate the pair even if unchanged. |
| PUT without encryption or its CMK object, or with `encryption: {}` | Request Microsoft-managed protection. This removes existing customer-key protection. |
| PUT with null encryption, null CMK, or an incomplete CMK object | Return `400 InvalidEncryptionConfiguration` before any change. Empty encryption is valid; empty CMK is not. |
| PATCH with encryption omitted or an empty object | Keep the existing encryption setting. No PUT default is applied to the patch. |
| PATCH with CMK omitted | Keep the existing customer key. |
| PATCH with `"customerManagedKeyEncryption": null` or `"encryption": null` | Remove the writable key configuration through the normal removal operation. Keep onboarding and observations. |
| PATCH with only `keyEncryptionKeyUrl` | Retain the stored ID for same-vault rotation; authorize and validate the effective pair. Do not infer a vault ID from the URL. |
| PATCH with only `keyVaultResourceId` | Retain the URL; authorize and validate both effective values. Reject an incoherent pair. |
| PATCH changes vault | Supply a coherent new URL/ID pair. |
| PATCH with an empty CMK object | Retain an existing complete pair without lookup or encryption LRO when no member changes. Reject an incomplete merged result. |
| PATCH deletes only the URL or ID | Reject the incomplete CMK object at that exact property. This is not removal of CMK. |

The service merges PATCH with stored writable fields, then validates the syntax
and completeness of the result before accepting the operation. Required remote
validation also completes synchronously before acceptance, as described below.
Deleting either member while its CMK object remains is invalid. An empty patch is
not a request to reset encryption. Read-only `customerManagedKeyOnboarding` and
`status` inputs are ignored.

### Caller-bound ARM validation before acceptance

Use a bounded synchronous
[Vaults_Get](https://learn.microsoft.com/rest/api/keyvault/keyvault/vaults/get?view=rest-keyvault-keyvault-2024-11-01)
through the configured cloud's Azure Resource Manager endpoint. Complete it
before creating public operation metadata, persisting desired encryption,
accepting the encryption LRO, or changing Storage/customer data. Use the RP
first-party application credential with ARM signed-on-behalf-of authorization,
not the Storage crypto identity. Keep bearer and signed-OBO tokens only in
request memory, never in durable operation, Workspace, queue, history,
checkpoint, or log state. No elevated service-only fallback is permitted.

Compare returned canonical vault ID with the submitted ARM ID case-insensitively,
returned `properties.tenantId` with the immutable Workspace tenant, and the
parsed HTTPS origin of `properties.vaultUri` with the key URL's origin. For
creation, the Workspace tenant comes from trusted ARM context, not request
body input. Preserve key path/name case; suffix matching is not origin equality.
Unknown, denied, missing, or unusable metadata never establishes a match.
Validation is bound to the effective pair and Workspace state; a concurrent
change cannot reuse a result for a different pair.

The finite timeout/retry budget is within the gateway request budget. Once
exhausted, fail synchronously rather than continuing lookup in a background LRO.
Metadata validation does not prove key existence, consent, or Storage key use.
Private vaults need no service access to the customer's data-plane/private
endpoint for this lookup. Storage still needs its key-use grant and trusted
service network bypass; Network Security Perimeter requires an explicit rule
admitting Storage.

| Request | Vault metadata validation |
| --- | --- |
| Full PUT with CMK, even unchanged | Required before acceptance. |
| PATCH adds or changes either member | Authorize and validate the merged effective pair, including retained values. |
| Unrelated or empty PATCH with no CMK change | No lookup or encryption LRO; still reject incomplete merged configuration. |
| Full PUT without CMK, whole-CMK/encryption removal | No lookup. Revoked or deleted vaults do not block removal through this metadata prerequisite; Storage's separate removal requirements still apply. |
| GET, status reads, DELETE, old-version supported partial PATCH | No new vault lookup or permission requirement. |

### Provider registration and effective linked access

[ProviderHub resource-type registration](https://learn.microsoft.com/azure/templates/microsoft.providerhub/2025-10-01/providerregistrations/resourcetyperegistrations)
defines `linkedAccessChecks` entries with `actionName`, `linkedProperty`,
`linkedAction`, `linkedActionVerb`, and `linkedType`, and separately defines
`onBehalfOfTokens`. These are RP registration settings, not Workspace fields or
TypeSpec decorators. The typed ARM-ID schema does not deploy access checks.

The Workspace registration must associate CMK configuration writes with the
vault-reference property, linked type `Microsoft.KeyVault/vaults`, and caller
permission `Microsoft.KeyVault/vaults/read`. Configure signed-OBO issuance for
the applicable Workspace writes and a caller-conditioned RP metadata-read
service role using the existing `@Resource[HasOboToken]` pattern. This specs
project does not own the deployment manifest; configure and verify those
settings in the service registration before activation.

Verify the registration's property-path and action/verb representation rather
than treating a documentation fragment as a deployable manifest. In particular,
a linked check on a submitted property alone cannot be assumed to cover an ID
omitted from PATCH and retained from stored state. The signed-OBO ARM GET must
authorize that effective vault. Test user, service-principal, and managed-identity
callers, URL-only/ID-only patches, absent/null properties, and all no-lookup
operations above. Missing or expired caller proof must never trigger a
service-only retry. Neither existing registration fields nor existing OBO
helper code prove that CMK authorization is deployed or correct.

For example, a verified tenant mismatch returns HTTP 400 before acceptance:

```json
{
  "error": {
    "code": "InvalidEncryptionConfiguration",
    "message": "The key vault belongs to a different Microsoft Entra tenant than this Workspace. Use a key vault in the Workspace tenant.",
    "target": "properties.encryption.customerManagedKeyEncryption.keyVaultResourceId"
  }
}
```

A transient metadata failure returns HTTP 503 in the same envelope with
`EncryptionConfigurationFailed` and the message: "Key vault metadata validation
is temporarily unavailable. Retry the Workspace request. No configuration
operation was accepted." Include retry guidance and `Retry-After` when known.
Caller authorization failure returns the standard HTTP 403 authorization error,
with guidance to obtain `Microsoft.KeyVault/vaults/read` or refresh required
caller authorization. ARM throttling returns HTTP 429 with `Retry-After`.
Do not expose expected, observed, or embedded tenant IDs in any error.
Failure leaves requested state, active binding, and observations unchanged and
creates no pending requested state or public operation metadata.

Illustrative HTTP 403 for a denied vault read (an ARM linked check can instead
report `LinkedAuthorizationFailed`):

```json
{
  "error": {
    "code": "AuthorizationFailed",
    "message": "The caller must have Microsoft.KeyVault/vaults/read on the referenced key vault. Obtain access or refresh the required caller authorization, then retry.",
    "target": "properties.encryption.customerManagedKeyEncryption.keyVaultResourceId"
  }
}
```

Illustrative HTTP 429 with a service-provided `Retry-After` header:

```json
{
  "error": {
    "code": "TooManyRequests",
    "message": "Key vault metadata validation was throttled. Retry after the interval specified in Retry-After. No configuration operation was accepted."
  }
}
```

Illustrative HTTP 503 for a transient or unusable metadata response:

```json
{
  "error": {
    "code": "EncryptionConfigurationFailed",
    "message": "Key vault metadata validation is temporarily unavailable. Retry the Workspace request. No configuration operation was accepted."
  }
}
```

These examples describe synchronous validation errors in the existing default
error envelope, not new error-response schemas. Missing or malformed IDs and
confirmed not-found/ID/tenant mismatches use the ID target in the HTTP 400
example above. Invalid URLs and mismatches with the vault's HTTPS origin use
the key URL target instead.

The PATCH model uses `TypeSpec.Http.MergePatchUpdate<T>` on separate optional,
default-free fields. Four property-scoped `no-nullable` suppressions permit
request-only JSON Merge Patch deletion. The rule also reports nulls produced by
the public transform. The accepted PATCH-clear pattern in #45663 is prior art;
it does not constitute approval of this change. PUT and response fields are not
nullable.

Full encryption is a named model with no synthetic default object. The absent
CMK object is the Microsoft-managed default. GET keeps service-owned onboarding
and observations available without adding a desired CMK object.
C# client names use a `Uri` suffix through `client.tsp`; the public JSON names
retain the ARM-preferred `Url` suffix without a wire alias.

The status error uses
common-types v5 because the existing service selects v5 in `main.tsp`; mixing
versions conflicts with `SCHEMA-COMMON-TYPES-VERSION`. A service-wide upgrade is
not part of this change. The nested encryption object preserves the public
Workspace contract. It is not flattened: the current TypeSpec review guidance
prohibits new `@flattenProperty` decorators. No common-types or nesting warning
is suppressed.

### Requested setting and observed result

`customerManagedKeyEncryption.keyEncryptionKeyUrl` and `keyVaultResourceId`
are the accepted caller- and tenant-validated pair, not proof that the key
protects active data. After synchronous validation, initial async PUT and
GET/LIST can project that pair with `Pending` while observations continue to
describe actual protection. Validation failure creates no pending requested
state. The read-only
`customerManagedKeyOnboarding.applicationId` identifies the service application
for customer consent. It is returned for existing Workspaces before enrollment, including on a
Microsoft-managed Workspace. It is not a service principal object ID or a
customer-supplied identity selector. The Workspace's top-level identity serves
other features and does not select Storage CMK identity.
No internal identity, storage account, scope, or anchor identifiers are exposed.
There is no public `infrastructureEncryption` switch.

### Onboarding before creation or enrollment

For an existing Microsoft-managed Workspace, GET returns
`customerManagedKeyOnboarding.applicationId` before enrollment, as shown in
`Workspaces_Get_EncryptionNotConfigured.json`. Install or consent to that
application and grant its local service principal access to the customer key,
then use the paired PATCH in `Workspaces_Update_EnableCustomerKey.json`.
The configuring caller separately needs `Microsoft.KeyVault/vaults/read` on
the effective vault.

To create a Workspace with customer-managed protection directly, first obtain
the application name and client ID for the target cloud from the service
onboarding documentation or Portal configuration. Consent and grant key access
before sending the full URL/ID PUT in `Workspaces_CreateOrUpdate_WithCustomerKey.json`.
The caller must also have vault-read permission. Portal obtains the vault ID
from ARM metadata or manual input, not a data-plane reachability probe.
No temporary Microsoft-managed Workspace or failed create is needed.
GET after creation must return that same application ID. The existing GET and
born-CMK examples use the same illustrative ID; it is not a deployment constant.

Published onboarding values, Portal deployment configuration, and the runtime
GET value must come from the same service configuration. The application ID is
not the customer-tenant service principal's object ID. No discovery API or
customer-selectable encryption identity is added.

The read-only `status` object contains `state`, optional `observedProtection`,
optional `observedKeyEncryptionKeyUrl`, optional `lastCheckedAt`, and optional
`error`. `observedProtection` is `CustomerManaged` or `MicrosoftManaged`, and
is omitted when unknown. The observed URL is the active URL reported by Azure
Storage, including its version when available. It is omitted for unknown or
Microsoft-managed protection. A failed check must not copy requested values
into observed fields. During removal, desired CMK is absent while observed
protection can remain `CustomerManaged` until the change is verified.

| State | Meaning |
| --- | --- |
| `NotConfigured` | No per-Workspace encryption configuration exists; Microsoft-managed protection applies. |
| `Pending` | A configuration operation is in progress. |
| `Applied` | A fresh check confirms the requested protection and data access. This state applies to either key source. |
| `Failed` | A configuration step or health check failed; `error` includes a code and message. |
| `Unknown` | No usable fresh observation is available. |

The existing `properties.provisioningState` reports the Workspace operation.
There is no second encryption provisioning-state field. PUT uses the existing
`200`/`201` resource response with `Updating`/`Creating`. Asynchronous PATCH uses
an empty `202` with `Location`; its final result is the Workspace. Poll with the
existing operation endpoints.

After required caller/vault validation, an identical request with `Applied`
status succeeds without a new operation.
While a configuration operation runs, HTTP 409 with the existing Workspace
conflict code is required, including for an identical request. Returning the
same operation is not an alternative. After terminal failure, a valid
Workspace update can retry or replace the key. No repair or cancellation action
is required.

First enable can temporarily reject new operations that write customer data.
Existing operations finish before data moves; reads remain available. Key
replacement, removal, and re-enable do not require a separate public data-move
operation. Removal is not an emergency bypass for an inaccessible key: key
access may need to be restored before removal can complete.

Azure Storage follows versions of the requested key. Keep the old version
available for at least 24 hours after rotation. Do not assume immediate adoption
of a new version. Customer-key protection applies to active data; it does not
retroactively protect retained pre-enable copies.

### Protection, recovery, and support limits

Your key protects customer data stored under the Workspace's encryption scope.
Separate execution stores, system metadata, logs, metrics, traces, and other
service stores keep their existing Microsoft-managed protection and retention.
Revoking your key does not cryptographically erase those copies and does not
guarantee that an execution already in progress will stop.

The first release supports local payload and index recovery from verified
application checkpoints. It does not provide Azure Table point-in-time restore
or an account-loss or regional recovery point/time objective. Loss of the
checkpoint container, account, or region can also remove local checkpoints.
Recovery requires retained checkpoint data, current customer key access, and
valid Workspace metadata. Do not interpret this guidance as proof of deployed
recovery capability or a regional guarantee.

Key expiry and not-before dates are not the same as disable or revocation:
some unwrap/decrypt operations can remain permitted outside key date bounds.
Repair consent, local service-principal, grant, network, or key-access problems
through normal onboarding and key management. There is no emergency decryption
path, automatic Microsoft-managed fallback, or new support privilege. Existing
retention and legal/immutability holds apply; blocked cleanup does not imply
physical purge. No global purge deadline is promised.

### Customer-data reads during restore

During restore, operations that read Workspace customer data, including entity,
existence, page, and key reads, can return HTTP 503 `ServiceUnavailable` with a
positive numeric `Retry-After` header. Retry after that interval. Workspace
metadata and operation-status reads remain available. Capture pauses writes;
restore pauses customer-data reads and writes.

For example, a service-selected retry interval of 10 seconds is returned as
`Retry-After: 10`, with the existing standard Azure Resource Manager
`ErrorResponse` body:

```json
{
  "error": {
    "code": "ServiceUnavailable",
    "message": "Workspace customer data is temporarily unavailable while restore is in progress. Retry the request after the interval specified in the Retry-After header."
  }
}
```

The interval is retry guidance, not a restore completion guarantee. HEAD
responses retain the status and retry header without a body. This read
restriction does not itself change `provisioningState` or `encryption.status`
and adds no public action, model, or permission.

### Workspace deletion

Deletion uses the existing Workspace DELETE LRO. It closes admission for new
customer-data writers and waits for previously admitted writers to finish
before deleting their data. A timeout or uncertain drain is not successful
deletion. The existing operation result reports completion or failure; there is
no new deletion error code, drain field, route, or permission.
Deletion failure is not an encryption-health observation. Existing retention
and teardown rules still apply, and DELETE remains available through older
supported API versions.

### Errors and older clients

Errors use the existing Azure Resource Manager `ErrorResponse` envelope.
Synchronous caller/vault validation failures create no accepted operation.
After acceptance, configuration failures appear in the operation result and
`encryption.status.error`. These error envelopes add no routes or custom
permissions.

| HTTP status or result | Code | Corrective action |
| --- | --- | --- |
| 400 | `InvalidEncryptionConfiguration` | Correct a missing/malformed/wrong-type vault ID, confirmed missing vault, canonical-ID mismatch, or tenant mismatch. Target `properties.encryption.customerManagedKeyEncryption.keyVaultResourceId`. |
| 400 | `InvalidEncryptionConfiguration` | Correct a missing/malformed key URL, unsupported host/path, or origin mismatch with the vault URI. Target `properties.encryption.customerManagedKeyEncryption.keyEncryptionKeyUrl`. |
| 400 | `EncryptionNotSupportedForWorkspace` | Use a Workspace that supports customer-managed encryption. |
| 403 before acceptance | Standard authorization error | Obtain `Microsoft.KeyVault/vaults/read` on the effective vault or refresh missing/expired caller authorization. Preserve/translate the ARM linked/read error; do not substitute an invalid-key error or elevated retry. |
| 429 before acceptance | Standard throttling error | Honor `Retry-After` from the ARM metadata lookup. No encryption operation was accepted. |
| 503 before acceptance | `EncryptionConfigurationFailed` | Retry after transient timeout/5xx or missing/unusable metadata. Unknown metadata is not a match or confirmed customer mismatch; no operation was accepted. |
| 409 | Existing Workspace conflict code | Wait for the current operation to finish before another configuration request. |
| 409 | `CmkEnrollmentDisabled` | New enrollment is unavailable. Retry when enrollment is available; existing key management remains supported. |
| 503 | `CmkCapacityUnavailable` | Service capacity is unavailable. Retry later. |
| Failed operation or health check | `CustomerKeyAccessFailed` | Check key availability, service application access, and vault network rules. Restore access and retry. A platform 403 alone does not identify the exact cause. |
| Failed operation or health check | `EncryptionConfigurationFailed` | Retry the Workspace update. Contact support if the service-side failure continues. |
| 409 on pre-CMK PUT | `ApiVersionNotSupportedForEncryption` | GET and PUT with `2026-11-01`, including the desired encryption, or PATCH fields supported by the older version. |

For an existing customer-key configuration, this PATCH deletes a required value:

```json
{
  "properties": {
    "encryption": {
      "customerManagedKeyEncryption": { "keyEncryptionKeyUrl": null }
    }
  }
}
```

It returns HTTP 400 without changing the Workspace:

```json
{
  "error": {
    "code": "InvalidEncryptionConfiguration",
    "message": "The merged customerManagedKeyEncryption object has no valid key URL. Supply a versionless HTTPS Key Vault key URL and its matching vault resource ID, or delete the CMK object to select Microsoft-managed protection.",
    "target": "properties.encryption.customerManagedKeyEncryption.keyEncryptionKeyUrl"
  }
}
```

These negative samples are documentation, not `x-ms-examples`: the example
validator requires success responses in each example and does not match a
specific error status to the existing default-only error response.

`ApiVersionNotSupportedForEncryption` is a service-specific compatibility
restriction, not the standard error for an unknown API version. Before any side
effect, a pre-CMK PUT is rejected if a desired CMK object exists, observed
protection is customer-managed, or active protection is unknown for an enrolled
Workspace. Deleting desired CMK does not bypass the check while observed
protection remains customer-managed or unknown.
The check and write use the existing Workspace concurrency boundary. No
customer-vault lookup is required.

Pre-CMK PUT still works for Microsoft-managed Workspaces. Older GET returns only
that version's fields; supported partial PATCH and DELETE remain available for
customer-key Workspaces. The `2026-08-01-preview` schema is unchanged. Older
full-resource deployment templates must move to `2026-11-01` before they can
replace a Workspace after customer-key enrollment.

For example, such an older PUT receives HTTP 409 with:

```json
{
  "error": {
    "code": "ApiVersionNotSupportedForEncryption",
    "message": "This Workspace requires an encryption-capable API version for PUT. GET and PUT with api-version 2026-11-01 and include the desired encryption setting, or PATCH fields supported by the current API version.",
    "target": "api-version"
  }
}
```

### Contract and release checks

Run `node --test` on `tests/workspace-encryption.test.mjs` after compilation.
Set `CHAOS_CONTRACT_BASE_REF` to the stack base commit to compare all older
version output byte-for-byte and check that no routes were added.
The tests inspect the schema and examples; they do not prove service behavior.

Before customer activation, service and SDK tests must establish these results:

| Case | Required result |
| --- | --- |
| GET-to-PUT round trip | Supply both requested key URL and vault ID; perform required caller/vault validation and ignore read-only inputs. |
| SDK PATCH omission versus null | Serialization preserves the difference between no change and deletion. |
| What-If with a GA template that omits the CMK object | Show the change to Microsoft-managed protection. |
| What-If with an unchanged complete customer-key setting | No false encryption change from service-owned observations. |
| Old-version template before and after enrollment | Succeed before enrollment; return the documented 409 after enrollment without changing any field. |
| Concurrent enrollment and old-version PUT | No stale-state bypass of the compatibility check. |
| Corrected GA template after enrollment | Succeed with the complete desired encryption setting. |
| Invalid merged PATCH or invalid PUT | Return 400 before persistence or storage work. |
| Caller/vault denial, mismatch, throttle, transient failure, or unknown metadata | Return the documented synchronous error before public operation metadata, desired persistence, LRO acceptance, or Storage/customer-data work. |
| URL-only or ID-only PATCH | Retain the omitted member, then authorize and validate the effective pair before acceptance. |
| No-lookup operations | Unrelated/empty PATCH, whole-CMK removal, supported old PATCH, GET/status, and DELETE require no CMK metadata read. |
| Pending projection | Only after validation, PUT/GET/LIST can show the accepted pair with Pending; observed protection remains actual. |
| Born-CMK onboarding | Published per-cloud application ID, Portal configuration, and GET agree; consent and key grant precede PUT. |
| Identical request during configuration | Return HTTP 409; do not return the same operation as an alternative. |
| DELETE with admitted writers | Close admission, drain writers, and complete the existing deletion LRO only when deletion conditions hold. |
| Removal, re-enable, and failure after a key change | Requested and observed values remain distinct and accurate. |

The generated SDK, service implementation, and deployment tests must consume the
same pinned CMK spec commit. Schema checks do not replace compatibility
acceptance or deployed-service tests.

### Stack integration and normal ARM review

PR #46392 targets `juliagao-microsoft-chaos-2026-11-ga-promotion` and must merge
there before #45455 contains CMK. Normal ARM review of that combined GA diff
covers the vault reference, caller permission, lifecycle, and old-version 409.
Baseline-only review is not CMK approval. If #45455 merges first, rebase and
retarget #46392 to `main` and run normal main-target checks and review. No
separate dedicated CMK review, named compatibility approver, or additional
approval artifact is required; normal release and runtime acceptance remain.

## Getting Started

To build the SDKs for My API, simply install AutoRest via `npm` (`npm install -g autorest`) and then run:

> `autorest readme.md`

To see additional help and options, run:

> `autorest --help`

For other options on installation see [Installing AutoRest](https://aka.ms/autorest/install) on the AutoRest github page.

---

## Configuration

### Basic Information

These are the global settings for the chaos.

```yaml
title: ChaosManagementClient
description: Chaos Management Client
openapi-type: arm
tag: package-2026-11
```

### Tag: package-2026-11

These settings apply only when `--tag=package-2026-11` is specified on the command line.

```yaml $(tag) == 'package-2026-11'
input-file:
  - stable/2026-11-01/openapi.json
suppressions:
  - code: XMSSecretInResponse
    from: openapi.json
    where: $.definitions.PrivateAccessProperties.properties.publicNetworkAccess
    reason: False positive - publicNetworkAccess is not a secret. It is a simple Enabled/Disabled configuration setting for public network access control. The property name contains 'access' which may trigger the rule, but the values are not sensitive.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].get
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].put
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].put
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: TrackedResourcePatchOperation
    from: openapi.json
    where: $.definitions.Target
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: AvoidAdditionalProperties
    from: openapi.json
    where: $.definitions.Target.properties.properties
    reason: Existing GA-exposed resource which relies on additionalProperties currently. Our RP will release a V2 in the future.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/configurations/{scenarioConfigurationName}/fixResourcePermissions"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: GuidUsage
    from: openapi.json
    where: $.definitions["Azure.Core.uuid"].format
    reason: >-
      The Azure.Core.uuid scalar is used only for canonical Microsoft Entra
      identifiers and Azure RBAC role definition GUIDs: ConnectionProperties.principalId
      (Entra principal/object ID), ConnectionProperties.tenantId (Entra tenant ID), and
      ActionProperties.recommendedRoles (Azure RBAC role definition GUIDs). These are
      well-known UUIDs, not free-form resource identifiers. Approved by ARM API reviewer.
  - code: AllTrackedResourcesMustHaveDelete
    from: openapi.json
    where: $.definitions.Workspace
    reason: False positive - Workspace has a DELETE operation (Workspaces_Delete) at /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}. The linter fails to correlate the definition with its delete operation.
  - code: TrackedResourcePatchOperation
    from: openapi.json
    where: $.definitions.Workspace
    reason: False positive - Workspace has a PATCH operation (Workspaces_Update) at the same resource path with tags support via WorkspaceUpdate model. The linter fails to correlate the definition with its patch operation.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/configurations/{scenarioConfigurationName}/execute"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/configurations/{scenarioConfigurationName}/validate"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/runs/{runId}/cancel"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/discover"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/evaluate"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostOperationIdContainsUrlVerb
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/executions/{executionId}/getExecutionDetails"].post
    reason: The operationId Experiments_ExecutionDetails is established in previous API versions (2024-11-01-preview, 2025-01-01). Renaming would be a breaking change for existing SDKs.
```

### Tag: package-2026-08-01-preview

These settings apply only when `--tag=package-2026-08-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-08-01-preview'
input-file:
  - preview/2026-08-01-preview/openapi.json
suppressions:
  - code: XMSSecretInResponse
    from: openapi.json
    where: $.definitions.PrivateAccessProperties.properties.publicNetworkAccess
    reason: False positive - publicNetworkAccess is not a secret. It is a simple Enabled/Disabled configuration setting for public network access control. The property name contains 'access' which may trigger the rule, but the values are not sensitive.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].get
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].put
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].put
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: TrackedResourcePatchOperation
    from: openapi.json
    where: $.definitions.Target
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: AvoidAdditionalProperties
    from: openapi.json
    where: $.definitions.Target.properties.properties
    reason: Existing GA-exposed resource which relies on additionalProperties currently. Our RP will release a V2 in the future.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/configurations/{scenarioConfigurationName}/fixResourcePermissions"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: GuidUsage
    from: openapi.json
    where: $.definitions["Azure.Core.uuid"].format
    reason: >-
      The Azure.Core.uuid scalar is used only for canonical Microsoft Entra
      identifiers and Azure RBAC role definition GUIDs: ConnectionProperties.principalId
      (Entra principal/object ID), ConnectionProperties.tenantId (Entra tenant ID), and
      ActionProperties.recommendedRoles (Azure RBAC role definition GUIDs). These are
      well-known UUIDs, not free-form resource identifiers. Approved by ARM API reviewer.
  - code: AllTrackedResourcesMustHaveDelete
    from: openapi.json
    where: $.definitions.Workspace
    reason: False positive - Workspace has a DELETE operation (Workspaces_Delete) at /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}. The linter fails to correlate the definition with its delete operation.
  - code: TrackedResourcePatchOperation
    from: openapi.json
    where: $.definitions.Workspace
    reason: False positive - Workspace has a PATCH operation (Workspaces_Update) at the same resource path with tags support via WorkspaceUpdate model. The linter fails to correlate the definition with its patch operation.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/configurations/{scenarioConfigurationName}/execute"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/configurations/{scenarioConfigurationName}/validate"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/runs/{runId}/cancel"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/discover"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/evaluate"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostOperationIdContainsUrlVerb
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/executions/{executionId}/getExecutionDetails"].post
    reason: The operationId Experiments_ExecutionDetails is established in previous API versions (2024-11-01-preview, 2025-01-01). Renaming would be a breaking change for existing SDKs.
```

### Tag: package-2026-05-01-preview

These settings apply only when `--tag=package-2026-05-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-05-01-preview'
input-file:
  - preview/2026-05-01-preview/openapi.json
suppressions:
  - code: XMSSecretInResponse
    from: openapi.json
    where: $.definitions.PrivateAccessProperties.properties.publicNetworkAccess
    reason: False positive - publicNetworkAccess is not a secret. It is a simple Enabled/Disabled configuration setting for public network access control. The property name contains 'access' which may trigger the rule, but the values are not sensitive.
  - code: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].get
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].put
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].put
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: TrackedResourcePatchOperation
    from: openapi.json
    where: $.definitions.Target
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: AvoidAdditionalProperties
    from: openapi.json
    where: $.definitions.Target.properties.properties
    reason: Existing GA-exposed resource which relies on additionalProperties currently. Our RP will release a V2 in the future.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/configurations/{scenarioConfigurationName}/fixResourcePermissions"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: GuidUsage
    from: openapi.json
    where: $.definitions["Azure.Core.uuid"].format
    reason: >-
      The Azure.Core.uuid scalar is used only for canonical Microsoft Entra
      identifiers and Azure RBAC role definition GUIDs: ConnectionProperties.principalId
      (Entra principal/object ID), ConnectionProperties.tenantId (Entra tenant ID), and
      ActionProperties.recommendedRoles (Azure RBAC role definition GUIDs). These are
      well-known UUIDs, not free-form resource identifiers. Approved by ARM API reviewer.
  - code: AllTrackedResourcesMustHaveDelete
    from: openapi.json
    where: $.definitions.Workspace
    reason: False positive - Workspace has a DELETE operation (Workspaces_Delete) at /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}. The linter fails to correlate the definition with its delete operation.
  - code: TrackedResourcePatchOperation
    from: openapi.json
    where: $.definitions.Workspace
    reason: False positive - Workspace has a PATCH operation (Workspaces_Update) at the same resource path with tags support via WorkspaceUpdate model. The linter fails to correlate the definition with its patch operation.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/configurations/{scenarioConfigurationName}/execute"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/configurations/{scenarioConfigurationName}/validate"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/scenarios/{scenarioName}/runs/{runId}/cancel"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostResponseCodes
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/workspaces/{workspaceName}/refreshRecommendations"].post
    reason: LRO POST returns 202 with Location header containing a polling URL. The final result is obtained by polling the Location URL, not from the initial POST response.
  - code: PostOperationIdContainsUrlVerb
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/executions/{executionId}/getExecutionDetails"].post
    reason: The operationId Experiments_ExecutionDetails is established in previous API versions (2024-11-01-preview, 2025-01-01). Renaming would be a breaking change for existing SDKs.
```

### Tag: package-2025-01

These settings apply only when `--tag=package-2025-01` is specified on the command line.

```yaml $(tag) == 'package-2025-01'
input-file:
  - stable/2025-01-01/openapi.json
suppressions:
  - code: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].get
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].put
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].put
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: TrackedResourcePatchOperation
    from: openapi.json
    where: $.definitions.Target
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: AvoidAdditionalProperties
    from: openapi.json
    where: $.definitions.Target.properties.properties
    reason: Existing GA-exposed resource which relies on additionalProperties currently. Our RP will release a V2 in the future.
  - code: PatchBodyParametersSchema
    from: openapi.json
    reason: already used in GA api version, fixing it will cause breaking change
  - code: PostOperationIdContainsUrlVerb
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/executions/{executionId}/getExecutionDetails"].post
    reason: The operationId Experiments_ExecutionDetails is established in previous API versions. Renaming would be a breaking change for existing SDKs.
```

### Tag: package-preview-2024-11

These settings apply only when `--tag=package-preview-2024-11` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-11'
input-file:
  - preview/2024-11-01-preview/openapi.json
suppressions:
  - code: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].get
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: RequestSchemaForTrackedResourcesMustHaveTags
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].put
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: TrackedExtensionResourcesAreNotAllowed
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{parentProviderNamespace}/{parentResourceType}/{parentResourceName}/providers/Microsoft.Chaos/targets/{targetName}"].put
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: TrackedResourcePatchOperation
    from: openapi.json
    where: $.definitions.Target
    reason: Not actually a tracked resource, but location property is required to avoid breaking changes
  - code: AvoidAdditionalProperties
    from: openapi.json
    where: $.definitions.Target.properties.properties
    reason: Existing GA-exposed resource which relies on additionalProperties currently. Our RP will release a V2 in the future.
  - code: PatchBodyParametersSchema
    from: openapi.json
    reason: already used in GA api version, fixing it will cause breaking change
  - code: PostOperationIdContainsUrlVerb
    from: openapi.json
    where: $.paths["/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Chaos/experiments/{experimentName}/executions/{executionId}/getExecutionDetails"].post
    reason: The operationId Experiments_ExecutionDetails is established in previous API versions. Renaming would be a breaking change for existing SDKs.
```

### Tag: package-preview-2024-03

These settings apply only when `--tag=package-preview-2024-03` is specified on the command line.

```yaml $(tag) == 'package-preview-2024-03'
input-file:
  - preview/2024-03-22-preview/capabilities.json
  - preview/2024-03-22-preview/capabilityTypes.json
  - preview/2024-03-22-preview/experiments.json
  - preview/2024-03-22-preview/operationStatuses.json
  - preview/2024-03-22-preview/operations.json
  - preview/2024-03-22-preview/privateAccesses.json
  - preview/2024-03-22-preview/targetTypes.json
  - preview/2024-03-22-preview/targets.json
directive:
  - from: swagger-document
    where: "$.definitions.action"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentAction";
  - from: swagger-document
    where: "$.definitions.branch"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentBranch";
  - from: swagger-document
    where: "$.definitions.step"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentStep";
  - from: swagger-document
    where: "$.definitions.filter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilterParameters"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilterParameters";
  - from: swagger-document
    where: "$.definitions.selector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSelector";
  - from: swagger-document
    where: "$.definitions.listSelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetListSelector";
  - from: swagger-document
    where: "$.definitions.querySelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetQuerySelector";
```

### Tag: package-2024-01

These settings apply only when `--tag=package-2024-01` is specified on the command line.

```yaml $(tag) == 'package-2024-01'
input-file:
  - stable/2024-01-01/capabilities.json
  - stable/2024-01-01/capabilityTypes.json
  - stable/2024-01-01/experiments.json
  - stable/2024-01-01/operationStatuses.json
  - stable/2024-01-01/operations.json
  - stable/2024-01-01/targetTypes.json
  - stable/2024-01-01/targets.json
directive:
  - from: swagger-document
    where: "$.definitions.action"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentAction";
  - from: swagger-document
    where: "$.definitions.branch"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentBranch";
  - from: swagger-document
    where: "$.definitions.step"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentStep";
  - from: swagger-document
    where: "$.definitions.filter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilterParameters"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilterParameters";
  - from: swagger-document
    where: "$.definitions.selector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSelector";
  - from: swagger-document
    where: "$.definitions.listSelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetListSelector";
  - from: swagger-document
    where: "$.definitions.querySelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetQuerySelector";
```

### Tag: package-2023-11

These settings apply only when `--tag=package-2023-11` is specified on the command line.

```yaml $(tag) == 'package-2023-11'
input-file:
  - stable/2023-11-01/capabilities.json
  - stable/2023-11-01/capabilityTypes.json
  - stable/2023-11-01/experiments.json
  - stable/2023-11-01/operationStatuses.json
  - stable/2023-11-01/operations.json
  - stable/2023-11-01/targetTypes.json
  - stable/2023-11-01/targets.json
directive:
  - from: swagger-document
    where: "$.definitions.action"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentAction";
  - from: swagger-document
    where: "$.definitions.branch"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentBranch";
  - from: swagger-document
    where: "$.definitions.step"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentStep";
  - from: swagger-document
    where: "$.definitions.filter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilterParameters"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilterParameters";
  - from: swagger-document
    where: "$.definitions.selector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSelector";
  - from: swagger-document
    where: "$.definitions.listSelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetListSelector";
  - from: swagger-document
    where: "$.definitions.querySelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetQuerySelector";
```

### Tag: package-preview-2023-10

These settings apply only when `--tag=package-preview-2023-10` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-10'
input-file:
  - preview/2023-10-27-preview/capabilities.json
  - preview/2023-10-27-preview/capabilityTypes.json
  - preview/2023-10-27-preview/experiments.json
  - preview/2023-10-27-preview/operationStatuses.json
  - preview/2023-10-27-preview/operations.json
  - preview/2023-10-27-preview/privateAccesses.json
  - preview/2023-10-27-preview/targetTypes.json
  - preview/2023-10-27-preview/targets.json
directive:
  - from: swagger-document
    where: "$.definitions.action"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentAction";
  - from: swagger-document
    where: "$.definitions.branch"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentBranch";
  - from: swagger-document
    where: "$.definitions.step"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentStep";
  - from: swagger-document
    where: "$.definitions.filter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilterParameters"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilterParameters";
  - from: swagger-document
    where: "$.definitions.selector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSelector";
  - from: swagger-document
    where: "$.definitions.listSelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetListSelector";
  - from: swagger-document
    where: "$.definitions.querySelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetQuerySelector";
```

### Tag: package-preview-2023-09

These settings apply only when `--tag=package-preview-2023-09` is specified on the command line.

```yaml $(tag) == 'package-preview-2023-09'
input-file:
  - preview/2023-09-01-preview/capabilities.json
  - preview/2023-09-01-preview/capabilityTypes.json
  - preview/2023-09-01-preview/experiments.json
  - preview/2023-09-01-preview/operations.json
  - preview/2023-09-01-preview/targetTypes.json
  - preview/2023-09-01-preview/targets.json
  - preview/2023-09-01-preview/operationStatuses.json
directive:
  - from: swagger-document
    where: "$.definitions.action"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentAction";
  - from: swagger-document
    where: "$.definitions.branch"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentBranch";
  - from: swagger-document
    where: "$.definitions.step"
    transform: >
      $["x-ms-client-name"] = "ChaosExperimentStep";
  - from: swagger-document
    where: "$.definitions.filter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilter"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilter";
  - from: swagger-document
    where: "$.definitions.simpleFilterParameters"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSimpleFilterParameters";
  - from: swagger-document
    where: "$.definitions.selector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetSelector";
  - from: swagger-document
    where: "$.definitions.listSelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetListSelector";
  - from: swagger-document
    where: "$.definitions.querySelector"
    transform: >
      $["x-ms-client-name"] = "ChaosTargetQuerySelector";
```

### Tag: package-2023-04-15-preview

These settings apply only when `--tag=package-2023-04-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-04-15-preview'
input-file:
  - preview/2023-04-15-preview/capabilities.json
  - preview/2023-04-15-preview/capabilityTypes.json
  - preview/2023-04-15-preview/experiments.json
  - preview/2023-04-15-preview/operations.json
  - preview/2023-04-15-preview/targetTypes.json
  - preview/2023-04-15-preview/targets.json
```

### Tag: package-2023-04-01-preview

These settings apply only when `--tag=package-2023-04-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2023-04-01-preview'
input-file:
  - preview/2023-04-01-preview/capabilities.json
  - preview/2023-04-01-preview/capabilityTypes.json
  - preview/2023-04-01-preview/experiments.json
  - preview/2023-04-01-preview/operations.json
  - preview/2023-04-01-preview/targetTypes.json
  - preview/2023-04-01-preview/targets.json
```

### Tag: package-2022-10-01-preview

These settings apply only when `--tag=package-2022-10-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-10-01-preview'
directive:
  - suppress: R3026
    reason: Patch is not implemented in this version.
    where:
      - $.definitions.experiment

input-file:
  - preview/2022-10-01-preview/capabilities.json
  - preview/2022-10-01-preview/capabilityTypes.json
  - preview/2022-10-01-preview/experiments.json
  - preview/2022-10-01-preview/operations.json
  - preview/2022-10-01-preview/targetTypes.json
  - preview/2022-10-01-preview/targets.json
```

### Tag: package-2022-07-01-preview

These settings apply only when `--tag=package-2022-07-01-preview` is specified on the command line.

```yaml $(tag) == 'package-2022-07-01-preview'
directive:
  - suppress: R3026
    reason: Patch is not implemented in this version.
    where:
      - $.definitions.experiment

input-file:
  - preview/2022-07-01-preview/capabilities.json
  - preview/2022-07-01-preview/experiments.json
  - preview/2022-07-01-preview/operations.json
  - preview/2022-07-01-preview/targets.json
  - preview/2022-07-01-preview/targetTypes.json
  - preview/2022-07-01-preview/capabilityTypes.json
```

### Tag: package-2021-09-15-preview

These settings apply only when `--tag=package-2021-09-15-preview` is specified on the command line.

```yaml $(tag) == 'package-2021-09-15-preview'
directive:
  - suppress: R3026
    reason: Patch is not implemented in this version.
    where:
      - $.definitions.experiment

input-file:
  - preview/2021-09-15-preview/capabilities.json
  - preview/2021-09-15-preview/experiments.json
  - preview/2021-09-15-preview/operations.json
  - preview/2021-09-15-preview/targets.json
  - preview/2021-09-15-preview/targetTypes.json
  - preview/2021-09-15-preview/capabilityTypes.json
```

---

# Code Generation

## Swagger to SDK

This section describes what SDK should be generated by the automatic system.
This is not used by Autorest itself.

```yaml $(swagger-to-sdk)
swagger-to-sdk:
  - repo: azure-sdk-for-python
  - repo: azure-sdk-for-java
  - repo: azure-sdk-for-go
  - repo: azure-resource-manager-schemas
  - repo: azure-cli-extensions
  - repo: azure-powershell
```

## Az

See configuration in [readme.az.md](./readme.az.md)

## Go

See configuration in [readme.go.md](./readme.go.md)

## Python

See configuration in [readme.python.md](./readme.python.md)

## CSharp

See configuration in [readme.csharp.md](./readme.csharp.md)

## Suppression

```yaml
directive:
  - suppress: TopLevelResourcesListBySubscription
    where: $.definitions.target
    from: targets.json
    reason: |-
      We have the top level resource list by subscription operation here: https://github.com/mariohdez/azure-rest-api-specs/blob/5a870f3163ae6e9cc5ed33d40cfff61764050213/specification/chaos/resource-manager/Microsoft.Chaos/preview/2021-09-15-preview/targets.json#L37

      this is a false positive I believe.
  - suppress: TopLevelResourcesListBySubscription
    where: $.definitions.target
    from: targets.json
    reason: |-
      we defined the the top level resource list here:

      https://github.com/mariohdez/azure-rest-api-specs/blob/5a870f3163ae6e9cc5ed33d40cfff61764050213/specification/chaos/resource-manager/Microsoft.Chaos/preview/2021-09-15-preview/targets.json#L37
  - suppress: EnumInsteadOfBoolean
    where: $.definitions.Operation.properties.isDataAction
    from: types.json
    reason: We are consuming the type model declaration from "common". I don't think our service is responsible for updating this error... Plz push back otherwise.
```

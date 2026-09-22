# chaos

> see https://aka.ms/autorest

This is the AutoRest configuration file for chaos.

## Workspace customer-managed keys in 2026-11-01

Workspace PUT, PATCH, GET, and list responses support `properties.encryption`.
Changes use `Microsoft.Chaos/workspaces/write`. Reads use
`Microsoft.Chaos/workspaces/read`. There are no separate encryption actions or
permissions.

Set `encryption.customerManagedKeyEncryption.keyEncryptionKeyUrl` to request a
customer-managed key. The URL must be a versionless HTTPS Key Vault key URL in
the supported cloud and Workspace tenant. Do not supply a key version, query
string, or fragment. Absence of `customerManagedKeyEncryption` means
Microsoft-managed protection. There is no writable protection-mode enum or
alternate key-setting shape.

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
        "keyEncryptionKeyUrl": "https://contoso-premium.vault.azure.net/keys/workspace-rsa-hsm"
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

### Replacement and partial updates

| Request | Result |
| --- | --- |
| PUT with a CMK object | Apply the requested key. A present `customerManagedKeyEncryption` requires a valid non-null `keyEncryptionKeyUrl`. |
| PUT without encryption or its CMK object, or with `encryption: {}` | Request Microsoft-managed protection. This removes existing customer-key protection. |
| PUT with null encryption, null CMK, or an incomplete CMK object | Return `400 InvalidEncryptionConfiguration` before any change. Empty encryption is valid; empty CMK is not. |
| PATCH with encryption omitted or an empty object | Keep the existing encryption setting. No PUT default is applied to the patch. |
| PATCH with CMK omitted | Keep the existing customer key. |
| PATCH with `"customerManagedKeyEncryption": null` or `"encryption": null` | Remove the writable key configuration through the normal removal operation. Keep onboarding and observations. |
| PATCH with `customerManagedKeyEncryption.keyEncryptionKeyUrl` | Merge the URL, validate, and enable or replace the customer key. |
| PATCH with an empty CMK object | Retain an existing URL. Reject the request if no valid URL exists after merging. |
| PATCH with only a null key URL | Reject the resulting CMK object without a URL. This is not removal of CMK. |

The service merges PATCH with stored writable fields, then validates the syntax
and completeness of the result before accepting the operation. Remote tenant
verification is the first stage of the existing configuration LRO, as described
below. In particular,
deleting the key URL while its CMK object remains is invalid. An empty patch is
not a request to reset encryption. Read-only `customerManagedKeyOnboarding` and
`status` inputs are ignored.

### Tenant verification

The key vault must belong to the same Microsoft Entra tenant as the Workspace.
Syntax, trusted cloud vault host, and key path are checked before acceptance.
For an operation that supplies a customer key, tenant discovery is the first
remote stage of the existing Workspace LRO. The operation can retain its input,
but requested encryption state is not persisted until the tenant matches.
No Azure Storage configuration or customer-data change occurs before that match.

The service sends a credential-free HTTPS request to the validated Key Vault
endpoint and reads the cloud authority and tenant from its documented
`401 WWW-Authenticate` challenge. It compares this tenant with the persisted
Workspace tenant. It does not obtain a token, make an authenticated retry,
follow an arbitrary redirect, or fetch a URL from the challenge.
This verifies tenant routing, not consent, key existence, grants, or key access.

| Discovery result | Existing LRO result |
| --- | --- |
| Deterministic tenant mismatch or permanently invalid/non-verifiable endpoint | `Failed` with `InvalidEncryptionConfiguration`, targeting `properties.encryption.customerManagedKeyEncryption.keyEncryptionKeyUrl`. Correct the key URL or use a vault in the Workspace tenant. |
| Transient timeout, throttling, or dependency 5xx | `Failed` with `EncryptionConfigurationFailed` and retry guidance. Honor `Retry-After` when provided. |

Do not expose expected or observed tenant IDs in errors. An unknown tenant is
not a match. Discovery failure leaves desired encryption, the active binding,
and observed protection unchanged. It is reported through the existing
operation-result error, not as a retrospective HTTP 400 from a status GET.
Removal without a desired customer key does not require tenant discovery.

For example, a tenant mismatch is reported by operation-status GET with HTTP
200 and this body:

```json
{
  "status": "Failed",
  "error": {
    "code": "InvalidEncryptionConfiguration",
    "message": "The key vault belongs to a different Microsoft Entra tenant than this Workspace. Use a key vault in the Workspace tenant.",
    "target": "properties.encryption.customerManagedKeyEncryption.keyEncryptionKeyUrl"
  }
}
```

A transient discovery failure uses the same envelope with
`EncryptionConfigurationFailed` and the message: "Key vault tenant verification
is temporarily unavailable. Retry the Workspace request after the indicated
retry interval. No encryption or customer-data changes were made."

The PATCH model uses `TypeSpec.Http.MergePatchUpdate<T>` on separate optional,
default-free fields. Three property-scoped `no-nullable` suppressions permit
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

`customerManagedKeyEncryption.keyEncryptionKeyUrl` is the last accepted
customer key, not proof that it protects active data. The read-only
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
then use the PATCH in `Workspaces_Update_EnableCustomerKey.json`.

To create a Workspace with customer-managed protection directly, first obtain
the application name and client ID for the target cloud from the service
onboarding documentation or Portal configuration. Consent and grant key access
before sending the full PUT in `Workspaces_CreateOrUpdate_WithCustomerKey.json`.
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

An identical request with `Applied` status succeeds without a new operation.
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
Accepted-operation failures appear in the operation result. Configuration or
health failures after tenant verification can also appear in
`encryption.status.error`; discovery failure leaves observed protection
unchanged. These codes do not add routes or permissions.

| HTTP status or result | Code | Corrective action |
| --- | --- | --- |
| 400 | `InvalidEncryptionConfiguration` | Supply a valid versionless key URL in a present CMK object, or correct the merged PATCH setting. No mutation occurs. |
| 400 | `EncryptionNotSupportedForWorkspace` | Use a Workspace that supports customer-managed encryption. |
| Failed tenant-discovery operation | `InvalidEncryptionConfiguration` | Correct the invalid/non-verifiable endpoint or use a vault in the Workspace tenant. No tenant IDs are disclosed. |
| Failed tenant-discovery operation | `EncryptionConfigurationFailed` | Retry after a transient dependency failure; honor `Retry-After` when provided. No encryption or customer-data change occurred. |
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
    "message": "The merged customerManagedKeyEncryption object has no valid key URL. Supply a versionless HTTPS Key Vault key URL, or delete the CMK object to select Microsoft-managed protection.",
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
| GET-to-PUT round trip | Preserve the complete requested key setting; ignore read-only inputs. |
| SDK PATCH omission versus null | Serialization preserves the difference between no change and deletion. |
| What-If with a GA template that omits the CMK object | Show the change to Microsoft-managed protection. |
| What-If with an unchanged complete customer-key setting | No false encryption change from service-owned observations. |
| Old-version template before and after enrollment | Succeed before enrollment; return the documented 409 after enrollment without changing any field. |
| Concurrent enrollment and old-version PUT | No stale-state bypass of the compatibility check. |
| Corrected GA template after enrollment | Succeed with the complete desired encryption setting. |
| Invalid merged PATCH or invalid PUT | Return 400 before persistence or storage work. |
| Tenant discovery mismatch or transient failure | Fail the accepted LRO with the corresponding documented code before persisting desired encryption or changing Storage/customer data. |
| Born-CMK onboarding | Published per-cloud application ID, Portal configuration, and GET agree; consent and key grant precede PUT. |
| Identical request during configuration | Return HTTP 409; do not return the same operation as an alternative. |
| DELETE with admitted writers | Close admission, drain writers, and complete the existing deletion LRO only when deletion conditions hold. |
| Removal, re-enable, and failure after a key change | Requested and observed values remain distinct and accurate. |

The generated SDK, service implementation, and deployment tests must consume the
same pinned CMK spec commit. Schema checks do not replace compatibility
acceptance or deployed-service tests.

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

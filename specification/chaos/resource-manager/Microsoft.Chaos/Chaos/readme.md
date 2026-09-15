# chaos

> see https://aka.ms/autorest

This is the AutoRest configuration file for chaos.

## Workspace customer-managed keys in 2026-11-01

Workspace PUT, PATCH, GET, and list responses support `properties.encryption`.
Changes use `Microsoft.Chaos/workspaces/write`. Reads use
`Microsoft.Chaos/workspaces/read`. There are no separate encryption actions or
permissions.

Set `keySource` to `Microsoft.Keyvault` and supply
`keyVaultProperties.keyUri` to request a customer-managed key. The URI must be a
versionless HTTPS Key Vault key URI in the supported cloud and Workspace tenant.
Do not supply a key version, query string, or fragment. `Microsoft.Keyvault` is
the exact public wire value; `Microsoft.KeyVault` is not an alternate spelling.
Set `keySource` to `Microsoft.Storage`, with no key properties, to request
Microsoft-managed protection.

### Replacement and partial updates

| Request | Result |
| --- | --- |
| PUT with complete encryption | Apply the requested setting. `keySource` is required. A key-properties object requires `keyUri`. |
| PUT without encryption | Apply the static default `{"keySource":"Microsoft.Storage"}`. This removes existing customer-key protection. |
| PUT with null or incomplete encryption | Return `400 InvalidEncryptionConfiguration` before any change. |
| PATCH with encryption omitted or an empty object | Keep the existing encryption setting. No PUT default is applied to the patch. |
| PATCH with `"encryption": null` | Delete the setting and apply Microsoft-managed protection through the normal removal operation. |
| PATCH with only `keyVaultProperties.keyUri` | Retain the existing key source and replace the URI after merge validation. |
| PATCH with `keySource: "Microsoft.Storage"` | Also delete any stored key properties with `"keyVaultProperties": null`. |
| PATCH with a null nested field | Delete that field. Reject the request if the merged setting is invalid. |

The service merges PATCH with stored writable fields, then validates the complete
result before it changes any resource or starts encryption work. In particular,
deleting `keySource`, or deleting the URI while the source remains
`Microsoft.Keyvault`, is invalid. An empty patch is not a request to reset
encryption. Read-only `identity` and `status` inputs are ignored.

The PATCH model uses `TypeSpec.Http.MergePatchUpdate<T>` on separate optional,
default-free fields. Four property-scoped `no-nullable` suppressions permit
request-only JSON Merge Patch deletion. The rule also reports nulls produced by
the public transform. The accepted PATCH-clear pattern in #45663 is prior art;
it does not constitute approval of this change. PUT and response fields are not
nullable.

The full encryption model is a named template instance so that the AutoRest
emitter includes the static object default. A plain named-model reference loses
that default in emitter version 0.71.0. The schema tests assert the emitted
default, not only the TypeSpec source.

The v3 lint comparison reports two additional warnings. The status error uses
common-types v5 because the existing service selects v5 in `main.tsp`; mixing
versions conflicts with `SCHEMA-COMMON-TYPES-VERSION`. A service-wide upgrade is
not part of this change. The nested encryption object preserves the public
Workspace contract. It is not flattened: the current TypeSpec review guidance
prohibits new `@flattenProperty` decorators. Neither warning is suppressed.

### Requested setting and observed result

`keySource` and `keyVaultProperties` are the last accepted request, not proof that
the key protects active data. The read-only `identity.applicationId` identifies
the service application for customer consent. It is available before enrollment.
It does not identify a customer-supplied managed identity.

The read-only `status` object contains `state`, optional `observedKeySource`,
optional `observedKeyUri`, optional `lastCheckedAt`, and optional `error`.
Unknown optional values are omitted, not returned as null. The observed URI is
the active URI reported by Azure Storage, including its version when available.
It is absent for Microsoft-managed protection. A failed check must not copy
requested values into observed fields.

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
While a configuration operation runs, the existing Workspace conflict response
applies, including for an identical request. After terminal failure, a valid
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

### Errors and older clients

Errors use the existing Azure Resource Manager `ErrorResponse` envelope.
Accepted-operation failures also appear in the operation result and
`encryption.status.error`. These codes do not add routes or permissions.

| HTTP status or result | Code | Corrective action |
| --- | --- | --- |
| 400 | `InvalidEncryptionConfiguration` | Supply a supported source and a valid versionless key URI, or correct the merged PATCH setting. No mutation occurs. |
| 400 | `EncryptionNotSupportedForWorkspace` | Use a Workspace that supports customer-managed encryption. |
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
      "keyVaultProperties": { "keyUri": null }
    }
  }
}
```

It returns HTTP 400 without changing the Workspace:

```json
{
  "error": {
    "code": "InvalidEncryptionConfiguration",
    "message": "The merged encryption setting uses Microsoft.Keyvault but has no key URI. Supply a versionless HTTPS Key Vault key URI, or remove encryption to select Microsoft-managed protection.",
    "target": "properties.encryption.keyVaultProperties.keyUri"
  }
}
```

These negative samples are documentation, not `x-ms-examples`: the example
validator requires success responses in each example and does not match a
specific error status to the existing default-only error response.

`ApiVersionNotSupportedForEncryption` is a service-specific compatibility
restriction, not the standard error for an unknown API version. Before any side
effect, a pre-CMK PUT is rejected if the desired or observed source is
customer-managed, or if active protection is unknown for an enrolled Workspace.
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
| What-If with a GA template that omits encryption | Show the change to the static Microsoft-managed default. |
| What-If with an unchanged complete customer-key setting | No false encryption change from service-owned observations. |
| Old-version template before and after enrollment | Succeed before enrollment; return the documented 409 after enrollment without changing any field. |
| Concurrent enrollment and old-version PUT | No stale-state bypass of the compatibility check. |
| Corrected GA template after enrollment | Succeed with the complete desired encryption setting. |
| Invalid merged PATCH or invalid PUT | Return 400 before persistence or storage work. |
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

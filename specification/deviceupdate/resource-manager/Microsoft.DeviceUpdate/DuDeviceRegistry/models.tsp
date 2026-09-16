import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.DeviceUpdate;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Provisioning state.
 */
union ProvisioningState {
  string,
  ResourceProvisioningState,

  /**
   * Provisioning State Accepted
   */
  Accepted: "Accepted",

  /**
   * Provisioning State Creating
   */
  Creating: "Creating",

  /**
   * Provisioning State Deleting
   */
  Deleting: "Deleting",
}

/**
 * Linked Account properties.
 *
 * All properties are read-only because resource state is managed exclusively
 * through the internal link* action endpoints (linkNamespace, linkModuleGateway,
 * linkDevice, linkDeviceGroup).
 */
model LinkedAccountProperties {
  /**
   * Provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Service-facing address for ADR→ADU communication.
   */
  @visibility(Lifecycle.Read)
  serviceAddress?: string;

  /**
   * Modern device-facing address.
   */
  @visibility(Lifecycle.Read)
  deviceAddress?: string;

  /**
   * Legacy SDK-facing device address.
   */
  @visibility(Lifecycle.Read)
  legacyDeviceAddress?: string;

  /**
   * Account linking state. Absent until first /link/initiate.
   */
  @visibility(Lifecycle.Read)
  linking?: AccountLinking;
}

/**
 * Update Instance properties.
 *
 * All properties are read-only because resource state is managed exclusively
 * through the internal link* action endpoints.
 */
model UpdateInstanceProperties {
  /**
   * Provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Service-facing address for ADR→ADU communication.
   */
  @visibility(Lifecycle.Read)
  serviceAddress?: string;

  /**
   * Account linking state. Absent until first /link/initiate.
   */
  @visibility(Lifecycle.Read)
  linking?: AccountLinking;
}

/**
 * Request payload used to update an existing Linked Account.
 */
model LinkedAccountUpdate {
  /**
   * List of key value pairs that describe the resource. This will overwrite the existing tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Updating dictionary of tags"
  tags?: Record<string>;

  /**
   * The type of identity used for the resource.
   */
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

/**
 * Request payload used to update an existing Update Instance.
 */
model UpdateInstanceUpdate {
  /**
   * List of key value pairs that describe the resource. This will overwrite the existing tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Updating dictionary of tags"
  tags?: Record<string>;

  /**
   * The type of identity used for the resource.
   */
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

/**
 * Account linking state.
 *
 * Tracks the relationship between a linkable resource and an ADR namespace.
 * The property is absent before any link attempt; its presence indicates a link
 * has been initiated. NotLinked is a logical initial state, not a persisted value.
 */
union AccountLinkingState {
  string,

  /**
   * Link in progress.
   */
  InProgress: "InProgress",

  /**
   * Successfully linked to a namespace.
   */
  Succeeded: "Succeeded",

  /**
   * Link was attempted but failed.
   */
  @removed(Versions.v2026_06_01_preview)
  Failed: "Failed",

  /**
   * Was linked; namespace was deleted. ADR sent namespaceDeleted. Terminal state — no
   * re-link is allowed. The resource is not auto-deleted; the customer must explicitly delete it.
   */
  Orphaned: "Orphaned",
}

/**
 * Account linking information. Present only after the first /link/initiate.
 */
model AccountLinking {
  /**
   * The ARM resource ID of the linked Azure Device Registry namespace.
   */
  namespaceResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces";
    }
  ]>;

  /**
   * The current linking state. Absent before any link attempt (logical NotLinked state).
   * See AccountLinkingState for the full state machine and transition rules.
   */
  linkingState: AccountLinkingState;
}

/**
 * Link notify action type.
 */
union LinkNotifyAction {
  string,

  /**
   * Commit the linking operation (InProgress → Succeeded). Resource starts
   * linked behavior.
   */
  commit: "commit",

  /**
   * Report that the linking operation failed.
   */
  fail: "fail",

  /**
   * The linked namespace was deleted (Succeeded → Orphaned). Terminal. Resource enters an
   * unusable state: devices are wiped, linked behavior stops, no re-link allowed.
   */
  namespaceDeleted: "namespaceDeleted",
}

/**
 * Identity information for inbound calls from Azure Device Registry.
 */
model InboundCallerIdentity {
  /**
   * The type of managed identity.
   */
  type: Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType;

  /**
   * ARM resource ID of the user-assigned managed identity. Required when type is "UserAssigned".
   */
  @typeChangedFrom(Versions.v2026_07_02_preview, string)
  userAssignedIdentity?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/**
 * Request body for /link/preflight.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model LinkPreflightRequest {
  /**
   * ARM resource ID of the namespace. Resource stores this for ARM property visibility and optional best-effort deletion notification.
   */
  namespaceResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces";
    }
  ]>;

  /**
   * Globally unique namespace identifier for backend operations.
   */
  namespaceUuid: string;

  /**
   * Managed Identity the resource should use for ADR communication.
   */
  inboundCallerIdentity: InboundCallerIdentity;
}

/**
 * Readiness status for preflight check.
 */
union LinkPreflightStatus {
  string,

  /** All readiness checks pass. */
  Ready: "Ready",

  /** One or more blocking errors exist. */
  NotReady: "NotReady",
}

/**
 * Response body for /link/preflight.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model LinkPreflightResponse {
  /**
   * Ready if all readiness checks pass, NotReady if any blocking error exists.
   */
  status: LinkPreflightStatus;

  /**
   * Array of blocking conditions when status is NotReady.
   */
  @Azure.ResourceManager.identifiers(#[])
  errors?: Azure.ResourceManager.CommonTypes.ErrorDetail[];

  /**
   * Array of non-blocking conditions ADR surfaces to the customer (e.g., edge/module presence per C3). May appear with either Ready or NotReady.
   */
  @Azure.ResourceManager.identifiers(#[])
  warnings?: Azure.ResourceManager.CommonTypes.ErrorDetail[];

  /**
   * Resource-defined sub-object for resource-internal data not available via ARM GET.
   */
  metadata?: LinkedResourceMetadata;
}

/**
 * Metadata returned by the preflight check.
 */
model LinkedResourceMetadata {
  /**
   * Total number of devices in the hub.
   */
  deviceCount?: int32;
}

/**
 * Request body for /link/initiate.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model LinkInitiateRequest {
  /**
   * ARM resource ID of the namespace.
   */
  namespaceResourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces";
    }
  ]>;

  /**
   * Globally unique namespace identifier for backend operations.
   */
  namespaceUuid: string;

  /**
   * Data-plane address of the ADR namespace.
   */
  dataAddress: string;

  /**
   * Managed Identity the resource should use for ADR communcation.
   */
  @renamedFrom(Versions.v2026_07_02_preview, "inboundCallerIdentity")
  @removed(Versions.v2026_07_02_preview)
  inboundCallerIdentityOld: InboundCallerIdentity;

  /**
   * Managed Identity the resource should use for ADR communication.
   */
  @added(Versions.v2026_07_02_preview)
  inboundCallerIdentity: InboundCallerIdentity;
}

/**
 * Request body for /link/notify. Idempotent: a duplicate notification matching the
 * resource's current linkingState returns 200 with no further state change, making
 * it safe for ADR to retry after transient failures.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model LinkNotifyRequest {
  /**
   * The action to perform on the linking state.
   */
  action: LinkNotifyAction;

  /**
   * Error code describing the failure. Required when action is "fail"; ignored otherwise.
   * Tracked on ADR's LRO for diagnostics.
   */
  errorCode?: string;

  /**
   * Human-readable reason for the failure. Required when action is "fail"; ignored otherwise.
   * Tracked on ADR's LRO for diagnostics.
   */
  reason?: string;
}

/**
 * Request body for /link/update. Acts as a PATCH — only provided properties are applied.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model LinkUpdateRequest {
  /**
   * ARM resource ID of the namespace.
   */
  namespaceResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces";
    }
  ]>;

  /**
   * Globally unique namespace identifier for backend operations.
   */
  namespaceUuid?: string;

  /**
   * ADR data-plane address for the namespace. Resource uses this for post-link runtime communication (device sync, provisioning).
   */
  dataAddress?: string;

  /**
   * User or Managed Identity for inbound calls from Azure Device Registry.
   */
  inboundCallerIdentity?: InboundCallerIdentity;
}

/**
 * Response body for /link/update. Empty on success.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Empty response object to satisfy R4008 AvoidEmptyResponseSchema, preserves forward extensibility"
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model LinkUpdateResponse is Record<unknown>;

/**
 * Response body for /link/update.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
model UpdateInstanceLinkUpdateResponse {
  /**
   * Placeholder state for the 200 response. This value is only a placeholder to satisfy the response contract and does not represent backend operation state.
   */
  state: string = "Succeeded";
}

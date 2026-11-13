import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.App;

/** A SandboxGroup resource, representing a group of sandboxes that share configuration defaults and quotas. */
@added(Versions.v2026_07_01)
model SandboxGroup is TrackedResource<SandboxGroupProperties> {
  ...ResourceNameParameter<
    Resource = SandboxGroup,
    KeyName = "sandboxGroupName",
    SegmentName = "sandboxGroups",
    NamePattern = "^(?![.-])[A-Za-z0-9-]{1,32}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@@added(SandboxGroup.identity, Versions.v2026_11_01_preview);

/** SandboxGroup resource specific properties. */
@added(Versions.v2026_07_01)
model SandboxGroupProperties {
  /** The resource ID of the Azure Container Apps environment to link to the sandbox group. A sandbox group can be linked after creation, but the link cannot then be changed or removed. For subsequent create-or-update (PUT) requests, specify the same environment ID; omitting or changing it returns 409 Conflict. Omitting it from an update (PATCH) request leaves the existing link unchanged. */
  environmentId?: armResourceIdentifier<[
    {
      type: "Microsoft.App/managedEnvironments";
    }
  ]>;

  /** The default domain of the linked Azure Container Apps environment. Sandbox endpoints use subdomains of this domain. This read-only property is populated by the service and is omitted when no environment is linked. */
  @visibility(Lifecycle.Read)
  defaultDomain?: string;

  /** Whether to publish per-sandbox resource metrics for this group. Omitted on PUT means false; omitted on PATCH preserves the current value. */
  @added(Versions.v2026_11_01_preview)
  enableDetailedMetrics?: boolean;

  /** Lifecycle event export configuration for sandboxes in this group. */
  @added(Versions.v2026_11_01_preview)
  telemetryConfig?: SandboxGroupTelemetryConfig;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Description is on the referenced type to avoid emitting a sibling of $ref."
  @visibility(Lifecycle.Read)
  provisioningState?: SandboxGroupProvisioningState;
}

/** Provisioning state of the SandboxGroup. */
@added(Versions.v2026_07_01)
@lroStatus
union SandboxGroupProvisioningState {
  string,
  ResourceProvisioningState,

  /** The resource is being provisioned. */
  InProgress: "InProgress",

  /** The resource is being updated. */
  Updating: "Updating",

  /** The resource is being deleted. */
  Deleting: "Deleting",
}

@added(Versions.v2026_07_01)
@armResourceOperations
interface SandboxGroups {
  /** Get the properties of a SandboxGroup. */
  get is ArmResourceRead<SandboxGroup>;

  /** Create or update a SandboxGroup. */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SandboxGroup>;

  /** Patches a SandboxGroup. */
  update is ArmCustomPatchAsync<
    SandboxGroup,
    SandboxGroupPatch,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = SandboxGroup>
  >;

  /** Delete a SandboxGroup. */
  delete is ArmResourceDeleteWithoutOkAsync<
    SandboxGroup,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /** Get all SandboxGroups in a resource group. */
  listByResourceGroup is ArmResourceListByParent<SandboxGroup>;

  /** Get all SandboxGroups for a subscription. */
  listBySubscription is ArmListBySubscription<SandboxGroup>;
}

/** A SandboxGroup resource for use in patch requests. */
@added(Versions.v2026_07_01)
model SandboxGroupPatch {
  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Resource tags are defined as an open key/value map per ARM contract."
  tags?: Record<string>;

  /** SandboxGroup properties that can be updated. */
  properties?: SandboxGroupPatchProperties;

  /** Managed identity updates. Omit to preserve the current identities. */
  @added(Versions.v2026_11_01_preview)
  identity?: OptionalProperties<PickProperties<
    Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
    "type" | "userAssignedIdentities"
  >>;
}

/** SandboxGroup resource specific properties for patch requests. */
@added(Versions.v2026_07_01)
model SandboxGroupPatchProperties {
  ...PickProperties<
    SandboxGroupProperties,
    "environmentId" | "enableDetailedMetrics"
  >;

  /** Lifecycle event export updates. Omit endpoints to preserve the current destinations; a supplied array replaces them. */
  @added(Versions.v2026_11_01_preview)
  telemetryConfig?: OptionalProperties<SandboxGroupTelemetryConfig>;
}

/** Lifecycle event export configuration for a sandbox group. */
@added(Versions.v2026_11_01_preview)
model SandboxGroupTelemetryConfig {
  /** Event Hub destinations for sandbox lifecycle events. */
  @minItems(1)
  @identifiers(#["fullyQualifiedNamespace", "eventHubName"])
  endpoints: SandboxGroupEventHubTelemetryEndpoint[];
}

/** An Event Hub destination for sandbox lifecycle events, delivered by the ADC platform. */
@added(Versions.v2026_11_01_preview)
model SandboxGroupEventHubTelemetryEndpoint {
  /** The telemetry destination kind. */
  kind: "EventHub";

  /** The Event Hubs namespace hostname, such as example.servicebus.windows.net. Must end with .servicebus.windows.net. */
  fullyQualifiedNamespace: string;

  /** The name of the destination Event Hub. */
  @minLength(1)
  @maxLength(256)
  @pattern("^[A-Za-z0-9](?:[A-Za-z0-9._-]*[A-Za-z0-9])?$")
  eventHubName: string;

  /** The event data to export. Only sandbox lifecycle events are supported. */
  @minItems(1)
  data: "LifecycleEvents"[];

  /** The delivery route. Sandbox group lifecycle events require platform-side delivery. */
  egressRouting: "Platform";

  /** Managed identity authentication for sending to the destination Event Hub. The identity must be assigned to this sandbox group and have permission to send to the Event Hub. */
  auth: SandboxGroupTelemetryAuth;
}

/** Managed identity authentication for sandbox group lifecycle event export. */
@added(Versions.v2026_11_01_preview)
@discriminator("kind")
model SandboxGroupTelemetryAuth {
  /** The managed identity authentication kind. */
  kind: SandboxGroupTelemetryAuthKind;
}

/** The supported managed identity authentication kinds. */
@added(Versions.v2026_11_01_preview)
union SandboxGroupTelemetryAuthKind {
  /** A user-assigned managed identity attached to the sandbox group. */
  ManagedIdentity: "ManagedIdentity",

  /** The sandbox group's system-assigned managed identity. */
  SystemAssignedManagedIdentity: "SystemAssignedManagedIdentity",

  string,
}

/** Uses the sandbox group's system-assigned managed identity to send lifecycle events. */
@added(Versions.v2026_11_01_preview)
model SandboxGroupSystemAssignedIdentityTelemetryAuth
  extends SandboxGroupTelemetryAuth {
  /** Selects the sandbox group's system-assigned managed identity. */
  kind: "SystemAssignedManagedIdentity";
}

/** Uses a user-assigned managed identity attached to the sandbox group to send lifecycle events. */
@added(Versions.v2026_11_01_preview)
model SandboxGroupUserAssignedIdentityTelemetryAuth
  extends SandboxGroupTelemetryAuth {
  /** Selects a user-assigned managed identity. */
  kind: "ManagedIdentity";

  /** The resource ID of the user-assigned managed identity attached to the sandbox group. */
  identity: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

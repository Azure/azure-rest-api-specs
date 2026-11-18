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

@@added(SandboxGroup.identity, Versions.v2026_07_01);

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

  /** Encryption-at-rest configuration. It cannot be added to or removed from an existing sandbox group. On PUT, include the existing configuration to retain it. On PATCH, omit it to retain the current configuration; a supplied configuration replaces it. */
  @added(Versions.v2026_11_01_preview)
  encryption?: SandboxGroupEncryption;

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
  @added(Versions.v2026_07_01)
  identity?: SandboxGroupIdentity;
}

/** The managed identity properties that can be updated on a SandboxGroup. */
@added(Versions.v2026_07_01)
model SandboxGroupIdentity
  is OptionalProperties<UpdateableProperties<Azure.ResourceManager.CommonTypes.ManagedServiceIdentity>>;

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

  /** Encryption-at-rest configuration. Omit to preserve the current configuration; a supplied configuration replaces it. Encryption cannot be added to or removed from an existing sandbox group. */
  @added(Versions.v2026_11_01_preview)
  encryption?: SandboxGroupEncryption;
}

/** Encryption-at-rest configuration for a sandbox group. */
@added(Versions.v2026_11_01_preview)
@discriminator("keySource")
model SandboxGroupEncryption {
  /** The source of the encryption key. */
  keySource: SandboxGroupEncryptionKeySource;
}

/** The source of the encryption key. */
@added(Versions.v2026_11_01_preview)
union SandboxGroupEncryptionKeySource {
  /** Encryption uses a Microsoft-managed key. */
  MicrosoftManaged: "MicrosoftManaged",

  /** Encryption uses a customer-managed key. */
  CustomerManaged: "CustomerManaged",

  string,
}

/** Encryption protected by a Microsoft-managed key. */
@added(Versions.v2026_11_01_preview)
model SandboxGroupMicrosoftManagedEncryption extends SandboxGroupEncryption {
  /** Encryption uses a Microsoft-managed key. */
  keySource: "MicrosoftManaged";
}

/** Encryption protected by a customer-managed key. */
@added(Versions.v2026_11_01_preview)
model SandboxGroupCustomerManagedEncryption extends SandboxGroupEncryption {
  /** Encryption uses a customer-managed key. */
  keySource: "CustomerManaged";

  /** The customer-managed key and identity used to access it. */
  customerManagedKeyEncryption: SandboxGroupCustomerManagedKeyEncryption;
}

/** Customer-managed key settings for a sandbox group. */
@added(Versions.v2026_11_01_preview)
model SandboxGroupCustomerManagedKeyEncryption {
  /** The identity used to access the key in Azure Key Vault. */
  keyEncryptionKeyIdentity: SandboxGroupKeyEncryptionKeyIdentity;

  /** The versioned or unversioned Azure Key Vault key URL. The vault must belong to the configured Azure cloud. */
  keyEncryptionKeyUrl: url;
}

/** An identity used to access a customer-managed key. */
@added(Versions.v2026_11_01_preview)
@discriminator("identityType")
model SandboxGroupKeyEncryptionKeyIdentity {
  /** The type of identity used to access the key. */
  identityType: SandboxGroupKeyEncryptionKeyIdentityType;

  /** The application client ID used to access the key in a different tenant, in GUID format. */
  federatedClientId?: string;
}

/** The type of identity used to access a customer-managed key. */
@added(Versions.v2026_11_01_preview)
union SandboxGroupKeyEncryptionKeyIdentityType {
  /** The sandbox group's system-assigned identity. */
  systemAssignedIdentity: "systemAssignedIdentity",

  /** A user-assigned identity attached to the sandbox group. */
  userAssignedIdentity: "userAssignedIdentity",

  /** An identity delegated from another resource. */
  delegatedResourceIdentity: "delegatedResourceIdentity",

  string,
}

/** Uses the sandbox group's system-assigned identity to access the key. */
@added(Versions.v2026_11_01_preview)
model SandboxGroupSystemAssignedKeyIdentity
  extends SandboxGroupKeyEncryptionKeyIdentity {
  /** Selects the system-assigned identity. */
  identityType: "systemAssignedIdentity";
}

/** Uses a user-assigned identity to access the key. */
@added(Versions.v2026_11_01_preview)
model SandboxGroupUserAssignedKeyIdentity
  extends SandboxGroupKeyEncryptionKeyIdentity {
  /** Selects a user-assigned identity. */
  identityType: "userAssignedIdentity";

  /** The resource ID of the user-assigned identity. */
  userAssignedIdentityResourceId: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

/** Uses a delegated identity to access the key. */
@added(Versions.v2026_11_01_preview)
model SandboxGroupDelegatedKeyIdentity
  extends SandboxGroupKeyEncryptionKeyIdentity {
  /** Selects a delegated resource identity. */
  identityType: "delegatedResourceIdentity";

  /** The client ID of the delegated identity, in GUID format. */
  delegatedIdentityClientId: string;
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

  /** The event data to export. Currently, only sandbox lifecycle events are supported. */
  @minItems(1)
  data: SandboxGroupTelemetryData[];

  /** The delivery route. Sandbox group lifecycle events require platform-side delivery. */
  egressRouting: SandboxGroupTelemetryEgressRouting;

  /** Managed identity authentication for sending to the destination Event Hub. The identity must be assigned to this sandbox group and have permission to send to the Event Hub. */
  auth: SandboxGroupTelemetryAuth;
}

/** Event data supported by sandbox lifecycle export. */
@added(Versions.v2026_11_01_preview)
union SandboxGroupTelemetryData {
  /** Sandbox lifecycle events. */
  LifecycleEvents: "LifecycleEvents",

  string,
}

/** Supported delivery routes for sandbox lifecycle event export. */
@added(Versions.v2026_11_01_preview)
union SandboxGroupTelemetryEgressRouting {
  /** Event delivery is performed by the platform. */
  Platform: "Platform",

  string,
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

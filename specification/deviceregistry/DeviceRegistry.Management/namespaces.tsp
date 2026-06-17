import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/error.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@doc("Namespace definition.")
model Namespace is TrackedResource<NamespaceProperties> {
  @doc("The name of the namespace.")
  @key("namespaceName")
  @segment("namespaces")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Explicit identity property required for @typeChangedFrom versioning"
  @doc("The managed service identities assigned to this resource.")
  @typeChangedFrom(
    Versions.v2026_11_01_preview,
    Azure.ResourceManager.CommonTypes.SystemAssignedServiceIdentity
  )
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;
}

@added(Versions.v2024_10_01_preview)
@doc("The namespace messaging endpoints model.")
model Messaging {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Dictionary keyed by user-supplied endpoint name."
  @doc("Dictionary of messaging endpoints.")
  endpoints?: Record<MessagingEndpoint>;
}

@added(Versions.v2026_02_01_preview)
@doc("The namespace management endpoints model.")
model Management {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Dictionary of management endpoints.")
  endpoints?: Record<ManagementEndpoint>;
}

@added(Versions.v2024_10_01_preview)
@doc("The namespace properties model.")
model NamespaceProperties {
  @doc("Globally unique, immutable, non-reusable ID.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @added(Versions.v2026_11_01_preview)
  @doc("The data-plane endpoint used to perform operations in this namespace.")
  @visibility(Lifecycle.Read)
  dataEndpoint?: string;

  @added(Versions.v2026_11_01_preview)
  @doc("The certificate management state for the namespace.")
  certificateManagement?: CertificateManagementState;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Container wrapping the messaging endpoints dictionary."
  @doc("Assigned and unassigned messaging endpoints.")
  messaging?: Messaging;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Assigned and unassigned management endpoints.")
  @added(Versions.v2026_02_01_preview)
  management?: Management;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Container wrapping the provisioning endpoints dictionary."
  @added(Versions.v2026_11_01_preview)
  @doc("The provisioning endpoints associated with this namespace.")
  provisioning?: NamespaceProvisioning;

  @added(Versions.v2026_11_01_preview)
  @doc("The identity used for outbound calls from the ADR namespace. If not specified and the namespace has a system-assigned identity enabled, the system-assigned identity is used by default.")
  outboundIdentity?: OutboundIdentity;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Container wrapping the device update endpoints dictionary."
  @added(Versions.v2026_11_01_preview)
  @doc("The device update endpoints associated with this namespace.")
  updating?: NamespaceUpdating;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_11_01_preview)
@doc("The certificate management state for the namespace.")
union CertificateManagementState {
  string,

  @doc("Certificate management is enabled.")
  Enabled: "Enabled",

  @doc("Certificate management is disabled.")
  Disabled: "Disabled",
}

@added(Versions.v2024_10_01_preview)
@doc("Namespace messaging endpoint model used by a device to connect to a service.")
model MessagingEndpoint {
  @doc("Type of connection used for messaging endpoint.")
  @removed(Versions.v2025_07_01_preview)
  type?: string;

  @doc("Type of connection used for messaging endpoint.")
  @added(Versions.v2025_07_01_preview)
  endpointType?: string;

  // Intentionally typed as string, not url. Values are bare hostnames
  // without scheme (e.g., "myhub.azure-devices.net").
  @added(Versions.v2025_07_01_preview)
  @madeOptional(Versions.v2026_11_01_preview)
  @doc("The endpoint address used by services.")
  address?: string;

  @doc("The messaging endpoint Azure resource Id.")
  resourceId?: string;

  @added(Versions.v2026_11_01_preview)
  @doc("The endpoint address used by devices.")
  @visibility(Lifecycle.Read)
  deviceAddress?: string;

  @added(Versions.v2026_11_01_preview)
  @doc("The identity the linked resource uses to call the ADR namespace.")
  inboundCallerIdentity: InboundCallerIdentity;

  @added(Versions.v2026_11_01_preview)
  @doc("The linking state of this messaging endpoint.")
  @visibility(Lifecycle.Read)
  linkingState?: NamespaceLinkingStateValue;

  @added(Versions.v2026_11_01_preview)
  @doc("The provisioning configuration for this messaging endpoint.")
  provisioning?: MessagingEndpointProvisioning;
}

@added(Versions.v2026_02_01_preview)
@doc("Namespace management endpoint model used by service to connect to device.")
model ManagementEndpoint {
  @doc("Type of connection used for management endpoint.")
  endpointType: string;

  @doc("The endpoint address to connect to.")
  address: string;

  @doc("The scope ID for the management endpoint.")
  scopeId: string;

  @doc("The messaging endpoint Azure resource Id.")
  resourceId: string;
}

@added(Versions.v2026_11_01_preview)
@doc("The provisioning configuration for a messaging endpoint.")
model MessagingEndpointProvisioning {
  @doc("The availability status of the messaging endpoint.")
  availability?: MessagingEndpointAvailability;

  @doc("The allocation weight for this messaging endpoint.")
  allocationWeight?: int32;
}

@added(Versions.v2026_11_01_preview)
@doc("The availability status of a messaging endpoint.")
union MessagingEndpointAvailability {
  string,

  @doc("The messaging endpoint is available.")
  Available: "Available",

  @doc("The messaging endpoint is disabled.")
  Disabled: "Disabled",
}

@added(Versions.v2026_11_01_preview)
@doc("The provisioning endpoints associated with this namespace.")
model NamespaceProvisioning {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Dictionary keyed by user-supplied endpoint name."
  @doc("Dictionary of provisioning endpoints.")
  endpoints?: Record<ProvisioningEndpoint>;
}

@added(Versions.v2026_11_01_preview)
@doc("The device update endpoints associated with this namespace.")
model NamespaceUpdating {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Dictionary keyed by user-supplied endpoint name."
  @doc("Dictionary of device update endpoints.")
  endpoints?: Record<UpdatingEndpoint>;
}

@added(Versions.v2026_11_01_preview)
@doc("A provisioning service endpoint linked to this namespace.")
model ProvisioningEndpoint {
  @doc("Type of provisioning resource.")
  endpointType: ProvisioningEndpointType;

  @doc("The provisioning endpoint Azure resource Id.")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Devices/provisioningServices";
    }
  ]>;

  @doc("The identity the linked resource uses to call the ADR namespace.")
  inboundCallerIdentity: InboundCallerIdentity;

  @doc("The linking state of this provisioning endpoint.")
  @visibility(Lifecycle.Read)
  linkingState?: NamespaceLinkingStateValue;
}

@added(Versions.v2026_11_01_preview)
@doc("A device update endpoint linked to this namespace.")
model UpdatingEndpoint {
  @doc("Type of device update resource.")
  endpointType: UpdatingEndpointType;

  @doc("The device update endpoint Azure resource Id.")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceUpdate/linkedAccounts";
    }
  ]>;

  @doc("The identity the linked resource uses to call the ADR namespace.")
  inboundCallerIdentity: InboundCallerIdentity;

  @doc("The linking state of this device update endpoint.")
  @visibility(Lifecycle.Read)
  linkingState?: NamespaceLinkingStateValue;

  // Intentionally typed as string, not url. Values are bare hostnames
  // without scheme (e.g., "account.api.adu.microsoft.com").
  @doc("The service-facing endpoint address.")
  @visibility(Lifecycle.Read)
  serviceAddress?: string;

  @doc("The device-facing endpoint address.")
  @visibility(Lifecycle.Read)
  deviceAddress?: string;

  @doc("The legacy device-facing endpoint address for older client SDKs.")
  @visibility(Lifecycle.Read)
  legacyDeviceAddress?: string;
}

@added(Versions.v2026_11_01_preview)
@doc("The type of provisioning resource that can be linked to a namespace.")
union ProvisioningEndpointType {
  string,

  @doc("Azure Device Provisioning Service.")
  DPS: "Microsoft.Devices/provisioningServices",
}

@added(Versions.v2026_11_01_preview)
@doc("The type of device update resource that can be linked to a namespace.")
union UpdatingEndpointType {
  string,

  @doc("Azure Device Update linked account.")
  ADU: "Microsoft.DeviceUpdate/linkedAccounts",
}

@added(Versions.v2026_11_01_preview)
@doc("The linking state values for namespace endpoint entries.")
union NamespaceLinkingStateValue {
  string,

  @doc("Linking is in progress.")
  InProgress: "InProgress",

  @doc("Linking succeeded.")
  Succeeded: "Succeeded",

  @doc("Linking failed.")
  Failed: "Failed",
}

@added(Versions.v2026_11_01_preview)
@doc("The identity a linked resource uses for inbound calls to the ADR namespace.")
model InboundCallerIdentity {
  @doc("The identity type.")
  type: InboundCallerIdentityType;

  @doc("The resource ID of the user-assigned managed identity. Required when type is UserAssigned.")
  userAssignedIdentity?: string;
}

@added(Versions.v2026_11_01_preview)
@doc("The type of identity used for inbound calls to the ADR namespace.")
union InboundCallerIdentityType {
  string,

  @doc("System-assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User-assigned managed identity.")
  UserAssigned: "UserAssigned",
}

@added(Versions.v2026_11_01_preview)
@doc("The identity the ADR namespace uses for outbound calls. If this property is null and the namespace has a system-assigned identity enabled, the namespace defaults to using the system-assigned identity for outbound calls.")
model OutboundIdentity {
  @doc("The identity type.")
  type: OutboundIdentityType;

  @doc("The resource ID of the user-assigned managed identity. Required when type is UserAssigned.")
  userAssignedIdentity?: string;
}

@added(Versions.v2026_11_01_preview)
@doc("The type of identity used for outbound calls from the ADR namespace.")
union OutboundIdentityType {
  string,

  @doc("System-assigned managed identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User-assigned managed identity.")
  UserAssigned: "UserAssigned",
}

@added(Versions.v2025_07_01_preview)
@doc("Request body for the migrate resources operation in to Namespace resource.")
model NamespaceMigrateRequest {
  @doc("Scope of the migrate resources operation.")
  scope?: Scope;

  @doc("List of asset resources to be migrated.")
  resourceIds?: string[];
}

@added(Versions.v2025_07_01_preview)
@doc("Response for the migrate asset resources operation into Namespace resource.")
model NamespaceMigrateResponse {
  @doc("List of migrate results containing result of each asset migrate operation.")
  @identifiers(#["resourceId"])
  migrateResults?: MigrateResult[];
}

@added(Versions.v2025_07_01_preview)
@doc("Result of Migrate operation of asset resource into Namespace resource.")
model MigrateResult {
  @doc("The resource Id of the asset resource.")
  resourceId?: string;

  @doc("The result of the migrate operation.")
  result?: MigrateResultType;

  @doc("The error if the migrate operation is not successful.")
  error?: Error;
}

@added(Versions.v2025_07_01_preview)
@doc("Result Type of Migrate Operation.")
union MigrateResultType {
  @doc("Resource Migrate operation is successful.")
  Succeeded: "Succeeded",

  @doc("Resource Migrate operation is not successful.")
  Failed: "Failed",

  string,
}

@added(Versions.v2025_07_01_preview)
@doc("Scope of the migrate resources operation.")
union Scope {
  @doc("Scoping the migration to resourceIds provided")
  Resources: "Resources",

  string,
}

@added(Versions.v2024_10_01_preview)
@armResourceOperations
interface Namespaces {
  get is ArmResourceRead<Namespace>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Namespace>;
  update is ArmResourcePatchAsync<Namespace, NamespaceProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Namespace>;
  listByResourceGroup is ArmResourceListByParent<Namespace>;
  listBySubscription is ArmListBySubscription<Namespace>;

  @doc("Migrate the resources into Namespace")
  @added(Versions.v2025_07_01_preview)
  migrate is ArmResourceActionAsync<
    Namespace,
    NamespaceMigrateRequest,
    NamespaceMigrateResponse,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

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

@added(Versions.v2025_07_01_preview)
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

  ...ManagedSystemAssignedIdentityProperty;
}

@added(Versions.v2025_07_01_preview)
@doc("The namespace messaging endpoints model.")
model Messaging {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Dictionary of messaging endpoints.")
  endpoints?: Record<MessagingEndpoint>;
}

@added(Versions.v2026_04_01)
@doc("The namespace management endpoints model.")
model Management {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Dictionary of management endpoints.")
  endpoints?: Record<ManagementEndpoint>;
}

@added(Versions.v2025_07_01_preview)
@doc("The namespace properties model.")
model NamespaceProperties {
  @doc("Globally unique, immutable, non-reusable ID.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Assigned and unassigned messaging endpoints.")
  messaging?: Messaging;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" ""
  @doc("Assigned and unassigned management endpoints.")
  @added(Versions.v2026_04_01)
  management?: Management;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Container wrapping the provisioning endpoints dictionary."
  @added(Versions.v2026_11_01_preview)
  @doc("The provisioning endpoints associated with this namespace.")
  provisioning?: NamespaceProvisioning;

  @added(Versions.v2026_11_01_preview)
  @doc("The identity used for outbound calls from the ADR namespace. If not specified and the namespace has a system-assigned identity enabled, the system-assigned identity is used by default.")
  outboundIdentity?: OutboundIdentity;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Container wrapping the observability endpoints dictionary."
  @added(Versions.v2026_11_02_preview)
  @doc("""
    The observability configuration associated with this namespace.
    On create or replace, this property replaces the complete observability
    configuration. Omitting it removes any existing configuration. On PATCH,
    omitting it preserves the existing configuration.
    """)
  observability?: NamespaceObservability;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Container wrapping the device update endpoints dictionary."
  @added(Versions.v2026_11_02_preview)
  @doc("The device update endpoints associated with this namespace.")
  updating?: NamespaceUpdating;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_07_01_preview)
@doc("Namespace messaging endpoint model used by a device to connect to a service.")
model MessagingEndpoint {
  @doc("Type of connection used for messaging endpoint.")
  endpointType?: string;

  @madeOptional(Versions.v2026_11_01_preview)
  @doc("The endpoint address to connect to.")
  address?: string;

  @doc("The messaging endpoint Azure resource Id.")
  resourceId?: string;

  @added(Versions.v2026_11_01_preview)
  @doc("The endpoint address used by devices.")
  @visibility(Lifecycle.Read)
  deviceAddress?: string;

  @added(Versions.v2026_11_01_preview)
  @doc("The identity the linked resource uses to call the ADR namespace.")
  inboundCallerIdentity?: InboundCallerIdentity;

  @added(Versions.v2026_11_01_preview)
  @doc("The linking state of this messaging endpoint.")
  @visibility(Lifecycle.Read)
  linkingState?: NamespaceLinkingStateValue;

  @added(Versions.v2026_11_01_preview)
  @doc("The error detail surfaced when this messaging endpoint is in the Failed linking state.")
  @visibility(Lifecycle.Read)
  linkingError?: NamespaceLinkingError;

  @added(Versions.v2026_11_01_preview)
  @doc("The provisioning configuration for this messaging endpoint.")
  provisioning?: MessagingEndpointProvisioning;
}

@added(Versions.v2026_04_01)
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

@added(Versions.v2025_07_01_preview)
@doc("Request body for the migrate resources operation in to Namespace resource.")
model NamespaceMigrateRequest {
  @doc("Scope of the migrate resources operation.")
  scope?: Scope;

  @doc("List of asset resources to be migrated.")
  resourceIds?: string[];
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
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

@added(Versions.v2026_11_02_preview)
@doc("The observability configuration associated with a namespace.")
model NamespaceObservability {
  @doc("""
    Whether observability features are enabled. When omitted during create or
    replace, the effective value is false. On PATCH, omission preserves the
    current value. Setting this property to false prevents new Live Data
    sessions while preserving the configured endpoints.
    """)
  enabled?: boolean;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Dictionary keyed by the full ARM resource ID of an Azure Custom Location."
  @doc("""
    Event Grid MQTT endpoints keyed by custom location resource ID. The key is
    the full ARM resource ID of the Azure Custom Location for one AIO site.
    On PATCH, omission preserves the existing endpoint map. Supplying this
    property replaces the complete endpoint map.
    """)
  endpoints?: Record<ObservabilityEndpoint>;
}

@added(Versions.v2026_11_02_preview)
@doc("An Event Grid MQTT endpoint used for namespace observability.")
model ObservabilityEndpoint {
  @doc("The Azure resource type of the observability endpoint.")
  endpointType: ObservabilityEndpointType;

  // Intentionally typed as string, not url. The value is an MQTT hostname
  // without a URI scheme.
  @doc("The Event Grid namespace MQTT hostname.")
  address: string;

  @doc("The Azure IoT Operations instance scope ID used for MQTT authentication and Live Data topic construction.")
  scopeId: string;

  @doc("The full Azure resource ID of the Event Grid namespace.")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.EventGrid/namespaces";
    }
  ]>;
}

@added(Versions.v2026_11_02_preview)
@doc("The type of endpoint used for namespace observability.")
union ObservabilityEndpointType {
  string,

  @doc("Azure Event Grid namespace.")
  EventGridNamespace: "Microsoft.EventGrid/namespaces",
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

@added(Versions.v2026_11_02_preview)
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

  @doc("The error detail surfaced when this provisioning endpoint is in the Failed linking state.")
  @visibility(Lifecycle.Read)
  linkingError?: NamespaceLinkingError;
}

@added(Versions.v2026_11_02_preview)
@doc("A device update endpoint linked to this namespace.")
model UpdatingEndpoint {
  @doc("Type of device update resource.")
  endpointType: UpdatingEndpointType;

  @doc("The device update endpoint Azure resource Id.")
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.DeviceUpdate/updateInstances";
    }
  ]>;

  @doc("The identity the linked resource uses to call the ADR namespace.")
  inboundCallerIdentity: InboundCallerIdentity;

  @doc("The linking state of this device update endpoint.")
  @visibility(Lifecycle.Read)
  linkingState?: NamespaceLinkingStateValue;

  @doc("The error detail surfaced when this device update endpoint is in the Failed linking state.")
  @visibility(Lifecycle.Read)
  linkingError?: NamespaceLinkingError;

  // Intentionally typed as string, not url. Values are bare hostnames
  // without scheme (e.g., "account.api.adu.microsoft.com").
  @doc("The service-facing endpoint address.")
  @visibility(Lifecycle.Read)
  serviceAddress?: string;
}

@added(Versions.v2026_11_01_preview)
@doc("The type of provisioning resource that can be linked to a namespace.")
union ProvisioningEndpointType {
  string,

  @doc("Azure Device Provisioning Service.")
  DPS: "Microsoft.Devices/provisioningServices",
}

@added(Versions.v2026_11_02_preview)
@doc("The type of device update resource that can be linked to a namespace.")
union UpdatingEndpointType {
  string,

  @doc("Azure Device Update instance.")
  ADU: "Microsoft.DeviceUpdate/updateInstances",
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
@doc("Error detail for an endpoint whose linking state is Failed. Present only while the linking state is Failed and removed when the endpoint recovers.")
model NamespaceLinkingError {
  @doc("Error code that classifies the linking failure.")
  @visibility(Lifecycle.Read)
  code?: string;

  @doc("Human-readable message describing the linking failure.")
  @visibility(Lifecycle.Read)
  message?: string;
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

@added(Versions.v2026_11_02_preview)
@doc("The type of report.")
union ReportType {
  string,

  @doc("Compliance report describing the updating state of devices in the namespace.")
  NamespaceUpdateComplianceReport: "NamespaceUpdateComplianceReport",

  @doc("Report describing the best available updates and update compliance for the devices within a group.")
  GroupBestUpdatesComplianceReport: "GroupBestUpdatesComplianceReport",

  @doc("Report listing the installable updates for the devices within a group.")
  GroupInstallableUpdatesReport: "GroupInstallableUpdatesReport",
}

@added(Versions.v2026_11_02_preview)
@doc("Selector identifying a report by type and target. Shared as the request body for both the generateReport and getLatestReport actions.")
@discriminator("reportType")
model ReportSelector {
  @doc("The type of report.")
  reportType: ReportType;

  @doc("The target of this report (e.g. group resource).")
  reportTarget?: string;
}

@added(Versions.v2026_11_02_preview)
@doc("Request to generate a NamespaceUpdateCompliance report.")
model NamespaceUpdateComplianceReportRequest extends ReportSelector {
  reportType: ReportType.NamespaceUpdateComplianceReport;
}

@added(Versions.v2026_11_02_preview)
@doc("Request to generate a GroupBestUpdates compliance report.")
model GroupBestUpdatesComplianceReportRequest extends ReportSelector {
  reportType: ReportType.GroupBestUpdatesComplianceReport;

  @doc("The group that the report is generated against.")
  reportTarget: string;
}

@added(Versions.v2026_11_02_preview)
@doc("Request to generate a GroupInstallableUpdates report.")
model GroupInstallableUpdatesReportRequest extends ReportSelector {
  reportType: ReportType.GroupInstallableUpdatesReport;

  @doc("The group that the report is generated against.")
  reportTarget: string;
}

@added(Versions.v2026_11_02_preview)
@doc("Base report type.")
@discriminator("reportType")
model Report {
  @doc("The type of report.")
  @visibility(Lifecycle.Read)
  reportType: ReportType;

  @doc("The scope the report was generated against.")
  @visibility(Lifecycle.Read)
  reportTarget?: string;

  @doc("The UTC timestamp at which the report was generated.")
  @visibility(Lifecycle.Read)
  generatedAt: utcDateTime;

  @doc("The UTC timestamp at which the report will no longer be retained and available.")
  @visibility(Lifecycle.Read)
  expiresAt: utcDateTime;
}

@added(Versions.v2026_11_02_preview)
@doc("Result of a NamespaceUpdateCompliance report.")
model NamespaceUpdateComplianceReport extends Report {
  @doc("Discriminator for NamespaceUpdateCompliance reports.")
  @visibility(Lifecycle.Read)
  reportType: ReportType.NamespaceUpdateComplianceReport;

  @doc("Total number of devices in the namespace that are eligible for updates.")
  @visibility(Lifecycle.Read)
  totalUpdateableDeviceCount: int32;

  @doc("Number of updateable devices that are currently on the latest available update.")
  @visibility(Lifecycle.Read)
  onLatestUpdateDeviceCount: int32;

  @doc("Number of updateable devices for which a newer update is available but not yet applied.")
  @visibility(Lifecycle.Read)
  newUpdatesAvailableDeviceCount: int32;

  @doc("Number of updateable devices currently being updated to the latest available update.")
  @visibility(Lifecycle.Read)
  updatesInProgressDeviceCount: int32;

  @doc("Total number of devices in the namespace that are not eligible for updates.")
  @visibility(Lifecycle.Read)
  totalNotUpdateableDeviceCount: int32;
}

@added(Versions.v2026_11_02_preview)
@doc("Criteria selecting which devices an update targets.")
model TargetDevices {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Free-form compatibility properties keyed by device attribute name."
  @doc("Free-form compatibility properties (e.g. manufacturer, model) used to match devices.")
  @visibility(Lifecycle.Read)
  compatProperties: Record<string>;

  @doc("The agent profile that the targeted devices must implement.")
  @visibility(Lifecycle.Read)
  agentProfile: int32;
}

@added(Versions.v2026_11_02_preview)
@doc("A best-available update for a subset of devices in the group.")
model BestUpdate {
  @doc("The devices that this update targets.")
  @visibility(Lifecycle.Read)
  targetDevices: TargetDevices;

  @doc("The URI of the best-available update for the targeted devices.")
  @visibility(Lifecycle.Read)
  updateResourceId: string;

  @doc("The number of devices in the group that target this update but are not yet running it.")
  @visibility(Lifecycle.Read)
  devicesNotOnBestUpdateCount: int32;
}

@added(Versions.v2026_11_02_preview)
@doc("Group-level update compliance counters.")
model GroupUpdateCompliance {
  @doc("Total number of devices in the group that are eligible for updates.")
  @visibility(Lifecycle.Read)
  totalUpdateableDeviceCount: int32;

  @doc("Number of updateable devices that are currently on the best available update.")
  @visibility(Lifecycle.Read)
  onBestUpdateDeviceCount: int32;

  @doc("Number of updateable devices for which a better update is available but not yet applied.")
  @visibility(Lifecycle.Read)
  bestUpdateAvailableDeviceCount: int32;

  @doc("Number of updateable devices currently being updated to the best available update.")
  @visibility(Lifecycle.Read)
  devicesInProgressOnBestUpdate: int32;

  @doc("Total number of devices in the group that are not eligible for updates.")
  @visibility(Lifecycle.Read)
  totalNotUpdateableDeviceCount: int32;
}

@added(Versions.v2026_11_02_preview)
@doc("Result of a GroupBestUpdates compliance report.")
model GroupBestUpdatesComplianceReport extends Report {
  @doc("Discriminator for GroupBestUpdates compliance reports.")
  @visibility(Lifecycle.Read)
  reportType: ReportType.GroupBestUpdatesComplianceReport;

  @doc("The group that this report was generated against.")
  @visibility(Lifecycle.Read)
  reportTarget: string;

  @doc("Group-level update compliance counters.")
  @visibility(Lifecycle.Read)
  updateCompliance: GroupUpdateCompliance;

  @doc("The best-available updates for devices in the group. May be empty.")
  @identifiers(#[])
  @visibility(Lifecycle.Read)
  bestUpdates: BestUpdate[];
}

@added(Versions.v2026_11_02_preview)
@doc("An installable update represented as a resource URI.")
model InstallableUpdate {
  @doc("The URI of the installable update.")
  @visibility(Lifecycle.Read)
  updateResourceId: string;
}

@added(Versions.v2026_11_02_preview)
@doc("The set of installable updates available for a class of target devices in the group.")
model InstallableUpdatesForTargetDevices {
  @doc("The devices that this set of updates targets.")
  @visibility(Lifecycle.Read)
  targetDevices: TargetDevices;

  @doc("The updates that can be installed on the targeted devices.")
  @identifiers(#[])
  @visibility(Lifecycle.Read)
  installableUpdates: InstallableUpdate[];
}

@added(Versions.v2026_11_02_preview)
@doc("Result of a GroupInstallableUpdates report.")
model GroupInstallableUpdatesReport extends Report {
  @doc("Discriminator for GroupInstallableUpdates reports.")
  @visibility(Lifecycle.Read)
  reportType: ReportType.GroupInstallableUpdatesReport;

  @doc("The group that this report was generated against.")
  @visibility(Lifecycle.Read)
  reportTarget: string;

  @doc("Installable updates grouped by the devices they target. May be empty.")
  @identifiers(#[])
  @visibility(Lifecycle.Read)
  installableUpdatesAndTargetDevices: InstallableUpdatesForTargetDevices[];
}

@added(Versions.v2025_07_01_preview)
@armResourceOperations
interface Namespaces {
  get is ArmResourceRead<Namespace>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<Namespace>;
  // Using 'ArmCustomPatchAsync' instead of 'ArmResourcePatchAsync' to define the correct patch payload for the resource.
  // This is a workaround to fix the patch payload that otherwise will expose the 'location' field (not present in patch),
  // since otherwise it extends the ARM TrackedResource type.
  update is ArmCustomPatchAsync<
    Namespace,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Namespace,
      NamespaceProperties
    >
  >;
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

  @doc("Generate a report for a namespace.")
  @added(Versions.v2026_11_02_preview)
  generateReport is ArmResourceActionAsync<
    Namespace,
    ReportSelector,
    Report,
    LroHeaders = ArmAsyncOperationHeader &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Get the most recently generated report of the given type and target without triggering a new report generation.")
  @added(Versions.v2026_11_02_preview)
  getLatestReport is ArmResourceActionSync<Namespace, ReportSelector, Report>;
}

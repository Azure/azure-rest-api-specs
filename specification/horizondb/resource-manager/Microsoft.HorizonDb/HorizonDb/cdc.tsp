import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

@added(Versions.v2026_10_01)
@doc("A caller-selected lowercase name for a HorizonDB change data capture resource.")
@pattern("^[a-z0-9](?:[-a-z0-9]*[a-z0-9])?$")
@minLength(1)
@maxLength(63)
scalar CdcResourceName extends string;

@added(Versions.v2026_10_01)
@doc("An Azure resource ID that identifies a HorizonDB change data capture destination.")
scalar CdcDestinationResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters/cdcDestinations",
    }
  ]>;

@added(Versions.v2026_10_01)
@doc("An Azure resource ID that identifies a HorizonDB change data capture identity assignment.")
scalar CdcIdentityAssignmentResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters/cdcDestinations/identityAssignments",
    }
  ]>;

@added(Versions.v2026_10_01)
@doc("An Azure resource ID that identifies a HorizonDB change data capture configuration.")
scalar CdcConfigurationResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.HorizonDb/clusters/cdcConfigurations",
    }
  ]>;

@added(Versions.v2026_10_01)
@doc("An Azure resource ID that identifies a user-assigned managed identity.")
scalar CdcUserAssignedIdentityResourceId
  extends armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities",
    }
  ]>;

@added(Versions.v2026_10_01)
@doc("The singleton change data capture capability for a HorizonDB cluster.")
@singleton("default")
@parentResource(Cluster)
model CdcCapability
  is Azure.ResourceManager.ProxyResource<CdcCapabilityProperties> {
  ...ResourceNameParameter<
    Resource = CdcCapability,
    KeyName = "cdcName",
    SegmentName = "cdc",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@added(Versions.v2026_10_01)
@doc("A reusable Microsoft Fabric destination for HorizonDB change data capture configurations.")
@parentResource(Cluster)
model CdcDestination
  is Azure.ResourceManager.ProxyResource<CdcDestinationProperties> {
  @doc("The caller-selected name of the change data capture destination.")
  @key("destinationName")
  @path
  @segment("cdcDestinations")
  name: CdcResourceName;

  ...Azure.ResourceManager.EntityTagProperty;
}

@added(Versions.v2026_10_01)
@doc("A user-assigned managed identity authorized for a HorizonDB change data capture destination.")
@parentResource(CdcDestination)
model IdentityAssignment
  is Azure.ResourceManager.ProxyResource<CdcIdentityAssignmentProperties> {
  @doc("The caller-selected name of the identity assignment.")
  @key("assignmentName")
  @path
  @segment("identityAssignments")
  name: CdcResourceName;

  ...Azure.ResourceManager.EntityTagProperty;
}

@added(Versions.v2026_10_01)
@doc("A HorizonDB database enrollment for Microsoft Fabric Mirroring.")
@parentResource(Cluster)
model CdcConfiguration
  is Azure.ResourceManager.ProxyResource<CdcConfigurationProperties> {
  @doc("The caller-selected ARM-safe name of the change data capture configuration. The exact PostgreSQL database name is stored in properties.databaseName.")
  @key("configurationName")
  @path
  @segment("cdcConfigurations")
  name: CdcResourceName;

  ...Azure.ResourceManager.EntityTagProperty;
}

@added(Versions.v2026_10_01)
@doc("The requested state of a HorizonDB change data capture capability, destination, or configuration.")
union CdcDesiredState {
  string,

  @doc("The resource should be enabled.")
  Enabled: "Enabled",

  @doc("The resource should be disabled.")
  Disabled: "Disabled",
}

@added(Versions.v2026_10_01)
@doc("The effective state of a HorizonDB change data capture capability or configuration.")
union CdcEffectiveState {
  string,

  @doc("The resource is being enabled.")
  Enabling: "Enabling",

  @doc("The resource is enabled.")
  Enabled: "Enabled",

  @doc("The resource is being disabled.")
  Disabling: "Disabling",

  @doc("The resource is disabled.")
  Disabled: "Disabled",

  @doc("The resource is available with reduced functionality or impaired health.")
  Degraded: "Degraded",

  @doc("The resource is not operational because reconciliation failed.")
  Failed: "Failed",
}

@added(Versions.v2026_10_01)
@doc("The effective state of a HorizonDB change data capture destination.")
union CdcDestinationEffectiveState {
  string,

  @doc("The destination is waiting for a validated active identity assignment.")
  WaitingForIdentity: "WaitingForIdentity",

  @doc("The destination is being enabled.")
  Enabling: "Enabling",

  @doc("The destination is enabled.")
  Enabled: "Enabled",

  @doc("The destination is being disabled.")
  Disabling: "Disabling",

  @doc("The destination is disabled.")
  Disabled: "Disabled",

  @doc("The destination is available with reduced functionality or impaired health.")
  Degraded: "Degraded",

  @doc("The destination is not operational because reconciliation failed.")
  Failed: "Failed",
}

@added(Versions.v2026_10_01)
@doc("The implementation architecture used to capture and publish changes.")
union CdcReplicationArchitecture {
  string,

  @doc("Change capture runs with the HorizonDB compute layer.")
  ComputeBased: "ComputeBased",

  @doc("Change capture runs with the HorizonDB storage layer.")
  StorageBased: "StorageBased",

  @doc("Change capture uses both compute and storage components.")
  Hybrid: "Hybrid",
}

@added(Versions.v2026_10_01)
@doc("The lifecycle state of the HorizonDB change data capture extension.")
union CdcExtensionState {
  string,

  @doc("The extension is not installed.")
  NotInstalled: "NotInstalled",

  @doc("The extension is being installed.")
  Installing: "Installing",

  @doc("The extension is ready.")
  Ready: "Ready",

  @doc("The extension is being upgraded.")
  Upgrading: "Upgrading",

  @doc("The extension is being removed.")
  Removing: "Removing",

  @doc("The extension operation failed.")
  Failed: "Failed",
}

@added(Versions.v2026_10_01)
@doc("The readiness of HorizonDB engine settings required for change data capture.")
union CdcEngineConfigurationState {
  string,

  @doc("The required engine settings are ready.")
  Ready: "Ready",

  @doc("One or more required engine settings are not ready.")
  NotReady: "NotReady",

  @doc("The service is reconciling required engine settings.")
  Reconciling: "Reconciling",

  @doc("Engine-setting reconciliation failed.")
  Failed: "Failed",
}

@added(Versions.v2026_10_01)
@doc("The availability of a read-write endpoint for change data capture engine mutations.")
union CdcReadWriteEndpointState {
  string,

  @doc("An eligible read-write endpoint is ready.")
  Ready: "Ready",

  @doc("No eligible read-write endpoint is currently available.")
  Unavailable: "Unavailable",
}

@added(Versions.v2026_10_01)
@doc("The destination type supported by this API version.")
union CdcDestinationType {
  string,

  @doc("A Microsoft Fabric destination.")
  Fabric: "Fabric",
}

@added(Versions.v2026_10_01)
@doc("The protocol used to communicate with a change data capture destination.")
union CdcProtocol {
  string,

  @doc("The destination's native protocol.")
  Native: "Native",
}

@added(Versions.v2026_10_01)
@doc("The reason that a change data capture configuration exists.")
union CdcUsageProfile {
  string,

  @doc("The configuration publishes database changes for Microsoft Fabric Mirroring.")
  Mirroring: "Mirroring",
}

@added(Versions.v2026_10_01)
@doc("The lifecycle state of a change data capture identity assignment.")
union CdcIdentityAssignmentState {
  string,

  @doc("The identity is being assigned.")
  Assigning: "Assigning",

  @doc("The identity is assigned.")
  Assigned: "Assigned",

  @doc("The identity assignment is being removed.")
  Removing: "Removing",

  @doc("The identity assignment operation failed.")
  Failed: "Failed",
}

@added(Versions.v2026_10_01)
@doc("The activation state of a change data capture identity assignment.")
union CdcIdentityActivationState {
  string,

  @doc("The identity assignment is not active.")
  Inactive: "Inactive",

  @doc("The identity assignment is being activated.")
  Activating: "Activating",

  @doc("The identity assignment is active.")
  Active: "Active",

  @doc("The identity assignment is being deactivated.")
  Deactivating: "Deactivating",

  @doc("The identity activation transition failed.")
  Failed: "Failed",
}

@added(Versions.v2026_10_01)
@doc("The validation state of a change data capture identity assignment.")
union CdcIdentityValidationState {
  string,

  @doc("Identity validation has not started.")
  NotStarted: "NotStarted",

  @doc("Identity validation is running.")
  Running: "Running",

  @doc("Identity validation succeeded.")
  Succeeded: "Succeeded",

  @doc("Identity validation failed.")
  Failed: "Failed",
}

@added(Versions.v2026_10_01)
@doc("The state of a destination-owned replication session.")
union CdcReplicationState {
  string,

  @doc("A destination session does not apply to the current resource state.")
  NotApplicable: "NotApplicable",

  @doc("No destination session is connected.")
  NotConnected: "NotConnected",

  @doc("A destination session is connecting.")
  Connecting: "Connecting",

  @doc("A destination session is replicating changes.")
  Replicating: "Replicating",

  @doc("A destination session is reconnecting after an interruption.")
  Reconnecting: "Reconnecting",

  @doc("The destination session is paused.")
  Paused: "Paused",

  @doc("The destination session is stopping.")
  Stopping: "Stopping",

  @doc("The destination session is operating with impaired health.")
  Degraded: "Degraded",

  @doc("The destination session failed.")
  Failed: "Failed",
}

@added(Versions.v2026_10_01)
@doc("The relationship of a change data capture configuration to the current writer topology.")
union CdcTopologyBindingState {
  string,

  @doc("The configuration belongs to the current active writer.")
  Active: "Active",

  @doc("The service is reconciling the configuration after a writer change.")
  Reconciling: "Reconciling",

  @doc("The destination session must bind to a replacement configuration resource ID.")
  RebindRequired: "RebindRequired",

  @doc("The configuration belongs to a former writer and has been replaced.")
  Superseded: "Superseded",

  @doc("Equivalent change data capture state could not be materialized without overwriting unrelated state.")
  Conflict: "Conflict",
}

@added(Versions.v2026_10_01)
@doc("Customer-safe health information for a HorizonDB change data capture resource.")
model CdcStatus {
  @doc("A stable machine-readable status code.")
  @visibility(Lifecycle.Read)
  code: string;

  @doc("A localized customer-safe description of the current status.")
  @visibility(Lifecycle.Read)
  message: string;
}

@added(Versions.v2026_10_01)
@doc("The installed HorizonDB change data capture extension and its current state.")
model CdcExtensionStatus {
  @doc("The extension name.")
  @visibility(Lifecycle.Read)
  name: string;

  @doc("The installed extension version.")
  @visibility(Lifecycle.Read)
  version: string;

  @doc("The current extension lifecycle state.")
  @visibility(Lifecycle.Read)
  state: CdcExtensionState;
}

@added(Versions.v2026_10_01)
@doc("The current readiness of prerequisites shared by change data capture configurations.")
model CdcPrerequisiteStatus {
  @doc("The readiness of the required engine configuration.")
  @visibility(Lifecycle.Read)
  engineConfigurationState: CdcEngineConfigurationState;

  @doc("The availability of the read-write endpoint required for engine mutations.")
  @visibility(Lifecycle.Read)
  readWriteEndpointState: CdcReadWriteEndpointState;
}

@added(Versions.v2026_10_01)
@doc("The current validation result for a change data capture identity assignment.")
model IdentityValidationStatus {
  @doc("The current validation state.")
  @visibility(Lifecycle.Read)
  state: CdcIdentityValidationState;

  @doc("The date and time, in UTC, when validation most recently completed.")
  @visibility(Lifecycle.Read)
  validatedAtUtc?: utcDateTime;

  @doc("The customer-safe validation error when validation failed.")
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@added(Versions.v2026_10_01)
@doc("The destination-owned replication-session status known to HorizonDB.")
model CdcReplicationStatus {
  @doc("The current replication-session state.")
  @visibility(Lifecycle.Read)
  state: CdcReplicationState;

  @doc("An opaque identifier of a destination-owned artifact, such as a Microsoft Fabric mirrored-database item. HorizonDB does not create, update, or delete the identified artifact.")
  @visibility(Lifecycle.Read)
  externalArtifactId?: string;

  @doc("The date and time, in UTC, when a destination session most recently connected.")
  @visibility(Lifecycle.Read)
  lastConnectedAtUtc?: utcDateTime;
}

@added(Versions.v2026_10_01)
@doc("The current writer-topology binding of a change data capture configuration.")
model CdcTopologyBindingStatus {
  @doc("The configuration's relationship to the current writer topology.")
  @visibility(Lifecycle.Read)
  state: CdcTopologyBindingState;

  @doc("A monotonically increasing topology generation for this logical stream.")
  @visibility(Lifecycle.Read)
  generation: int64;

  @doc("The Azure resource ID of the cluster that currently owns the active configuration projection.")
  @visibility(Lifecycle.Read)
  activeClusterResourceId: HorizonDbClusterResourceId;

  @doc("The replacement configuration resource ID when this projection has been superseded or requires rebinding.")
  @visibility(Lifecycle.Read)
  replacementConfigurationResourceId?: CdcConfigurationResourceId;
}

@added(Versions.v2026_10_01)
@doc("The properties of the singleton change data capture capability.")
model CdcCapabilityProperties {
  @doc("The requested capability state.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  desiredState: CdcDesiredState;

  @doc("The current effective capability state.")
  @visibility(Lifecycle.Read)
  effectiveState: CdcEffectiveState;

  @doc("The provisioning state of the latest capability mutation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Whether HorizonDB may automatically upgrade the service-owned change data capture extension within the supported compatibility policy.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  autoUpgradeExtension?: boolean;

  @doc("The implementation architecture currently used for change capture.")
  @visibility(Lifecycle.Read)
  replicationArchitecture: CdcReplicationArchitecture;

  @doc("The installed change data capture extension and its current lifecycle state.")
  @visibility(Lifecycle.Read)
  extension: CdcExtensionStatus;

  @doc("The current readiness of change data capture engine and read-write endpoint prerequisites.")
  @visibility(Lifecycle.Read)
  prerequisites: CdcPrerequisiteStatus;

  @doc("The number of change data capture destinations under this cluster.")
  @visibility(Lifecycle.Read)
  destinationCount: int32;

  @doc("The number of change data capture configurations under this cluster.")
  @visibility(Lifecycle.Read)
  configurationCount: int32;

  @doc("Customer-safe health information for the capability.")
  @visibility(Lifecycle.Read)
  status: CdcStatus;
}

@added(Versions.v2026_10_01)
@doc("Properties for updating the singleton change data capture capability. Omitted properties preserve their current values.")
model CdcCapabilityPropertiesForPatchUpdate {
  @doc("The requested capability state.")
  @visibility(Lifecycle.Update)
  desiredState?: CdcDesiredState;

  @doc("Whether HorizonDB may automatically upgrade the service-owned change data capture extension within the supported compatibility policy.")
  @visibility(Lifecycle.Update)
  autoUpgradeExtension?: boolean;
}

@added(Versions.v2026_10_01)
@doc("A sparse update request for the singleton change data capture capability.")
model CdcCapabilityForPatchUpdate {
  @doc("The capability properties to update.")
  properties?: CdcCapabilityPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("Destination-specific settings discriminated by destinationType.")
@discriminator("destinationType")
model CdcDestinationDetails {
  @doc("The destination family.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  destinationType: CdcDestinationType;

  @doc("The protocol used to communicate with the destination.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  protocol: CdcProtocol;
}

@added(Versions.v2026_10_01)
@doc("Settings for a Microsoft Fabric destination.")
model FabricDestinationDetails extends CdcDestinationDetails {
  @doc("Specifies a Microsoft Fabric destination.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  destinationType: "Fabric";

  @doc("Specifies the Microsoft Fabric native destination protocol.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  protocol: "Native";

  @doc("The opaque identifier of the Microsoft Fabric workspace that owns the destination artifact.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  workspaceId: string;
}

@added(Versions.v2026_10_01)
@doc("The properties of a Microsoft Fabric change data capture destination.")
model CdcDestinationProperties {
  @doc("The immutable Microsoft Fabric destination settings. Resubmitting the same values is accepted; changing them requires deleting and recreating the destination.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  destination: CdcDestinationDetails;

  @doc("The requested destination state.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  desiredState: CdcDesiredState;

  @doc("The current effective destination state.")
  @visibility(Lifecycle.Read)
  effectiveState: CdcDestinationEffectiveState;

  @doc("The provisioning state of the latest destination mutation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The resource ID of the currently active identity assignment, if one is active.")
  @visibility(Lifecycle.Read)
  activeIdentityAssignmentResourceId?: CdcIdentityAssignmentResourceId;

  @doc("The number of change data capture configurations that reference this destination.")
  @visibility(Lifecycle.Read)
  configurationCount: int32;

  @doc("Customer-safe health information for the destination.")
  @visibility(Lifecycle.Read)
  status: CdcStatus;
}

@added(Versions.v2026_10_01)
@doc("Properties for updating a change data capture destination. Omitted properties preserve their current values.")
model CdcDestinationPropertiesForPatchUpdate {
  @doc("The requested destination state.")
  @visibility(Lifecycle.Update)
  desiredState?: CdcDesiredState;
}

@added(Versions.v2026_10_01)
@doc("A sparse update request for a change data capture destination.")
model CdcDestinationForPatchUpdate {
  @doc("The destination properties to update.")
  properties?: CdcDestinationPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("The properties of a change data capture identity assignment.")
model CdcIdentityAssignmentProperties {
  @doc("The immutable resource ID of the user-assigned managed identity. Resubmitting the same value is accepted; changing it requires deleting and recreating the assignment.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  identityResourceId: CdcUserAssignedIdentityResourceId;

  @doc("The current assignment lifecycle state.")
  @visibility(Lifecycle.Read)
  effectiveState: CdcIdentityAssignmentState;

  @doc("The current activation state within the parent destination.")
  @visibility(Lifecycle.Read)
  activationState: CdcIdentityActivationState;

  @doc("The Microsoft Entra principal ID resolved from the user-assigned managed identity, represented as an RFC 4122 GUID.")
  @visibility(Lifecycle.Read)
  principalId: string;

  @doc("The Microsoft Entra tenant ID resolved from the user-assigned managed identity, represented as an RFC 4122 GUID.")
  @visibility(Lifecycle.Read)
  tenantId: string;

  @doc("The provisioning state of the latest identity-assignment mutation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The latest validation result for this identity assignment.")
  @visibility(Lifecycle.Read)
  validation: IdentityValidationStatus;

  @doc("Customer-safe health information for the identity assignment.")
  @visibility(Lifecycle.Read)
  status: CdcStatus;
}

@added(Versions.v2026_10_01)
@doc("The properties of a Microsoft Fabric Mirroring configuration.")
model CdcConfigurationProperties {
  @doc("The exact PostgreSQL database name enrolled in this logical stream. This value is immutable.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  databaseName: string;

  @doc("The immutable usage profile. API version 2026-10-01 accepts Mirroring only.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  usageProfile: CdcUsageProfile;

  @doc("The immutable resource ID of an enabled change data capture destination under the same cluster.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  destinationResourceId: CdcDestinationResourceId;

  @doc("A service-generated identifier for the logical stream, represented as an RFC 4122 GUID. This value remains stable when a writer role moves and the service materializes a replacement ARM resource under the new writer cluster.")
  @visibility(Lifecycle.Read)
  logicalStreamId: string;

  @doc("The requested configuration state.")
  @visibility(Lifecycle.Create, Lifecycle.Update, Lifecycle.Read)
  desiredState: CdcDesiredState;

  @doc("The current effective configuration state.")
  @visibility(Lifecycle.Read)
  effectiveState: CdcEffectiveState;

  @doc("The provisioning state of the latest configuration mutation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The change data capture extension state for the enrolled database.")
  @visibility(Lifecycle.Read)
  extension: CdcExtensionStatus;

  @doc("The known status of the destination-owned replication session.")
  @visibility(Lifecycle.Read)
  replication: CdcReplicationStatus;

  @doc("The current writer-topology binding for this logical stream.")
  @visibility(Lifecycle.Read)
  topology: CdcTopologyBindingStatus;

  @doc("Customer-safe health information for the configuration.")
  @visibility(Lifecycle.Read)
  status: CdcStatus;
}

@added(Versions.v2026_10_01)
@doc("Properties for updating a change data capture configuration. Omitted properties preserve their current values.")
model CdcConfigurationPropertiesForPatchUpdate {
  @doc("The requested configuration state.")
  @visibility(Lifecycle.Update)
  desiredState?: CdcDesiredState;
}

@added(Versions.v2026_10_01)
@doc("A sparse update request for a change data capture configuration.")
model CdcConfigurationForPatchUpdate {
  @doc("The configuration properties to update.")
  properties?: CdcConfigurationPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("The request to activate an identity assignment for a change data capture destination.")
model ActivateCdcIdentityRequest {
  @doc("The resource ID of an inactive, successfully validated identity assignment under the destination receiving the action.")
  identityAssignmentResourceId: CdcIdentityAssignmentResourceId;

  @doc("Whether existing destination sessions should drain before the identity cutover. The default is false.")
  drainExistingSessions?: boolean;
}

@added(Versions.v2026_10_01)
@doc("The completed result of activating a change data capture destination identity.")
model ActivateCdcIdentityResult {
  @doc("The completed activation status.")
  @visibility(Lifecycle.Read)
  status: "Succeeded";

  @doc("The resource ID of the newly active identity assignment.")
  @visibility(Lifecycle.Read)
  targetIdentityAssignmentResourceId: CdcIdentityAssignmentResourceId;

  @doc("The resource ID of the previously active identity assignment, when one existed.")
  @visibility(Lifecycle.Read)
  previousIdentityAssignmentResourceId?: CdcIdentityAssignmentResourceId;
}

@added(Versions.v2026_10_01)
@doc("The required entity tag precondition for a change data capture destination identity activation.")
model CdcDestinationIfMatchParameter {
  @doc("The destination entity tag. The action proceeds only when this value matches the destination's current entity tag.")
  @header("If-Match")
  ifMatch: string;
}

@added(Versions.v2026_10_01)
@doc("Operations for the singleton HorizonDB change data capture capability.")
@armResourceOperations
interface CdcCapabilities {
  @doc("Gets the singleton change data capture capability for a HorizonDB cluster.")
  get is ArmResourceRead<CdcCapability>;

  @doc("Creates or replaces the singleton change data capture capability and reconciles shared engine prerequisites.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CdcCapability>;

  @doc("Updates mutable change data capture capability properties. Omitted properties preserve their current values.")
  update is ArmCustomPatchAsync<CdcCapability, CdcCapabilityForPatchUpdate>;

  @doc("Deletes the change data capture capability after all change data capture destinations and configurations have been removed.")
  delete is ArmResourceDeleteWithoutOkAsync<CdcCapability>;

  @doc("Lists the optional singleton change data capture capability for a cluster. The result contains zero or one item.")
  list is ArmResourceListByParent<CdcCapability>;
}

@added(Versions.v2026_10_01)
@doc("Operations for reusable Microsoft Fabric change data capture destinations.")
@armResourceOperations
interface CdcDestinations {
  @doc("Gets a change data capture destination.")
  get is ArmResourceRead<CdcDestination>;

  @doc("Creates or replaces a Microsoft Fabric change data capture destination.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CdcDestination>;

  @doc("Updates mutable change data capture destination properties. Omitted properties preserve their current values.")
  update is ArmCustomPatchAsync<CdcDestination, CdcDestinationForPatchUpdate>;

  @doc("Deletes a change data capture destination after all referencing configurations and identity assignments have been removed.")
  delete is ArmResourceDeleteWithoutOkAsync<CdcDestination>;

  @doc("Lists change data capture destinations in a HorizonDB cluster.")
  list is ArmResourceListByParent<CdcDestination>;

  @doc("Atomically activates a validated identity assignment for this destination. If-Match is evaluated against the destination entity tag. Activating the already-active assignment succeeds idempotently.")
  @action("activateIdentity")
  activateIdentity is ArmResourceActionAsync<
    CdcDestination,
    ActivateCdcIdentityRequest,
    ActivateCdcIdentityResult,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<CdcDestination> &
      CdcDestinationIfMatchParameter
  >;
}

@added(Versions.v2026_10_01)
@doc("Operations for user-assigned managed identities authorized for a change data capture destination.")
@armResourceOperations
interface IdentityAssignments {
  @doc("Gets a change data capture identity assignment.")
  get is ArmResourceRead<IdentityAssignment>;

  @doc("Creates or idempotently replaces a change data capture identity assignment. The identity resource ID is immutable.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<IdentityAssignment>;

  @doc("Deletes an inactive change data capture identity assignment.")
  delete is ArmResourceDeleteWithoutOkAsync<IdentityAssignment>;

  @doc("Lists identity assignments for a change data capture destination.")
  list is ArmResourceListByParent<IdentityAssignment>;
}

@added(Versions.v2026_10_01)
@doc("Operations for HorizonDB Microsoft Fabric Mirroring configurations.")
@armResourceOperations
interface CdcConfigurations {
  @doc("Gets a change data capture configuration.")
  get is ArmResourceRead<CdcConfiguration>;

  @doc("Creates or replaces a change data capture configuration that enrolls a PostgreSQL database for Microsoft Fabric Mirroring.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<CdcConfiguration>;

  @doc("Updates mutable change data capture configuration properties. Omitted properties preserve their current values.")
  update is ArmCustomPatchAsync<
    CdcConfiguration,
    CdcConfigurationForPatchUpdate
  >;

  @doc("Deletes a change data capture configuration after destination-side replication has been stopped or detached. This operation never deletes the Microsoft Fabric mirrored-database item.")
  delete is ArmResourceDeleteWithoutOkAsync<CdcConfiguration>;

  @doc("Lists change data capture configurations in a HorizonDB cluster.")
  list is ArmResourceListByParent<CdcConfiguration>;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./hciCommon.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core;

@armProviderNamespace("Microsoft.AzureStackHCI")
namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state"
@doc("Cluster details.")
@discriminator("kind")
model Cluster is Azure.ResourceManager.TrackedResource<{}> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge Solution type to support polymorphic resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind: EdgeSolutionType;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Clusters {
  @doc("Get HCI cluster.")
  get is ArmResourceRead<Cluster>;

  @doc("Create an HCI cluster.")
  create is ArmResourceCreateOrReplaceSync<Cluster>;

  @doc("Update an HCI cluster.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Cluster, ClusterPatch>;

  @doc("Delete an HCI cluster.")
  delete is ArmResourceDeleteWithoutOkAsync<Cluster>;

  @doc("List all HCI clusters in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  @doc("List all HCI clusters in a subscription.")
  listBySubscription is ArmListBySubscription<Cluster>;

  @doc("Upload certificate.")
  uploadCertificate is ArmResourceActionNoResponseContentAsync<
    Cluster,
    UploadCertificateRequest
  >;

  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  #suppress "@azure-tools/typespec-azure-core/no-operation-id"
  @doc("Create cluster identity.")
  createClusterIdentity is ArmResourceActionAsync<
    Cluster,
    void,
    StackHciClusterIdentityResponseResult
  >;

  @doc("Extends Software Assurance Benefit to a cluster.")
  extendSoftwareAssuranceBenefit is ArmResourceActionAsync<
    Cluster,
    SoftwareAssuranceChangeRequest,
    Cluster
  >;

  @doc("Trigger Log Collection on a cluster.")
  triggerLogCollection is ArmResourceActionAsync<
    Cluster,
    LogCollectionRequest,
    Cluster
  >;

  @doc("Configure RemoteSupport on a cluster.")
  configureRemoteSupport is ArmResourceActionAsync<
    Cluster,
    RemoteSupportRequest,
    Cluster
  >;

  @doc("Update cluster secrets locations.")
  updateSecretsLocations is ArmResourceActionAsync<
    Cluster,
    SecretsLocationsChangeRequest,
    Cluster
  >;
}

@@doc(Cluster.name, "The name of the cluster.");
@@doc(Clusters.create::parameters.resource, "Details of the HCI cluster.");
@@doc(Clusters.update::parameters.properties, "Details of the HCI cluster.");
@@doc(Clusters.uploadCertificate::parameters.body,
  "Upload certificate request."
);
@@doc(Clusters.extendSoftwareAssuranceBenefit::parameters.body,
  "Software Assurance Change Request Payload"
);
@@doc(Clusters.triggerLogCollection::parameters.body,
  "Trigger Log Collection Request Payload"
);
@@doc(Clusters.configureRemoteSupport::parameters.body,
  "Configure Remote Support Request Payload"
);

////////////models////////////////

@doc("Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).")
union ManagedServiceIdentityType {
  string,

  @doc("No managed service identity.")
  None: "None",

  @doc("System-assigned managed service identity.")
  SystemAssigned: "SystemAssigned",

  @doc("User-assigned managed service identity.")
  UserAssigned: "UserAssigned",
}

@doc("Customer Intent for Software Assurance Benefit.")
union SoftwareAssuranceIntent {
  string,

  @doc("Enable Software Assurance Benefit.")
  Enable: "Enable",

  @doc("Disable Software Assurance Benefit.")
  Disable: "Disable",
}

@doc("Provisioning state.")
union ClusterProvisioningState {
  string,

  @doc("The provisioning succeeded.")
  Succeeded: "Succeeded",

  @doc("The provisioning failed.")
  Failed: "Failed",

  @doc("The provisioning was canceled.")
  Canceled: "Canceled",

  @doc("The provisioning was accepted.")
  Accepted: "Accepted",

  @doc("The provisioning is in progress.")
  Provisioning: "Provisioning",

  @doc("The provisioning state is not specified.")
  NotSpecified: "NotSpecified",

  @doc("The cluster is being created.")
  Creating: "Creating",

  @doc("The cluster is being updated.")
  Updating: "Updating",

  @doc("The cluster is being deleted.")
  Deleting: "Deleting",

  @doc("The cluster is being moved.")
  Moving: "Moving",

  @doc("The cluster has been deleted.")
  Deleted: "Deleted",

  @doc("The provisioning partially succeeded.")
  PartiallySucceeded: "PartiallySucceeded",

  @doc("The provisioning is in progress.")
  InProgress: "InProgress",

  @doc("The cluster disable operation is in progress.")
  DisableInProgress: "DisableInProgress",

  @doc("The cluster is connected.")
  Connected: "Connected",

  @doc("The cluster is partially connected.")
  PartiallyConnected: "PartiallyConnected",

  @doc("The cluster is disconnected.")
  Disconnected: "Disconnected",
}

@doc("Status of the cluster agent.")
union Status {
  string,

  @doc("The agent has not yet registered.")
  NotYetRegistered: "NotYetRegistered",

  @doc("The agent has connected recently.")
  ConnectedRecently: "ConnectedRecently",

  @doc("The agent has not connected recently.")
  NotConnectedRecently: "NotConnectedRecently",

  @doc("The agent is disconnected.")
  Disconnected: "Disconnected",

  @doc("An error has occurred with the agent.")
  Error: "Error",

  @doc("The status of the agent is not specified.")
  NotSpecified: "NotSpecified",

  @doc("Validation of the agent is in progress.")
  ValidationInProgress: "ValidationInProgress",

  @doc("Validation of the agent was successful.")
  ValidationSuccess: "ValidationSuccess",

  @doc("Validation of the agent failed.")
  ValidationFailed: "ValidationFailed",

  @doc("Deployment of the agent is in progress.")
  DeploymentInProgress: "DeploymentInProgress",

  @doc("Deployment of the agent failed.")
  DeploymentFailed: "DeploymentFailed",

  @doc("Deployment of the agent was successful.")
  DeploymentSuccess: "DeploymentSuccess",
}

@doc("Overall connectivity status for the cluster resource.")
union ConnectivityStatus {
  string,

  @doc("The cluster resource has not yet been registered.")
  NotYetRegistered: "NotYetRegistered",

  @doc("The cluster resource is connected.")
  Connected: "Connected",

  @doc("The cluster resource has not been connected recently.")
  NotConnectedRecently: "NotConnectedRecently",

  @doc("The cluster resource is partially connected.")
  PartiallyConnected: "PartiallyConnected",

  @doc("The cluster resource is disconnected.")
  Disconnected: "Disconnected",

  @doc("The connectivity status of the cluster resource is not specified.")
  NotSpecified: "NotSpecified",
}

@doc("Status of the Software Assurance for the cluster.")
union SoftwareAssuranceStatus {
  string,

  @doc("Software Assurance is enabled.")
  Enabled: "Enabled",

  @doc("Software Assurance is disabled.")
  Disabled: "Disabled",
}

@doc("Desired state of Windows Server Subscription.")
union WindowsServerSubscription {
  string,

  @doc("Windows Server Subscription is disabled.")
  Disabled: "Disabled",

  @doc("Windows Server Subscription is enabled.")
  Enabled: "Enabled",
}

@doc("Desired level of diagnostic data emitted by the cluster.")
union DiagnosticLevel {
  string,

  @doc("No diagnostic data is emitted.")
  Off: "Off",

  @doc("Basic level of diagnostic data is emitted.")
  Basic: "Basic",

  @doc("Enhanced level of diagnostic data is emitted.")
  Enhanced: "Enhanced",
}

@doc("The node type of all the nodes of the cluster.")
union ClusterNodeType {
  string,

  @doc("Nodes provided by the first party (original manufacturer).")
  FirstParty: "FirstParty",

  @doc("Nodes provided by a third party.")
  ThirdParty: "ThirdParty",
}

@doc("OEM activation status of the cluster.")
union OemActivation {
  string,

  @doc("OEM activation is disabled.")
  Disabled: "Disabled",

  @doc("OEM activation is enabled.")
  Enabled: "Enabled",
}

@doc("Hardware class of the cluster.")
union HardwareClass {
  string,

  @doc("The hardware class is small.")
  Small: "Small",

  @doc("The hardware class is medium. This corresponds to the default")
  Medium: "Medium",

  @doc("The hardware class is large.")
  Large: "Large",
}

@doc("IMDS attestation status of the cluster.")
union ImdsAttestation {
  string,

  @doc("IMDS attestation is disabled.")
  Disabled: "Disabled",

  @doc("IMDS attestation is enabled.")
  Enabled: "Enabled",
}

@doc("Cluster details to update.")
@discriminator("kind")
model ClusterPatch {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @doc("Resource tags.")
  tags?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" ""
  @doc("Edge Solution type to support polymorphic resource.")
  kind: EdgeSolutionType;

  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@doc("Request model for uploading certificates.")
model UploadCertificateRequest {
  @doc("Raw certificate data.")
  properties?: RawCertificateData;
}

@doc("Model containing raw certificate data.")
model RawCertificateData {
  @doc("List of certificates in raw format.")
  certificates?: string[];
}

@doc("Cluster Identity details.")
model StackHciClusterIdentityResponseResult {
  @doc("Cluster identity properties.")
  @visibility(Lifecycle.Read)
  properties?: ClusterIdentityResponseProperties;
}

@doc("Properties for the cluster identity response.")
model ClusterIdentityResponseProperties {
  @doc("Azure Active Directory client ID.")
  aadClientId?: string;

  @doc("Azure Active Directory tenant ID.")
  aadTenantId?: string;

  @doc("Azure Active Directory service principal object ID.")
  aadServicePrincipalObjectId?: string;

  @doc("Azure Active Directory application object ID.")
  aadApplicationObjectId?: string;
}

@doc("Request model for changing Software Assurance properties.")
model SoftwareAssuranceChangeRequest {
  @doc("Properties for the Software Assurance change request.")
  properties?: SoftwareAssuranceChangeRequestProperties;
}

@doc("Cluster of nodes installed with Windows-based OS.")
model WindowsCluster extends Cluster {
  @doc("properties for Cluster of nodes installed with Windows-based OS.")
  properties?: WindowsClusterProperties;

  @doc("Cluster kind to support polymorphic resource.")
  kind: EdgeSolutionType.WindowsServer;
}

@doc("Cluster of nodes installed with AzureLinux-based OS.")
model AzureLinuxCluster extends Cluster {
  @doc("properties for Cluster of nodes installed with AzureLinux-based OS.")
  properties?: AzureLinuxClusterProperties;

  @doc("Cluster kind to support polymorphic resource.")
  kind: EdgeSolutionType.AzureLinux;
}

@doc("Cluster properties.")
model ClusterProperties {
  @doc("Provisioning state.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Status of the cluster agent.")
  @visibility(Lifecycle.Read)
  status?: Status;

  @doc("Overall connectivity status for the cluster resource.")
  @visibility(Lifecycle.Read)
  connectivityStatus?: ConnectivityStatus;

  @doc("Id of cluster identity service principal.")
  aadServicePrincipalObjectId?: string;

  @doc("Tenant id of cluster AAD identity.")
  aadTenantId?: string;

  @doc("Unique, immutable resource id.")
  @visibility(Lifecycle.Read)
  cloudId?: string;

  @doc("Endpoint configured for management from the Azure portal.")
  cloudManagementEndpoint?: string;

  @doc("First cluster sync timestamp.")
  @visibility(Lifecycle.Read)
  registrationTimestamp?: utcDateTime;

  @doc("Most recent cluster sync timestamp.")
  @visibility(Lifecycle.Read)
  lastSyncTimestamp?: utcDateTime;

  @doc("Object id of RP Service Principal")
  @visibility(Lifecycle.Read)
  resourceProviderObjectId?: string;

  @doc("Region specific DataPath Endpoint of the cluster.")
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;
}

@doc("Cluster properties.")
model WindowsClusterProperties {
  ...ClusterProperties;

  @doc("App id of cluster AAD identity.")
  aadClientId?: string;

  @doc("Object id of cluster AAD identity.")
  aadApplicationObjectId?: string;

  @doc("Software Assurance properties of the cluster.")
  softwareAssuranceProperties?: SoftwareAssuranceProperties;

  @doc("Log Collection properties of the cluster.")
  logCollectionProperties?: LogCollectionProperties;

  @doc("RemoteSupport properties of the cluster.")
  remoteSupportProperties?: ClusterRemoteSupportProperties;

  @doc("Desired properties of the cluster.")
  desiredProperties?: ClusterDesiredProperties;

  @doc("Properties reported by cluster agent.")
  @visibility(Lifecycle.Read)
  reportedProperties?: WindowsClusterReportedProperties;

  @doc("Attestation configurations for isolated VM (e.g. TVM, CVM) of the cluster.")
  @visibility(Lifecycle.Read)
  isolatedVmAttestationConfiguration?: IsolatedVmAttestationConfiguration;

  @doc("Number of days remaining in the trial period.")
  @visibility(Lifecycle.Read)
  trialDaysRemaining?: float32;

  @doc("Type of billing applied to the resource.")
  @visibility(Lifecycle.Read)
  billingModel?: string;

  @doc("Most recent billing meter timestamp.")
  @visibility(Lifecycle.Read)
  lastBillingTimestamp?: utcDateTime;

  @doc("List of secret locations.")
  @Azure.ResourceManager.identifiers(#[])
  secretsLocations?: SecretsLocationDetails[];

  @visibility(Lifecycle.Read)
  @doc("Supported Storage Type for HCI Cluster")
  clusterPattern?: ClusterPattern;

  @Azure.ResourceManager.identifiers(#["localAvailabilityZoneName"])
  @doc("Local Availability Zone information for HCI cluster")
  localAvailabilityZones?: LocalAvailabilityZones[];

  @visibility(Lifecycle.Read)
  @doc("Identity Provider for the cluster")
  identityProvider?: IdentityProvider = IdentityProvider.ActiveDirectory;
}

@doc("Cluster properties.")
model AzureLinuxClusterProperties {
  ...ClusterProperties;

  @doc("Properties reported by cluster agent.")
  @visibility(Lifecycle.Read)
  reportedProperties?: AzureLinuxClusterReportedProperties;
}

@doc("Software Assurance properties of the cluster.")
model SoftwareAssuranceProperties {
  @doc("Status of the Software Assurance for the cluster.")
  @visibility(Lifecycle.Read)
  softwareAssuranceStatus?: SoftwareAssuranceStatus;

  @doc("Customer Intent for Software Assurance Benefit.")
  softwareAssuranceIntent?: SoftwareAssuranceIntent;

  @doc("TimeStamp denoting the latest SA benefit applicability is validated.")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

@doc("Log Collection properties of the cluster.")
model LogCollectionProperties {
  @doc("From DateTimeStamp from when logs need to be connected")
  @visibility(Lifecycle.Read)
  fromDate?: utcDateTime;

  @doc("To DateTimeStamp till when logs need to be connected")
  @visibility(Lifecycle.Read)
  toDate?: utcDateTime;

  @doc("Recent DateTimeStamp where logs are successfully generated")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLogGenerated?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("Log collection session details.")
  @Azure.ResourceManager.identifiers(#["logStartTime"])
  logCollectionSessionDetails?: ClusterLogCollectionSession[];
}

@doc("Log Collection Session details of the cluster.")
model ClusterLogCollectionSession {
  @doc("Start Time of the logs when it was collected")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  logStartTime?: utcDateTime;

  @doc("End Time of the logs when it was collected")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  logEndTime?: utcDateTime;

  @doc("Duration of logs collected")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCollected?: utcDateTime;

  @doc("Size of the logs collected")
  @visibility(Lifecycle.Read)
  logSize?: int64;

  @doc("LogCollection status")
  @visibility(Lifecycle.Read)
  logCollectionStatus?: LogCollectionStatus;

  @doc("LogCollection job type")
  @visibility(Lifecycle.Read)
  logCollectionJobType?: LogCollectionJobType;

  @doc("CorrelationId of the log collection")
  @visibility(Lifecycle.Read)
  correlationId?: string;

  @doc("End Time of the logs when it was collected")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeCollected?: utcDateTime;

  @doc("Log Collection Error details of the cluster.")
  @visibility(Lifecycle.Read)
  logCollectionError?: LogCollectionError;
}

@doc("Log Collection Error details of the cluster.")
model LogCollectionError {
  @doc("Error Code of the log collection")
  @visibility(Lifecycle.Read)
  errorCode?: string;

  @doc("Error Message of the log collection")
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

@doc("Remote Support properties of the cluster.")
model ClusterRemoteSupportProperties {
  @doc("Remote Support Access Level")
  @visibility(Lifecycle.Read)
  accessLevel?: RemoteSupportAccessLevel;

  @doc("Expiration DateTimeStamp when Remote Support Access will be expired")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStamp?: utcDateTime;

  @doc("Remote Support Type for cluster")
  @visibility(Lifecycle.Read)
  remoteSupportType?: RemoteSupportType;

  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  @doc("Remote Support node settings of the cluster.")
  remoteSupportNodeSettings?: ClusterRemoteSupportNodeSettings[];

  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#[])
  @doc("Remote Support session details of the cluster.")
  remoteSupportSessionDetails?: PerNodeRemoteSupportSession[];
}

@doc("Remote Support Node Settings of the cluster.")
model ClusterRemoteSupportNodeSettings {
  @doc("Arc ResourceId of the Node")
  @visibility(Lifecycle.Read)
  arcResourceId?: string;

  @doc("Remote Support Access Connection State on the Node")
  @visibility(Lifecycle.Read)
  state?: string;

  @doc("Remote Support Enablement Request Created TimeStamp on the Node")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("Remote Support Enablement Request Updated TimeStamp on the Node")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  @doc("Remote Support Access Connection Status on the Node")
  @visibility(Lifecycle.Read)
  connectionStatus?: string;

  @doc("Remote Support Access Connection Error Message on the Node")
  @visibility(Lifecycle.Read)
  connectionErrorMessage?: string;

  @doc("Remote Support Transcript location on the node")
  @visibility(Lifecycle.Read)
  transcriptLocation?: string;
}

@doc("Remote Support Node Session Details on the Node.")
model PerNodeRemoteSupportSession {
  @doc("Remote Support Session StartTime on the Node")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sessionStartTime?: utcDateTime;

  @doc("Remote Support Session EndTime on the Node")
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sessionEndTime?: utcDateTime;

  @doc("Name of the node")
  @visibility(Lifecycle.Read)
  nodeName?: string;

  @doc("Duration of Remote Support Enablement")
  @visibility(Lifecycle.Read)
  duration?: int64;

  @doc("Remote Support Access Level")
  @visibility(Lifecycle.Read)
  accessLevel?: RemoteSupportAccessLevel;
}

@doc("Desired properties of the cluster.")
model ClusterDesiredProperties {
  @doc("Desired state of Windows Server Subscription.")
  windowsServerSubscription?: WindowsServerSubscription;

  @doc("Desired level of diagnostic data emitted by the cluster.")
  diagnosticLevel?: DiagnosticLevel;
}

@doc("Properties reported by cluster agent.")
model ClusterReportedProperties {
  @doc("Last time the cluster reported the data.")
  @visibility(Lifecycle.Read)
  lastUpdated?: utcDateTime;

  @doc("Capabilities supported by the cluster.")
  @visibility(Lifecycle.Read)
  supportedCapabilities?: string[];

  @doc("Name of the on-prem cluster connected to this resource.")
  @visibility(Lifecycle.Read)
  customLocationId?: string;

  @doc("The hardware class of the cluster")
  @visibility(Lifecycle.Read)
  hardwareClass?: HardwareClass = HardwareClass.Medium;
}

@doc("Properties reported by cluster agent.")
model WindowsClusterReportedProperties {
  ...ClusterReportedProperties;

  @doc("Name of the on-prem cluster connected to this resource.")
  @visibility(Lifecycle.Read)
  clusterName?: string;

  @doc("Unique id generated by the on-prem cluster.")
  @visibility(Lifecycle.Read)
  clusterId?: string;

  @doc("Version of the cluster software.")
  @visibility(Lifecycle.Read)
  clusterVersion?: string;

  @doc("IMDS attestation status of the cluster.")
  @visibility(Lifecycle.Read)
  imdsAttestation?: ImdsAttestation;

  @doc("Level of diagnostic data emitted by the cluster.")
  diagnosticLevel?: DiagnosticLevel;

  @doc("The node type of all the nodes of the cluster.")
  @visibility(Lifecycle.Read)
  clusterType?: ClusterNodeType;

  @doc("The manufacturer of all the nodes of the cluster.")
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  @doc("OEM activation status of the cluster.")
  @visibility(Lifecycle.Read)
  oemActivation?: OemActivation;

  @doc("List of nodes reported by the cluster.")
  @visibility(Lifecycle.Read)
  @identifiers(#["id"])
  nodes?: WindowsClusterNode[];
}

@doc("Properties reported by cluster agent.")
model AzureLinuxClusterReportedProperties {
  ...ClusterReportedProperties;

  @doc("List of nodes reported by the cluster.")
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["edgeDeviceResourceId"])
  nodes?: AzureLinuxClusterNode[];
}

@doc("Cluster node details.")
model ClusterNode {
  @doc("Name of the cluster node.")
  @visibility(Lifecycle.Read)
  name?: string;

  @doc("Edge device resource Id.")
  @visibility(Lifecycle.Read)
  edgeDeviceResourceId?: string;

  @doc("Manufacturer of the cluster node hardware.")
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  @doc("Model name of the cluster node hardware.")
  @visibility(Lifecycle.Read)
  `model`?: string;

  @doc("Operating system running on the cluster node.")
  @visibility(Lifecycle.Read)
  osName?: string;

  @doc("Version of the operating system running on the cluster node.")
  @visibility(Lifecycle.Read)
  osVersion?: string;

  @doc("Display version of the operating system running on the cluster node.")
  @visibility(Lifecycle.Read)
  osDisplayVersion?: string;

  @doc("Immutable id of the cluster node.")
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  @doc("Number of physical cores on the cluster node.")
  @visibility(Lifecycle.Read)
  coreCount?: float32;

  @doc("Total available memory on the cluster node (in GiB).")
  @visibility(Lifecycle.Read)
  memoryInGiB?: float32;
}

@doc("Cluster node details.")
model WindowsClusterNode {
  ...ClusterNode;

  @doc("Id of the node in the cluster.")
  @visibility(Lifecycle.Read)
  id?: float32;

  @doc("State of Windows Server Subscription.")
  @visibility(Lifecycle.Read)
  windowsServerSubscription?: WindowsServerSubscription;

  @doc("Type of the cluster node hardware.")
  @visibility(Lifecycle.Read)
  nodeType?: ClusterNodeType;

  @doc("Edge Hardware Center Resource Id")
  @visibility(Lifecycle.Read)
  ehcResourceId?: string;

  @doc("Most recent licensing timestamp.")
  @visibility(Lifecycle.Read)
  lastLicensingTimestamp?: utcDateTime;

  @doc("OEM activation status of the node.")
  @visibility(Lifecycle.Read)
  oemActivation?: OemActivation;
}

@doc("Cluster node details.")
model AzureLinuxClusterNode {
  ...ClusterNode;
}

@doc("Attestation configurations for isolated VM (e.g. TVM, CVM) of the cluster.")
model IsolatedVmAttestationConfiguration {
  @doc("Fully qualified Azure resource id of the Microsoft Azure attestation resource associated with this cluster.")
  @visibility(Lifecycle.Read)
  attestationResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Attestation/attestationProviders";
      scope: "tenant";
    }
  ]>;

  @doc("Region specific endpoint for relying party service.")
  @visibility(Lifecycle.Read)
  relyingPartyServiceEndpoint?: string;

  @doc("Region specific endpoint for Microsoft Azure Attestation service for the cluster")
  @visibility(Lifecycle.Read)
  attestationServiceEndpoint?: string;

  @doc("Region specific endpoint for AzCS service.")
  @visibility(Lifecycle.Read)
  azureCertificateServiceEndpoint?: url;
}

@doc("Cluster of nodes installed with Windows-based OS.")
model WindowsClusterPatch extends ClusterPatch {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing api"
  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("Identity of Cluster resource")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;

  @doc("patch properties for HCI Cluster")
  properties?: WindowsClusterPatchProperties;

  @doc("Cluster kind to support polymorphic resource.")
  kind: "WindowsServer";
}

@doc("Cluster properties.")
model WindowsClusterPatchProperties {
  @doc("Endpoint configured for management from the Azure portal")
  cloudManagementEndpoint?: string;

  @doc("App id of cluster AAD identity.")
  aadClientId?: string;

  @doc("Tenant id of cluster AAD identity.")
  aadTenantId?: string;

  @doc("Desired properties of the cluster.")
  desiredProperties?: ClusterDesiredProperties;
}

@doc("Properties for the Software Assurance change request.")
model SoftwareAssuranceChangeRequestProperties {
  @doc("Customer intent for the Software Assurance benefit.")
  softwareAssuranceIntent?: SoftwareAssuranceIntent;
}

@doc("Log Collection Request")
model LogCollectionRequest {
  @doc("Properties for Log Collection Request")
  properties?: LogCollectionRequestProperties;
}

@doc("Properties for Log Collection Request")
model LogCollectionRequestProperties {
  @doc("From DateTimeStamp from when logs need to be connected")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fromDate: utcDateTime;

  @doc("To DateTimeStamp till when logs need to be connected")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  toDate: utcDateTime;
}

@doc("Remote Support Request")
model RemoteSupportRequest {
  @doc("Properties for Remote Support Request")
  properties?: RemoteSupportRequestProperties;
}

@doc("Properties for Remote Support Request")
model RemoteSupportRequestProperties {
  @doc("Remote Support Access Level")
  @visibility(Lifecycle.Read)
  accessLevel?: RemoteSupportAccessLevel;

  @doc("Expiration DateTimeStamp when Remote Support Access will expire")
  expirationTimeStamp?: utcDateTime;

  @doc("Remote Support Type for cluster")
  remoteSupportType?: RemoteSupportType;
}

@doc("LogCollection job type.")
union LogCollectionJobType {
  string,

  @doc("Log collection job is on-demand.")
  OnDemand: "OnDemand",

  @doc("Log collection job is scheduled.")
  Scheduled: "Scheduled",
}

@doc("Update secrets locations change  Request.")
model SecretsLocationsChangeRequest {
  /**
   * List of secret locations
   */
  @Azure.ResourceManager.identifiers(#[])
  properties?: SecretsLocationDetails[];
}

@doc("Secrets location details")
model SecretsLocationDetails {
  @doc("Type of secrets to store")
  secretsType: SecretsType;

  @doc("secrets location")
  secretsLocation: string;
}

@doc("Type of secrets to store")
union SecretsType {
  string,

  @doc("Backup secrets type")
  BackupSecrets: "BackupSecrets",
}

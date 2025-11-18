import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Cluster details.
 */
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Clusters {
  /**
   * Get HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  get is ArmResourceRead<Cluster>;

  /**
   * Create an HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceAsync<
    Cluster,
    Response = ArmResourceUpdatedResponse<Cluster>
  >;

  /**
   * Update an HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Cluster, PatchModel = ClusterPatch>;

  /**
   * Delete an HCI cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Cluster,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all HCI clusters in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listByResourceGroup is ArmResourceListByParent<
    Cluster,
    Response = ArmResponse<ClusterList>
  >;

  /**
   * List all HCI clusters in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  listBySubscription is ArmListBySubscription<
    Cluster,
    Response = ArmResponse<ClusterList>
  >;

  /**
   * Update cluster secrets locations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  updateSecretsLocations is ArmResourceActionAsync<
    Cluster,
    SecretsLocationsChangeRequest,
    Cluster
  >;

  /**
   * Upload certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  uploadCertificate is ArmResourceActionNoResponseContentAsync<
    Cluster,
    UploadCertificateRequest
  >;

  /**
   * Create cluster identity.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "not including ArmLroLocationHeader for backward compatibility"
  @action("createClusterIdentity")
  createIdentity is ArmResourceActionAsync<
    Cluster,
    void,
    ArmResponse<ClusterIdentityResponse>,
    LroHeaders = ArmAsyncOperationHeader<FinalResult = ClusterIdentityResponse>
  >;

  /**
   * Changes ring of a cluster
   */
  changeRing is ArmResourceActionAsync<Cluster, ChangeRingRequest, Cluster>;

  /**
   * Extends Software Assurance Benefit to a cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  extendSoftwareAssuranceBenefit is ArmResourceActionAsync<
    Cluster,
    SoftwareAssuranceChangeRequest,
    Cluster
  >;

  /**
   * Trigger Log Collection on a cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  triggerLogCollection is ArmResourceActionAsync<
    Cluster,
    LogCollectionRequest,
    Cluster
  >;

  /**
   * Configure RemoteSupport on a cluster
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  configureRemoteSupport is ArmResourceActionAsync<
    Cluster,
    RemoteSupportRequest,
    Cluster
  >;

  /**
   * List Offers available across publishers for the HCI Cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("offers")
  @operationId("Offers_ListByCluster")
  listByCluster is ArmResourceActionSync<
    Cluster,
    void,
    ArmResponse<OfferList>,
    Parameters = {
      /**
       * Specify $expand=content,contentVersion to populate additional fields related to the marketplace offer.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

@@doc(Cluster.name, "The name of the cluster.");
@@doc(Cluster.properties, "Cluster properties.");
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

// Models

/**
 * List of clusters.
 */
model ClusterList is Azure.Core.Page<Cluster>;

/**
 * Cluster properties.
 */
model ClusterProperties {
  /**
   * Provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Status of the cluster agent.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * Overall connectivity status for the cluster resource.
   */
  @visibility(Lifecycle.Read)
  connectivityStatus?: ConnectivityStatus;

  /**
   * Indicates whether the cluster is under support.
   */
  @visibility(Lifecycle.Read)
  supportStatus?: SupportStatus;

  /**
   * Unique, immutable resource id.
   */
  @visibility(Lifecycle.Read)
  cloudId?: string;

  /**
   * The ring to which this cluster belongs to.
   */
  @visibility(Lifecycle.Read)
  ring?: string;

  /**
   * Endpoint configured for management from the Azure portal.
   */
  cloudManagementEndpoint?: string;

  /**
   * App id of cluster AAD identity.
   */
  aadClientId?: string;

  /**
   * Tenant id of cluster AAD identity.
   */
  aadTenantId?: string;

  /**
   * Object id of cluster AAD identity.
   */
  aadApplicationObjectId?: string;

  /**
   * Id of cluster identity service principal.
   */
  aadServicePrincipalObjectId?: string;

  /**
   * Software Assurance properties of the cluster.
   */
  softwareAssuranceProperties?: SoftwareAssuranceProperties;

  /**
   * Is Management Cluster, when true indicates that the cluster is used for managing other clusters
   */
  @visibility(Lifecycle.Read)
  isManagementCluster?: boolean;

  /**
   * Log Collection properties of the cluster.
   */
  logCollectionProperties?: LogCollectionProperties;

  /**
   * RemoteSupport properties of the cluster.
   */
  remoteSupportProperties?: RemoteSupportProperties;

  /**
   * Desired properties of the cluster.
   */
  desiredProperties?: ClusterDesiredProperties;

  /**
   * Properties reported by cluster agent.
   */
  @visibility(Lifecycle.Read)
  reportedProperties?: ClusterReportedProperties;

  /**
   * Attestation configurations for isolated VM (e.g. TVM, CVM) of the cluster.
   */
  @visibility(Lifecycle.Read)
  isolatedVmAttestationConfiguration?: IsolatedVmAttestationConfiguration;

  /**
   * Number of days remaining in the trial period.
   */
  @visibility(Lifecycle.Read)
  trialDaysRemaining?: float32;

  /**
   * Type of billing applied to the resource.
   */
  @visibility(Lifecycle.Read)
  billingModel?: string;

  /**
   * First cluster sync timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  registrationTimestamp?: utcDateTime;

  /**
   * Most recent cluster sync timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastSyncTimestamp?: utcDateTime;

  /**
   * Most recent billing meter timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastBillingTimestamp?: utcDateTime;

  /**
   * Region specific DataPath Endpoint of the cluster.
   */
  @visibility(Lifecycle.Read)
  serviceEndpoint?: string;

  /**
   * Object id of RP Service Principal
   */
  @visibility(Lifecycle.Read)
  resourceProviderObjectId?: string;

  /**
   * List of secret locations.
   */
  @identifiers(#[])
  secretsLocations?: SecretsLocationDetails[];

  /**
   * Supported Storage Type for HCI Cluster
   */
  @visibility(Lifecycle.Read)
  clusterPattern?: ClusterPattern;

  /**
   * Local Availability Zone information for HCI cluster
   */
  @identifiers(#["localAvailabilityZoneName"])
  localAvailabilityZones?: LocalAvailabilityZones[];

  /**
   * Identity Provider for the cluster
   */
  @visibility(Lifecycle.Read)
  identityProvider?: IdentityProvider;
}

/**
 * Indicates whether the cluster is under support.
 */
union SupportStatus {
  string,

  /**
   * The cluster is under support.
   */
  InSupport: "InSupport",

  /**
   * The cluster is out of support.
   */
  OutOfSupport: "OutOfSupport",

  /**
   * The support status is not specified.
   */
  NotSpecified: "NotSpecified",
}

/**
 * Software Assurance properties of the cluster.
 */
model SoftwareAssuranceProperties {
  /**
   * Status of the Software Assurance for the cluster.
   */
  @visibility(Lifecycle.Read)
  softwareAssuranceStatus?: SoftwareAssuranceStatus;

  /**
   * Customer Intent for Software Assurance Benefit.
   */
  softwareAssuranceIntent?: SoftwareAssuranceIntent;

  /**
   * TimeStamp denoting the latest SA benefit applicability is validated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;
}

/**
 * Cluster Witness properties of the cluster. A cluster witness is a resource (such as a storage account or file share) that helps maintain quorum and supports automatic failover in high-availability cluster configurations.
 */
model ClusterWitnessProperties {
  /**
   * The authentication mode for the cluster witness. An example value 'ManagedIdentity'.
   */
  @visibility(Lifecycle.Read)
  authenticationMode?: string;
}

/**
 * Log Collection properties of the cluster.
 */
model LogCollectionProperties {
  /**
   * From DateTimeStamp from when logs need to be connected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fromDate?: utcDateTime;

  /**
   * To DateTimeStamp till when logs need to be connected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  toDate?: utcDateTime;

  /**
   * Recent DateTimeStamp where logs are successfully generated
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLogGenerated?: utcDateTime;

  /**
   * Log collection session details for the cluster.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  logCollectionSessionDetails?: LogCollectionSession[];
}

/**
 * Log Collection Session details of the cluster.
 */
model LogCollectionSession {
  /**
   * Start Time of the logs when it was collected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  logStartTime?: utcDateTime;

  /**
   * End Time of the logs when it was collected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  logEndTime?: utcDateTime;

  /**
   * Duration of logs collected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeCollected?: utcDateTime;

  /**
   * Size of the logs collected
   */
  @visibility(Lifecycle.Read)
  logSize?: int64;

  /**
   * LogCollection status
   */
  @visibility(Lifecycle.Read)
  logCollectionStatus?: LogCollectionStatus;

  /**
   * CorrelationId of the log collection
   */
  @visibility(Lifecycle.Read)
  correlationId?: string;

  /**
   * LogCollection job type
   */
  @visibility(Lifecycle.Read)
  logCollectionJobType?: LogCollectionJobType;

  /**
   * End Time of the logs when it was collected
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTimeCollected?: utcDateTime;

  /**
   * Log Collection Error details of the cluster.
   */
  @visibility(Lifecycle.Read)
  logCollectionError?: LogCollectionError;
}

/**
 * Log Collection Error details of the cluster.
 */
model LogCollectionError {
  /**
   * Error Code of the log collection
   */
  @visibility(Lifecycle.Read)
  errorCode?: string;

  /**
   * Error Message of the log collection
   */
  @visibility(Lifecycle.Read)
  errorMessage?: string;
}

/**
 * Remote Support properties of the cluster.
 */
model RemoteSupportProperties {
  /**
   * Remote Support Access Level
   */
  @visibility(Lifecycle.Read)
  accessLevel?: AccessLevel;

  /**
   * Expiration DateTimeStamp when Remote Support Access will be expired
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStamp?: utcDateTime;

  /**
   * Remote Support Type for cluster
   */
  @visibility(Lifecycle.Read)
  remoteSupportType?: RemoteSupportType;

  /**
   * Remote support node settings for the cluster.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  remoteSupportNodeSettings?: RemoteSupportNodeSettings[];

  /**
   * Remote support session details for the cluster.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  remoteSupportSessionDetails?: PerNodeRemoteSupportSession[];
}

/**
 * Remote Support Node Settings of the cluster.
 */
model RemoteSupportNodeSettings {
  /**
   * Arc ResourceId of the Node
   */
  @visibility(Lifecycle.Read)
  arcResourceId?: string;

  /**
   * Remote Support Access Connection State on the Node
   */
  @visibility(Lifecycle.Read)
  state?: string;

  /**
   * Remote Support Enablement Request Created TimeStamp on the Node
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * Remote Support Enablement Request Updated TimeStamp on the Node
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Remote Support Access Connection Status on the Node
   */
  @visibility(Lifecycle.Read)
  connectionStatus?: string;

  /**
   * Remote Support Access Connection Error Message on the Node
   */
  @visibility(Lifecycle.Read)
  connectionErrorMessage?: string;

  /**
   * Remote Support Transcript location on the node
   */
  @visibility(Lifecycle.Read)
  transcriptLocation?: string;
}

/**
 * Remote Support Node Session Details on the Node.
 */
model PerNodeRemoteSupportSession {
  /**
   * Remote Support Session StartTime on the Node
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sessionStartTime?: utcDateTime;

  /**
   * Remote Support Session EndTime on the Node
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  sessionEndTime?: utcDateTime;

  /**
   * Name of the node
   */
  @visibility(Lifecycle.Read)
  nodeName?: string;

  /**
   * Duration of Remote Support Enablement
   */
  @visibility(Lifecycle.Read)
  duration?: int64;

  /**
   * Remote Support Access Level
   */
  @visibility(Lifecycle.Read)
  accessLevel?: AccessLevel;
}

/**
 * Desired properties of the cluster.
 */
model ClusterDesiredProperties {
  /**
   * Desired state of Windows Server Subscription.
   */
  windowsServerSubscription?: WindowsServerSubscription;

  /**
   * Desired level of diagnostic data emitted by the cluster.
   */
  diagnosticLevel?: DiagnosticLevel;
}

/**
 * Properties reported by cluster agent.
 */
model ClusterReportedProperties {
  /**
   * Name of the on-prem cluster connected to this resource.
   */
  @visibility(Lifecycle.Read)
  clusterName?: string;

  /**
   * Unique id generated by the on-prem cluster.
   */
  @visibility(Lifecycle.Read)
  clusterId?: string;

  /**
   * Version of the cluster software.
   */
  @visibility(Lifecycle.Read)
  clusterVersion?: string;

  /**
   * List of nodes reported by the cluster.
   */
  @visibility(Lifecycle.Read)
  nodes?: ClusterNode[];

  /**
   * Last time the cluster reported the data.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastUpdated?: utcDateTime;

  /**
   * MSI expiration timestamp of the cluster MSI
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  msiExpirationTimeStamp?: utcDateTime;

  /**
   * IMDS attestation status of the cluster.
   */
  @visibility(Lifecycle.Read)
  imdsAttestation?: ImdsAttestation;

  /**
   * Level of diagnostic data emitted by the cluster.
   */
  diagnosticLevel?: DiagnosticLevel;

  /**
   * Capabilities supported by the cluster.
   */
  @visibility(Lifecycle.Read)
  supportedCapabilities?: string[];

  /**
   * The node type of all the nodes of the cluster.
   */
  @visibility(Lifecycle.Read)
  clusterType?: ClusterNodeType;

  /**
   * The manufacturer of all the nodes of the cluster.
   */
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  /**
   * OEM activation status of the cluster.
   */
  @visibility(Lifecycle.Read)
  oemActivation?: OemActivation;

  /**
   * Hardware class of the cluster.
   */
  @visibility(Lifecycle.Read)
  hardwareClass?: HardwareClass = HardwareClass.Medium;

  /**
   * Name of the on-prem cluster connected to this resource.
   */
  @visibility(Lifecycle.Read)
  customLocationId?: string;
}

/**
 * Cluster node details.
 */
model ClusterNode {
  /**
   * Name of the cluster node.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Id of the node in the cluster.
   */
  @visibility(Lifecycle.Read)
  id?: float32;

  /**
   * State of Windows Server Subscription.
   */
  @visibility(Lifecycle.Read)
  windowsServerSubscription?: WindowsServerSubscription;

  /**
   * Type of the cluster node hardware.
   */
  @visibility(Lifecycle.Read)
  nodeType?: ClusterNodeType;

  /**
   * Edge Hardware Center Resource Id
   */
  @visibility(Lifecycle.Read)
  ehcResourceId?: string;

  /**
   * Manufacturer of the cluster node hardware.
   */
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  /**
   * Model name of the cluster node hardware.
   */
  @visibility(Lifecycle.Read)
  `model`?: string;

  /**
   * Operating system running on the cluster node.
   */
  @visibility(Lifecycle.Read)
  osName?: string;

  /**
   * Version of the operating system running on the cluster node.
   */
  @visibility(Lifecycle.Read)
  osVersion?: string;

  /**
   * Display version of the operating system running on the cluster node.
   */
  @visibility(Lifecycle.Read)
  osDisplayVersion?: string;

  /**
   * Immutable id of the cluster node.
   */
  @visibility(Lifecycle.Read)
  serialNumber?: string;

  /**
   * Number of physical cores on the cluster node.
   */
  @visibility(Lifecycle.Read)
  coreCount?: float32;

  /**
   * Total available memory on the cluster node (in GiB).
   */
  @visibility(Lifecycle.Read)
  memoryInGiB?: float32;

  /**
   * Most recent licensing timestamp.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastLicensingTimestamp?: utcDateTime;

  /**
   * OEM activation status of the node.
   */
  @visibility(Lifecycle.Read)
  oemActivation?: OemActivation;
}

/**
 * Attestation configurations for isolated VM (e.g. TVM, CVM) of the cluster.
 */
model IsolatedVmAttestationConfiguration {
  /**
   * Fully qualified Azure resource id of the Microsoft Azure attestation resource associated with this cluster.
   */
  @visibility(Lifecycle.Read)
  attestationResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Attestation/attestationProviders";
    }
  ]>;

  /**
   * Region specific endpoint for relying party service.
   */
  @visibility(Lifecycle.Read)
  relyingPartyServiceEndpoint?: string;

  /**
   * Region specific endpoint for Microsoft Azure Attestation service for the cluster
   */
  @visibility(Lifecycle.Read)
  attestationServiceEndpoint?: string;
}

/**
 * Secrets location details
 */
model SecretsLocationDetails {
  /**
   * Type of secrets to store
   */
  secretsType: SecretsType;

  /**
   * secrets location
   */
  secretsLocation: string;
}

/**
 * Cluster details to update.
 */
model ClusterPatch {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * Identity of Cluster resource
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Cluster properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  properties?: ClusterPatchProperties;
}

/**
 * Cluster properties.
 */
model ClusterPatchProperties {
  /**
   * Endpoint configured for management from the Azure portal
   */
  cloudManagementEndpoint?: string;

  /**
   * App id of cluster AAD identity.
   */
  aadClientId?: string;

  /**
   * Tenant id of cluster AAD identity.
   */
  aadTenantId?: string;

  /**
   * Desired properties of the cluster.
   */
  desiredProperties?: ClusterDesiredProperties;
}

/**
 * Update secrets locations change  Request.
 */
model SecretsLocationsChangeRequest {
  /**
   * List of secret locations
   */
  @identifiers(#[])
  properties?: SecretsLocationDetails[];
}

/**
 * Upload certificate request.
 */
model UploadCertificateRequest {
  /**
   * Raw certificate data for upload.
   */
  properties?: RawCertificateData;
}

/**
 * Raw certificate data.
 */
model RawCertificateData {
  /**
   * List of certificates to upload.
   */
  certificates?: string[];
}

/**
 * Cluster Identity details.
 */
model ClusterIdentityResponse {
  /**
   * Cluster identity properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @visibility(Lifecycle.Read)
  properties?: ClusterIdentityResponseProperties;
}

/**
 * Cluster identity response properties.
 */
model ClusterIdentityResponseProperties {
  /**
   * App id of cluster AAD identity.
   */
  aadClientId?: string;

  /**
   * Tenant id of cluster AAD identity.
   */
  aadTenantId?: string;

  /**
   * Id of cluster identity service principal.
   */
  aadServicePrincipalObjectId?: string;

  /**
   * Object id of cluster AAD identity.
   */
  aadApplicationObjectId?: string;
}

/**
 * Software Assurance change request.
 */
model SoftwareAssuranceChangeRequest {
  /**
   * Properties for Software Assurance change request.
   */
  properties?: SoftwareAssuranceChangeRequestProperties;
}

/**
 * Properties for Software Assurance change request.
 */
model SoftwareAssuranceChangeRequestProperties {
  /**
   * Customer Intent for Software Assurance Benefit.
   */
  softwareAssuranceIntent?: SoftwareAssuranceIntent;
}

/**
 * Log Collection Request
 */
model LogCollectionRequest {
  /**
   * Properties for Log Collection Request
   */
  properties?: LogCollectionRequestProperties;
}

/**
 * Properties for Log Collection Request
 */
model LogCollectionRequestProperties {
  /**
   * From DateTimeStamp from when logs need to be connected
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  fromDate: utcDateTime;

  /**
   * To DateTimeStamp till when logs need to be connected
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  toDate: utcDateTime;
}

/**
 * Remote Support Request
 */
model RemoteSupportRequest {
  /**
   * Properties for Remote Support Request
   */
  properties?: RemoteSupportRequestProperties;
}

/**
 * Properties for Remote Support Request
 */
model RemoteSupportRequestProperties {
  /**
   * Remote Support Access Level
   */
  @visibility(Lifecycle.Read)
  accessLevel?: AccessLevel;

  /**
   * Expiration DateTimeStamp when Remote Support Access will be expired
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationTimeStamp?: utcDateTime;

  /**
   * Remote Support Type for cluster
   */
  remoteSupportType?: RemoteSupportType;
}

/**
 * Change Ring Request for cluster
 */
model ChangeRingRequest {
  /**
   * Properties for Change Ring Request
   */
  properties?: ChangeRingRequestProperties;
}

/**
 * Properties for Change Ring Request
 */
model ChangeRingRequestProperties {
  /**
   * The target ring for the cluster.
   */
  targetRing?: string;
}

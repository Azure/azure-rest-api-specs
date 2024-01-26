import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ResourceConnector;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The identity type.
 */
enum ResourceIdentityType {
  SystemAssigned,
  None,
}

/**
 * Represents a supported Fabric/Infra. (AKSEdge etc...).
 */
enum Distro {
  AKSEdge,
}

/**
 * Information about the connected appliance.
 */
enum Provider {
  VMWare,
  HCI,
  SCVMM,
}

/**
 * Appliance’s health and state of connection to on-prem
 */
enum Status {
  WaitingForHeartbeat,
  Validating,
  Connecting,
  Connected,
  Running,
  PreparingForUpgrade,
  ETCDSnapshotFailed,
  UpgradePrerequisitesCompleted,
  ValidatingSFSConnectivity,
  ValidatingImageDownload,
  ValidatingImageUpload,
  ValidatingETCDHealth,
  PreUpgrade,
  UpgradingKVAIO,
  WaitingForKVAIO,
  ImagePending,
  ImageProvisioning,
  ImageProvisioned,
  ImageDownloading,
  ImageDownloaded,
  ImageDeprovisioning,
  ImageUnknown,
  UpdatingCloudOperator,
  WaitingForCloudOperator,
  UpdatingCAPI,
  UpdatingCluster,
  PostUpgrade,
  UpgradeComplete,
  UpgradeClusterExtensionFailedToDelete,
  UpgradeFailed,
  Offline,
  None,
}

/**
 * Name which contains the role of the kubeconfig.
 */
enum AccessProfileType {
  clusterUser,
  clusterCustomerUser,
}

/**
 * Appliance ArtifactType definition.
 */
enum ArtifactType {
  LogsArtifactType,
}

/**
 * Appliance SSHKeyType definition.
 */
enum SSHKeyType {
  SSHCustomerUser,
  ManagementCAKey,
  LogsKey,
  ScopedAccessKey,
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: ResourceIdentityType;
}

/**
 * Properties for an appliance.
 */
model ApplianceProperties {
  /**
   * Represents a supported Fabric/Infra. (AKSEdge etc...).
   */
  distro?: Distro = Distro.AKSEdge;

  /**
   * Contains infrastructure information about the Appliance
   */
  infrastructureConfig?: AppliancePropertiesInfrastructureConfig;

  /**
   * The current deployment or provisioning state, which only appears in the response.
   */
  @visibility("read")
  provisioningState?: string;

  /**
   * Certificates pair used to download MSI certificate from HIS. Can only be set once.
   */
  publicKey?: string;

  /**
   * Appliance’s health and state of connection to on-prem
   */
  @visibility("read")
  status?: Status;

  /**
   * Version of the Appliance
   */
  version?: string;
}

/**
 * Contains infrastructure information about the Appliance
 */
model AppliancePropertiesInfrastructureConfig {
  /**
   * Information about the connected appliance.
   */
  provider?: Provider;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The Get Telemetry Config Result appliance.
 */
model ApplianceGetTelemetryConfigResult {
  /**
   * Telemetry instrumentation key.
   */
  @visibility("read")
  telemetryInstrumentationKey?: string;
}

/**
 * The Appliances patchable resource definition.
 */
model PatchableAppliance {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

/**
 * The List Cluster User Credential appliance.
 */
model ApplianceListCredentialResults {
  /**
   * Contains the REP (rendezvous endpoint) and “Listener” access token from notification service (NS).
   */
  @visibility("read")
  hybridConnectionConfig?: HybridConnectionConfig;

  /**
   * The list of appliance kubeconfigs.
   */
  @visibility("read")
  kubeconfigs?: ApplianceCredentialKubeconfig[];
}

/**
 * Contains the REP (rendezvous endpoint) and “Listener” access token from notification service (NS).
 */
model HybridConnectionConfig {
  /**
   * Timestamp when this token will be expired.
   */
  @visibility("read")
  expirationTime?: int64;

  /**
   * Name of the connection
   */
  @visibility("read")
  hybridConnectionName?: string;

  /**
   * Name of the notification service.
   */
  @visibility("read")
  relay?: string;

  /**
   * Listener access token
   */
  @visibility("read")
  token?: string;
}

/**
 * Cluster User Credential appliance.
 */
model ApplianceCredentialKubeconfig {
  /**
   * Name which contains the role of the kubeconfig.
   */
  @visibility("read")
  name?: AccessProfileType;

  /**
   * Contains the kubeconfig value.
   */
  @visibility("read")
  value?: string;
}

/**
 * The List Cluster Keys Results appliance.
 */
model ApplianceListKeysResults {
  /**
   * Map of artifacts that contains a list of ArtifactProfile used to upload artifacts such as logs.
   */
  @visibility("read")
  artifactProfiles?: Record<ArtifactProfile>;

  /**
   * The list of appliance kubeconfigs.
   */
  @visibility("read")
  kubeconfigs?: ApplianceCredentialKubeconfig[];

  /**
   * Map of Customer User Public, Private SSH Keys and Certificate when available.
   */
  @visibility("read")
  sshKeys?: Record<SSHKey>;
}

/**
 * Appliance ArtifactProfile definition.
 */
model ArtifactProfile {
  /**
   * Endpoint is the URL to upload artifacts to.
   */
  @visibility("read")
  endpoint?: string;
}

/**
 * Appliance SSHKey definition.
 */
model SSHKey {
  /**
   * Certificate associated with the public key if the key is signed.
   */
  @visibility("read")
  certificate?: string;

  /**
   * Certificate creation timestamp (Unix).
   */
  @visibility("read")
  creationTimeStamp?: int64;

  /**
   * Certificate expiration timestamp (Unix).
   */
  @visibility("read")
  expirationTimeStamp?: int64;

  /**
   * Private Key.
   */
  @visibility("read")
  privateKey?: string;

  /**
   * Public Key.
   */
  @visibility("read")
  publicKey?: string;
}

/**
 * The Upgrade Graph for appliance.
 */
model UpgradeGraph {
  /**
   * The appliance resource path
   */
  @visibility("read")
  id?: string;

  /**
   * The release train name.
   */
  @visibility("read")
  name?: string;

  /**
   * The properties of supported version
   */
  properties?: UpgradeGraphProperties;
}

/**
 * The Upgrade Graph Properties for appliance.
 */
model UpgradeGraphProperties {
  /**
   * The current appliance version
   */
  @visibility("read")
  applianceVersion?: string;

  /**
   * This contains the current version and supported upgrade versions.
   */
  @visibility("read")
  supportedVersions?: SupportedVersion[];
}

/**
 * The SupportedVersion object for appliance.
 */
model SupportedVersion {
  /**
   * This is the metadata of the supported newer version.
   */
  @visibility("read")
  metadata?: SupportedVersionMetadata;

  /**
   * The newer version available for upgrade.
   */
  @visibility("read")
  version?: string;
}

/**
 * The SupportedVersionMetadata object for appliance.
 */
model SupportedVersionMetadata {
  /**
   * The newer supported version catalog version.
   */
  @visibility("read")
  catalogVersion?: SupportedVersionCatalogVersion;
}

/**
 * The SupportedVersionCatalogVersion object for appliance.
 */
model SupportedVersionCatalogVersion {
  /**
   * The newer supported version catalog version data.
   */
  @visibility("read")
  data?: SupportedVersionCatalogVersionData;

  /**
   * The catalog version name for the version available for upgrade.
   */
  @visibility("read")
  name?: string;

  /**
   * The catalog version namespace for the version available for upgrade.
   */
  @visibility("read")
  `namespace`?: string;
}

/**
 * The SupportedVersionCatalogVersionData object for appliance.
 */
model SupportedVersionCatalogVersionData {
  /**
   * The image audience name for the version available for upgrade.
   */
  @visibility("read")
  audience?: string;

  /**
   * The image catalog name for the version available for upgrade.
   */
  @visibility("read")
  catalog?: string;

  /**
   * The image offer name for the version available for upgrade.
   */
  @visibility("read")
  offer?: string;

  /**
   * The image version for the version available for upgrade.
   */
  @visibility("read")
  version?: string;
}

/**
 * Appliances operation.
 */
model ApplianceOperation {
  /**
   * Describes the properties of an Appliances Operation Value Display.
   */
  @extension("x-ms-client-flatten", true)
  display?: ApplianceOperationValueDisplay;

  /**
   * Is this Operation a data plane operation
   */
  @visibility("read")
  isDataAction?: boolean;

  /**
   * The name of the compute operation.
   */
  @visibility("read")
  name?: string;

  /**
   * The origin of the compute operation.
   */
  @visibility("read")
  origin?: string;
}

/**
 * Describes the properties of an Appliances Operation Value Display.
 */
model ApplianceOperationValueDisplay {
  /**
   * The description of the operation.
   */
  @visibility("read")
  description?: string;

  /**
   * The display name of the compute operation.
   */
  @visibility("read")
  operation?: string;

  /**
   * The resource provider for the operation.
   */
  @visibility("read")
  provider?: string;

  /**
   * The display name of the resource the operation applies to.
   */
  @visibility("read")
  resource?: string;
}

/**
 * Lists of Appliances operations.
 */
model ApplianceOperationsList {
  /**
   * Next page of operations.
   */
  nextLink?: string;

  /**
   * Array of applianceOperation
   */
  value: ApplianceOperation[];
}

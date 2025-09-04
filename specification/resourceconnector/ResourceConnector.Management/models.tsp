import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ResourceConnector;

/**
 * The identity type.
 */
union ResourceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * Represents a supported Fabric/Infra. (AKSEdge etc...).
 */
union Distro {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AKSEdge: "AKSEdge",
}

/**
 * Information about the connected appliance.
 */
union Provider {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  VMWare: "VMWare",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HCI: "HCI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SCVMM: "SCVMM",
}

/**
 * Appliance’s health and state of connection to on-prem
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForHeartbeat: "WaitingForHeartbeat",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Validating: "Validating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connecting: "Connecting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PreparingForUpgrade: "PreparingForUpgrade",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ETCDSnapshotFailed: "ETCDSnapshotFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpgradePrerequisitesCompleted: "UpgradePrerequisitesCompleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidatingSFSConnectivity: "ValidatingSFSConnectivity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidatingImageDownload: "ValidatingImageDownload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidatingImageUpload: "ValidatingImageUpload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ValidatingETCDHealth: "ValidatingETCDHealth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PreUpgrade: "PreUpgrade",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpgradingKVAIO: "UpgradingKVAIO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForKVAIO: "WaitingForKVAIO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImagePending: "ImagePending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageProvisioning: "ImageProvisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageProvisioned: "ImageProvisioned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageDownloading: "ImageDownloading",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageDownloaded: "ImageDownloaded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageDeprovisioning: "ImageDeprovisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ImageUnknown: "ImageUnknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpdatingCloudOperator: "UpdatingCloudOperator",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  WaitingForCloudOperator: "WaitingForCloudOperator",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpdatingCAPI: "UpdatingCAPI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpdatingCluster: "UpdatingCluster",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PostUpgrade: "PostUpgrade",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpgradeComplete: "UpgradeComplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpgradeClusterExtensionFailedToDelete: "UpgradeClusterExtensionFailedToDelete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UpgradeFailed: "UpgradeFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Key: "Key",
}

/**
 * Name which contains the role of the kubeconfig.
 */
union AccessProfileType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  clusterUser: "clusterUser",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  clusterCustomerUser: "clusterCustomerUser",
}

/**
 * Appliance ArtifactType definition.
 */
union ArtifactType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LogsArtifactType: "LogsArtifactType",
}

/**
 * Appliance SSHKeyType definition.
 */
union SSHKeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SSHCustomerUser: "SSHCustomerUser",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ManagementCAKey: "ManagementCAKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  LogsKey: "LogsKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ScopedAccessKey: "ScopedAccessKey",
}

/**
 * Appliances operation.
 */
model ApplianceOperation {
  /**
   * Describes the properties of an Appliances Operation Value Display.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  display?: ApplianceOperationValueDisplay;

  /**
   * Is this Operation a data plane operation
   */
  @visibility(Lifecycle.Read)
  isDataAction?: boolean;

  /**
   * The name of the compute operation.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The origin of the compute operation.
   */
  @visibility(Lifecycle.Read)
  origin?: string;
}

/**
 * Describes the properties of an Appliances Operation Value Display.
 */
model ApplianceOperationValueDisplay {
  /**
   * The description of the operation.
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * The display name of the compute operation.
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * The resource provider for the operation.
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * The display name of the resource the operation applies to.
   */
  @visibility(Lifecycle.Read)
  resource?: string;
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Certificates pair used to download MSI certificate from HIS. Can only be set once.
   */
  publicKey?: string;

  /**
   * Appliance’s health and state of connection to on-prem
   */
  @visibility(Lifecycle.Read)
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
 * The Get Telemetry Config Result appliance.
 */
model ApplianceGetTelemetryConfigResult {
  /**
   * Telemetry instrumentation key.
   */
  @visibility(Lifecycle.Read)
  telemetryInstrumentationKey?: string;
}

/**
 * The Appliances patchable resource definition.
 */
model PatchableAppliance {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The List Cluster User Credential appliance.
 */
model ApplianceListCredentialResults {
  /**
   * Contains the REP (rendezvous endpoint) and “Listener” access token from notification service (NS).
   */
  @visibility(Lifecycle.Read)
  hybridConnectionConfig?: HybridConnectionConfig;

  /**
   * The list of appliance kubeconfigs.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  kubeconfigs?: ApplianceCredentialKubeconfig[];
}

/**
 * Contains the REP (rendezvous endpoint) and “Listener” access token from notification service (NS).
 */
model HybridConnectionConfig {
  /**
   * Timestamp when this token will be expired.
   */
  @visibility(Lifecycle.Read)
  expirationTime?: int64;

  /**
   * Name of the connection
   */
  @visibility(Lifecycle.Read)
  hybridConnectionName?: string;

  /**
   * Name of the notification service.
   */
  @visibility(Lifecycle.Read)
  relay?: string;

  /**
   * Listener access token
   */
  @visibility(Lifecycle.Read)
  token?: string;
}

/**
 * Cluster User Credential appliance.
 */
model ApplianceCredentialKubeconfig {
  /**
   * Name which contains the role of the kubeconfig.
   */
  @visibility(Lifecycle.Read)
  name?: AccessProfileType;

  /**
   * Contains the kubeconfig value.
   */
  @visibility(Lifecycle.Read)
  value?: string;
}

/**
 * The List Cluster Keys Results appliance.
 */
model ApplianceListKeysResults {
  /**
   * Map of artifacts that contains a list of ArtifactProfile used to upload artifacts such as logs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  artifactProfiles?: Record<ArtifactProfile>;

  /**
   * The list of appliance kubeconfigs.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  kubeconfigs?: ApplianceCredentialKubeconfig[];

  /**
   * Map of Customer User Public, Private SSH Keys and Certificate when available.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read)
  sshKeys?: Record<SSHKey>;
}

/**
 * Appliance ArtifactProfile definition.
 */
model ArtifactProfile {
  /**
   * Endpoint is the URL to upload artifacts to.
   */
  @visibility(Lifecycle.Read)
  endpoint?: string;
}

/**
 * Appliance SSHKey definition.
 */
model SSHKey {
  /**
   * Certificate associated with the public key if the key is signed.
   */
  @visibility(Lifecycle.Read)
  certificate?: string;

  /**
   * Certificate creation timestamp (Unix).
   */
  @visibility(Lifecycle.Read)
  creationTimeStamp?: int64;

  /**
   * Certificate expiration timestamp (Unix).
   */
  @visibility(Lifecycle.Read)
  expirationTimeStamp?: int64;

  /**
   * Private Key.
   */
  @visibility(Lifecycle.Read)
  privateKey?: string;

  /**
   * Public Key.
   */
  @visibility(Lifecycle.Read)
  publicKey?: string;
}

/**
 * The Upgrade Graph for appliance.
 */
model UpgradeGraph {
  /**
   * The appliance resource path
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The release train name.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  applianceVersion?: string;

  /**
   * This contains the current version and supported upgrade versions.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  supportedVersions?: SupportedVersion[];
}

/**
 * The SupportedVersion object for appliance.
 */
model SupportedVersion {
  /**
   * This is the metadata of the supported newer version.
   */
  @visibility(Lifecycle.Read)
  metadata?: SupportedVersionMetadata;

  /**
   * The newer version available for upgrade.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * The SupportedVersionMetadata object for appliance.
 */
model SupportedVersionMetadata {
  /**
   * The newer supported version catalog version.
   */
  @visibility(Lifecycle.Read)
  catalogVersion?: SupportedVersionCatalogVersion;
}

/**
 * The SupportedVersionCatalogVersion object for appliance.
 */
model SupportedVersionCatalogVersion {
  /**
   * The newer supported version catalog version data.
   */
  @visibility(Lifecycle.Read)
  data?: SupportedVersionCatalogVersionData;

  /**
   * The catalog version name for the version available for upgrade.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The catalog version namespace for the version available for upgrade.
   */
  @visibility(Lifecycle.Read)
  `namespace`?: string;
}

/**
 * The SupportedVersionCatalogVersionData object for appliance.
 */
model SupportedVersionCatalogVersionData {
  /**
   * The image audience name for the version available for upgrade.
   */
  @visibility(Lifecycle.Read)
  audience?: string;

  /**
   * The image catalog name for the version available for upgrade.
   */
  @visibility(Lifecycle.Read)
  catalog?: string;

  /**
   * The image offer name for the version available for upgrade.
   */
  @visibility(Lifecycle.Read)
  offer?: string;

  /**
   * The image version for the version available for upgrade.
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

model ApplianceOperationsList is Azure.Core.Page<ApplianceOperation>;

model ApplianceListResult is Azure.Core.Page<Appliance>;

@@visibility(ApplianceListResult.value, Lifecycle.Read);

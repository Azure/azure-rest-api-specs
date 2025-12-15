import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

namespace Microsoft.ResourceConnector;

/**
 * The identity type.
 */
union ResourceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * Represents a supported Fabric/Infra. (AKSEdge etc...).
 */
union Distro {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  AKSEdge: "AKSEdge",
}

/**
 * Information about the connected appliance.
 */
union Provider {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  VMWare: "VMWare",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  HCI: "HCI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SCVMM: "SCVMM",
}

/**
 * Appliance’s health and state of connection to on-prem. This list of values is not exhaustive.
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForHeartbeat: "WaitingForHeartbeat",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Validating: "Validating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Connecting: "Connecting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Connected: "Connected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PreparingForUpgrade: "PreparingForUpgrade",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ETCDSnapshotFailed: "ETCDSnapshotFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpgradePrerequisitesCompleted: "UpgradePrerequisitesCompleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidatingSFSConnectivity: "ValidatingSFSConnectivity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidatingImageDownload: "ValidatingImageDownload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidatingImageUpload: "ValidatingImageUpload",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ValidatingETCDHealth: "ValidatingETCDHealth",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PreUpgrade: "PreUpgrade",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpgradingKVAIO: "UpgradingKVAIO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForKVAIO: "WaitingForKVAIO",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImagePending: "ImagePending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImageProvisioning: "ImageProvisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImageProvisioned: "ImageProvisioned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImageDownloading: "ImageDownloading",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImageDownloaded: "ImageDownloaded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImageDeprovisioning: "ImageDeprovisioning",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ImageUnknown: "ImageUnknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpdatingCloudOperator: "UpdatingCloudOperator",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  WaitingForCloudOperator: "WaitingForCloudOperator",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpdatingCAPI: "UpdatingCAPI",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpdatingCluster: "UpdatingCluster",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PostUpgrade: "PostUpgrade",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpgradeComplete: "UpgradeComplete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpgradeClusterExtensionFailedToDelete: "UpgradeClusterExtensionFailedToDelete",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  UpgradeFailed: "UpgradeFailed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Offline: "Offline",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  NetworkProxyUpdatePreparing: "NetworkProxyUpdatePreparing",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  NetworkProxyUpdating: "NetworkProxyUpdating",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  NetworkProxyUpdateComplete: "NetworkProxyUpdateComplete",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  NetworkProxyUpdateFailed: "NetworkProxyUpdateFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  NetworkDNSUpdatePreparing: "NetworkDNSUpdatePreparing",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  NetworkDNSUpdating: "NetworkDNSUpdating",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  NetworkDNSUpdateComplete: "NetworkDNSUpdateComplete",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  NetworkDNSUpdateFailed: "NetworkDNSUpdateFailed",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  ArcGatewayUpdatePreparing: "ArcGatewayUpdatePreparing",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  ArcGatewayUpdating: "ArcGatewayUpdating",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  ArcGatewayUpdateComplete: "ArcGatewayUpdateComplete",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  ArcGatewayUpdateFailed: "ArcGatewayUpdateFailed",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Name which contains the role of the kubeconfig.
 */
union AccessProfileType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterUser: "clusterUser",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  clusterCustomerUser: "clusterCustomerUser",
}

/**
 * Appliance ArtifactType definition.
 */
@usage(Usage.output)
union ArtifactType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LogsArtifactType: "LogsArtifactType",
}

/**
 * Appliance SSHKeyType definition.
 */
@usage(Usage.output)
union SSHKeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  SSHCustomerUser: "SSHCustomerUser",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagementCAKey: "ManagementCAKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  LogsKey: "LogsKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ScopedAccessKey: "ScopedAccessKey",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2025_03_01_preview)
  UserManagementKey: "UserManagementKey",
}

/**
 * Appliances operation.
 */
model ApplianceOperation {
  /**
   * Describes the properties of an Appliances Operation Value Display.
   */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Certificates pair used to download MSI certificate from HIS. Can only be set once.
   */
  publicKey?: string;

  /**
   * Appliance’s health and state of connection to on-prem. This list of values is not exhaustive.
   */
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * Version of the Appliance
   */
  version?: string;

  /**
   * A list of events that occurred on the Appliance to relay information to the user.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  @added(Versions.v2025_03_01_preview)
  events?: Event[];

  /**
   * Contains network information about the Appliance
   */
  @added(Versions.v2025_03_01_preview)
  networkProfile?: NetworkProfile;
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
 * Event contains information about customer driven, platform driven, or unplanned events that occurred on the Appliance
 */
model Event {
  /**
   * The type of event is used to classify how the event was initiated.
   */
  type?: string;

  /**
   * Code is used to break down the event further to identify why it occurred.
   */
  code?: string;

  /**
   * Status is used to represent the outcome of the event.
   */
  status?: string;

  /**
   * Message is intended to be actionable and should be used to inform the user of the event.
   */
  message?: string;

  /**
   * Severity is the classification of the event to relay the importance of the event.
   */
  severity?: string;

  /**
   * Timestamp is the time the event occurred.
   */
  timestamp?: utcDateTime;
}

/**
 * Contains network information about the Appliance
 */
model NetworkProfile {
  /**
   * Contains proxy information about the Appliance
   */
  proxyConfiguration?: ProxyConfiguration;

  /**
   * Contains DNS information about the Appliance
   */
  dnsConfiguration?: DnsConfiguration;

  /**
   * Contains Arc Gateway information about the Appliance
   */
  gatewayConfiguration?: GatewayConfiguration;
}

/**
 * Contains proxy information about the Appliance
 */
model ProxyConfiguration {
  /**
   * Version of the proxy configuration.
   */
  version?: string;
}

/**
 * Contains DNS information about the Appliance
 */
model DnsConfiguration {
  /**
   * Version of the DNS configuration.
   */
  version?: string;
}

/**
 * Contains Arc Gateway information about the Appliance
 */
model GatewayConfiguration {
  /**
   * Version of the Arc Gateway configuration.
   */
  version?: string;
}

/**
 * The Get Telemetry Config Result appliance.
 */
model ApplianceGetTelemetryConfigResult {
  /**
   * Telemetry instrumentation key.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Mark this property as @secret if it should be kept private."
  @visibility(Lifecycle.Read)
  telemetryInstrumentationKey?: string;
}

/**
 * The Appliances patchable resource definition.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PatchableAppliance {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  @identifiers(#[])
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Mark this property as @secret if it should be kept private."
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  artifactProfiles?: Record<ArtifactProfile>;

  /**
   * The list of appliance kubeconfigs.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  kubeconfigs?: ApplianceCredentialKubeconfig[];

  /**
   * Map of Customer User Public, Private SSH Keys and Certificate when available.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Mark this property as @secret if it should be kept private."
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
  @identifiers(#[])
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

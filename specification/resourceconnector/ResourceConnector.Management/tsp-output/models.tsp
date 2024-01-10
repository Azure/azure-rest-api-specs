import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ResourceConnector;

interface Operations extends Azure.ResourceManager.Operations {}

enum ResourceIdentityType {
  SystemAssigned,
  None,
}

enum Distro {
  AKSEdge,
}

enum Provider {
  VMWare,
  HCI,
  SCVMM,
}

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

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum AccessProfileType {
  clusterUser,
  clusterCustomerUser,
}

enum ArtifactType {
  LogsArtifactType,
}

enum SSHKeyType {
  SSHCustomerUser,
  ManagementCAKey,
  LogsKey,
  ScopedAccessKey,
}

@doc("Identity for the resource.")
model Identity {
  @doc("The principal ID of resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of resource.")
  @visibility("read")
  tenantId?: string;

  @doc("The identity type.")
  type?: ResourceIdentityType;
}

@doc("Properties for an appliance.")
model ApplianceProperties {
  @doc("Represents a supported Fabric/Infra. (AKSEdge etc...).")
  distro?: Distro;

  @doc("Contains infrastructure information about the Appliance")
  infrastructureConfig?: AppliancePropertiesInfrastructureConfig;

  @doc("The current deployment or provisioning state, which only appears in the response.")
  @visibility("read")
  provisioningState?: string;

  @doc("Certificates pair used to download MSI certificate from HIS. Can only be set once.")
  publicKey?: string;

  @doc("Appliance’s health and state of connection to on-prem")
  @visibility("read")
  status?: Status;

  @doc("Version of the Appliance")
  version?: string;
}

@doc("Contains infrastructure information about the Appliance")
model AppliancePropertiesInfrastructureConfig {
  @doc("Information about the connected appliance.")
  provider?: Provider;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The Get Telemetry Config Result appliance.")
model ApplianceGetTelemetryConfigResult {
  @doc("Telemetry instrumentation key.")
  @visibility("read")
  telemetryInstrumentationKey?: string;
}

@doc("The Appliances patchable resource definition.")
model PatchableAppliance {
  @doc("Resource tags")
  tags?: Record<string>;
}

@doc("The List Cluster User Credential appliance.")
model ApplianceListCredentialResults {
  @doc("Contains the REP (rendezvous endpoint) and “Listener” access token from notification service (NS).")
  @visibility("read")
  hybridConnectionConfig?: HybridConnectionConfig;

  @doc("The list of appliance kubeconfigs.")
  @visibility("read")
  kubeconfigs?: ApplianceCredentialKubeconfig[];
}

@doc("Contains the REP (rendezvous endpoint) and “Listener” access token from notification service (NS).")
model HybridConnectionConfig {
  @doc("Timestamp when this token will be expired.")
  @visibility("read")
  expirationTime?: int32;

  @doc("Name of the connection")
  @visibility("read")
  hybridConnectionName?: string;

  @doc("Name of the notification service.")
  @visibility("read")
  relay?: string;

  @doc("Listener access token")
  @visibility("read")
  token?: string;
}

@doc("Cluster User Credential appliance.")
model ApplianceCredentialKubeconfig {
  @doc("Name which contains the role of the kubeconfig.")
  @visibility("read")
  name?: AccessProfileType;

  @doc("Contains the kubeconfig value.")
  @visibility("read")
  value?: string;
}

@doc("The List Cluster Keys Results appliance.")
model ApplianceListKeysResults {
  @doc("Map of artifacts that contains a list of ArtifactProfile used to upload artifacts such as logs.")
  @visibility("read")
  artifactProfiles?: Record<ArtifactProfile>;

  @doc("The list of appliance kubeconfigs.")
  @visibility("read")
  kubeconfigs?: ApplianceCredentialKubeconfig[];

  @doc("Map of Customer User Public, Private SSH Keys and Certificate when available.")
  @visibility("read")
  sshKeys?: Record<SSHKey>;
}

@doc("Appliance ArtifactProfile definition.")
model ArtifactProfile {
  @doc("Endpoint is the URL to upload artifacts to.")
  @visibility("read")
  endpoint?: string;
}

@doc("Appliance SSHKey definition.")
model SSHKey {
  @doc("Certificate associated with the public key if the key is signed.")
  @visibility("read")
  certificate?: string;

  @doc("Certificate creation timestamp (Unix).")
  @visibility("read")
  creationTimeStamp?: int32;

  @doc("Certificate expiration timestamp (Unix).")
  @visibility("read")
  expirationTimeStamp?: int32;

  @doc("Private Key.")
  @visibility("read")
  privateKey?: string;

  @doc("Public Key.")
  @visibility("read")
  publicKey?: string;
}

@doc("The Upgrade Graph for appliance.")
model UpgradeGraph {
  @doc("The appliance resource path")
  @visibility("read")
  id?: string;

  @doc("The release train name.")
  @visibility("read")
  name?: string;

  @doc("The properties of supported version")
  properties?: UpgradeGraphProperties;
}

@doc("The Upgrade Graph Properties for appliance.")
model UpgradeGraphProperties {
  @doc("The current appliance version")
  @visibility("read")
  applianceVersion?: string;

  @doc("This contains the current version and supported upgrade versions.")
  @visibility("read")
  supportedVersions?: SupportedVersion[];
}

@doc("The SupportedVersion object for appliance.")
model SupportedVersion {
  @doc("This is the metadata of the supported newer version.")
  @visibility("read")
  metadata?: SupportedVersionMetadata;

  @doc("The newer version available for upgrade.")
  @visibility("read")
  version?: string;
}

@doc("The SupportedVersionMetadata object for appliance.")
model SupportedVersionMetadata {
  @doc("The newer supported version catalog version.")
  @visibility("read")
  catalogVersion?: SupportedVersionCatalogVersion;
}

@doc("The SupportedVersionCatalogVersion object for appliance.")
model SupportedVersionCatalogVersion {
  @doc("The newer supported version catalog version data.")
  @visibility("read")
  data?: SupportedVersionCatalogVersionData;

  @doc("The catalog version name for the version available for upgrade.")
  @visibility("read")
  name?: string;

  @doc("The catalog version namespace for the version available for upgrade.")
  @visibility("read")
  `namespace`?: string;
}

@doc("The SupportedVersionCatalogVersionData object for appliance.")
model SupportedVersionCatalogVersionData {
  @doc("The image audience name for the version available for upgrade.")
  @visibility("read")
  audience?: string;

  @doc("The image catalog name for the version available for upgrade.")
  @visibility("read")
  catalog?: string;

  @doc("The image offer name for the version available for upgrade.")
  @visibility("read")
  offer?: string;

  @doc("The image version for the version available for upgrade.")
  @visibility("read")
  version?: string;
}

@doc("Appliances operation.")
model ApplianceOperation {
  @doc("Describes the properties of an Appliances Operation Value Display.")
  display?: ApplianceOperationValueDisplay;

  @doc("Is this Operation a data plane operation")
  @visibility("read")
  isDataAction?: boolean;

  @doc("The name of the compute operation.")
  @visibility("read")
  name?: string;

  @doc("The origin of the compute operation.")
  @visibility("read")
  origin?: string;
}

@doc("Describes the properties of an Appliances Operation Value Display.")
model ApplianceOperationValueDisplay {
  @doc("The description of the operation.")
  @visibility("read")
  description?: string;

  @doc("The display name of the compute operation.")
  @visibility("read")
  operation?: string;

  @doc("The resource provider for the operation.")
  @visibility("read")
  provider?: string;

  @doc("The display name of the resource the operation applies to.")
  @visibility("read")
  resource?: string;
}

@doc("Lists of Appliances operations.")
model ApplianceOperationsList {
  @doc("Next page of operations.")
  nextLink?: string;

  @doc("Array of applianceOperation")
  value: ApplianceOperation[];
}

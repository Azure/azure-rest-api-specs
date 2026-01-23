import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceFabric;
/**
 * The cluster resource
 *
 */
model Cluster is Azure.ResourceManager.TrackedResource<ClusterProperties> {
  ...ResourceNameParameter<
    Resource = Cluster,
    KeyName = "clusterName",
    SegmentName = "clusters",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "servicefabric is brownfield service with legacy patterns for resources"
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface Clusters {
  /**
   * Get a Service Fabric cluster resource created or in the process of being created in the specified resource group.
   */
  get is ArmResourceRead<Cluster>;

  /**
   * Create or update a Service Fabric cluster resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "servicefabric is brownfield service with existing non-standard 202 response body"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "servicefabric is brownfield service with existing non-standard response codes"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cluster,
    Response = ArmResourceUpdatedResponse<Cluster> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Cluster>> & {
      @bodyRoot
      _: Cluster;
    })
  >;

  /**
   * Update the configuration of a Service Fabric cluster resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "servicefabric is brownfield service with existing non-standard 202 response body"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Cluster,
    PatchModel = ClusterUpdateParameters,
    Response = ArmResponse<Cluster> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Cluster;
    }),
    LroHeaders = ArmCombinedLroHeaders<FinalResult = Cluster>
  >;

  /**
   * Delete a Service Fabric cluster resource with the specified name.
   */
  delete is ArmResourceDeleteSync<Cluster>;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Cluster>;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the subscription.
   */
  list is ArmListBySubscription<Cluster>;

  /**
   * If a target is not provided, it will get the minimum and maximum versions available from the current cluster version. If a target is given, it will provide the required path to get from the current cluster version to the target version.
   */
  listUpgradableVersions is ArmResourceActionSync<
    Cluster,
    UpgradableVersionsDescription,
    ArmResponse<UpgradableVersionPathResult>,
    OptionalRequestBody = true
  >;
}

@@doc(Cluster.name, "The name of the cluster resource.");
@@doc(Cluster.properties, "The cluster resource properties");
@@doc(Clusters.createOrUpdate::parameters.resource, "The cluster resource.");
@@doc(Clusters.update::parameters.properties,
  "The parameters which contains the property value and property name which used to update the cluster configuration."
);
@@doc(Clusters.listUpgradableVersions::parameters.body,
  "The upgrade path description with target version."
);

/**
 * Describes the cluster resource properties.
 */
model ClusterProperties {
  /**
   * The list of add-on features to enable in the cluster.
   */
  addOnFeatures?: AddOnFeatures[];

  /**
   * The Service Fabric runtime versions available for this cluster.
   */
  @identifiers(#["codeVersion", "environment"])
  @visibility(Lifecycle.Read)
  availableClusterVersions?: ClusterVersionDetails[];

  /**
   * The AAD authentication settings of the cluster.
   */
  azureActiveDirectory?: AzureActiveDirectory;

  /**
   * The certificate to use for securing the cluster. The certificate provided will be used for node to node security within the cluster, SSL certificate for cluster management endpoint and default admin client.
   */
  certificate?: CertificateDescription;

  /**
   * Describes a list of server certificates referenced by common name that are used to secure the cluster.
   */
  certificateCommonNames?: ServerCertificateCommonNames;

  /**
   * The list of client certificates referenced by common name that are allowed to manage the cluster.
   */
  @identifiers(#["certificateCommonName"])
  clientCertificateCommonNames?: ClientCertificateCommonName[];

  /**
   * The list of client certificates referenced by thumbprint that are allowed to manage the cluster.
   */
  @identifiers(#["certificateThumbprint"])
  clientCertificateThumbprints?: ClientCertificateThumbprint[];

  /**
   * The Service Fabric runtime version of the cluster. This property can only by set the user when **upgradeMode** is set to 'Manual'. To get list of available Service Fabric versions for new clusters use [ClusterVersion API](https://learn.microsoft.com/rest/api/servicefabric/cluster-versions/list). To get the list of available version for existing clusters use **availableClusterVersions**.
   */
  clusterCodeVersion?: string;

  /**
   * The Azure Resource Provider endpoint. A system service in the cluster connects to this  endpoint.
   */
  @visibility(Lifecycle.Read)
  clusterEndpoint?: string;

  /**
   * A service generated unique identifier for the cluster resource.
   */
  @visibility(Lifecycle.Read)
  clusterId?: string;

  /**
   * The current state of the cluster.
   *
   *   - WaitingForNodes - Indicates that the cluster resource is created and the resource provider is waiting for Service Fabric VM extension to boot up and report to it.
   *   - Deploying - Indicates that the Service Fabric runtime is being installed on the VMs. Cluster resource will be in this state until the cluster boots up and system services are up.
   *   - BaselineUpgrade - Indicates that the cluster is upgrading to establishes the cluster version. This upgrade is automatically initiated when the cluster boots up for the first time.
   *   - UpdatingUserConfiguration - Indicates that the cluster is being upgraded with the user provided configuration.
   *   - UpdatingUserCertificate - Indicates that the cluster is being upgraded with the user provided certificate.
   *   - UpdatingInfrastructure - Indicates that the cluster is being upgraded with the latest Service Fabric runtime version. This happens only when the **upgradeMode** is set to 'Automatic'.
   *   - EnforcingClusterVersion - Indicates that cluster is on a different version than expected and the cluster is being upgraded to the expected version.
   *   - UpgradeServiceUnreachable - Indicates that the system service in the cluster is no longer polling the Resource Provider. Clusters in this state cannot be managed by the Resource Provider.
   *   - AutoScale - Indicates that the ReliabilityLevel of the cluster is being adjusted.
   *   - Ready - Indicates that the cluster is in a stable state.
   *
   */
  @visibility(Lifecycle.Read)
  clusterState?: ClusterState;

  /**
   * The storage account information for storing Service Fabric diagnostic logs.
   */
  diagnosticsStorageAccountConfig?: DiagnosticsStorageAccountConfig;

  /**
   * Indicates if the event store service is enabled.
   */
  eventStoreServiceEnabled?: boolean;

  /**
   * The list of custom fabric settings to configure the cluster.
   */
  fabricSettings?: SettingsSectionDescription[];

  /**
   * The http management endpoint of the cluster.
   */
  managementEndpoint: string;

  /**
   * The list of node types in the cluster.
   */
  nodeTypes: NodeTypeDescription[];

  /**
   * The provisioning state of the cluster resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).
   *
   *   - None - Run the System services with a target replica set count of 1. This should only be used for test clusters.
   *   - Bronze - Run the System services with a target replica set count of 3. This should only be used for test clusters.
   *   - Silver - Run the System services with a target replica set count of 5.
   *   - Gold - Run the System services with a target replica set count of 7.
   *   - Platinum - Run the System services with a target replica set count of 9.
   *
   */
  reliabilityLevel?: ReliabilityLevel;

  /**
   * The server certificate used by reverse proxy.
   */
  reverseProxyCertificate?: CertificateDescription;

  /**
   * Describes a list of server certificates referenced by common name that are used to secure the cluster.
   */
  reverseProxyCertificateCommonNames?: ServerCertificateCommonNames;

  /**
   * The policy to use when upgrading the cluster.
   */
  upgradeDescription?: ClusterUpgradePolicy;

  /**
   * The upgrade mode of the cluster when new Service Fabric runtime version is available.
   */
  upgradeMode?: UpgradeMode = UpgradeMode.Automatic;

  /**
   * The policy used to clean up unused versions.
   */
  applicationTypeVersionsCleanupPolicy?: ApplicationTypeVersionsCleanupPolicy;

  /**
   * The VM image VMSS has been configured with. Generic names such as Windows or Linux can be used.
   */
  vmImage?: string;

  /**
   * This property controls the logical grouping of VMs in upgrade domains (UDs). This property can't be modified if a node type with multiple Availability Zones is already present in the cluster.
   */
  sfZonalUpgradeMode?: SfZonalUpgradeMode;

  /**
   * This property defines the upgrade mode for the virtual machine scale set, it is mandatory if a node type with multiple Availability Zones is added.
   */
  vmssZonalUpgradeMode?: VmssZonalUpgradeMode;

  /**
   * Indicates if infrastructure service manager is enabled.
   */
  infrastructureServiceManager?: boolean;

  /**
   * Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0. Only applies when **upgradeMode** is set to 'Automatic'.
   */
  upgradeWave?: ClusterUpgradeCadence;

  /**
   * Indicates the start date and time to pause automatic runtime version upgrades on the cluster for an specific period of time on the cluster (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradePauseStartTimestampUtc?: utcDateTime;

  /**
   * Indicates the end date and time to pause automatic runtime version upgrades on the cluster for an specific period of time on the cluster (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradePauseEndTimestampUtc?: utcDateTime;

  /**
   * Boolean to pause automatic runtime version upgrades to the cluster.
   */
  waveUpgradePaused?: boolean;

  /**
   * Indicates a list of notification channels for cluster events.
   */
  @identifiers(#[])
  notifications?: Notification[];

  /**
   * If true, token-based authentication is not allowed on the HttpGatewayEndpoint. This is required to support TLS versions 1.3 and above. If token-based authentication is used, HttpGatewayTokenAuthEndpointPort must be defined.
   */
  enableHttpGatewayExclusiveAuthMode?: boolean;
}

/**
 * Available cluster add-on features
 */
union AddOnFeatures {
  string,

  /**
   * Add on RepairManager
   */
  RepairManager: "RepairManager",

  /**
   * Add on DnsService
   */
  DnsService: "DnsService",

  /**
   * Add on BackupRestoreService
   */
  BackupRestoreService: "BackupRestoreService",

  /**
   * Add on ResourceMonitorService
   */
  ResourceMonitorService: "ResourceMonitorService",
}

/**
 * Cluster operating system, the default will be Windows
 */
union ClusterEnvironment {
  string,

  /**
   * Windows operating system
   */
  Windows: "Windows",

  /**
   * Linux operating system
   */
  Linux: "Linux",
}

/**
 * The local certificate store location.
 */
union StoreName {
  string,

  /**
   * Static value for AddressBook
   */
  AddressBook: "AddressBook",

  /**
   * Static value for AuthRoot
   */
  AuthRoot: "AuthRoot",

  /**
   * Static value for CertificateAuthority
   */
  CertificateAuthority: "CertificateAuthority",

  /**
   * Static value for Disallowed
   */
  Disallowed: "Disallowed",

  /**
   * Static value for My
   */
  My: "My",

  /**
   * Static value for Root
   */
  Root: "Root",

  /**
   * Static value for TrustedPeople
   */
  TrustedPeople: "TrustedPeople",

  /**
   * Static value for TrustedPublisher
   */
  TrustedPublisher: "TrustedPublisher",
}

/**
 * The current state of the cluster.
 */
union ClusterState {
  string,

  /**
   * Indicates that the cluster resource is created and the resource provider is waiting for Service Fabric VM extension to boot up and report to it.
   */
  WaitingForNodes: "WaitingForNodes",

  /**
   * Indicates that the Service Fabric runtime is being installed on the VMs. Cluster resource will be in this state until the cluster boots up and system services are up.
   */
  Deploying: "Deploying",

  /**
   * Indicates that the cluster is upgrading to establishes the cluster version. This upgrade is automatically initiated when the cluster boots up for the first time.
   */
  BaselineUpgrade: "BaselineUpgrade",

  /**
   * Indicates that the cluster is being upgraded with the user provided configuration.
   */
  UpdatingUserConfiguration: "UpdatingUserConfiguration",

  /**
   * Indicates that the cluster is being upgraded with the user provided certificate.
   */
  UpdatingUserCertificate: "UpdatingUserCertificate",

  /**
   * Indicates that the cluster is being upgraded with the latest Service Fabric runtime version. This happens only when the **upgradeMode** is set to 'Automatic'.
   */
  UpdatingInfrastructure: "UpdatingInfrastructure",

  /**
   * Indicates that cluster is on a different version than expected and the cluster is being upgraded to the expected version.
   */
  EnforcingClusterVersion: "EnforcingClusterVersion",

  /**
   * Indicates that the system service in the cluster is no longer polling the Resource Provider. Clusters in this state cannot be managed by the Resource Provider.
   */
  UpgradeServiceUnreachable: "UpgradeServiceUnreachable",

  /**
   * Indicates that the ReliabilityLevel of the cluster is being adjusted.
   */
  AutoScale: "AutoScale",

  /**
   * Indicates that the cluster is in a stable state.
   */
  Ready: "Ready",
}

/**
 * The durability level of the node type. Learn about [DurabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).
 */
union DurabilityLevel {
  string,

  /**
   *  No privileges. This is the default.
   */
  Bronze: "Bronze",

  /**
   * The infrastructure jobs can be paused for a duration of 10 minutes per UD.
   */
  Silver: "Silver",

  /**
   * The infrastructure jobs can be paused for a duration of 2 hours per UD. Gold durability can be enabled only on full node VM skus like D15_V2, G5 etc.
   */
  Gold: "Gold",
}

/**
 * The provisioning state of the cluster resource.
 */
union ProvisioningState {
  string,

  /**
   * Cluster is updating.
   */
  Updating: "Updating",

  /**
   * Cluster provisioning succeeded.
   */
  Succeeded: "Succeeded",

  /**
   * Cluster provisioning failed.
   */
  Failed: "Failed",

  /**
   * Cluster provisioning was canceled.
   */
  Canceled: "Canceled",
}

/**
 * The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).
 */
union ReliabilityLevel {
  string,

  /**
   * Run the System services with a target replica set count of 1. This should only be used for test clusters.
   */
  None: "None",

  /**
   * Run the System services with a target replica set count of 3. This should only be used for test clusters.
   */
  Bronze: "Bronze",

  /**
   * Run the System services with a target replica set count of 5.
   */
  Silver: "Silver",

  /**
   * Run the System services with a target replica set count of 7.
   */
  Gold: "Gold",

  /**
   * Run the System services with a target replica set count of 9.
   */
  Platinum: "Platinum",
}

/**
 * The upgrade mode of the cluster when new Service Fabric runtime version is available.
 */
union UpgradeMode {
  string,

  /**
   * The cluster will be automatically upgraded to the latest Service Fabric runtime version, **upgradeWave** will determine when the upgrade starts after the new version becomes available.
   */
  Automatic: "Automatic",

  /**
   * The cluster will not be automatically upgraded to the latest Service Fabric runtime version. The cluster is upgraded by setting the **clusterCodeVersion** property in the cluster resource.
   */
  Manual: "Manual",
}

/**
 * This property controls the logical grouping of VMs in upgrade domains (UDs). This property can't be modified if a node type with multiple Availability Zones is already present in the cluster.
 */
union SfZonalUpgradeMode {
  string,

  /**
   * VMs under the node type are grouped into UDs and ignore the zone info in five UDs. This setting causes UDs across all zones to be upgraded at the same time. This deployment mode is faster for upgrades, we don't recommend it because it goes against the SDP guidelines, which state that the updates should be applied to one zone at a time.
   */
  Parallel: "Parallel",

  /**
   * If this value is omitted or set to Hierarchical, VMs are grouped to reflect the zonal distribution in up to 15 UDs. Each of the three zones has five UDs. This ensures that the zones are updated one at a time, moving to next zone only after completing five UDs within the first zone. This update process is safer for the cluster and the user application.
   */
  Hierarchical: "Hierarchical",
}

/**
 * This property defines the upgrade mode for the virtual machine scale set, it is mandatory if a node type with multiple Availability Zones is added.
 */
union VmssZonalUpgradeMode {
  string,

  /**
   * Updates will happen in all Availability Zones at once for the virtual machine scale sets.
   */
  Parallel: "Parallel",

  /**
   * VMs are grouped to reflect the zonal distribution in up to 15 UDs. Each of the three zones has five UDs. This ensures that the zones are updated one at a time, moving to next zone only after completing five UDs within the first zone.
   */
  Hierarchical: "Hierarchical",
}

/**
 * Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0.
 */
union ClusterUpgradeCadence {
  string,

  /**
   * Cluster upgrade starts immediately after a new version is rolled out. Recommended for Test/Dev clusters.
   */
  Wave0: "Wave0",

  /**
   * Cluster upgrade starts 7 days after a new version is rolled out. Recommended for Pre-prod clusters.
   */
  Wave1: "Wave1",

  /**
   * Cluster upgrade starts 14 days after a new version is rolled out. Recommended for Production clusters.
   */
  Wave2: "Wave2",
}

/**
 * The detail of the Service Fabric runtime version result
 */
model ClusterVersionDetails {
  /**
   * The Service Fabric runtime version of the cluster.
   */
  codeVersion?: string;

  /**
   * The date of expiry of support of the version.
   */
  supportExpiryUtc?: string;

  /**
   * Indicates if this version is for Windows or Linux operating system.
   */
  environment?: ClusterEnvironment;
}

/**
 * The settings to enable AAD authentication on the cluster.
 */
model AzureActiveDirectory {
  /**
   * Azure active directory tenant id.
   */
  tenantId?: string;

  /**
   * Azure active directory cluster application id.
   */
  clusterApplication?: string;

  /**
   * Azure active directory client application id.
   */
  clientApplication?: string;
}

/**
 * Describes the certificate details.
 */
model CertificateDescription {
  /**
   * Thumbprint of the primary certificate.
   */
  thumbprint: string;

  /**
   * Thumbprint of the secondary certificate.
   */
  thumbprintSecondary?: string;

  /**
   * The local certificate store location.
   */
  x509StoreName?: StoreName;
}

/**
 * Describes a list of server certificates referenced by common name that are used to secure the cluster.
 */
model ServerCertificateCommonNames {
  /**
   * The list of server certificates referenced by common name that are used to secure the cluster.
   */
  @identifiers(#["certificateCommonName"])
  commonNames?: ServerCertificateCommonName[];

  /**
   * The local certificate store location.
   */
  x509StoreName?: StoreName;
}

/**
 * Describes the server certificate details using common name.
 */
model ServerCertificateCommonName {
  /**
   * The common name of the server certificate.
   */
  certificateCommonName: string;

  /**
   * The issuer thumbprint of the server certificate.
   */
  certificateIssuerThumbprint: string;
}

/**
 * Cluster update request
 */
model ClusterUpdateParameters {
  /**
   * Describes the cluster resource properties that can be updated during PATCH operation.
   */
  properties?: ClusterPropertiesUpdateParameters;

  /**
   * Cluster update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  tags?: Record<string>;
}

/**
 * Describes the cluster resource properties that can be updated during PATCH operation.
 */
model ClusterPropertiesUpdateParameters {
  /**
   * The list of add-on features to enable in the cluster.
   */
  addOnFeatures?: AddOnFeatures[];

  /**
   * The certificate to use for securing the cluster. The certificate provided will be used for  node to node security within the cluster, SSL certificate for cluster management endpoint and default  admin client.
   */
  certificate?: CertificateDescription;

  /**
   * Describes a list of server certificates referenced by common name that are used to secure the cluster.
   */
  certificateCommonNames?: ServerCertificateCommonNames;

  /**
   * The list of client certificates referenced by common name that are allowed to manage the cluster. This will overwrite the existing list.
   */
  @identifiers(#["certificateCommonName"])
  clientCertificateCommonNames?: ClientCertificateCommonName[];

  /**
   * The list of client certificates referenced by thumbprint that are allowed to manage the cluster. This will overwrite the existing list.
   */
  @identifiers(#["certificateThumbprint"])
  clientCertificateThumbprints?: ClientCertificateThumbprint[];

  /**
   * The Service Fabric runtime version of the cluster. This property can only by set the user when **upgradeMode** is set to 'Manual'. To get list of available Service Fabric versions for new clusters use [ClusterVersion API](https://learn.microsoft.com/rest/api/servicefabric/cluster-versions/list). To get the list of available version for existing clusters use **availableClusterVersions**.
   */
  clusterCodeVersion?: string;

  /**
   * Indicates if the event store service is enabled.
   */
  eventStoreServiceEnabled?: boolean;

  /**
   * The list of custom fabric settings to configure the cluster. This will overwrite the existing list.
   */
  fabricSettings?: SettingsSectionDescription[];

  /**
   * The list of node types in the cluster. This will overwrite the existing list.
   */
  nodeTypes?: NodeTypeDescription[];

  /**
   * The reliability level sets the replica set size of system services. Learn about [ReliabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).
   *
   *   - None - Run the System services with a target replica set count of 1. This should only be used for test clusters.
   *   - Bronze - Run the System services with a target replica set count of 3. This should only be used for test clusters.
   *   - Silver - Run the System services with a target replica set count of 5.
   *   - Gold - Run the System services with a target replica set count of 7.
   *   - Platinum - Run the System services with a target replica set count of 9.
   *
   */
  reliabilityLevel?: ReliabilityLevel;

  /**
   * The server certificate used by reverse proxy.
   */
  reverseProxyCertificate?: CertificateDescription;

  /**
   * The policy to use when upgrading the cluster.
   */
  upgradeDescription?: ClusterUpgradePolicy;

  /**
   * The policy used to clean up unused versions.
   */
  applicationTypeVersionsCleanupPolicy?: ApplicationTypeVersionsCleanupPolicy;

  /**
   * The upgrade mode of the cluster when new Service Fabric runtime version is available.
   */
  upgradeMode?: UpgradeMode = UpgradeMode.Automatic;

  /**
   * This property controls the logical grouping of VMs in upgrade domains (UDs). This property can't be modified if a node type with multiple Availability Zones is already present in the cluster.
   */
  sfZonalUpgradeMode?: SfZonalUpgradeMode;

  /**
   * This property defines the upgrade mode for the virtual machine scale set, it is mandatory if a node type with multiple Availability Zones is added.
   */
  vmssZonalUpgradeMode?: VmssZonalUpgradeMode;

  /**
   * Indicates if infrastructure service manager is enabled.
   */
  infrastructureServiceManager?: boolean;

  /**
   * Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0. Only applies when **upgradeMode** is set to 'Automatic'.
   */
  upgradeWave?: ClusterUpgradeCadence;

  /**
   * The start timestamp to pause runtime version upgrades on the cluster (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradePauseStartTimestampUtc?: utcDateTime;

  /**
   * The end timestamp of pause runtime version upgrades on the cluster (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  upgradePauseEndTimestampUtc?: utcDateTime;

  /**
   * Boolean to pause automatic runtime version upgrades to the cluster.
   */
  waveUpgradePaused?: boolean;

  /**
   * Indicates a list of notification channels for cluster events.
   */
  @identifiers(#[])
  notifications?: Notification[];

  /**
   * If true, token-based authentication is not allowed on the HttpGatewayEndpoint. This is required to support TLS versions 1.3 and above. If token-based authentication is used, HttpGatewayTokenAuthEndpointPort must be defined.
   */
  enableHttpGatewayExclusiveAuthMode?: boolean;
}

/**
 * The upgrade path description with target version.
 */
model UpgradableVersionsDescription {
  /**
   * The target code version.
   */
  targetVersion: string;
}

/**
 * The list of intermediate cluster code versions for an upgrade or downgrade, or minimum and maximum upgradable version if no target was given.
 */
model UpgradableVersionPathResult {
  /**
   * The list of intermediate cluster code versions for an upgrade or downgrade.
   */
  supportedPath?: string[];
}

/**
 * Describes the client certificate details using common name.
 */
model ClientCertificateCommonName {
  /**
   * Indicates if the client certificate has admin access to the cluster. Non admin clients can perform only read only operations on the cluster.
   */
  isAdmin: boolean;

  /**
   * The common name of the client certificate.
   */
  certificateCommonName: string;

  /**
   * The issuer thumbprint of the client certificate.
   */
  certificateIssuerThumbprint: string;
}

/**
 * Describes the client certificate details using thumbprint.
 */
model ClientCertificateThumbprint {
  /**
   * Indicates if the client certificate has admin access to the cluster. Non admin clients can perform only read only operations on the cluster.
   */
  isAdmin: boolean;

  /**
   * The thumbprint of the client certificate.
   */
  certificateThumbprint: string;
}

/**
 * The storage account information for storing Service Fabric diagnostic logs.
 */
model DiagnosticsStorageAccountConfig {
  /**
   * The Azure storage account name.
   */
  storageAccountName: string;

  /**
   * The protected diagnostics storage key name.
   */
  protectedAccountKeyName: string;

  /**
   * The secondary protected diagnostics storage key name. If one of the storage account keys is rotated the cluster will fallback to using the other.
   */
  protectedAccountKeyName2?: string;

  /**
   * The blob endpoint of the azure storage account.
   */
  blobEndpoint: string;

  /**
   * The queue endpoint of the azure storage account.
   */
  queueEndpoint: string;

  /**
   * The table endpoint of the azure storage account.
   */
  tableEndpoint: string;
}

/**
 * Describes a section in the fabric settings of the cluster.
 */
model SettingsSectionDescription {
  /**
   * The section name of the fabric settings.
   */
  name: string;

  /**
   * The collection of parameters in the section.
   */
  parameters: SettingsParameterDescription[];
}

/**
 * Describes a parameter in fabric settings of the cluster.
 */
model SettingsParameterDescription {
  /**
   * The parameter name of fabric setting.
   */
  name: string;

  /**
   * The parameter value of fabric setting.
   */
  value: string;
}
/**
 * Describes the policy used when upgrading the cluster.
 */
model ClusterUpgradePolicy {
  /**
   * If true, then processes are forcefully restarted during upgrade even when the code version has not changed (the upgrade only changes configuration or data).
   */
  forceRestart?: boolean = false;

  /**
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues. When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues. The timeout is reset at the start of each upgrade domain. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  upgradeReplicaSetCheckTimeout: string;

  /**
   * The length of time to wait after completing an upgrade domain before performing health checks. The duration can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  healthCheckWaitDuration: string;

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. The duration can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  healthCheckStableDuration: string;

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  healthCheckRetryTimeout: string;

  /**
   * The amount of time the overall upgrade has to complete before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  upgradeTimeout: string;

  /**
   * The amount of time each upgrade domain has to complete before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  upgradeDomainTimeout: string;

  /**
   * The cluster health policy used when upgrading the cluster.
   */
  healthPolicy: ClusterHealthPolicy;

  /**
   * The cluster delta health policy used when upgrading the cluster.
   */
  deltaHealthPolicy?: ClusterUpgradeDeltaHealthPolicy;
}

/**
 * Defines a health policy used to evaluate the health of the cluster or of a cluster node.
 *
 */
model ClusterHealthPolicy {
  /**
   * The maximum allowed percentage of unhealthy nodes before reporting an error. For example, to allow 10% of nodes to be unhealthy, this value would be 10.
   *
   * The percentage represents the maximum tolerated percentage of nodes that can be unhealthy before the cluster is considered in error.
   * If the percentage is respected but there is at least one unhealthy node, the health is evaluated as Warning.
   * The percentage is calculated by dividing the number of unhealthy nodes over the total number of nodes in the cluster.
   * The computation rounds up to tolerate one failure on small numbers of nodes. Default percentage is zero.
   *
   * In large clusters, some nodes will always be down or out for repairs, so this percentage should be configured to tolerate that.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyNodes?: int32 = 0;

  /**
   * The maximum allowed percentage of unhealthy applications before reporting an error. For example, to allow 10% of applications to be unhealthy, this value would be 10.
   *
   * The percentage represents the maximum tolerated percentage of applications that can be unhealthy before the cluster is considered in error.
   * If the percentage is respected but there is at least one unhealthy application, the health is evaluated as Warning.
   * This is calculated by dividing the number of unhealthy applications over the total number of application instances in the cluster, excluding applications of application types that are included in the ApplicationTypeHealthPolicyMap.
   * The computation rounds up to tolerate one failure on small numbers of applications. Default percentage is zero.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyApplications?: int32 = 0;

  /**
   * Defines the application health policy map used to evaluate the health of an application or one of its children entities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  applicationHealthPolicies?: Record<ApplicationHealthPolicy>;
}

/**
 * Defines a health policy used to evaluate the health of an application or one of its children entities.
 *
 */
model ApplicationHealthPolicy {
  /**
   * The health policy used by default to evaluate the health of a service type.
   */
  defaultServiceTypeHealthPolicy?: ServiceTypeHealthPolicy;

  /**
   * The map with service type health policy per service type name. The map is empty by default.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  serviceTypeHealthPolicies?: Record<ServiceTypeHealthPolicy>;
}

/**
 * Represents the health policy used to evaluate the health of services belonging to a service type.
 *
 */
model ServiceTypeHealthPolicy {
  /**
   * The maximum percentage of services allowed to be unhealthy before your application is considered in error.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUnhealthyServices?: int32;
}

/**
 * Describes the delta health policies for the cluster upgrade.
 */
model ClusterUpgradeDeltaHealthPolicy {
  /**
   * The maximum allowed percentage of nodes health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the nodes at the beginning of upgrade and the state of the nodes at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentDeltaUnhealthyNodes: int32 = 0;

  /**
   * The maximum allowed percentage of upgrade domain nodes health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the upgrade domain nodes at the beginning of upgrade and the state of the upgrade domain nodes at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion for all completed upgrade domains to make sure the state of the upgrade domains is within tolerated limits.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUpgradeDomainDeltaUnhealthyNodes: int32 = 0;

  /**
   * The maximum allowed percentage of applications health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the applications at the beginning of upgrade and the state of the applications at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits. System services are not included in this.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentDeltaUnhealthyApplications: int32 = 0;

  /**
   * Defines the application delta health policy map used to evaluate the health of an application or one of its child entities when upgrading the cluster.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  applicationDeltaHealthPolicies?: Record<ApplicationDeltaHealthPolicy>;
}

/**
 * Defines a delta health policy used to evaluate the health of an application or one of its child entities when upgrading the cluster.
 *
 */
model ApplicationDeltaHealthPolicy {
  /**
   * The delta health policy used by default to evaluate the health of a service type when upgrading the cluster.
   */
  defaultServiceTypeDeltaHealthPolicy?: ServiceTypeDeltaHealthPolicy;

  /**
   * The map with service type delta health policy per service type name. The map is empty by default.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  serviceTypeDeltaHealthPolicies?: Record<ServiceTypeDeltaHealthPolicy>;
}
/**
 * Represents the delta health policy used to evaluate the health of services belonging to a service type when upgrading the cluster.
 *
 */
model ServiceTypeDeltaHealthPolicy {
  /**
   * The maximum allowed percentage of services health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the services at the beginning of upgrade and the state of the services at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentDeltaUnhealthyServices?: int32;
}

/**
 * The policy used to clean up unused versions.
 */
model ApplicationTypeVersionsCleanupPolicy {
  /**
   * Number of unused versions per application type to keep.
   */
  @minValue(0)
  maxUnusedVersionsToKeep: int64;
}

/**
 * Describes the notification channel for cluster events.
 */
model Notification {
  /**
   * Indicates if the notification is enabled.
   */
  isEnabled: boolean;

  /**
   * The category of notification.
   */
  notificationCategory: NotificationCategory;

  /**
   * The level of notification.
   */
  notificationLevel: NotificationLevel;

  /**
   * List of targets that subscribe to the notification.
   */
  @identifiers(#[])
  notificationTargets: NotificationTarget[];
}

/**
 * The category of notification.
 */
union NotificationCategory {
  string,

  /**
   * Notification will be regarding wave progress.
   */
  WaveProgress: "WaveProgress",
}

/**
 * The level of notification.
 */
union NotificationLevel {
  string,

  /**
   * Receive only critical notifications.
   */
  Critical: "Critical",

  /**
   * Receive all notifications.
   */
  All: "All",
}

/**
 * The notification channel indicates the type of receivers subscribed to the notification, either user or subscription.
 */
union NotificationChannel {
  string,

  /**
   * For email user receivers. In this case, the parameter receivers should be a list of email addresses that will receive the notifications.
   */
  EmailUser: "EmailUser",

  /**
   * For subscription receivers. In this case, the parameter receivers should be a list of roles of the subscription for the cluster (eg. Owner, AccountAdmin, etc) that will receive the notifications.
   */
  EmailSubscription: "EmailSubscription",
}

/**
 * Describes the notification target properties.
 */
model NotificationTarget {
  /**
   * The notification channel indicates the type of receivers subscribed to the notification, either user or subscription.
   */
  notificationChannel: NotificationChannel;

  /**
   * List of targets that subscribe to the notification.
   */
  receivers: string[];
}

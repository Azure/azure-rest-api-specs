import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.ServiceFabric;
/**
 * The managed cluster resource
 *
 */
model ManagedCluster
  is Azure.ResourceManager.TrackedResource<ManagedClusterProperties> {
  ...ResourceNameParameter<
    Resource = ManagedCluster,
    KeyName = "clusterName",
    SegmentName = "managedClusters",
    NamePattern = ""
  >;

  /**
   * If eTag is provided in the response body, it may also be provided as a header per the normal etag convention.  Entity tags are used for comparing two or more entities from the same requested resource. HTTP/1.1 uses entity tags in the etag (section 14.19), If-Match (section 14.24), If-None-Match (section 14.26), and If-Range (section 14.27) header fields.",
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The sku of the managed cluster
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  sku: Sku;
}

@armResourceOperations
interface ManagedClusters {
  /**
   * Get a Service Fabric managed cluster resource created or in the process of being created in the specified resource group.
   */
  get is ArmResourceRead<ManagedCluster>;

  /**
   * Create or update a Service Fabric managed cluster resource with the specified name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Day 0 Property"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Day 0 Property"
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ManagedCluster,
    Response = ArmResourceUpdatedResponse<ManagedCluster> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = ManagedCluster>> & {
      @bodyRoot
      _: ManagedCluster;
    })
  >;

  /**
   * Update the tags of of a Service Fabric managed cluster resource with the specified name.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ManagedCluster,
    PatchModel = ManagedClusterUpdateParameters
  >;

  /**
   * Delete a Service Fabric managed cluster resource with the specified name.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedCluster,
    LroHeaders = ArmCombinedLroHeaders
  >;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the resource group.
   */
  listByResourceGroup is ArmResourceListByParent<ManagedCluster>;

  /**
   * Gets all Service Fabric cluster resources created or in the process of being created in the subscription.
   */
  listBySubscription is ArmListBySubscription<ManagedCluster>;

  /**
   * Gets a fault simulation by the simulationId.
   */
  @tag("FaultSimulation")
  getFaultSimulation is ArmResourceActionSync<
    ManagedCluster,
    FaultSimulationIdContent,
    ArmResponse<FaultSimulation>
  >;

  /**
   * Gets the list of recent fault simulations for the cluster.
   */
  @tag("FaultSimulation")
  listFaultSimulation is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<FaultSimulationListResult>
  >;

  /**
   * Starts a fault simulation on the cluster.
   */
  @tag("FaultSimulation")
  startFaultSimulation is ArmResourceActionAsync<
    ManagedCluster,
    FaultSimulationContentWrapper,
    never,
    LroHeaders = ArmLroLocationHeader<FinalResult = FaultSimulation> &
      ArmAsyncOperationHeader
  >;

  /**
   * Stops a fault simulation on the cluster.
   */
  @tag("FaultSimulation")
  stopFaultSimulation is ArmResourceActionAsync<
    ManagedCluster,
    FaultSimulationIdContent,
    never,
    LroHeaders = ArmLroLocationHeader<FinalResult = FaultSimulation> &
      ArmAsyncOperationHeader
  >;
}

@armResourceOperations
interface ManagedAzResiliencyStatus {
  /**
   * Action to get Az Resiliency Status of all the Base resources constituting Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @action("getazresiliencystatus")
  @operationId("managedAzResiliencyStatus_Get")
  get is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<ManagedAzResiliencyStatusContent>
  >;
}

@armResourceOperations
interface ManagedApplyMaintenanceWindow {
  /**
   * Action to Apply Maintenance window on the Service Fabric Managed Clusters, right now. Any pending update will be applied.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @action("applyMaintenanceWindow")
  @operationId("managedApplyMaintenanceWindow_Post")
  post is ArmResourceActionSync<ManagedCluster, void, OkResponse>;
}

@armResourceOperations
interface ManagedMaintenanceWindowStatus {
  /**
   * Action to get Maintenance Window Status of the Service Fabric Managed Clusters.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Backwards compatibility with non-standard operation id"
  @action("getMaintenanceWindowStatus")
  @operationId("managedMaintenanceWindowStatus_Get")
  get is ArmResourceActionSync<
    ManagedCluster,
    void,
    ArmResponse<ManagedMaintenanceWindowStatusContent>
  >;
}

@@doc(ManagedCluster.name, "The name of the cluster resource.");
@@doc(ManagedCluster.properties, "The managed cluster resource properties");
@@doc(ManagedClusters.createOrUpdate::parameters.resource,
  "The cluster resource."
);
@@doc(ManagedClusters.update::parameters.properties,
  "The managed cluster resource updated tags."
);
@@doc(ManagedClusters.getFaultSimulation::parameters.body,
  "parameter with fault simulation id."
);
@@doc(ManagedClusters.startFaultSimulation::parameters.body,
  "parameters describing the fault simulation."
);
@@doc(ManagedClusters.stopFaultSimulation::parameters.body,
  "parameter with fault simulation id."
);

/**
 * Describes the managed cluster resource properties.
 */
model ManagedClusterProperties {
  /**
   * The cluster dns name.
   */
  dnsName: string;

  /**
   * The fully qualified domain name associated with the public load balancer of the cluster.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * The IPv4 address associated with the public load balancer of the cluster.
   */
  @visibility(Lifecycle.Read)
  ipv4Address?: string;

  /**
   * A service generated unique identifier for the cluster resource.
   */
  @visibility(Lifecycle.Read)
  @deserializeEmptyStringAsNull
  clusterId?: string;

  /**
   * The current state of the cluster.
   */
  @visibility(Lifecycle.Read)
  clusterState?: ClusterState;

  /**
   * List of thumbprints of the cluster certificates.
   */
  @visibility(Lifecycle.Read)
  clusterCertificateThumbprints?: string[];

  /**
   * The port used for client connections to the cluster.
   */
  clientConnectionPort?: int32 = 19000;

  /**
   * The port used for HTTP connections to the cluster.
   */
  httpGatewayConnectionPort?: int32 = 19080;

  /**
   * VM admin user name.
   */
  adminUserName: string;

  /**
   * VM admin user password.
   */
  @secret
  adminPassword?: string;

  /**
   * Load balancing rules that are applied to the public load balancer of the cluster.
   */
  @identifiers(#[])
  loadBalancingRules?: LoadBalancingRule[];

  /**
   * Setting this to true enables RDP access to the VM. The default NSG rule opens RDP port to Internet which can be overridden with custom Network Security Rules. The default value for this setting is false.
   */
  allowRdpAccess?: boolean;

  /**
   * Custom Network Security Rules that are applied to the Virtual Network of the cluster.
   */
  @identifiers(#[])
  networkSecurityRules?: NetworkSecurityRule[];

  /**
   * Client certificates that are allowed to manage the cluster.
   */
  @identifiers(#[])
  clients?: ClientCertificate[];

  /**
   * The AAD authentication settings of the cluster.
   */
  azureActiveDirectory?: AzureActiveDirectory;

  /**
   * The list of custom fabric settings to configure the cluster.
   */
  @identifiers(#[])
  fabricSettings?: SettingsSectionDescription[];

  /**
   * The provisioning state of the managed cluster resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ManagedResourceProvisioningState;

  /**
   * The Service Fabric runtime version of the cluster. This property is required when **clusterUpgradeMode** is set to 'Manual'. To get list of available Service Fabric versions for new clusters use [ClusterVersion API](./ClusterVersion.md). To get the list of available version for existing clusters use **availableClusterVersions**.
   */
  clusterCodeVersion?: string;

  /**
   * The upgrade mode of the cluster when new Service Fabric runtime version is available.
   *
   */
  clusterUpgradeMode?: ClusterUpgradeMode = ClusterUpgradeMode.Automatic;

  /**
   * Indicates when new cluster runtime version upgrades will be applied after they are released. By default is Wave0. Only applies when **clusterUpgradeMode** is set to 'Automatic'.
   */
  clusterUpgradeCadence?: ClusterUpgradeCadence;

  /**
   * List of add-on features to enable on the cluster.
   */
  addonFeatures?: ManagedClusterAddOnFeature[];

  /**
   * Enables automatic OS upgrade for node types created using OS images with version 'latest'. The default value for this setting is false.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "OS is a well known abbreviation"
  enableAutoOSUpgrade?: boolean;

  /**
   * Indicates if the cluster has zone resiliency.
   */
  zonalResiliency?: boolean = false;

  /**
   * The policy used to clean up unused versions.
   */
  applicationTypeVersionsCleanupPolicy?: ApplicationTypeVersionsCleanupPolicy;

  /**
   * Setting this to true creates IPv6 address space for the default VNet used by the cluster. This setting cannot be changed once the cluster is created. The default value for this setting is false.
   */
  enableIpv6?: boolean;

  /**
   * If specified, the node types for the cluster are created in this subnet instead of the default VNet. The **networkSecurityRules** specified for the cluster are also applied to this subnet. This setting cannot be changed once the cluster is created.
   */
  subnetId?: string;

  /**
   * The list of IP tags associated with the default public IP address of the cluster.
   */
  @identifiers(#[])
  ipTags?: IpTag[];

  /**
   * IPv6 address for the cluster if IPv6 is enabled.
   */
  @visibility(Lifecycle.Read)
  ipv6Address?: string;

  /**
   * Setting this to true will link the IPv4 address as the ServicePublicIP of the IPv6 address. It can only be set to True if IPv6 is enabled on the cluster.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  enableServicePublicIP?: boolean;

  /**
   * Auxiliary subnets for the cluster.
   */
  @identifiers(#[])
  auxiliarySubnets?: Subnet[];

  /**
   * Service endpoints for subnets in the cluster.
   */
  @identifiers(#[])
  serviceEndpoints?: ServiceEndpoint[];

  /**
   * Indicates the update mode for Cross Az clusters.
   */
  zonalUpdateMode?: ZonalUpdateMode;

  /**
   * For new clusters, this parameter indicates that it uses Bring your own VNet, but the subnet is specified at node type level; and for such clusters, the subnetId property is required for node types.
   */
  useCustomVnet?: boolean;

  /**
   * Specify the resource id of a public IPv4 prefix that the load balancer will allocate a public IPv4 address from. This setting cannot be changed once the cluster is created.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  publicIPPrefixId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;

  /**
   * Specify the resource id of a public IPv6 prefix that the load balancer will allocate a public IPv6 address from. This setting cannot be changed once the cluster is created.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "IP is a well known abbreviation"
  publicIPv6PrefixId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/publicIPPrefixes";
    }
  ]>;

  /**
   * Specify the resource id of a DDoS network protection plan that will be associated with the virtual network of the cluster.
   */
  ddosProtectionPlanId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/ddosProtectionPlans";
    }
  ]>;

  /**
   * The policy to use when upgrading the cluster.
   */
  upgradeDescription?: ClusterUpgradePolicy;

  /**
   * The port used for token-auth based HTTPS connections to the cluster. Cannot be set to the same port as HttpGatewayEndpoint.
   */
  httpGatewayTokenAuthConnectionPort?: int32;

  /**
   * If true, token-based authentication is not allowed on the HttpGatewayEndpoint. This is required to support TLS versions 1.3 and above. If token-based authentication is used, HttpGatewayTokenAuthConnectionPort must be defined.
   */
  enableHttpGatewayExclusiveAuthMode?: boolean;

  /**
   * This property is the entry point to using a public CA cert for your cluster cert. It specifies the level of reuse allowed for the custom FQDN created, matching the subject of the public CA cert.
   */
  autoGeneratedDomainNameLabelScope?: AutoGeneratedDomainNameLabelScope;

  /**
   * The number of outbound ports allocated for SNAT for each node in the backend pool of the default load balancer. The default value is 0 which provides dynamic port allocation based on pool size.
   */
  allocatedOutboundPorts?: int32;

  /**
   * The VM image the node types are configured with. This property controls the Service Fabric component packages to be used for the cluster. Allowed values are: 'Windows'. The default value is 'Windows'.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "VM is a well known acronym, consistency with other properties"
  @added(Versions.v2025_03_01_preview)
  VMImage?: string = "Windows";
}

/**
 * The current state of the cluster.
 *
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
  Upgrading: "Upgrading",

  /**
   * Indicates that the last upgrade for the cluster has failed.
   */
  UpgradeFailed: "UpgradeFailed",

  /**
   * Indicates that the cluster is in a stable state.
   */
  Ready: "Ready",
}
/**
 * The upgrade mode of the cluster when new Service Fabric runtime version is available.
 *
 */
union ClusterUpgradeMode {
  string,

  /**
   * The cluster will be automatically upgraded to the latest Service Fabric runtime version, **clusterUpgradeCadence** will determine when the upgrade starts after the new version becomes available.
   */
  Automatic: "Automatic",

  /**
   * The cluster will not be automatically upgraded to the latest Service Fabric runtime version. The cluster is upgraded by setting the **clusterCodeVersion** property in the cluster resource.
   */
  Manual: "Manual",
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
 * Available cluster add-on features
 */
union ManagedClusterAddOnFeature {
  string,

  /**
   * Dns service
   */
  DnsService: "DnsService",

  /**
   * Backup and restore service
   */
  BackupRestoreService: "BackupRestoreService",

  /**
   * Resource monitor service
   */
  ResourceMonitorService: "ResourceMonitorService",
}

/**
 * Enable or Disable apply network policies on private end point in the subnet.
 */
union PrivateEndpointNetworkPolicies {
  string,

  /**
   * Enable apply network policies on private end point in the subnet.
   */
  enabled: "enabled",

  /**
   * Disable apply network policies on private end point in the subnet.
   */
  disabled: "disabled",
}

/**
 * Enable or Disable apply network policies on private link service in the subnet.
 */
union PrivateLinkServiceNetworkPolicies {
  string,

  /**
   * Enable apply network policies on private link service in the subnet.
   */
  enabled: "enabled",

  /**
   * Disable apply network policies on private link service in the subnet.
   */
  disabled: "disabled",
}

/**
 * Indicates the update mode for Cross Az clusters.
 */
union ZonalUpdateMode {
  string,

  /**
   * The cluster will use 5 upgrade domains for Cross Az Node types.
   */
  Standard: "Standard",

  /**
   * The cluster will use a maximum of 3 upgrade domains per zone instead of 5 for Cross Az Node types for faster deployments.
   */
  Fast: "Fast",
}

/**
 * This enum is the entrypoint to using a certificate from a public CA for your cluster. This property was introduced to solve the
 * domain squatting problem with new domains. A domain name will be generated in the following format: {clustername}.{hash}.{regionname}.sfmcdomain.
 * The hash portion comes from Azure DNS' Deterministic Name Library. The library creates a hash using the cluster's Tenant, Subscription, Resource Group
 * and Resource Name using the AutoGeneratedDomainNameLabelScope/reuse policy chosen.
 *
 */
union AutoGeneratedDomainNameLabelScope {
  string,

  /**
   * TenantReuse allows for the same hash to be created if the resource is created in the same Tenant with the same resource name.
   */
  TenantReuse: "TenantReuse",

  /**
   * SubscriptionReuse allows for the same hash to be created if the resource is created in the same Subscription with the same resource name.
   */
  SubscriptionReuse: "SubscriptionReuse",

  /**
   * ResourceGroupReuse allows for the same hash to be created if the resource is created in the same Resource Group with the same resource name.
   */
  ResourceGroupReuse: "ResourceGroupReuse",

  /**
   * NoReuse will create a new hash regardless of the Subscription, Resource Group, Tenant and Resource name.
   */
  NoReuse: "NoReuse",
}

/**
 * Sku Name.
 */
union SkuName {
  string,

  /**
   * Basic requires a minimum of 3 nodes and allows only 1 node type.
   */
  Basic: "Basic",

  /**
   * Requires a minimum of 5 nodes and allows 1 or more node type.
   */
  Standard: "Standard",
}

/**
 * Describes a Subnet.
 */
model Subnet {
  /**
   * Subnet name.
   */
  @deserializeEmptyStringAsNull
  name: string;

  /**
   * Indicates wether to enable Ipv6 or not. If not provided, it will take the same configuration as the cluster.
   */
  enableIpv6?: boolean;

  /**
   * Enable or Disable apply network policies on private end point in the subnet.
   */
  privateEndpointNetworkPolicies?: PrivateEndpointNetworkPolicies;

  /**
   * Enable or Disable apply network policies on private link service in the subnet.
   */
  privateLinkServiceNetworkPolicies?: PrivateLinkServiceNetworkPolicies;

  /**
   * Full resource id for the network security group.
   */
  @deserializeEmptyStringAsNull
  networkSecurityGroupId?: string;
}

/**
 * The service endpoint properties.
 */
model ServiceEndpoint {
  /**
   * The type of the endpoint service.
   */
  service: string;

  /**
   * A list of locations.
   */
  locations?: string[];
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
   * The cluster health policy defines a health policy used to evaluate the health of the cluster during a cluster upgrade.
   */
  healthPolicy?: ClusterHealthPolicy;

  /**
   * The cluster delta health policy defines a health policy used to evaluate the health of the cluster during a cluster upgrade.
   */
  deltaHealthPolicy?: ClusterUpgradeDeltaHealthPolicy;

  /**
   * The cluster monitoring policy describes the parameters for monitoring an upgrade in Monitored mode.
   */
  monitoringPolicy?: ClusterMonitoringPolicy;

  /**
   * The maximum amount of time to block processing of an upgrade domain and prevent loss of availability when there are unexpected issues.
   * When this timeout expires, processing of the upgrade domain will proceed regardless of availability loss issues.
   * The timeout is reset at the start of each upgrade domain. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   * This value must be between 00:00:00 and 49710.06:28:15 (unsigned 32 bit integer for seconds)
   *
   */
  upgradeReplicaSetCheckTimeout?: string;
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
  maxPercentUnhealthyNodes: int32 = 0;

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
  maxPercentUnhealthyApplications: int32 = 0;
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
  maxPercentDeltaUnhealthyNodes: int32;

  /**
   * The maximum allowed percentage of upgrade domain nodes health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the upgrade domain nodes at the beginning of upgrade and the state of the upgrade domain nodes at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion for all completed upgrade domains to make sure the state of the upgrade domains is within tolerated limits.
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentUpgradeDomainDeltaUnhealthyNodes?: int32;

  /**
   * The maximum allowed percentage of applications health degradation allowed during cluster upgrades.
   * The delta is measured between the state of the applications at the beginning of upgrade and the state of the applications at the time of the health evaluation.
   * The check is performed after every upgrade domain upgrade completion to make sure the global state of the cluster is within tolerated limits. System services are not included in this.
   * NOTE: This value will overwrite the value specified in properties.UpgradeDescription.HealthPolicy.MaxPercentUnhealthyApplications
   *
   */
  @minValue(0)
  @maxValue(100)
  maxPercentDeltaUnhealthyApplications?: int32;
}

/**
 * Describes the monitoring policies for the cluster upgrade.
 */
model ClusterMonitoringPolicy {
  /**
   * The length of time to wait after completing an upgrade domain before performing health checks. The duration can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Backwards compatibility with non-standard duration encoding in c#"
  @encode("duration-constant")
  healthCheckWaitDuration: duration;

  /**
   * The amount of time that the application or cluster must remain healthy before the upgrade proceeds to the next upgrade domain. The duration can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Backwards compatibility with non-standard duration encoding in c#"
  @encode("duration-constant")
  healthCheckStableDuration: duration;

  /**
   * The amount of time to retry health evaluation when the application or cluster is unhealthy before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Backwards compatibility with non-standard duration encoding in c#"
  @encode("duration-constant")
  healthCheckRetryTimeout: duration;

  /**
   * The amount of time the overall upgrade has to complete before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Backwards compatibility with non-standard duration encoding in c#"
  @encode("duration-constant")
  upgradeTimeout: duration;

  /**
   * The amount of time each upgrade domain has to complete before the upgrade rolls back. The timeout can be in either hh:mm:ss or in d.hh:mm:ss.ms format.
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Backwards compatibility with non-standard duration encoding in c#"
  @encode("duration-constant")
  upgradeDomainTimeout: duration;
}

/**
 * Service Fabric managed cluster Sku definition
 */
model Sku {
  /**
   * Sku Name.
   */
  name: SkuName;
}

/**
 * Managed cluster update request
 */
#suppress "@azure-tools/typespec-azure-resource-manager/patch-envelope" "Not adding skus property as this API is for updating tags only"
model ManagedClusterUpdateParameters {
  /**
   * Managed cluster update parameters
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Day 0 property, used to pass string to string dictionary"
  tags?: Record<string>;
}

/**
 * Describes a load balancing rule.
 */
model LoadBalancingRule {
  /**
   * The port for the external endpoint. Port numbers for each rule must be unique within the Load Balancer. Acceptable values are between 1 and 65534.
   */
  @maxValue(65534)
  @minValue(1)
  frontendPort: int32;

  /**
   * The port used for internal connections on the endpoint. Acceptable values are between 1 and 65535.
   */
  @maxValue(65534)
  @minValue(1)
  backendPort: int32;

  /**
   * The reference to the transport protocol used by the load balancing rule.
   */
  protocol: Protocol;

  /**
   * The prob port used by the load balancing rule. Acceptable values are between 1 and 65535.
   */
  @maxValue(65534)
  @minValue(1)
  probePort?: int32;

  /**
   * the reference to the load balancer probe used by the load balancing rule.
   */
  probeProtocol: ProbeProtocol;

  /**
   * The probe request path. Only supported for HTTP/HTTPS probes.
   */
  probeRequestPath?: string;

  /**
   * The load distribution policy for this rule.
   */
  loadDistribution?: string;
}

/**
 * Describes a network security rule.
 */
model NetworkSecurityRule {
  /**
   * Network security rule name.
   */
  name: string;

  /**
   * Network security rule description.
   */
  description?: string;

  /**
   * Network protocol this rule applies to.
   */
  protocol: NsgProtocol;

  /**
   * The CIDR or source IP ranges.
   */
  sourceAddressPrefixes?: string[];

  /**
   * The destination address prefixes. CIDR or destination IP ranges.
   */
  destinationAddressPrefixes?: string[];

  /**
   * The source port ranges.
   */
  sourcePortRanges?: string[];

  /**
   * The destination port ranges.
   */
  destinationPortRanges?: string[];

  /**
   * The CIDR or source IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used. If this is an ingress rule, specifies where network traffic originates from.
   */
  sourceAddressPrefix?: string;

  /**
   * The destination address prefix. CIDR or destination IP range. Asterisk '*' can also be used to match all source IPs. Default tags such as 'VirtualNetwork', 'AzureLoadBalancer' and 'Internet' can also be used.
   */
  destinationAddressPrefix?: string;

  /**
   * The source port or range. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports.
   */
  sourcePortRange?: string;

  /**
   * he destination port or range. Integer or range between 0 and 65535. Asterisk '*' can also be used to match all ports.
   */
  destinationPortRange?: string;

  /**
   * The network traffic is allowed or denied.
   */
  access: Access;

  /**
   * The priority of the rule. The value can be in the range 1000 to 3000. Values outside this range are reserved for Service Fabric ManagerCluster Resource Provider. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
   */
  @maxValue(3000)
  @minValue(1000)
  priority: int32;

  /**
   * Network security rule direction.
   */
  direction: Direction;
}

/**
 * Describes the maintenance window status of the Service Fabric Managed Cluster.
 */
model ManagedMaintenanceWindowStatusContent {
  /**
   * If maintenance window is enabled on this cluster.
   */
  @visibility(Lifecycle.Read)
  isWindowEnabled?: boolean;

  /**
   * Indicates if the region is ready to configure maintenance windows.
   */
  @visibility(Lifecycle.Read)
  isRegionReady?: boolean;

  /**
   * If maintenance window is active.
   */
  @visibility(Lifecycle.Read)
  isWindowActive?: boolean;

  /**
   * If updates can be applied.
   */
  @visibility(Lifecycle.Read)
  canApplyUpdates?: boolean;

  /**
   * Last window update time in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UTC is a well known abbreviation"
  @visibility(Lifecycle.Read)
  lastWindowStatusUpdateAtUTC?: utcDateTime;

  /**
   * Last window start time in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UTC is a well known abbreviation"
  @visibility(Lifecycle.Read)
  lastWindowStartTimeUTC?: utcDateTime;

  /**
   * Last window end time in UTC.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "UTC is a well known abbreviation"
  @visibility(Lifecycle.Read)
  lastWindowEndTimeUTC?: utcDateTime;
}

/**
 * Describes the result of the request to list Managed VM Sizes for Service Fabric Managed Clusters.
 */
model ManagedAzResiliencyStatusContent {
  /**
   * List of Managed VM Sizes for Service Fabric Managed Clusters.
   */
  @identifiers(#[])
  baseResourceStatus?: ResourceAzStatus[];

  /**
   * URL to get the next set of Managed VM Sizes if there are any.
   */
  @visibility(Lifecycle.Read)
  isClusterZoneResilient?: boolean;
}

/**
 * Describes Az Resiliency status of Base resources
 */
model ResourceAzStatus {
  /**
   * VM Size properties.
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;

  /**
   * VM Size id.
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * VM Size name.
   */
  @visibility(Lifecycle.Read)
  isZoneResilient?: boolean;

  /**
   * Zone resiliency status details for the resource.
   */
  @visibility(Lifecycle.Read)
  details?: string;
}

/**
 * The reference to the transport protocol used by the load balancing rule.
 */
union Protocol {
  string,

  /**
   * Transport protocol is TCP.
   */
  tcp: "tcp",

  /**
   * Transport protocol is UDP.
   */
  udp: "udp",
}

/**
 * The reference to the load balancer probe used by the load balancing rule.
 */
union ProbeProtocol {
  string,

  /**
   * Probe protocol is TCP.
   */
  tcp: "tcp",

  /**
   * Probe protocol is HTTP.
   */
  http: "http",

  /**
   * Probe protocol is HTTPS.
   */
  https: "https",
}

/**
 * Network protocol this rule applies to.
 */
union NsgProtocol {
  string,

  /**
   * Protocol applies to HTTP.
   */
  http: "http",

  /**
   * Protocol applies to HTTPS.
   */
  https: "https",

  /**
   * Protocol applies to TCP.
   */
  tcp: "tcp",

  /**
   * Protocol applies to UDP.
   */
  udp: "udp",

  /**
   * Protocol applies to ICMP.
   */
  icmp: "icmp",

  /**
   * Protocol applies to AH.
   */
  ah: "ah",

  /**
   * Protocol applies to ESP.
   */
  esp: "esp",
}

/**
 * The network traffic is allowed or denied.
 */
union Access {
  string,

  /**
   * The network traffic is allowed.
   */
  allow: "allow",

  /**
   * The network traffic is denied.
   */
  deny: "deny",
}

/**
 * Network security rule direction.
 */
union Direction {
  string,

  /**
   * Inbound direction.
   */
  inbound: "inbound",

  /**
   * Outbound direction.
   */
  outbound: "outbound",
}

/**
 * Client certificate definition.
 */
model ClientCertificate {
  /**
   * Indicates if the client certificate has admin access to the cluster. Non admin clients can perform only read only operations on the cluster.
   */
  isAdmin: boolean;

  /**
   * Certificate thumbprint.
   */
  thumbprint?: string;

  /**
   * Certificate common name.
   */
  commonName?: string;

  /**
   * Issuer thumbprint for the certificate. Only used together with CommonName.
   */
  issuerThumbprint?: string;
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
  @identifiers(#["name"])
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
 * The policy used to clean up unused versions. When the policy is not specified explicitly, the default unused application versions to keep will be 3.
 */
model ApplicationTypeVersionsCleanupPolicy {
  /**
   * Number of unused versions per application type to keep.
   */
  @minValue(0)
  maxUnusedVersionsToKeep: int32;
}

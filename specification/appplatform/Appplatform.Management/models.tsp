import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AppPlatform;

/**
 * Provisioning state of the Service
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Starting: "Starting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopping: "Stopping",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moved: "Moved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  MoveFailed: "MoveFailed",
}

/**
 * The direction of required traffic
 */
union TrafficDirection {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Inbound: "Inbound",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Outbound: "Outbound",
}

/**
 * Indicates whether the vnet injection service enables private links for backend storage account and container registry.
 */
union PrivateStorageAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * The frequency to run the maintenance job
 */
union Frequency {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Weekly: "Weekly",
}

/**
 * Power state of the Service
 */
union PowerState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopped: "Stopped",
}

/**
 * Type of managed service identity (either system assigned, or none).
 */
union SystemAssignedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
}

/**
 * The type of identity that last modified the resource.
 */
union LastModifiedByType {
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
 * Type of the test key
 */
union TestKeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Primary: "Primary",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Secondary: "Secondary",
}

/**
 * State of the APM.
 */
union ApmProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * State of the eureka server.
 */
union EurekaServerState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Enabled state of the eureka server. This is only used in Consumption tier.
 */
union EurekaServerEnabledState {
  string,

  /**
   * Enable the eureka server.
   */
  Enabled: "Enabled",

  /**
   * Disable the eureka server.
   */
  Disabled: "Disabled",
}

/**
 * State of the config server.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ConfigServerState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotAvailable: "NotAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleted: "Deleted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * Enabled state of the config server. This is only used in Consumption tier.
 */
union ConfigServerEnabledState {
  string,

  /**
   * Enable the config server.
   */
  Enabled: "Enabled",

  /**
   * Disable the config server.
   */
  Disabled: "Disabled",
}

/**
 * State of the Application Configuration Service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ConfigurationServiceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * The generation of the Application Configuration Service.
 */
union ConfigurationServiceGeneration {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Gen1: "Gen1",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Gen2: "Gen2",
}

/**
 * Git libraries used to support various repository providers
 */
union GitImplementation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `go-git`: "go-git",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  libgit2: "libgit2",
}

/**
 * State of the Service Registry.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ServiceRegistryProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * State of the Application Live View.
 */
union ApplicationLiveViewProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * State of the Dev Tool Portal.
 */
union DevToolPortalProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * State of the plugin
 */
union DevToolPortalFeatureState {
  string,

  /**
   * Enable the plugin in Dev Tool Portal.
   */
  Enabled: "Enabled",

  /**
   * Disable the plugin in Dev Tool Portal.
   */
  Disabled: "Disabled",
}

/**
 * State of the Container Registry.
 */
union ContainerRegistryProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Provisioning state of the KPack build service
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union BuildServiceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * Provisioning state of the KPack build result
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union BuildProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * The provisioning state of this build result
 */
union TriggeredBuildResultProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Queuing: "Queuing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Building: "Building",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Buildpack Binding Type
 */
union BindingType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ApplicationInsights: "ApplicationInsights",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ApacheSkyWalking: "ApacheSkyWalking",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AppDynamics: "AppDynamics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Dynatrace: "Dynatrace",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NewRelic: "NewRelic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ElasticAPM: "ElasticAPM",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  CACertificates: "CACertificates",
}

/**
 * State of the Buildpack Binding.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union BuildpackBindingProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * Provisioning state of the KPack build result
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union BuildResultProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Queuing: "Queuing",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Building: "Building",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * The provisioning state of this build stage resource.
 */
union KPackBuildStageProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotStarted: "NotStarted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Builder provision status.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union BuilderProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * State of the Monitoring Setting.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union MonitoringSettingState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotAvailable: "NotAvailable",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
}

/**
 * Provisioning state of the App
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union AppResourceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * The type of the underlying resource to mount as a persistent disk.
 */
union Type {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AzureFileVolume: "AzureFileVolume",
}

/**
 * Type of the affinity, set this to Cookie to enable session affinity.
 */
union SessionAffinity {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Cookie: "Cookie",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * How ingress should communicate with this app backend service.
 */
union BackendProtocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  GRPC: "GRPC",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Default: "Default",
}

/**
 * State of test endpoint auth.
 */
union TestEndpointAuthState {
  string,

  /**
   * Enable test endpoint auth.
   */
  Enabled: "Enabled",

  /**
   * Disable test endpoint auth
   */
  Disabled: "Disabled",
}

/**
 * The type of the storage.
 */
union StorageType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  StorageAccount: "StorageAccount",
}

/**
 * Provisioning state of the Certificate
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union CertificateResourceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * Provisioning state of the Domain
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union CustomDomainResourceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * The type of the action to take to perform the health check.
 */
union ProbeActionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HTTPGetAction: "HTTPGetAction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TCPSocketAction: "TCPSocketAction",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ExecAction: "ExecAction",
}

/**
 * Provisioning state of the Deployment
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union DeploymentResourceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Status of the Deployment
 */
union DeploymentResourceStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Stopped: "Stopped",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
}

/**
 * The raw value which could be passed to deployment CRUD operations.
 */
union SupportedRuntimeValue {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Java_8: "Java_8",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Java_11: "Java_11",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Java_17: "Java_17",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Java_21: "Java_21",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NetCore_31: "NetCore_31",
}

/**
 * The platform of this runtime version (possible values: "Java" or ".NET").
 */
union SupportedRuntimePlatform {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Java: "Java",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `.NET Core`: ".NET Core",
}

/**
 * Gets or sets the type of the scale.
 */
union SkuScaleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Manual: "Manual",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Automatic: "Automatic",
}

/**
 * Gets the type of restrictions. Possible values include: 'Location', 'Zone'
 */
union ResourceSkuRestrictionsType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Location: "Location",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Zone: "Zone",
}

/**
 * Gets the reason for restriction. Possible values include: 'QuotaId', 'NotAvailableForSubscription'
 */
union ResourceSkuRestrictionsReasonCode {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  QuotaId: "QuotaId",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NotAvailableForSubscription: "NotAvailableForSubscription",
}

/**
 * State of the Spring Cloud Gateway.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union GatewayProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * Whether to enable certificate verification or not
 */
union GatewayCertificateVerification {
  string,

  /**
   * Enable certificate verification in Spring Cloud Gateway.
   */
  Enabled: "Enabled",

  /**
   * Disable certificate verification in Spring Cloud Gateway.
   */
  Disabled: "Disabled",
}

/**
 * Type of application performance monitoring
 */
union ApmType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ApplicationInsights: "ApplicationInsights",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  AppDynamics: "AppDynamics",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Dynatrace: "Dynatrace",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NewRelic: "NewRelic",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  ElasticAPM: "ElasticAPM",
}

/**
 * Protocol of routed Azure Spring Apps applications.
 */
union GatewayRouteConfigProtocol {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HTTP: "HTTP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HTTPS: "HTTPS",
}

/**
 * State of the API portal.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union ApiPortalProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
}

/**
 * Indicates whether the API try-out feature is enabled or disabled. When enabled, users can try out the API by sending requests and viewing responses in API portal. When disabled, users cannot try out the API.
 */
union ApiPortalApiTryOutEnabledState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * State of the application accelerator.
 */
union ApplicationAcceleratorProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * State of the customized accelerator.
 */
union CustomizedAcceleratorProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Type of the customized accelerator.
 */
union CustomizedAcceleratorType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accelerator: "Accelerator",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Fragment: "Fragment",
}

/**
 * State of the customized accelerator validation result
 */
union CustomizedAcceleratorValidateResultState {
  string,

  /**
   * Customized accelerator properties are valid.
   */
  Valid: "Valid",

  /**
   * Customized accelerator properties are invalid.
   */
  Invalid: "Invalid",
}

/**
 * Provisioning state of the predefined accelerator.
 */
union PredefinedAcceleratorProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * State of the predefined accelerator.
 */
union PredefinedAcceleratorState {
  string,

  /**
   * Enable the predefined accelerator.
   */
  Enabled: "Enabled",

  /**
   * Disable the predefined accelerator.
   */
  Disabled: "Disabled",
}

/**
 * Provisioning state of the Job
 */
union JobResourceProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
}

/**
 * Type of job trigger
 */
union TriggerType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Manual: "Manual",
}

/**
 * Current state of the job execution
 */
union JobExecutionRunningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Completed: "Completed",
}

/**
 * The day to run the maintenance job
 */
union WeekDay {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Monday: "Monday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Tuesday: "Tuesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Wednesday: "Wednesday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Thursday: "Thursday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Friday: "Friday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Saturday: "Saturday",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Sunday: "Sunday",
}

/**
 * Indicates whether to automatically synchronize certificate from key vault or not.
 */
union KeyVaultCertificateAutoSync {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
}

/**
 * Scheme to use for connecting to the host. Defaults to HTTP.
 *
 * Possible enum values:
 *  - `"HTTP"` means that the scheme used will be http://
 *  - `"HTTPS"` means that the scheme used will be https://
 */
union HttpSchemeType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HTTP: "HTTP",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  HTTPS: "HTTPS",
}

/**
 * Service properties payload
 */
model ClusterResourceProperties {
  /**
   * Provisioning state of the Service
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Network profile of the Service
   */
  networkProfile?: NetworkProfile;

  /**
   * Additional Service settings in vnet injection instance
   */
  vnetAddons?: ServiceVNetAddons;

  /**
   * Additional Service settings for planned maintenance
   */
  maintenanceScheduleConfiguration?: MaintenanceScheduleConfiguration;

  /**
   * Version of the Service
   */
  @visibility(Lifecycle.Read)
  version?: int32;

  /**
   * ServiceInstanceEntity Id which uniquely identifies a created resource
   */
  @visibility(Lifecycle.Read)
  serviceId?: string;

  /**
   * The resource Id of the Managed Environment that the Spring Apps instance builds on
   */
  managedEnvironmentId?: string;

  /**
   * The name of the resource group that contains the infrastructure resources
   */
  infraResourceGroup?: string;

  /**
   * Power state of the Service
   */
  @visibility(Lifecycle.Read)
  powerState?: PowerState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  zoneRedundant?: boolean;

  /**
   * Fully qualified dns name of the service instance
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * Purchasing 3rd party product of the Service resource.
   */
  marketplaceResource?: MarketplaceResource;
}

/**
 * Service network profile payload
 */
model NetworkProfile {
  /**
   * Fully qualified resource Id of the subnet to host Azure Spring Apps Service Runtime
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceRuntimeSubnetId?: string;

  /**
   * Fully qualified resource Id of the subnet to host customer apps in Azure Spring Apps
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  appSubnetId?: string;

  /**
   * Azure Spring Apps service reserved CIDR
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceCidr?: string;

  /**
   * Name of the resource group containing network resources of Azure Spring Apps Service Runtime
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  serviceRuntimeNetworkResourceGroup?: string;

  /**
   * Name of the resource group containing network resources for customer apps in Azure Spring Apps
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  appNetworkResourceGroup?: string;

  /**
   * Desired outbound IP resources for Azure Spring Apps resource.
   */
  @visibility(Lifecycle.Read)
  outboundIPs?: NetworkProfileOutboundIPs;

  /**
   * Required inbound or outbound traffics for Azure Spring Apps resource.
   */
  @visibility(Lifecycle.Read)
  requiredTraffics?: RequiredTraffic[];

  /**
   * Ingress configuration payload for Azure Spring Apps resource.
   */
  ingressConfig?: IngressConfig;

  /**
   * The egress traffic type of Azure Spring Apps VNet instances.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  outboundType?: string;
}

/**
 * Desired outbound IP resources for Azure Spring Apps resource.
 */
model NetworkProfileOutboundIPs {
  /**
   * A list of public IP addresses.
   */
  @visibility(Lifecycle.Read)
  publicIPs?: string[];
}

/**
 * Required inbound or outbound traffic for Azure Spring Apps resource.
 */
model RequiredTraffic {
  /**
   * The protocol of required traffic
   */
  @visibility(Lifecycle.Read)
  protocol?: string;

  /**
   * The port of required traffic
   */
  @visibility(Lifecycle.Read)
  port?: int32;

  /**
   * The ip list of required traffic
   */
  @visibility(Lifecycle.Read)
  ips?: string[];

  /**
   * The FQDN list of required traffic
   */
  @visibility(Lifecycle.Read)
  fqdns?: string[];

  /**
   * The direction of required traffic
   */
  @visibility(Lifecycle.Read)
  direction?: TrafficDirection;
}

/**
 * Ingress configuration payload for Azure Spring Apps resource.
 */
model IngressConfig {
  /**
   * Ingress read time out in seconds.
   */
  readTimeoutInSeconds?: int32;
}

/**
 * Additional Service settings in vnet injection instance
 */
model ServiceVNetAddons {
  /**
   * Indicates whether the log stream in vnet injection instance could be accessed from internet.
   */
  logStreamPublicEndpoint?: boolean;

  /**
   * Indicates whether the data plane components(log stream, app connect, remote debugging) in vnet injection instance could be accessed from internet.
   */
  dataPlanePublicEndpoint?: boolean;

  /**
   * Indicates whether the vnet injection service enables private links for backend storage account and container registry.
   */
  privateStorageAccess?: PrivateStorageAccess;

  /**
   * Fully qualified resource Id of the Private DNS zone to link with the customer virtual network.
   */
  privateDnsZoneId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Network/privateDnsZones";
    }
  ]>;
}

/**
 * Configuration for the planned maintenance
 */
@discriminator("frequency")
model MaintenanceScheduleConfiguration {
  /**
   * The frequency to run the maintenance job
   */
  frequency: Frequency;
}

/**
 * Purchasing 3rd Party product for one Azure Spring Apps instance
 */
model MarketplaceResource {
  /**
   * The plan id of the 3rd Party Artifact that is being procured.
   */
  plan?: string;

  /**
   * The publisher id of the 3rd Party Artifact that is being bought.
   */
  publisher?: string;

  /**
   * The 3rd Party artifact that is being procured.
   */
  product?: string;
}

/**
 * Managed service identity (either system assigned, or none)
 */
model SystemAssignedServiceIdentity {
  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-format"
  @visibility(Lifecycle.Read)
  @format("uuid")
  tenantId?: string;

  /**
   * Type of managed service identity (either system assigned, or none).
   */
  type: SystemAssignedServiceIdentityType;
}

/**
 * Sku of Azure Spring Apps
 */
model Sku {
  /**
   * Name of the Sku
   */
  name?: string = "S0";

  /**
   * Tier of the Sku
   */
  tier?: string = "Standard";

  /**
   * Current capacity of the target resource
   */
  capacity?: int32;
}

/**
 * The core properties of ARM resources.
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * An error response from the service.
 */
@error
model CloudError {
  /**
   * An error response from the service.
   */
  error?: CloudErrorBody;
}

/**
 * An error response from the service.
 */
model CloudErrorBody {
  /**
   * An identifier for the error. Codes are invariant and are intended to be consumed programmatically.
   */
  code?: string;

  /**
   * A message describing the error, intended to be suitable for display in a user interface.
   */
  message?: string;

  /**
   * The target of the particular error. For example, the name of the property in error.
   */
  target?: string;

  /**
   * A list of additional details about the error.
   */
  details?: CloudErrorBody[];
}

/**
 * Test keys payload
 */
model TestKeys {
  /**
   * Primary key
   */
  primaryKey?: string;

  /**
   * Secondary key
   */
  secondaryKey?: string;

  /**
   * Primary test endpoint
   */
  primaryTestEndpoint?: string;

  /**
   * Secondary test endpoint
   */
  secondaryTestEndpoint?: string;

  /**
   * Indicates whether the test endpoint feature enabled or not
   */
  enabled?: boolean;
}

/**
 * Regenerate test key request payload
 */
model RegenerateTestKeyRequestPayload {
  /**
   * Type of the test key
   */
  keyType: TestKeyType;
}

/**
 * Supported APM types payload
 */
model SupportedApmTypes is Azure.Core.Page<SupportedApmType>;

/**
 * Supported APM type
 */
model SupportedApmType {
  /**
   * The name of the supported APM type
   */
  name?: string;
}

/**
 * Globally enabled APMs payload
 */
model GloballyEnabledApms {
  /**
   * Collection of the globally enabled APMs
   */
  value?: string[];
}

/**
 * A reference to the APM
 */
model ApmReference {
  /**
   * Resource Id of the APM
   */
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AppPlatform/Spring/apms";
    }
  ]>;
}

/**
 * Object that includes an array of APM resources and a possible link for next set
 */
model ApmResourceCollection is Azure.Core.Page<ApmResource>;

/**
 * Properties of an APM
 */
model ApmProperties {
  /**
   * APM Type
   */
  type: string;

  /**
   * State of the APM.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ApmProvisioningState;

  /**
   * Non-sensitive properties for the APM
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * Sensitive properties for the APM
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Create, Lifecycle.Update)
  secrets?: Record<string>;
}

/**
 * Keys of APM sensitive properties
 */
model ApmSecretKeys {
  /**
   * Collection of the keys for the APM sensitive properties
   */
  value?: string[];
}

/**
 * Object that includes an array of Eureka server resources and a possible link for next set
 */
model EurekaServerResourceCollection {
  /**
   * Collection of Eureka server resources
   */
  value?: EurekaServerResource[];

  /**
   * URL client should use to fetch the next page (per server side paging).
   * It's null for now, added for future use.
   */
  nextLink?: string;
}

/**
 * Eureka server properties payload
 */
model EurekaServerProperties {
  /**
   * State of the eureka server.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EurekaServerState;

  /**
   * Enabled state of the eureka server. This is only used in Consumption tier.
   */
  enabledState?: EurekaServerEnabledState;

  /**
   * Error when applying eureka server settings.
   */
  error?: Error;
}

/**
 * The error code compose of code and message.
 */
model Error {
  /**
   * The code of error.
   */
  code?: string;

  /**
   * The message of error.
   */
  message?: string;
}

/**
 * Config server git properties payload
 */
model ConfigServerProperties {
  /**
   * State of the config server.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ConfigServerState;

  /**
   * The requested resource quantity for required CPU and Memory, only available in Enterprise Plan.
   */
  @visibility(Lifecycle.Read)
  resourceRequests?: ConfigServerResourceRequests;

  /**
   * Collection of instances belong to Config Server, only available in Enterprise Plan.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  instances?: ConfigServerInstance[];

  /**
   * Error when apply config server settings.
   */
  error?: Error;

  /**
   * Enabled state of the config server. This is only used in Consumption tier.
   */
  enabledState?: ConfigServerEnabledState;

  /**
   * Settings of config server.
   */
  configServer?: ConfigServerSettings;
}

/**
 * Resource request payload of Config Server, only available in Enterprise Plan.
 */
model ConfigServerResourceRequests {
  /**
   * CPU allocated to each Config Server instance
   */
  @visibility(Lifecycle.Read)
  cpu?: string;

  /**
   * Memory allocated to each Config Server instance
   */
  @visibility(Lifecycle.Read)
  memory?: string;

  /**
   * Instance count of the Config Server
   */
  @visibility(Lifecycle.Read)
  instanceCount?: int32;
}

/**
 * Collection of instances belong to the Config Server, only available in Enterprise Plan.
 */
model ConfigServerInstance {
  /**
   * Name of the Config Server instance
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the Config Server instance
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * The settings of config server.
 */
model ConfigServerSettings {
  /**
   * Property of git environment.
   */
  gitProperty?: ConfigServerGitProperty;
}

/**
 * Property of git.
 */
model ConfigServerGitProperty {
  /**
   * Repositories of git.
   */
  repositories?: GitPatternRepository[];

  /**
   * URI of the repository
   */
  uri: string;

  /**
   * Label of the repository
   */
  label?: string;

  /**
   * Searching path of the repository
   */
  searchPaths?: string[];

  /**
   * Username of git repository basic auth.
   */
  username?: string;

  /**
   * Password of git repository basic auth.
   */
  password?: string;

  /**
   * Public sshKey of git repository.
   */
  hostKey?: string;

  /**
   * SshKey algorithm of git repository.
   */
  hostKeyAlgorithm?: string;

  /**
   * Private sshKey algorithm of git repository.
   */
  privateKey?: string;

  /**
   * Strict host key checking or not.
   */
  strictHostKeyChecking?: boolean;
}

/**
 * Git repository property payload for config server
 */
model GitPatternRepository {
  /**
   * Name of the repository
   */
  name: string;

  /**
   * Collection of pattern of the repository
   */
  pattern?: string[];

  /**
   * URI of the repository
   */
  uri: string;

  /**
   * Label of the repository
   */
  label?: string;

  /**
   * Searching path of the repository
   */
  searchPaths?: string[];

  /**
   * Username of git repository basic auth.
   */
  username?: string;

  /**
   * Password of git repository basic auth.
   */
  password?: string;

  /**
   * Public sshKey of git repository.
   */
  hostKey?: string;

  /**
   * SshKey algorithm of git repository.
   */
  hostKeyAlgorithm?: string;

  /**
   * Private sshKey algorithm of git repository.
   */
  privateKey?: string;

  /**
   * Strict host key checking or not.
   */
  strictHostKeyChecking?: boolean;
}

/**
 * Object that includes an array of config server resources and a possible link for next set
 */
model ConfigServerResourceCollection is Azure.Core.Page<ConfigServerResource>;

/**
 * Validation result for config server settings
 */
model ConfigServerSettingsValidateResult {
  /**
   * Indicate if the config server settings are valid
   */
  isValid?: boolean;

  /**
   * The detail validation results
   */
  details?: ConfigServerSettingsErrorRecord[];
}

/**
 * Error record of the config server settings
 */
model ConfigServerSettingsErrorRecord {
  /**
   * The name of the config server settings error record
   */
  name?: string;

  /**
   * The uri of the config server settings error record
   */
  uri?: string;

  /**
   * The detail error messages of the record
   */
  messages?: string[];
}

/**
 * Application Configuration Service properties payload
 */
model ConfigurationServiceProperties {
  /**
   * State of the Application Configuration Service.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ConfigurationServiceProvisioningState;

  /**
   * The generation of the Application Configuration Service.
   */
  generation?: ConfigurationServiceGeneration = ConfigurationServiceGeneration.Gen1;

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  @visibility(Lifecycle.Read)
  resourceRequests?: ConfigurationServiceResourceRequests;

  /**
   * Collection of instances belong to Application Configuration Service.
   */
  @visibility(Lifecycle.Read)
  instances?: ConfigurationServiceInstance[];

  /**
   * The settings of Application Configuration Service.
   */
  settings?: ConfigurationServiceSettings;
}

/**
 * Resource request payload of Application Configuration Service
 */
model ConfigurationServiceResourceRequests {
  /**
   * CPU allocated to each Application Configuration Service instance
   */
  @visibility(Lifecycle.Read)
  cpu?: string;

  /**
   * Memory allocated to each Application Configuration Service instance
   */
  @visibility(Lifecycle.Read)
  memory?: string;

  /**
   * Instance count of the Application Configuration Service
   */
  @visibility(Lifecycle.Read)
  instanceCount?: int32;
}

/**
 * Collection of instances belong to the Application Configuration Service
 */
model ConfigurationServiceInstance {
  /**
   * Name of the Application Configuration Service instance
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the Application Configuration Service instance
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * The settings of Application Configuration Service.
 */
model ConfigurationServiceSettings {
  /**
   * Property of git environment.
   */
  gitProperty?: ConfigurationServiceGitProperty;

  /**
   * How often (in seconds) to check repository updates. Minimum value is 0.
   */
  refreshIntervalInSeconds?: int32;
}

/**
 * Property of git environment.
 */
model ConfigurationServiceGitProperty {
  /**
   * Repositories of Application Configuration Service git property.
   */
  repositories?: ConfigurationServiceGitRepository[];
}

/**
 * Git repository property payload for Application Configuration Service
 */
model ConfigurationServiceGitRepository {
  /**
   * Name of the repository
   */
  name: string;

  /**
   * Collection of patterns of the repository
   */
  patterns: string[];

  /**
   * URI of the repository
   */
  uri: string;

  /**
   * Label of the repository
   */
  label: string;

  /**
   * Searching path of the repository
   */
  searchPaths?: string[];

  /**
   * Username of git repository basic auth.
   */
  username?: string;

  /**
   * Password of git repository basic auth.
   */
  password?: string;

  /**
   * Public sshKey of git repository.
   */
  hostKey?: string;

  /**
   * SshKey algorithm of git repository.
   */
  hostKeyAlgorithm?: string;

  /**
   * Private sshKey algorithm of git repository.
   */
  privateKey?: string;

  /**
   * Strict host key checking or not.
   */
  strictHostKeyChecking?: boolean;

  /**
   * Git libraries used to support various repository providers
   */
  gitImplementation?: GitImplementation;

  /**
   * Resource Id of CA certificate for https URL of Git repository.
   */
  caCertResourceId?: string;
}

/**
 * Object that includes an array of configuration service resources and a possible link for next set
 */
model ConfigurationServiceResourceCollection
  is Azure.Core.Page<ConfigurationServiceResource>;

/**
 * Validation result for configuration service settings
 */
model ConfigurationServiceSettingsValidateResult {
  /**
   * Validation result for configuration service settings
   */
  gitPropertyValidationResult?: ConfigurationServiceGitPropertyValidateResult;
}

/**
 * Validation result for configuration service settings
 */
model ConfigurationServiceGitPropertyValidateResult {
  /**
   * Indicate if the configuration service settings are valid
   */
  isValid?: boolean;

  /**
   * The detail validation results
   */
  gitReposValidationResult?: ValidationMessages[];
}

/**
 * Validate messages of the configuration service git repositories
 */
model ValidationMessages {
  /**
   * The name of the configuration service git repository.
   */
  name?: string;

  /**
   * Detailed validation messages.
   */
  messages?: string[];
}

/**
 * Service Registry properties payload
 */
model ServiceRegistryProperties {
  /**
   * State of the Service Registry.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ServiceRegistryProvisioningState;

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  @visibility(Lifecycle.Read)
  resourceRequests?: ServiceRegistryResourceRequests;

  /**
   * Collection of instances belong to Service Registry.
   */
  @visibility(Lifecycle.Read)
  instances?: ServiceRegistryInstance[];
}

/**
 * Resource request payload of Service Registry
 */
model ServiceRegistryResourceRequests {
  /**
   * CPU allocated to each Service Registry instance
   */
  @visibility(Lifecycle.Read)
  cpu?: string;

  /**
   * Memory allocated to each Service Registry instance
   */
  @visibility(Lifecycle.Read)
  memory?: string;

  /**
   * Instance count of the Service Registry
   */
  @visibility(Lifecycle.Read)
  instanceCount?: int32;
}

/**
 * Collection of instances belong to the Service Registry
 */
model ServiceRegistryInstance {
  /**
   * Name of the Service Registry instance
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the Service Registry instance
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * Object that includes an array of Service Registry resources and a possible link for next set
 */
model ServiceRegistryResourceCollection
  is Azure.Core.Page<ServiceRegistryResource>;

/**
 * Object that includes an array of Application Live View resources and a possible link for next set
 */
model ApplicationLiveViewResourceCollection
  is Azure.Core.Page<ApplicationLiveViewResource>;

/**
 * Application Live View properties payload
 */
model ApplicationLiveViewProperties {
  /**
   * State of the Application Live View.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ApplicationLiveViewProvisioningState;

  /**
   * Component details of Application Live View
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  components?: ApplicationLiveViewComponent[];
}

/**
 * Application Live View properties payload
 */
model ApplicationLiveViewComponent {
  /**
   * Name of the component.
   */
  @visibility(Lifecycle.Read)
  name?: unknown;

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  @visibility(Lifecycle.Read)
  resourceRequests?: ApplicationLiveViewResourceRequests;

  /**
   * Collection of instances belong to Application Live View.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  instances?: ApplicationLiveViewInstance[];
}

/**
 * The resource quantity for required CPU and Memory of Application Live View component
 */
model ApplicationLiveViewResourceRequests {
  /**
   * Cpu quantity allocated to each Application Live View component instance. 1 core can be represented by 1 or 1000m.
   */
  @visibility(Lifecycle.Read)
  cpu?: string;

  /**
   * Memory quantity allocated to each Application Live View component instance. 1 GB can be represented by 1Gi or 1024Mi.
   */
  @visibility(Lifecycle.Read)
  memory?: string;

  /**
   * Desired instance count of Application Live View component instance.
   */
  @visibility(Lifecycle.Read)
  instanceCount?: int32;
}

/**
 * Collection of instances belong to the Application Live View
 */
model ApplicationLiveViewInstance {
  /**
   * Name of the Application Live View instance.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the Application Live View instance. It can be Pending, Running, Succeeded, Failed, Unknown.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * Object that includes an array of Dev Tool Portal resources and a possible link for next set
 */
model DevToolPortalResourceCollection is Azure.Core.Page<DevToolPortalResource>;

/**
 * Dev Tool Portal properties payload
 */
model DevToolPortalProperties {
  /**
   * State of the Dev Tool Portal.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DevToolPortalProvisioningState;

  /**
   * Collection of components belong to Dev Tool Portal.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  components?: DevToolPortalComponent[];

  /**
   * Indicates whether the resource exposes public endpoint
   */
  public?: boolean;

  /**
   * URL of the resource, exposed when 'public' is true.
   */
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * Single sign-on related configuration
   */
  ssoProperties?: DevToolPortalSsoProperties;

  /**
   * Settings for Dev Tool Portal
   */
  features?: DevToolPortalFeatureSettings;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model DevToolPortalComponent {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  @visibility(Lifecycle.Read)
  resourceRequests?: DevToolPortalResourceRequests;

  /**
   * Collection of instances belong to Dev Tool Portal.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #[])
  instances?: DevToolPortalInstance[];
}

/**
 * The resource quantity for required CPU and Memory of Dev Tool Portal
 */
model DevToolPortalResourceRequests {
  /**
   * Cpu quantity allocated to each Dev Tool Portal instance. 1 core can be represented by 1 or 1000m
   */
  @visibility(Lifecycle.Read)
  cpu?: string;

  /**
   * Memory quantity allocated to each Dev Tool Portal instance. 1 GB can be represented by 1Gi or 1024Mi.
   */
  @visibility(Lifecycle.Read)
  memory?: string;

  /**
   * Desired instance count of Dev Tool Portal.
   */
  @visibility(Lifecycle.Read)
  instanceCount?: int32;
}

/**
 * Collection of instances belong to the Dev Tool Portal.
 */
model DevToolPortalInstance {
  /**
   * Name of the Dev Tool Portal instance.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the Dev Tool Portal instance. It can be Pending, Running, Succeeded, Failed, Unknown.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * Single sign-on related configuration
 */
model DevToolPortalSsoProperties {
  /**
   * It defines the specific actions applications can be allowed to do on a user's behalf
   */
  scopes?: string[];

  /**
   * The public identifier for the application
   */
  clientId?: string;

  /**
   * The secret known only to the application and the authorization server
   */
  clientSecret?: string;

  /**
   * The URI of a JSON file with generic OIDC provider configuration.
   */
  metadataUrl?: string;
}

/**
 * Settings for Dev Tool Portal
 */
model DevToolPortalFeatureSettings {
  /**
   * Detail of Accelerator plugin
   */
  applicationAccelerator?: DevToolPortalFeatureDetail;

  /**
   * Detail of App Live View plugin
   */
  applicationLiveView?: DevToolPortalFeatureDetail;
}

/**
 * Detail settings for Dev Tool Portal feature
 */
model DevToolPortalFeatureDetail {
  /**
   * State of the plugin
   */
  state?: DevToolPortalFeatureState = DevToolPortalFeatureState.Enabled;

  /**
   * Route path to visit the plugin
   */
  @visibility(Lifecycle.Read)
  route?: string;
}

/**
 * Collection compose of container registry resources list and a possible link for next page.
 */
model ContainerRegistryResourceCollection
  is Azure.Core.Page<ContainerRegistryResource>;

/**
 * Container registry resource payload.
 */
model ContainerRegistryProperties {
  /**
   * The credentials of the container registry resource.
   */
  credentials: ContainerRegistryCredentials;

  /**
   * State of the Container Registry.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ContainerRegistryProvisioningState;
}

/**
 * The credential for the container registry resource.
 */
@discriminator("type")
model ContainerRegistryCredentials {
  /**
   * The credential type of the container registry credentials.
   */
  type: string;
}

/**
 * Validation result for container registry properties
 */
model ContainerRegistryValidateResult {
  /**
   * Indicate if the container registry properties are valid
   */
  isValid?: boolean;

  /**
   * Detailed validation messages.
   */
  message?: string;
}

/**
 * Object that includes an array of Build service resources and a possible link for next set
 */
model BuildServiceCollection is Azure.Core.Page<BuildService>;

/**
 * Build service resource properties payload
 */
model BuildServiceProperties {
  /**
   * The resource id of the container registry used in this build service.
   */
  containerRegistry?: string;

  /**
   * The installed KPack version in this build service.
   */
  @visibility(Lifecycle.Read)
  kPackVersion?: string;

  /**
   * Provisioning state of the KPack build service
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BuildServiceProvisioningState;

  /**
   * The runtime resource configuration of this build service.
   */
  resourceRequests?: BuildServicePropertiesResourceRequests;
}

/**
 * The runtime resource configuration of this build service.
 */
model BuildServicePropertiesResourceRequests {
  /**
   * vCPU allocated to the entire build service node pool.
   */
  @visibility(Lifecycle.Read)
  cpu?: string;

  /**
   * Memory allocated to the entire build service node pool.
   */
  @visibility(Lifecycle.Read)
  memory?: string;
}

/**
 * Object that includes an array of Build resources and a possible link for next set
 */
model BuildCollection is Azure.Core.Page<Build>;

/**
 * Build resource properties payload
 */
model BuildProperties {
  /**
   * The relative path of source code
   */
  relativePath?: string;

  /**
   * The resource id of builder to build the source code
   */
  builder?: string;

  /**
   * The resource id of agent pool
   */
  agentPool?: string;

  /**
   * Provisioning state of the KPack build result
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BuildProvisioningState;

  /**
   * The environment variables for this build
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  env?: Record<string>;

  /**
   * The APMs for this build
   */
  apms?: ApmReference[];

  /**
   * The CA Certificates for this build
   */
  certificates?: CertificateReference[];

  /**
   *  The build result triggered by this build
   */
  @visibility(Lifecycle.Read)
  triggeredBuildResult?: TriggeredBuildResult;

  /**
   * The customized build resource for this build
   */
  resourceRequests?: BuildResourceRequests;
}

/**
 * A reference to the certificate
 */
model CertificateReference {
  /**
   * Resource Id of the certificate
   */
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AppPlatform/Spring/certificates";
    }
  ]>;
}

/**
 * The build result triggered by a build
 */
model TriggeredBuildResult {
  /**
   * The unique build id of this build result
   */
  id?: string;

  /**
   * The provisioning state of this build result
   */
  @visibility(Lifecycle.Read)
  provisioningState?: TriggeredBuildResultProvisioningState;

  /**
   * The container image of this build result
   */
  image?: string;

  /**
   * The last transition time of this build result
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastTransitionTime?: utcDateTime;

  /**
   * The last transition reason of this build result
   */
  lastTransitionReason?: string;

  /**
   * The last transition status of this build result
   */
  lastTransitionStatus?: string;
}

/**
 * Resource request payload of Build Resource.
 */
model BuildResourceRequests {
  /**
   * Optional Cpu allocated to the build resource. 1 core can be represented by 1 or 1000m.
   * The default value is 1, this should not exceed build service agent pool cpu size.
   */
  cpu?: string = "1";

  /**
   * Optional Memory allocated to the build resource. 1 GB can be represented by 1Gi or 1024Mi.
   * The default value is 2Gi, this should not exceed build service agent pool memory size.
   */
  memory?: string = "2Gi";
}

/**
 * Object that includes an array of BuildpackBinding resources and a possible link for next set
 */
model BuildpackBindingResourceCollection
  is Azure.Core.Page<BuildpackBindingResource>;

/**
 * Properties of a buildpack binding
 */
model BuildpackBindingProperties {
  /**
   * Buildpack Binding Type
   */
  bindingType?: BindingType;

  /**
   * State of the Buildpack Binding.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BuildpackBindingProvisioningState;

  /**
   * The object describes the buildpack binding launch properties
   */
  launchProperties?: BuildpackBindingLaunchProperties;
}

/**
 * Buildpack Binding Launch Properties
 */
model BuildpackBindingLaunchProperties {
  /**
   * Non-sensitive properties for launchProperties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * Sensitive properties for launchProperties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  secrets?: Record<string>;
}

/**
 * Object that includes an array of Build result resources and a possible link for next set
 */
model BuildResultCollection is Azure.Core.Page<BuildResult>;

/**
 * Build result resource properties payload
 */
model BuildResultProperties {
  /**
   * The name of this build result
   */
  name?: string;

  /**
   * Provisioning state of the KPack build result
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BuildResultProvisioningState;

  /**
   * Error when build is failed.
   */
  error?: Error;

  /**
   * The build pod name which can be used to get the build log streaming.
   */
  buildPodName?: string;

  /**
   * All of the build stage (init-container and container) resources in build pod.
   */
  @visibility(Lifecycle.Read)
  buildStages?: BuildStageProperties[];

  /**
   * The container registry image of this build result.
   */
  @visibility(Lifecycle.Read)
  image?: string;
}

/**
 * The build stage (init-container and container) resources in build pod.
 */
model BuildStageProperties {
  /**
   * The name of this build stage resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The provisioning state of this build stage resource.
   */
  @visibility(Lifecycle.Read)
  status?: KPackBuildStageProvisioningState;

  /**
   * The exit code of this build init container.
   */
  @visibility(Lifecycle.Read)
  exitCode?: string;

  /**
   * The reason of this build init container.
   */
  @visibility(Lifecycle.Read)
  reason?: string;
}

/**
 * Build result log resource properties payload
 */
model BuildResultLog {
  /**
   * The public download URL of this build result log
   */
  blobUrl?: string;
}

/**
 * KPack Builder properties payload
 */
model BuilderProperties {
  /**
   * Builder provision status.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BuilderProvisioningState;

  /**
   * Builder cluster stack property.
   */
  stack?: StackProperties;

  /**
   * Builder buildpack groups.
   */
  buildpackGroups?: BuildpacksGroupProperties[];
}

/**
 * KPack ClusterStack properties payload
 */
model StackProperties {
  /**
   * Id of the ClusterStack.
   */
  id?: string;

  /**
   * Version of the ClusterStack
   */
  version?: string;
}

/**
 * Buildpack group properties of the Builder
 */
model BuildpacksGroupProperties {
  /**
   * Buildpack group name
   */
  name?: string;

  /**
   * Buildpacks in the buildpack group
   */
  buildpacks?: BuildpackProperties[];
}

/**
 * Buildpack properties payload
 */
model BuildpackProperties {
  /**
   * Id of the buildpack
   */
  id?: string;

  /**
   * Version of the buildpack
   */
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * Object that includes an array of Builder resources and a possible link for next set
 */
model BuilderResourceCollection is Azure.Core.Page<BuilderResource>;

/**
 * Resource upload definition payload
 */
model ResourceUploadDefinition {
  /**
   * Source relative path
   */
  relativePath?: string;

  /**
   * Upload URL
   */
  uploadUrl?: string;
}

/**
 * Object that includes an array of supported buildpacks resources and a possible link for next set
 */
model SupportedBuildpacksCollection {
  /**
   * Collection of supported buildpacks resources
   */
  value?: SupportedBuildpackResource[];

  /**
   * URL client should use to fetch the next page (per server side paging).
   * It's null for now, added for future use.
   */
  nextLink?: string;
}

/**
 * Supported buildpack resource properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SupportedBuildpackResourceProperties {
  /**
   * The id of supported buildpack
   */
  buildpackId?: string;

  /**
   * The version of supported buildpack
   */
  version?: string;
}

/**
 * Object that includes an array of supported stacks resources and a possible link for next set
 */
model SupportedStacksCollection {
  /**
   * Collection of supported stacks resources
   */
  value?: SupportedStackResource[];

  /**
   * URL client should use to fetch the next page (per server side paging).
   * It's null for now, added for future use.
   */
  nextLink?: string;
}

/**
 * Supported stack resource properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SupportedStackResourceProperties {
  /**
   * The id of supported stack
   */
  stackId?: string;

  /**
   * The version of supported stack
   */
  version?: string;
}

/**
 * Object that includes an array of build service agent pool resources and a possible link for next set
 */
model BuildServiceAgentPoolResourceCollection
  is Azure.Core.Page<BuildServiceAgentPoolResource>;

/**
 * Build service agent pool properties
 */
model BuildServiceAgentPoolProperties {
  /**
   * Provisioning state of the build service agent pool
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * build service agent pool size properties
   */
  poolSize?: BuildServiceAgentPoolSizeProperties;
}

/**
 * Build service agent pool size properties
 */
model BuildServiceAgentPoolSizeProperties {
  /**
   * The name of build service agent pool size
   */
  name?: string;

  /**
   * The cpu property of build service agent pool size
   */
  @visibility(Lifecycle.Read)
  cpu?: string;

  /**
   * The memory property of build service agent pool size
   */
  @visibility(Lifecycle.Read)
  memory?: string;
}

/**
 * Monitoring Setting properties payload
 */
model MonitoringSettingProperties {
  /**
   * State of the Monitoring Setting.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: MonitoringSettingState;

  /**
   * Error when apply Monitoring Setting changes.
   */
  error?: Error;

  /**
   * Indicates whether enable the trace functionality, which will be deprecated since api version 2020-11-01-preview. Please leverage appInsightsInstrumentationKey to indicate if monitoringSettings enabled or not
   */
  traceEnabled?: boolean;

  /**
   * Target application insight instrumentation key, null or whitespace include empty will disable monitoringSettings
   */
  appInsightsInstrumentationKey?: string;

  /**
   * Indicates the sampling rate of application insight agent, should be in range [0.0, 100.0]
   */
  @maxValue(100)
  appInsightsSamplingRate?: float64;

  /**
   * Indicates the versions of application insight agent
   */
  appInsightsAgentVersions?: ApplicationInsightsAgentVersions;
}

/**
 * Application Insights agent versions properties payload
 */
model ApplicationInsightsAgentVersions {
  /**
   * Indicates the version of application insight java agent
   */
  @visibility(Lifecycle.Read)
  java?: string;
}

/**
 * App resource properties payload
 */
model AppResourceProperties {
  /**
   * Indicates whether the App exposes public endpoint
   */
  public?: boolean;

  /**
   * URL of the App
   */
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * Collection of addons
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  addonConfigs?: Record<Record<unknown>>;

  /**
   * Provisioning state of the App
   */
  @visibility(Lifecycle.Read)
  provisioningState?: AppResourceProvisioningState;

  /**
   * Fully qualified dns Name.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * Indicate if only https is allowed.
   */
  httpsOnly?: boolean;

  /**
   * Temporary disk settings
   */
  temporaryDisk?: TemporaryDisk;

  /**
   * Persistent disk settings
   */
  persistentDisk?: PersistentDisk;

  /**
   * List of custom persistent disks
   */
  customPersistentDisks?: CustomPersistentDiskResource[];

  /**
   * Indicate if end to end TLS is enabled.
   */
  enableEndToEndTLS?: boolean;

  /**
   * Collection of loaded certificates
   */
  loadedCertificates?: LoadedCertificate[];

  /**
   * Additional App settings in vnet injection instance
   */
  vnetAddons?: AppVNetAddons;

  /**
   * App ingress settings payload.
   */
  ingressSettings?: IngressSettings;

  /**
   * Collection of auth secrets
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  secrets?: Secret[];

  /**
   * The workload profile used for this app. Supported for Consumption + Dedicated plan.
   */
  workloadProfileName?: string;

  /**
   * State of test endpoint auth.
   */
  testEndpointAuthState?: TestEndpointAuthState = TestEndpointAuthState.Enabled;
}

/**
 * Temporary disk payload
 */
model TemporaryDisk {
  /**
   * Size of the temporary disk in GB
   */
  @maxValue(5)
  sizeInGB?: int32;

  /**
   * Mount path of the temporary disk
   */
  mountPath?: string = "/tmp";
}

/**
 * Persistent disk payload
 */
model PersistentDisk {
  /**
   * Size of the persistent disk in GB
   */
  @maxValue(50)
  sizeInGB?: int32;

  /**
   * Size of the used persistent disk in GB
   */
  @visibility(Lifecycle.Read)
  @maxValue(50)
  usedInGB?: int32;

  /**
   * Mount path of the persistent disk
   */
  mountPath?: string;
}

/**
 * Custom persistent disk resource payload.
 */
model CustomPersistentDiskResource {
  /**
   * Properties of the custom persistent disk resource payload.
   */
  customPersistentDiskProperties?: CustomPersistentDiskProperties;

  /**
   * The resource id of Azure Spring Apps Storage resource.
   */
  storageId: string;
}

/**
 * Custom persistent disk resource payload.
 */
@discriminator("type")
model CustomPersistentDiskProperties {
  /**
   * The type of the underlying resource to mount as a persistent disk.
   */
  type: Type;

  /**
   * The mount path of the persistent disk.
   */
  mountPath: string;

  /**
   * Indicates whether the persistent disk is a readOnly one.
   */
  readOnly?: boolean;

  /**
   * If set to true, it will create and mount a dedicated directory for every individual app instance.
   */
  enableSubPath?: boolean;

  /**
   * These are the mount options for a persistent disk.
   */
  mountOptions?: string[];
}

/**
 * Loaded certificate payload
 */
model LoadedCertificate {
  /**
   * Resource Id of loaded certificate
   */
  resourceId: string;

  /**
   * Indicate whether the certificate will be loaded into default trust store, only work for Java runtime.
   */
  loadTrustStore?: boolean;
}

/**
 * Additional App settings in vnet injection instance
 */
model AppVNetAddons {
  /**
   * Indicates whether the App in vnet injection instance exposes endpoint which could be accessed from internet.
   */
  publicEndpoint?: boolean;

  /**
   * URL of the App in vnet injection instance which could be accessed from internet
   */
  @visibility(Lifecycle.Read)
  publicEndpointUrl?: string;
}

/**
 * App ingress settings payload.
 */
model IngressSettings {
  /**
   * Ingress read time out in seconds.
   */
  readTimeoutInSeconds?: int32;

  /**
   * Ingress send time out in seconds.
   */
  sendTimeoutInSeconds?: int32;

  /**
   * Type of the affinity, set this to Cookie to enable session affinity.
   */
  sessionAffinity?: SessionAffinity;

  /**
   * Time in seconds until the cookie expires.
   */
  sessionCookieMaxAge?: int32;

  /**
   * How ingress should communicate with this app backend service.
   */
  backendProtocol?: BackendProtocol;

  /**
   * Client-Certification Authentication.
   */
  clientAuth?: IngressSettingsClientAuth;
}

/**
 * Client-Certification Authentication.
 */
model IngressSettingsClientAuth {
  /**
   * Collection of certificate resource id.
   */
  certificates?: string[];
}

/**
 * Secret definition.
 */
model Secret {
  /**
   * Secret Name.
   */
  name?: string;

  /**
   * Secret Value.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  value?: string;
}

/**
 * The details of the user-assigned managed identity assigned to an App.
 */
model UserAssignedManagedIdentity {
  /**
   * Principal Id of user-assigned managed identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * Client Id of user-assigned managed identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}

/**
 * Object that includes an array of App resources and a possible link for next set
 */
model AppResourceCollection is Azure.Core.Page<AppResource>;

/**
 * Object that includes an array of Deployment resource name and set them as active.
 */
model ActiveDeploymentCollection {
  /**
   * Collection of Deployment name.
   */
  activeDeploymentNames?: string[];
}

/**
 * Binding resource properties payload
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model BindingResourceProperties {
  /**
   * The name of the bound resource
   */
  @visibility(Lifecycle.Read)
  resourceName?: string;

  /**
   * The standard Azure resource type of the bound resource
   */
  @visibility(Lifecycle.Read)
  resourceType?: string;

  /**
   * The Azure resource id of the bound resource
   */
  resourceId?: string;

  /**
   * The key of the bound resource
   */
  key?: string;

  /**
   * Binding parameters of the Binding resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  bindingParameters?: Record<string>;

  /**
   * The generated Spring Boot property file for this binding. The secret will be deducted.
   */
  @visibility(Lifecycle.Read)
  generatedProperties?: string;

  /**
   * Creation time of the Binding resource
   */
  @visibility(Lifecycle.Read)
  createdAt?: string;

  /**
   * Update time of the Binding resource
   */
  @visibility(Lifecycle.Read)
  updatedAt?: string;
}

/**
 * Object that includes an array of Binding resources and a possible link for next set
 */
model BindingResourceCollection is Azure.Core.Page<BindingResource>;

/**
 * Storage resource payload.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
@discriminator("storageType")
model StorageProperties {
  /**
   * The type of the storage.
   */
  storageType: StorageType;
}

/**
 * Collection compose of storage resources list and a possible link for next page.
 */
model StorageResourceCollection is Azure.Core.Page<StorageResource>;

/**
 * Certificate resource payload.
 */
@discriminator("type")
model CertificateProperties {
  /**
   * The type of the certificate source.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  type: string;

  /**
   * The thumbprint of certificate.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * The issuer of certificate.
   */
  @visibility(Lifecycle.Read)
  issuer?: string;

  /**
   * The issue date of certificate.
   */
  @visibility(Lifecycle.Read)
  issuedDate?: string;

  /**
   * The expiration date of certificate.
   */
  @visibility(Lifecycle.Read)
  expirationDate?: string;

  /**
   * The activate date of certificate.
   */
  @visibility(Lifecycle.Read)
  activateDate?: string;

  /**
   * The subject name of certificate.
   */
  @visibility(Lifecycle.Read)
  subjectName?: string;

  /**
   * The domain list of certificate.
   */
  @visibility(Lifecycle.Read)
  dnsNames?: string[];

  /**
   * Provisioning state of the Certificate
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CertificateResourceProvisioningState;
}

/**
 * Collection compose of certificate resources list and a possible link for next page.
 */
model CertificateResourceCollection is Azure.Core.Page<CertificateResource>;

/**
 * Name availability parameters payload
 */
model NameAvailabilityParameters {
  /**
   * Type of the resource to check name availability
   */
  type: string;

  /**
   * Name to be checked
   */
  name: string;
}

/**
 * Name availability result payload
 */
model NameAvailability {
  /**
   * Indicates whether the name is available
   */
  nameAvailable?: boolean;

  /**
   * Reason why the name is not available
   */
  reason?: string;

  /**
   * Message why the name is not available
   */
  message?: string;
}

/**
 * Custom domain of app resource payload.
 */
model CustomDomainProperties {
  /**
   * The thumbprint of bound certificate.
   */
  thumbprint?: string;

  /**
   * The app name of domain.
   */
  @visibility(Lifecycle.Read)
  appName?: string;

  /**
   * The bound certificate name of domain.
   */
  certName?: string;

  /**
   * Provisioning state of the Domain
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CustomDomainResourceProvisioningState;
}

/**
 * Collection compose of a custom domain resources list and a possible link for next page.
 */
model CustomDomainResourceCollection is Azure.Core.Page<CustomDomainResource>;

/**
 * Custom domain validate payload.
 */
model CustomDomainValidatePayload {
  /**
   * Name to be validated
   */
  name: string;
}

/**
 * Validation result for custom domain.
 */
model CustomDomainValidateResult {
  /**
   * Indicates if domain name is valid.
   */
  isValid?: boolean;

  /**
   * Message of why domain name is invalid.
   */
  message?: string;
}

/**
 * Deployment resource properties payload
 */
model DeploymentResourceProperties {
  /**
   * Uploaded source information of the deployment.
   */
  source?: UserSourceInfo;

  /**
   * Deployment settings of the Deployment
   */
  deploymentSettings?: DeploymentSettings;

  /**
   * Provisioning state of the Deployment
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DeploymentResourceProvisioningState;

  /**
   * Status of the Deployment
   */
  @visibility(Lifecycle.Read)
  status?: DeploymentResourceStatus;

  /**
   * Indicates whether the Deployment is active
   */
  active?: boolean;

  /**
   * Collection of instances belong to the Deployment
   */
  @visibility(Lifecycle.Read)
  instances?: DeploymentInstance[];
}

/**
 * Source information for a deployment or a job
 */
@discriminator("type")
model UserSourceInfo {
  /**
   * Type of the source uploaded
   */
  type: string;

  /**
   * Version of the source
   */
  version?: string;
}

/**
 * Deployment settings payload
 */
model DeploymentSettings {
  /**
   * The requested resource quantity for required CPU and Memory. It is recommended that using this field to represent the required CPU and Memory, the old field cpu and memoryInGB will be deprecated later.
   */
  resourceRequests?: ResourceRequests;

  /**
   * Collection of environment variables
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  environmentVariables?: Record<string>;

  /**
   * Collection of ApmReferences
   */
  apms?: ApmReference[];

  /**
   * Collection of addons
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  addonConfigs?: Record<Record<unknown>>;

  /**
   * Periodic probe of App Instance liveness. App Instance will be restarted if the probe fails. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
   */
  livenessProbe?: Probe;

  /**
   * Periodic probe of App Instance service readiness. App Instance will be removed from service endpoints if the probe fails. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
   */
  readinessProbe?: Probe;

  /**
   * StartupProbe indicates that the App Instance has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a App Instance's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
   */
  startupProbe?: Probe;

  /**
   * Optional duration in seconds the App Instance needs to terminate gracefully. May be decreased in delete request. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. The grace period is the duration in seconds after the processes running in the App Instance are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. Defaults to 90 seconds.
   */
  terminationGracePeriodSeconds?: int32 = 90;

  /**
   * Scaling properties for the Azure Spring Apps App Instance.
   */
  scale?: Scale;

  /**
   * Container liveness and readiness probe settings
   */
  containerProbeSettings?: ContainerProbeSettings;
}

/**
 * Deployment resource request payload
 */
model ResourceRequests {
  /**
   * Required CPU. 1 core can be represented by 1 or 1000m. This should be 500m or 1 for Basic tier, and {500m, 1, 2, 3, 4} for Standard tier.
   */
  cpu?: string;

  /**
   * Required memory. 1 GB can be represented by 1Gi or 1024Mi. This should be {512Mi, 1Gi, 2Gi} for Basic tier, and {512Mi, 1Gi, 2Gi, ..., 8Gi} for Standard tier.
   */
  memory?: string;
}

/**
 * Probe describes a health check to be performed against an App Instance to determine whether it is alive or ready to receive traffic.
 */
model Probe {
  /**
   * The action of the probe.
   */
  probeAction?: ProbeAction;

  /**
   * Indicate whether the probe is disabled.
   */
  disableProbe: boolean;

  /**
   * Number of seconds after the App Instance has started before probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes
   */
  initialDelaySeconds?: int32;

  /**
   * How often (in seconds) to perform the probe. Minimum value is 1.
   */
  periodSeconds?: int32;

  /**
   * Number of seconds after which the probe times out. Minimum value is 1.
   */
  timeoutSeconds?: int32;

  /**
   * Minimum consecutive failures for the probe to be considered failed after having succeeded. Minimum value is 1.
   */
  failureThreshold?: int32;

  /**
   * Minimum consecutive successes for the probe to be considered successful after having failed. Must be 1 for liveness and startup. Minimum value is 1.
   */
  successThreshold?: int32;
}

/**
 * The action of the probe.
 */
@discriminator("type")
model ProbeAction {
  /**
   * The type of the action to take to perform the health check.
   */
  type: ProbeActionType;
}

/**
 * Azure Spring Apps scaling configurations.
 */
model Scale {
  /**
   * Optional. Minimum number of container replicas.
   */
  minReplicas?: int32;

  /**
   * Optional. Maximum number of container replicas. Defaults to 10 if not set.
   */
  maxReplicas?: int32 = 10;

  /**
   * Scaling rules.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  rules?: ScaleRule[];
}

/**
 * Azure Spring Apps App Instance scaling rule.
 */
model ScaleRule {
  /**
   * Scale Rule Name
   */
  name?: string;

  /**
   * Azure Queue based scaling.
   */
  azureQueue?: QueueScaleRule;

  /**
   * Custom scale rule.
   */
  custom?: CustomScaleRule;

  /**
   * HTTP requests based scaling.
   */
  http?: HttpScaleRule;

  /**
   * Tcp requests based scaling.
   */
  tcp?: TcpScaleRule;
}

/**
 * Azure Spring Apps App Instance Azure Queue based scaling rule.
 */
model QueueScaleRule {
  /**
   * Queue name.
   */
  queueName?: string;

  /**
   * Queue length.
   */
  queueLength?: int32;

  /**
   * Authentication secrets for the queue scale rule.
   */
  @OpenAPI.extension("x-ms-identifiers", #["triggerParameter"])
  auth?: ScaleRuleAuth[];
}

/**
 * Auth Secrets for Azure Spring Apps App Instance Scale Rule
 */
model ScaleRuleAuth {
  /**
   * Name of the Azure Spring Apps App Instance secret from which to pull the auth params.
   */
  secretRef?: string;

  /**
   * Trigger Parameter that uses the secret
   */
  triggerParameter?: string;
}

/**
 * Azure Spring Apps App Instance Custom scaling rule.
 */
model CustomScaleRule {
  /**
   * Type of the custom scale rule
   * eg: azure-servicebus, redis etc.
   */
  type?: string;

  /**
   * Metadata properties to describe custom scale rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<string>;

  /**
   * Authentication secrets for the custom scale rule.
   */
  @OpenAPI.extension("x-ms-identifiers", #["triggerParameter"])
  auth?: ScaleRuleAuth[];
}

/**
 * Azure Spring Apps App Instance Http scaling rule.
 */
model HttpScaleRule {
  /**
   * Metadata properties to describe http scale rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<string>;

  /**
   * Authentication secrets for the custom scale rule.
   */
  @OpenAPI.extension("x-ms-identifiers", #["triggerParameter"])
  auth?: ScaleRuleAuth[];
}

/**
 * Azure Spring Apps App Instance Tcp scaling rule.
 */
model TcpScaleRule {
  /**
   * Metadata properties to describe tcp scale rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<string>;

  /**
   * Authentication secrets for the tcp scale rule.
   */
  @OpenAPI.extension("x-ms-identifiers", #["triggerParameter"])
  auth?: ScaleRuleAuth[];
}

/**
 * Container liveness and readiness probe settings
 */
model ContainerProbeSettings {
  /**
   * Indicates whether disable the liveness and readiness probe
   */
  disableProbe?: boolean;
}

/**
 * Deployment instance payload
 */
model DeploymentInstance {
  /**
   * Name of the deployment instance
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the deployment instance
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * Failed reason of the deployment instance
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * Discovery status of the deployment instance
   */
  @visibility(Lifecycle.Read)
  discoveryStatus?: string;

  /**
   * Start time of the deployment instance
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * Availability zone information of the deployment instance
   */
  @visibility(Lifecycle.Read)
  zone?: string;
}

/**
 * Object that includes an array of App resources and a possible link for next set
 */
model DeploymentResourceCollection is Azure.Core.Page<DeploymentResource>;

/**
 * A list of deployments resource ids.
 */
model DeploymentList {
  /**
   * A list of deployment resource ids.
   */
  deployments?: string[];
}

/**
 * Remote debugging payload.
 */
model RemoteDebuggingPayload {
  /**
   * Application debugging port.
   */
  port?: int32;
}

/**
 * Remote debugging config.
 */
model RemoteDebugging {
  /**
   * Application debugging port
   */
  port?: int32;

  /**
   * Indicate if remote debugging is enabled
   */
  enabled?: boolean;
}

/**
 * Log file URL payload
 */
model LogFileUrlResponse {
  /**
   * URL of the log file
   */
  url: string;
}

/**
 * Diagnostic parameters of diagnostic operations
 */
model DiagnosticParameters {
  /**
   * App instance name
   */
  appInstance?: string;

  /**
   * Your target file path in your own BYOS
   */
  filePath?: string;

  /**
   * Duration of your JFR. 1 min can be represented by 1m or 60s.
   */
  duration?: string;
}

/**
 * Object that includes an array of Service resources and a possible link for next set
 */
model ServiceResourceList is Azure.Core.Page<ServiceResource>;

/**
 * Operation detail payload
 */
model OperationDetail {
  /**
   * Name of the operation
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
   */
  @visibility(Lifecycle.Read)
  actionType?: ActionType;

  /**
   * Origin of the operation
   */
  origin?: string;

  /**
   * Properties of the operation
   */
  properties?: OperationProperties;
}

/**
 * Extra Operation properties
 */
model OperationProperties {
  /**
   * Service specifications of the operation
   */
  serviceSpecification?: ServiceSpecification;
}

/**
 * Service specification payload
 */
model ServiceSpecification {
  /**
   * Specifications of the Log for Azure Monitoring
   */
  logSpecifications?: LogSpecification[];

  /**
   * Specifications of the Metrics for Azure Monitoring
   */
  metricSpecifications?: MetricSpecification[];
}

/**
 * Specifications of the Log for Azure Monitoring
 */
model LogSpecification {
  /**
   * Name of the log
   */
  name?: string;

  /**
   * Localized friendly display name of the log
   */
  displayName?: string;

  /**
   * Blob duration of the log
   */
  blobDuration?: string;
}

/**
 * Specifications of the Metrics for Azure Monitoring
 */
model MetricSpecification {
  /**
   * Name of the metric
   */
  name?: string;

  /**
   * Localized friendly display name of the metric
   */
  displayName?: string;

  /**
   * Localized friendly description of the metric
   */
  displayDescription?: string;

  /**
   * Unit that makes sense for the metric
   */
  unit?: string;

  /**
   * Name of the metric category that the metric belongs to. A metric can only belong to a single category.
   */
  category?: string;

  /**
   * Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.
   */
  aggregationType?: string;

  /**
   * Supported aggregation types
   */
  supportedAggregationTypes?: string[];

  /**
   * Supported time grain types
   */
  supportedTimeGrainTypes?: string[];

  /**
   * Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published.
   */
  fillGapWithZero?: boolean;

  /**
   * Dimensions of the metric
   */
  dimensions?: MetricDimension[];

  /**
   * Name of the MDM namespace. Optional.
   */
  sourceMdmNamespace?: string;
}

/**
 * Specifications of the Dimension of metrics
 */
model MetricDimension {
  /**
   * Name of the dimension
   */
  name?: string;

  /**
   * Localized friendly display name of the dimension
   */
  displayName?: string;

  /**
   * Whether this dimension should be included for the Shoebox export scenario
   */
  toBeExportedForShoebox?: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AvailableRuntimeVersions {
  /**
   * A list of all supported runtime versions.
   */
  @visibility(Lifecycle.Read)
  value?: SupportedRuntimeVersion[];
}

/**
 * Supported deployment runtime version descriptor.
 */
model SupportedRuntimeVersion {
  /**
   * The raw value which could be passed to deployment CRUD operations.
   */
  value?: SupportedRuntimeValue;

  /**
   * The platform of this runtime version (possible values: "Java" or ".NET").
   */
  platform?: SupportedRuntimePlatform;

  /**
   * The detailed version (major.minor) of the platform.
   */
  version?: string;
}

/**
 * Object that includes an array of Azure Spring Apps SKU and a possible link for next set
 */
model ResourceSkuCollection is Azure.Core.Page<ResourceSku>;

/**
 * The SKU capacity
 */
model SkuCapacity {
  /**
   * Gets or sets the minimum.
   */
  minimum: int32;

  /**
   * Gets or sets the maximum.
   */
  maximum?: int32;

  /**
   * Gets or sets the default.
   */
  default?: int32;

  /**
   * Gets or sets the type of the scale.
   */
  scaleType?: SkuScaleType;
}

/**
 * Locations and availability zones where the SKU is available
 */
model ResourceSkuLocationInfo {
  /**
   * Gets location of the SKU
   */
  location?: string;

  /**
   * Gets list of availability zones where the SKU is supported.
   */
  zones?: string[];

  /**
   * Gets details of capabilities available to a SKU in specific zones.
   */
  zoneDetails?: ResourceSkuZoneDetails[];
}

/**
 * Details of capabilities available to a SKU in specific zones
 */
model ResourceSkuZoneDetails {
  /**
   * Gets the set of zones that the SKU is available in with the
   * specified capabilities.
   */
  name?: string[];

  /**
   * Gets a list of capabilities that are available for the SKU in the
   * specified list of zones.
   */
  capabilities?: ResourceSkuCapabilities[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ResourceSkuCapabilities {
  /**
   * Gets an invariant to describe the feature.
   */
  name?: string;

  /**
   * Gets an invariant if the feature is measured by quantity.
   */
  value?: string;
}

/**
 * Restrictions where the SKU cannot be used
 */
model ResourceSkuRestrictions {
  /**
   * Gets the type of restrictions. Possible values include: 'Location', 'Zone'
   */
  type?: ResourceSkuRestrictionsType;

  /**
   * Gets the value of restrictions. If the restriction type is set to
   * location. This would be different locations where the SKU is restricted.
   */
  values?: string[];

  /**
   * Gets the information about the restriction where the SKU cannot be used.
   */
  restrictionInfo?: ResourceSkuRestrictionInfo;

  /**
   * Gets the reason for restriction. Possible values include: 'QuotaId', 'NotAvailableForSubscription'
   */
  reasonCode?: ResourceSkuRestrictionsReasonCode;
}

/**
 * Information about the restriction where the SKU cannot be used
 */
model ResourceSkuRestrictionInfo {
  /**
   * Gets locations where the SKU is restricted
   */
  locations?: string[];

  /**
   * Gets list of availability zones where the SKU is restricted.
   */
  zones?: string[];
}

/**
 * Supported server versions.
 */
model SupportedServerVersions is Azure.Core.Page<SupportedServerVersion>;

/**
 * Supported server version.
 */
model SupportedServerVersion {
  /**
   * The raw server version value which could be passed to deployment CRUD operations.
   */
  value?: string;

  /**
   * The server name.
   */
  server?: string;

  /**
   * The Server version.
   */
  version?: string;
}

/**
 * Spring Cloud Gateway properties payload
 */
model GatewayProperties {
  /**
   * State of the Spring Cloud Gateway.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: GatewayProvisioningState;

  /**
   * Indicates whether the Spring Cloud Gateway exposes endpoint.
   */
  public?: boolean;

  /**
   * URL of the Spring Cloud Gateway, exposed when 'public' is true.
   */
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * Indicate if only https is allowed.
   */
  httpsOnly?: boolean;

  /**
   * Single sign-on related configuration
   */
  ssoProperties?: SsoProperties;

  /**
   * API metadata property for Spring Cloud Gateway
   */
  apiMetadataProperties?: GatewayApiMetadataProperties;

  /**
   * Cross-Origin Resource Sharing property
   */
  corsProperties?: GatewayCorsProperties;

  /**
   * Client-Certification Authentication.
   */
  clientAuth?: GatewayPropertiesClientAuth;

  /**
   * Collection of APM type used in Spring Cloud Gateway
   */
  apmTypes?: ApmType[];

  /**
   * Collection of ApmReferences in service level
   */
  apms?: ApmReference[];

  /**
   * Environment variables of Spring Cloud Gateway
   */
  environmentVariables?: GatewayPropertiesEnvironmentVariables;

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  resourceRequests?: GatewayResourceRequests;

  /**
   * Collection of addons for Spring Cloud Gateway
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  addonConfigs?: Record<Record<unknown>>;

  /**
   * Collection of instances belong to Spring Cloud Gateway.
   */
  @visibility(Lifecycle.Read)
  instances?: GatewayInstance[];

  /**
   * Properties of the Spring Cloud Gateway Operator.
   */
  @visibility(Lifecycle.Read)
  operatorProperties?: GatewayOperatorProperties;

  /**
   * The properties to configure different types of response cache for Spring Cloud Gateway.
   */
  responseCacheProperties?: GatewayResponseCacheProperties;
}

/**
 * Single sign-on related configuration
 */
model SsoProperties {
  /**
   * It defines the specific actions applications can be allowed to do on a user's behalf
   */
  scope?: string[];

  /**
   * The public identifier for the application
   */
  clientId?: string;

  /**
   * The secret known only to the application and the authorization server
   */
  clientSecret?: string;

  /**
   * The URI of Issuer Identifier
   */
  issuerUri?: string;
}

/**
 * API metadata property for Spring Cloud Gateway
 */
model GatewayApiMetadataProperties {
  /**
   * Title describing the context of the APIs available on the Gateway instance (default: `Spring Cloud Gateway for K8S`)
   */
  title?: string;

  /**
   * Detailed description of the APIs available on the Gateway instance (default: `Generated OpenAPI 3 document that describes the API routes configured.`)
   */
  description?: string;

  /**
   * Location of additional documentation for the APIs available on the Gateway instance
   */
  documentation?: string;

  /**
   * Version of APIs available on this Gateway instance (default: `unspecified`).
   */
  version?: string;

  /**
   * Base URL that API consumers will use to access APIs on the Gateway instance.
   */
  serverUrl?: string;
}

/**
 * Cross-Origin Resource Sharing property
 */
model GatewayCorsProperties {
  /**
   * Allowed origins to make cross-site requests. The special value `*` allows all domains.
   */
  allowedOrigins?: string[];

  /**
   * Allowed origin patterns to make cross-site requests.
   */
  allowedOriginPatterns?: string[];

  /**
   * Allowed HTTP methods on cross-site requests. The special value `*` allows all methods. If not set, `GET` and `HEAD` are allowed by default.
   */
  allowedMethods?: string[];

  /**
   * Allowed headers in cross-site requests. The special value `*` allows actual requests to send any header.
   */
  allowedHeaders?: string[];

  /**
   * How long, in seconds, the response from a pre-flight request can be cached by clients.
   */
  maxAge?: int32;

  /**
   * Whether user credentials are supported on cross-site requests. Valid values: `true`, `false`.
   */
  allowCredentials?: boolean;

  /**
   * HTTP response headers to expose for cross-site requests.
   */
  exposedHeaders?: string[];
}

/**
 * Client-Certification Authentication.
 */
model GatewayPropertiesClientAuth {
  /**
   * Collection of certificate resource Ids in Azure Spring Apps.
   */
  certificates?: string[];

  /**
   * Whether to enable certificate verification or not
   */
  certificateVerification?: GatewayCertificateVerification = GatewayCertificateVerification.Disabled;
}

/**
 * Environment variables of Spring Cloud Gateway
 */
model GatewayPropertiesEnvironmentVariables {
  /**
   * Non-sensitive properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  properties?: Record<string>;

  /**
   * Sensitive properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  secrets?: Record<string>;
}

/**
 * Resource request payload of Spring Cloud Gateway.
 */
model GatewayResourceRequests {
  /**
   * CPU allocated to each Spring Cloud Gateway instance.
   */
  cpu?: string = "1";

  /**
   * Memory allocated to each Spring Cloud Gateway instance.
   */
  memory?: string = "2Gi";
}

/**
 * Collection of instances belong to the Spring Cloud Gateway
 */
model GatewayInstance {
  /**
   * Name of the Spring Cloud Gateway instance
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the Spring Cloud Gateway instance
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * Properties of the Spring Cloud Gateway Operator.
 */
model GatewayOperatorProperties {
  /**
   * The requested resource quantity for required CPU and Memory.
   */
  @visibility(Lifecycle.Read)
  resourceRequests?: GatewayOperatorResourceRequests;

  /**
   * Collection of instances belong to Spring Cloud Gateway operator.
   */
  @visibility(Lifecycle.Read)
  instances?: GatewayInstance[];
}

/**
 * Properties of the Spring Cloud Gateway Operator.
 */
model GatewayOperatorResourceRequests {
  /**
   * CPU allocated to each Spring Cloud Gateway Operator instance.
   */
  @visibility(Lifecycle.Read)
  cpu?: string;

  /**
   * Memory allocated to each Spring Cloud Gateway Operator instance.
   */
  @visibility(Lifecycle.Read)
  memory?: string;

  /**
   * Instance count of the Spring Cloud Gateway Operator.
   */
  @visibility(Lifecycle.Read)
  instanceCount?: int32;
}

/**
 * Spring Cloud Gateway response cache properties.
 */
@discriminator("responseCacheType")
model GatewayResponseCacheProperties {
  /**
   * The type of the response cache.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  responseCacheType: string;
}

/**
 * Resource Sku object used for scaling out and scaling in.
 */
model SkuObject {
  /**
   * Sku of the Spring Cloud Gateway resource
   */
  sku?: Sku;
}

/**
 * Object that includes an array of gateway resources and a possible link for next set
 */
model GatewayResourceCollection is Azure.Core.Page<GatewayResource>;

/**
 * API route config of the Spring Cloud Gateway
 */
model GatewayRouteConfigProperties {
  /**
   * State of the Spring Cloud Gateway route config.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: GatewayProvisioningState;

  /**
   * The resource Id of the Azure Spring Apps app, required unless route defines `uri`.
   */
  appResourceId?: string;

  /**
   * OpenAPI properties of Spring Cloud Gateway route config.
   */
  openApi?: GatewayRouteConfigOpenApiProperties;

  /**
   * Protocol of routed Azure Spring Apps applications.
   */
  protocol?: GatewayRouteConfigProtocol = GatewayRouteConfigProtocol.HTTP;

  /**
   * Array of API routes, each route contains properties such as `title`, `uri`, `ssoEnabled`, `predicates`, `filters`.
   */
  routes?: GatewayApiRoute[];

  /**
   * Enable Single Sign-On in app level.
   */
  ssoEnabled?: boolean;

  /**
   * A number of conditions to evaluate a route for each request in app level. Each predicate may be evaluated against request headers and parameter values. All of the predicates associated with a route must evaluate to true for the route to be matched to the request.
   */
  predicates?: string[];

  /**
   * To modify the request before sending it to the target endpoint, or the received response in app level.
   */
  filters?: string[];
}

/**
 * OpenAPI properties of Spring Cloud Gateway route config.
 */
model GatewayRouteConfigOpenApiProperties {
  /**
   * The URI of OpenAPI specification.
   */
  uri?: string;
}

/**
 * API route config of the Spring Cloud Gateway
 */
model GatewayApiRoute {
  /**
   * A title, will be applied to methods in the generated OpenAPI documentation.
   */
  title?: string;

  /**
   * A description, will be applied to methods in the generated OpenAPI documentation.
   */
  description?: string;

  /**
   * Full uri, will override `appName`.
   */
  uri?: string;

  /**
   * Enable sso validation.
   */
  ssoEnabled?: boolean;

  /**
   * Pass currently-authenticated user's identity token to application service, default is 'false'
   */
  tokenRelay?: boolean;

  /**
   * A number of conditions to evaluate a route for each request. Each predicate may be evaluated against request headers and parameter values. All of the predicates associated with a route must evaluate to true for the route to be matched to the request.
   */
  predicates?: string[];

  /**
   * To modify the request before sending it to the target endpoint, or the received response.
   */
  filters?: string[];

  /**
   * Route processing order.
   */
  order?: int32;

  /**
   * Classification tags, will be applied to methods in the generated OpenAPI documentation.
   */
  tags?: string[];
}

/**
 * Object that includes an array of Spring Cloud Gateway route config resources and a possible link for next set
 */
model GatewayRouteConfigResourceCollection
  is Azure.Core.Page<GatewayRouteConfigResource>;

/**
 * The properties of custom domain for Spring Cloud Gateway
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model GatewayCustomDomainProperties {
  /**
   * The thumbprint of bound certificate.
   */
  thumbprint?: string;
}

/**
 * Object that includes an array of Spring Cloud Gateway custom domain resources and a possible link for next set
 */
model GatewayCustomDomainResourceCollection
  is Azure.Core.Page<GatewayCustomDomainResource>;

/**
 * API portal properties payload
 */
model ApiPortalProperties {
  /**
   * State of the API portal.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ApiPortalProvisioningState;

  /**
   * Indicates whether the API portal exposes endpoint.
   */
  public?: boolean;

  /**
   * URL of the API portal, exposed when 'public' is true.
   */
  @visibility(Lifecycle.Read)
  url?: string;

  /**
   * Indicate if only https is allowed.
   */
  httpsOnly?: boolean;

  /**
   * The array of resource Ids of gateway to integrate with API portal.
   */
  gatewayIds?: string[];

  /**
   * Collection of OpenAPI source URL locations.
   */
  sourceUrls?: string[];

  /**
   * Single sign-on related configuration
   */
  ssoProperties?: SsoProperties;

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  @visibility(Lifecycle.Read)
  resourceRequests?: ApiPortalResourceRequests;

  /**
   * Collection of instances belong to API portal.
   */
  @visibility(Lifecycle.Read)
  instances?: ApiPortalInstance[];

  /**
   * Indicates whether the API try-out feature is enabled or disabled. When enabled, users can try out the API by sending requests and viewing responses in API portal. When disabled, users cannot try out the API.
   */
  apiTryOutEnabledState?: ApiPortalApiTryOutEnabledState = ApiPortalApiTryOutEnabledState.Enabled;
}

/**
 * Resource requests of the API portal
 */
model ApiPortalResourceRequests {
  /**
   * CPU allocated to each API portal instance
   */
  @visibility(Lifecycle.Read)
  cpu?: string;

  /**
   * Memory allocated to each API portal instance
   */
  @visibility(Lifecycle.Read)
  memory?: string;
}

/**
 * Collection of instances belong to the API portal
 */
model ApiPortalInstance {
  /**
   * Name of the API portal instance
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the API portal instance
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

/**
 * Object that includes an array of API portal resources and a possible link for next set
 */
model ApiPortalResourceCollection is Azure.Core.Page<ApiPortalResource>;

/**
 * The properties of custom domain for API portal
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ApiPortalCustomDomainProperties {
  /**
   * The thumbprint of bound certificate.
   */
  thumbprint?: string;
}

/**
 * Object that includes an array of API portal custom domain resources and a possible link for next set
 */
model ApiPortalCustomDomainResourceCollection
  is Azure.Core.Page<ApiPortalCustomDomainResource>;

/**
 * Object that includes an array of application accelerator resources and a possible link for next set
 */
model ApplicationAcceleratorResourceCollection
  is Azure.Core.Page<ApplicationAcceleratorResource>;

/**
 * Application accelerator properties payload
 */
model ApplicationAcceleratorProperties {
  /**
   * State of the application accelerator.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ApplicationAcceleratorProvisioningState;

  /**
   * Collection of components belong to application accelerator.
   */
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  components?: ApplicationAcceleratorComponent[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ApplicationAcceleratorComponent {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  name?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  resourceRequests?: ApplicationAcceleratorResourceRequests;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  instances?: ApplicationAcceleratorInstance[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ApplicationAcceleratorResourceRequests {
  /**
   * CPU allocated to each application accelerator component. 1 core can be represented by 1 or 1000m
   */
  @visibility(Lifecycle.Read)
  cpu?: string;

  /**
   * Memory allocated to each application accelerator component. 1 GB can be represented by 1Gi or 1024Mi.
   */
  @visibility(Lifecycle.Read)
  memory?: string;

  /**
   * Instance count of the application accelerator component.
   */
  @visibility(Lifecycle.Read)
  instanceCount?: int32;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ApplicationAcceleratorInstance {
  /**
   * Name of the Application Accelerator instance.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Status of the Application Accelerator instance. It can be Pending, Running, Succeeded, Failed, Unknown.
   */
  @visibility(Lifecycle.Read)
  status?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model CustomizedAcceleratorResourceCollection
  is Azure.Core.Page<CustomizedAcceleratorResource>;

/**
 * Customized accelerator properties payload
 */
model CustomizedAcceleratorProperties {
  /**
   * State of the customized accelerator.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CustomizedAcceleratorProvisioningState;

  /**
   * Type of the customized accelerator.
   */
  acceleratorType?: CustomizedAcceleratorType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  displayName?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  description?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  iconUrl?: string;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  acceleratorTags?: string[];

  /**
   * Imports references all imports that this accelerator/fragment depends upon.
   */
  @visibility(Lifecycle.Read)
  imports?: string[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  gitRepository: AcceleratorGitRepository;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model AcceleratorGitRepository {
  /**
   * Git repository URL for the accelerator.
   */
  url: string;

  /**
   * Interval for checking for updates to Git or image repository.
   */
  intervalInSeconds?: int32;

  /**
   * Git repository branch to be used.
   */
  branch?: string;

  /**
   * Git repository commit to be used.
   */
  commit?: string;

  /**
   * Git repository tag to be used.
   */
  gitTag?: string;

  /**
   * Properties of the auth setting payload.
   */
  authSetting: AcceleratorAuthSetting;

  /**
   * Folder path inside the git repository to consider as the root of the accelerator or fragment.
   */
  subPath?: string;
}

/**
 * Auth setting payload.
 */
@discriminator("authType")
model AcceleratorAuthSetting {
  /**
   * The type of the auth setting.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  authType: string;
}

/**
 * Validation result for customized accelerator properties
 */
model CustomizedAcceleratorValidateResult {
  /**
   * State of the customized accelerator validation result
   */
  state?: CustomizedAcceleratorValidateResultState = CustomizedAcceleratorValidateResultState.Valid;

  /**
   * The detail validation results
   */
  errorMessage?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model PredefinedAcceleratorResourceCollection
  is Azure.Core.Page<PredefinedAcceleratorResource>;

/**
 * Predefined accelerator properties payload
 */
model PredefinedAcceleratorProperties {
  /**
   * Provisioning state of the predefined accelerator.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PredefinedAcceleratorProvisioningState;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  displayName?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  description?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  iconUrl?: string;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  @visibility(Lifecycle.Read)
  acceleratorTags?: string[];

  /**
   * State of the predefined accelerator.
   */
  state?: PredefinedAcceleratorState = PredefinedAcceleratorState.Enabled;
}

/**
 * List of Azure Spring Apps Jobs and a possible link for next set.
 */
model JobResourceCollection is Azure.Core.Page<JobResource>;

/**
 * Job resource properties payload
 */
model JobResourceProperties {
  /**
   * Provisioning state of the Job
   */
  @visibility(Lifecycle.Read)
  provisioningState?: JobResourceProvisioningState;

  /**
   * The template which is applied for all executions of the Job.
   */
  template?: JobExecutionTemplate;

  /**
   * Uploaded source information of the Job.
   */
  source?: UserSourceInfo;

  /**
   * Referenced managed components collection
   */
  managedComponentReferences?: ManagedComponentReference[];

  /**
   * The Job trigger related configuration.
   */
  triggerConfig?: JobTriggerConfig;
}

/**
 * Job's execution template, containing configuration for an execution
 */
model JobExecutionTemplate {
  /**
   * Environment variables of Job execution
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  environmentVariables?: EnvVar[];

  /**
   * Arguments for the Job execution.
   */
  args?: string[];

  /**
   * The requested resource quantity for required CPU and Memory.
   */
  resourceRequests?: JobResourceRequests;
}

/**
 * Azure Spring Apps components' environment variable.
 */
model EnvVar {
  /**
   * Environment variable name.
   */
  name?: string;

  /**
   * Non-secret environment variable value.
   */
  value?: string;

  /**
   * secret environment variable value.
   */
  secretValue?: string;
}

/**
 * Job resource request payload
 */
model JobResourceRequests {
  /**
   * CPU allocated to each job execution instance.
   */
  cpu?: string = "1";

  /**
   * Memory allocated to each job execution instance.
   */
  memory?: string = "2Gi";
}

/**
 * A reference to the managed component like Config Server.
 */
model ManagedComponentReference {
  /**
   * Resource Id of the managed component
   */
  resourceId: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AppPlatform/Spring/configServers";
    }
  ]>;
}

/**
 * Configuration for different trigger types
 */
@discriminator("triggerType")
model JobTriggerConfig {
  /**
   * Type of job trigger
   */
  triggerType: TriggerType = TriggerType.Manual;
}

/**
 * Azure Spring Apps Job execution.
 */
model JobExecution {
  /**
   * Job execution Name.
   */
  name?: string;

  /**
   * Current state of the job execution
   */
  status?: JobExecutionRunningState;

  /**
   * Job execution start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Job execution end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * The template which is applied for the execution of the Job.
   */
  template?: JobExecutionTemplate;

  /**
   * The snapshot of job configuration
   */
  jobSnapshot?: JobResourceProperties;
}

/**
 * Secret environment variable collection.
 */
model EnvSecretsCollection {
  /**
   * Collection of resources.
   */
  @OpenAPI.extension("x-ms-identifiers", #["name"])
  value: Secret[];
}

/**
 * Azure Spring App Job executions collection.
 */
model JobExecutionCollection is Azure.Core.Page<JobExecution>;

/**
 * The basic authentication properties for the container registry resource.
 */
model ContainerRegistryBasicCredentials extends ContainerRegistryCredentials {
  /**
   * The login server of the Container Registry.
   */
  server: string;

  /**
   * The username of the Container Registry.
   */
  username: string;

  /**
   * The password of the Container Registry.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  password: string;

  /**
   * The credential type of the container registry credentials.
   */
  type: "BasicAuth";
}

/**
 * Weekly planned maintenance
 */
model WeeklyMaintenanceScheduleConfiguration
  extends MaintenanceScheduleConfiguration {
  /**
   * The hour to run the maintenance job
   */
  @maxValue(23)
  hour: int32;

  /**
   * The duration time to run the maintenance job, specified in ISO8601 format, e.g. PT8H
   */
  @visibility(Lifecycle.Read)
  duration?: string;

  /**
   * The day to run the maintenance job
   */
  day: WeekDay;

  /**
   * The frequency to run the maintenance job
   */
  frequency: "Weekly";
}

/**
 * Properties of certificate imported from key vault.
 */
model KeyVaultCertificateProperties extends CertificateProperties {
  /**
   * The vault uri of user key vault.
   */
  vaultUri: string;

  /**
   * The certificate name of key vault.
   */
  keyVaultCertName: string;

  /**
   * The certificate version of key vault.
   */
  certVersion?: string;

  /**
   * Optional. If set to true, it will not import private key from key vault.
   */
  excludePrivateKey?: boolean;

  /**
   * Indicates whether to automatically synchronize certificate from key vault or not.
   */
  autoSync?: KeyVaultCertificateAutoSync = KeyVaultCertificateAutoSync.Disabled;

  /**
   * The type of the certificate source.
   */
  type: "KeyVaultCertificate";
}

/**
 * Properties of certificate imported from key vault.
 */
model ContentCertificateProperties extends CertificateProperties {
  /**
   * The content of uploaded certificate.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  content?: string;

  /**
   * The type of the certificate source.
   */
  type: "ContentCertificate";
}

/**
 * storage resource of type Azure Storage Account.
 */
model StorageAccount extends StorageProperties {
  /**
   * The account name of the Azure Storage Account.
   */
  accountName: string;

  /**
   * The account key of the Azure Storage Account.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  accountKey: string;

  /**
   * The type of the storage.
   */
  storageType: "StorageAccount";
}

/**
 * The properties of the Azure File volume. Azure File shares are mounted as volumes.
 */
model AzureFileVolume extends CustomPersistentDiskProperties {
  /**
   * The share name of the Azure File share.
   */
  shareName?: string;

  /**
   * The type of the underlying resource to mount as a persistent disk.
   */
  type: "AzureFileVolume";
}

/**
 * Source with uploaded location
 */
@discriminator("type")
model UploadedUserSourceInfo extends UserSourceInfo {
  /**
   * Relative path of the storage which stores the source
   */
  relativePath?: string;
}

/**
 * Uploaded Jar binary for a deployment
 */
model JarUploadedUserSourceInfo extends UploadedUserSourceInfo {
  /**
   * Runtime version of the Jar file
   */
  runtimeVersion?: string;

  /**
   * JVM parameter
   */
  jvmOptions?: string;

  /**
   * Type of the source uploaded
   */
  type: "Jar";
}

/**
 * Uploaded War binary for a deployment
 */
model WarUploadedUserSourceInfo extends UploadedUserSourceInfo {
  /**
   * Runtime version of the war file
   */
  runtimeVersion?: string;

  /**
   * JVM parameter
   */
  jvmOptions?: string;

  /**
   * Server version, currently only Apache Tomcat is supported
   */
  serverVersion?: string;

  /**
   * Type of the source uploaded
   */
  type: "War";
}

/**
 * Uploaded Java source code binary for a deployment
 */
model SourceUploadedUserSourceInfo extends UploadedUserSourceInfo {
  /**
   * Selector for the artifact to be used for the deployment for multi-module projects. This should be
   * the relative path to the target module/project.
   */
  artifactSelector?: string;

  /**
   * Runtime version of the source file
   */
  runtimeVersion?: string;

  /**
   * Type of the source uploaded
   */
  type: "Source";
}

/**
 * Uploaded Jar binary for a deployment
 */
model NetCoreZipUploadedUserSourceInfo extends UploadedUserSourceInfo {
  /**
   * The path to the .NET executable relative to zip root
   */
  netCoreMainEntryPath?: string;

  /**
   * Runtime version of the .Net file
   */
  runtimeVersion?: string;

  /**
   * Type of the source uploaded
   */
  type: "NetCoreZip";
}

/**
 * Reference to a build result
 */
model BuildResultUserSourceInfo extends UserSourceInfo {
  /**
   * Resource id of an existing succeeded build result under the same Spring instance.
   */
  buildResultId?: string;

  /**
   * Type of the source uploaded
   */
  type: "BuildResult";
}

/**
 * Custom container user source info
 */
model CustomContainerUserSourceInfo extends UserSourceInfo {
  /**
   * Custom container payload
   */
  customContainer?: CustomContainer;

  /**
   * Type of the source uploaded
   */
  type: "Container";
}

/**
 * Custom container payload
 */
model CustomContainer {
  /**
   * The name of the registry that contains the container image
   */
  server?: string;

  /**
   * Container image of the custom container. This should be in the form of <repository>:<tag> without the server name of the registry
   */
  containerImage?: string;

  /**
   * Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided.
   */
  command?: string[];

  /**
   * Arguments to the entrypoint. The docker image's CMD is used if this is not provided.
   */
  args?: string[];

  /**
   * Credential of the image registry
   */
  imageRegistryCredential?: ImageRegistryCredential;

  /**
   * Language framework of the container image uploaded. Supported values: "springboot", "", null.
   */
  languageFramework?: string;
}

/**
 * Credential of the image registry
 */
model ImageRegistryCredential {
  /**
   * The username of the image registry credential
   */
  username?: string;

  /**
   * The password of the image registry credential
   */
  password?: string;
}

/**
 * HTTPGetAction describes an action based on HTTP Get requests.
 */
model HttpGetAction extends ProbeAction {
  /**
   * Path to access on the HTTP server.
   */
  path?: string;

  /**
   * Scheme to use for connecting to the host. Defaults to HTTP.
   *
   * Possible enum values:
   *  - `"HTTP"` means that the scheme used will be http://
   *  - `"HTTPS"` means that the scheme used will be https://
   */
  scheme?: HttpSchemeType;

  /**
   * The type of the action to take to perform the health check.
   */
  type: "HTTPGetAction";
}

/**
 * ExecAction describes a "run in container" action.
 */
model ExecAction extends ProbeAction {
  /**
   * Command is the command line to execute inside the container, the working directory for the command is root ('/') in the container's filesystem. The command is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  command?: string[];

  /**
   * The type of the action to take to perform the health check.
   */
  type: "ExecAction";
}

/**
 * TCPSocketAction describes an action based on opening a socket
 */
model TCPSocketAction extends ProbeAction {
  /**
   * The type of the action to take to perform the health check.
   */
  type: "TCPSocketAction";
}

/**
 * Spring Cloud Gateway local response cache per route properties.
 */
model GatewayLocalResponseCachePerRouteProperties
  extends GatewayResponseCacheProperties {
  /**
   * Maximum size of cache (10MB, 900KB, 1GB...) to determine if the cache needs to evict some entries.
   */
  size?: string;

  /**
   * Time before a cached entry is expired (300s, 5m, 1h...)
   */
  timeToLive?: string;

  /**
   * The type of the response cache.
   */
  responseCacheType: "LocalCachePerRoute";
}

/**
 * Spring Cloud Gateway local response cache per instance properties.
 */
model GatewayLocalResponseCachePerInstanceProperties
  extends GatewayResponseCacheProperties {
  /**
   * Maximum size of cache (10MB, 900KB, 1GB...) to determine if the cache needs to evict some entries
   */
  size?: string;

  /**
   * Time before a cached entry is expired (300s, 5m, 1h...)
   */
  timeToLive?: string;

  /**
   * The type of the response cache.
   */
  responseCacheType: "LocalCachePerInstance";
}

/**
 * Auth setting for public url.
 */
model AcceleratorPublicSetting extends AcceleratorAuthSetting {
  /**
   * Resource Id of CA certificate for https URL of Git repository.
   */
  caCertResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AppPlatform/Spring/certificates";
    }
  ]>;

  /**
   * The type of the auth setting.
   */
  authType: "Public";
}

/**
 * Auth setting for basic auth.
 */
model AcceleratorBasicAuthSetting extends AcceleratorAuthSetting {
  /**
   * Resource Id of CA certificate for https URL of Git repository.
   */
  caCertResourceId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.AppPlatform/Spring/certificates";
    }
  ]>;

  /**
   * Username of git repository basic auth.
   */
  username: string;

  /**
   * Password of git repository basic auth.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  password?: string;

  /**
   * The type of the auth setting.
   */
  authType: "BasicAuth";
}

/**
 * Auth setting for SSH auth.
 */
model AcceleratorSshSetting extends AcceleratorAuthSetting {
  /**
   * Public SSH Key of git repository.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  hostKey?: string;

  /**
   * SSH Key algorithm of git repository.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  hostKeyAlgorithm?: string;

  /**
   * Private SSH Key algorithm of git repository.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  privateKey?: string;

  /**
   * The type of the auth setting.
   */
  authType: "SSH";
}

/**
 * Configuration for manual triggered job
 */
model ManualJobTriggerConfig extends JobTriggerConfig {
  /**
   * Number of parallel replicas of a job execution can run.
   */
  parallelism?: int32;

  /**
   * Maximum number of seconds an execution is allowed to run.
   */
  timeoutInSeconds?: int32;

  /**
   * Maximum number of retries before failing the job.
   */
  retryLimit?: int32;

  /**
   * Type of job trigger
   */
  triggerType: "Manual";
}

import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.MachineLearningCompute;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The provision state of the cluster. Valid values are Unknown, Updating, Provisioning, Succeeded, and Failed.
 */
enum OperationStatus {
  Unknown,
  Updating,
  Creating,
  Deleting,
  Succeeded,
  Failed,
  Canceled,
}

/**
 * The cluster type.
 */
enum ClusterType {
  ACS,
  Local,
}

/**
 * Type of orchestrator. It cannot be changed once the cluster is created.
 */
enum OrchestratorType {
  Kubernetes,
  None,
}

/**
 * The system service type
 */
enum SystemServiceType {
  None,
  ScoringFrontEnd,
  BatchFrontEnd,
}

/**
 * The Azure VM size of the agent VM nodes. This cannot be changed once the cluster is created. This list is non exhaustive; refer to https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes for the possible VM sizes.
 */
enum AgentVMSizeTypes {
  Standard_A0,
  Standard_A1,
  Standard_A2,
  Standard_A3,
  Standard_A4,
  Standard_A5,
  Standard_A6,
  Standard_A7,
  Standard_A8,
  Standard_A9,
  Standard_A10,
  Standard_A11,
  Standard_D1,
  Standard_D2,
  Standard_D3,
  Standard_D4,
  Standard_D11,
  Standard_D12,
  Standard_D13,
  Standard_D14,
  Standard_D1_v2,
  Standard_D2_v2,
  Standard_D3_v2,
  Standard_D4_v2,
  Standard_D5_v2,
  Standard_D11_v2,
  Standard_D12_v2,
  Standard_D13_v2,
  Standard_D14_v2,
  Standard_G1,
  Standard_G2,
  Standard_G3,
  Standard_G4,
  Standard_G5,
  Standard_DS1,
  Standard_DS2,
  Standard_DS3,
  Standard_DS4,
  Standard_DS11,
  Standard_DS12,
  Standard_DS13,
  Standard_DS14,
  Standard_GS1,
  Standard_GS2,
  Standard_GS3,
  Standard_GS4,
  Standard_GS5,
}

/**
 * SSL status. Allowed values are Enabled and Disabled.
 */
enum Status {
  Enabled,
  Disabled,
}

/**
 * Yes if updates are available for the system services, No if not.
 */
enum UpdatesAvailable {
  Yes,
  No,
}

/**
 * Properties of an operationalization cluster
 */
model OperationalizationClusterProperties {
  /**
   * The description of the cluster.
   */
  description?: string;

  /**
   * The date and time when the cluster was created.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * The date and time when the cluster was last modified.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  /**
   * The provision state of the cluster. Valid values are Unknown, Updating, Provisioning, Succeeded, and Failed.
   */
  @visibility("read")
  provisioningState?: OperationStatus;

  /**
   * List of provisioning errors reported by the resource provider.
   */
  @visibility("read")
  provisioningErrors?: ErrorResponseWrapper[];

  /**
   * The cluster type.
   */
  clusterType: ClusterType;

  /**
   * Storage Account properties.
   */
  storageAccount?: StorageAccountProperties;

  /**
   * Container Registry properties.
   */
  containerRegistry?: ContainerRegistryProperties;

  /**
   * Parameters for the Azure Container Service cluster.
   */
  containerService?: AcsClusterProperties;

  /**
   * AppInsights configuration.
   */
  appInsights?: AppInsightsProperties;

  /**
   * Contains global configuration for the web services in the cluster.
   */
  globalServiceConfiguration?: GlobalServiceConfiguration;
}

/**
 * Wrapper for error response to follow ARM guidelines.
 */
@error
model ErrorResponseWrapper {
  /**
   * The error response.
   */
  error?: ErrorResponse;
}

/**
 * Properties of Storage Account.
 */
model StorageAccountProperties {
  /**
   * ARM resource ID of the Azure Storage Account to store CLI specific files. If not provided one will be created. This cannot be changed once the cluster is created.
   */
  resourceId?: string;
}

/**
 * Properties of Azure Container Registry.
 */
model ContainerRegistryProperties {
  /**
   * ARM resource ID of the Azure Container Registry used to store Docker images for web services in the cluster. If not provided one will be created. This cannot be changed once the cluster is created.
   */
  resourceId?: string;
}

/**
 * Information about the container service backing the cluster
 */
model AcsClusterProperties {
  /**
   * The FQDN of the cluster.
   */
  @visibility("read")
  clusterFqdn?: string;

  /**
   * Type of orchestrator. It cannot be changed once the cluster is created.
   */
  orchestratorType: OrchestratorType;

  /**
   * Orchestrator specific properties
   */
  orchestratorProperties?: KubernetesClusterProperties;

  /**
   * The system services deployed to the cluster
   */
  systemServices?: SystemService[];

  /**
   * The number of master nodes in the container service.
   */
  @maxValue(5)
  @minValue(1)
  masterCount?: int32 = 1;

  /**
   * The number of agent nodes in the Container Service. This can be changed to scale the cluster.
   */
  @maxValue(100)
  @minValue(1)
  agentCount?: int32 = 2;

  /**
   * The Azure VM size of the agent VM nodes. This cannot be changed once the cluster is created. This list is non exhaustive; refer to https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes for the possible VM sizes.
   */
  agentVmSize?: AgentVMSizeTypes = AgentVMSizeTypes.Standard_D3_v2;
}

/**
 * Kubernetes cluster specific properties
 */
model KubernetesClusterProperties {
  /**
   * The Azure Service Principal used by Kubernetes
   */
  servicePrincipal?: ServicePrincipalProperties;
}

/**
 * The Azure service principal used by Kubernetes for configuring load balancers
 */
model ServicePrincipalProperties {
  /**
   * The service principal client ID
   */
  clientId: string;

  /**
   * The service principal secret. This is not returned in response of GET/PUT on the resource. To see this please call listKeys.
   */
  secret: string;
}

/**
 * Information about a system service deployed in the cluster
 */
model SystemService {
  /**
   * The system service type
   */
  systemServiceType: SystemServiceType;

  /**
   * The public IP address of the system service
   */
  @visibility("read")
  publicIpAddress?: string;

  /**
   * The state of the system service
   */
  @visibility("read")
  version?: string;
}

/**
 * Properties of App Insights.
 */
model AppInsightsProperties {
  /**
   * ARM resource ID of the App Insights.
   */
  resourceId?: string;
}

/**
 * Global configuration for services in the cluster.
 */
model GlobalServiceConfiguration extends Record<Record<unknown>> {
  /**
   * The configuration ETag for updates.
   */
  etag?: string;

  /**
   * The SSL configuration properties
   */
  ssl?: SslConfiguration;

  /**
   * Optional global authorization keys for all user services deployed in cluster. These are used if the service does not have auth keys.
   */
  serviceAuth?: ServiceAuthConfiguration;

  /**
   * The auto-scale configuration
   */
  autoScale?: AutoScaleConfiguration;
}

/**
 * SSL configuration. If configured data-plane calls to user services will be exposed over SSL only.
 */
model SslConfiguration {
  /**
   * SSL status. Allowed values are Enabled and Disabled.
   */
  status?: Status;

  /**
   * The SSL cert data in PEM format.
   */
  cert?: string;

  /**
   * The SSL key data in PEM format. This is not returned in response of GET/PUT on the resource. To see this please call listKeys API.
   */
  key?: string;

  /**
   * The CName of the certificate.
   */
  cname?: string;
}

/**
 * Global service auth configuration properties. These are the data-plane authorization keys and are used if a service doesn't define it's own.
 */
model ServiceAuthConfiguration {
  /**
   * The primary auth key hash. This is not returned in response of GET/PUT on the resource.. To see this please call listKeys API.
   */
  primaryAuthKeyHash: string;

  /**
   * The secondary auth key hash. This is not returned in response of GET/PUT on the resource.. To see this please call listKeys API.
   */
  secondaryAuthKeyHash: string;
}

/**
 * AutoScale configuration properties.
 */
model AutoScaleConfiguration {
  /**
   * If auto-scale is enabled for all services. Each service can turn it off individually.
   */
  status?: Status;

  /**
   * The minimum number of replicas for each service.
   */
  @minValue(1)
  minReplicas?: int32 = 1;

  /**
   * The maximum number of replicas for each service.
   */
  @minValue(1)
  maxReplicas?: int32 = 100;

  /**
   * The target utilization.
   */
  targetUtilization?: float32;

  /**
   * Refresh period in seconds.
   */
  refreshPeriodInSeconds?: int32;
}

/**
 * Azure resource
 */
model Resource {
  /**
   * Specifies the resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * Specifies the name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * Specifies the location of the resource.
   */
  @visibility("read", "create")
  location: string;

  /**
   * Specifies the type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Contains resource tags defined as key/value pairs.
   */
  tags?: Record<string>;
}

/**
 * Parameters for PATCH operation on an operationalization cluster
 */
model OperationalizationClusterUpdateParameters {
  /**
   * Gets or sets a list of key value pairs that describe the resource. These tags can be used in viewing and grouping this resource (across resource groups). A maximum of 15 tags can be provided for a resource. Each tag must have a key no greater in length than 128 characters and a value no greater in length than 256 characters.
   */
  tags?: Record<string>;
}

/**
 * Credentials to resources in the cluster.
 */
model OperationalizationClusterCredentials {
  /**
   * Credentials for the Storage Account.
   */
  storageAccount?: StorageAccountCredentials;

  /**
   * Credentials for Azure Container Registry.
   */
  containerRegistry?: ContainerRegistryCredentials;

  /**
   * Credentials for Azure Container Service.
   */
  containerService?: ContainerServiceCredentials;

  /**
   * Credentials for Azure AppInsights.
   */
  appInsights?: AppInsightsCredentials;

  /**
   * Global authorization keys for all user services deployed in cluster. These are used if the service does not have auth keys.
   */
  serviceAuthConfiguration?: ServiceAuthConfiguration;

  /**
   * The SSL configuration for the services.
   */
  sslConfiguration?: SslConfiguration;
}

/**
 * Access information for the storage account.
 */
model StorageAccountCredentials {
  /**
   * The ARM resource ID of the storage account.
   */
  @visibility("read")
  resourceId?: string;

  /**
   * The primary key of the storage account.
   */
  @visibility("read")
  primaryKey?: string;

  /**
   * The secondary key of the storage account.
   */
  @visibility("read")
  secondaryKey?: string;
}

/**
 * Information about the Azure Container Registry which contains the images deployed to the cluster.
 */
model ContainerRegistryCredentials {
  /**
   * The ACR login server name. User name is the first part of the FQDN.
   */
  @visibility("read")
  loginServer?: string;

  /**
   * The ACR primary password.
   */
  @visibility("read")
  password?: string;

  /**
   * The ACR secondary password.
   */
  @visibility("read")
  password2?: string;

  /**
   * The ACR login username.
   */
  @visibility("read")
  username?: string;
}

/**
 * Information about the Azure Container Registry which contains the images deployed to the cluster.
 */
model ContainerServiceCredentials {
  /**
   * The ACS kube config file.
   */
  @visibility("read")
  acsKubeConfig?: string;

  /**
   * Service principal configuration used by Kubernetes.
   */
  @visibility("read")
  servicePrincipalConfiguration?: ServicePrincipalProperties;

  /**
   * The ACR image pull secret name which was created in Kubernetes.
   */
  @visibility("read")
  imagePullSecretName?: string;
}

/**
 * AppInsights credentials.
 */
model AppInsightsCredentials {
  /**
   * The AppInsights application ID.
   */
  appId?: string;

  /**
   * The AppInsights instrumentation key. This is not returned in response of GET/PUT on the resource. To see this please call listKeys API.
   */
  instrumentationKey?: string;
}

/**
 * Information about updates available for system services in a cluster.
 */
model CheckSystemServicesUpdatesAvailableResponse {
  /**
   * Yes if updates are available for the system services, No if not.
   */
  @visibility("read")
  updatesAvailable?: UpdatesAvailable;
}

/**
 * Response of the update system services API
 */
model UpdateSystemServicesResponse {
  /**
   * Update status
   */
  @visibility("read")
  updateStatus?: OperationStatus;

  /**
   * The date and time when the last system services update was started.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updateStartedOn?: utcDateTime;

  /**
   * The date and time when the last system services update completed.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updateCompletedOn?: utcDateTime;
}

/**
 * Resource operation.
 */
model ResourceOperation {
  /**
   * Name of this operation.
   */
  name?: string;

  /**
   * Display of the operation.
   */
  display?: ResourceOperationDisplay;

  /**
   * The operation origin.
   */
  origin?: string;
}

/**
 * Display of the operation.
 */
model ResourceOperationDisplay {
  /**
   * The resource provider name.
   */
  provider?: string;

  /**
   * The resource name.
   */
  resource?: string;

  /**
   * The operation.
   */
  operation?: string;

  /**
   * The description of the operation.
   */
  description?: string;
}

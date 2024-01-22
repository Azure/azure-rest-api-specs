import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.HealthcareApis;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The provisioning state.
 */
enum ProvisioningState {
  Deleting,
  Succeeded,
  Creating,
  Accepted,
  Verifying,
  Updating,
  Failed,
  Canceled,
  Deprovisioned,
  Moving,
  Suspended,
  Warned,
  SystemMaintenance,
}

/**
 * The private endpoint connection status.
 */
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

/**
 * The current provisioning state.
 */
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

/**
 * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * Type of identity being specified, currently SystemAssigned and None are allowed.
 */
enum ManagedServiceIdentityType {
  SystemAssigned,
  None,
}

/**
 * Indicates the current status of event support for the resource.
 */
enum ServiceEventState {
  Disabled,
  Enabled,
  Updating,
}

/**
 * Type of identity being specified, currently SystemAssigned and None are allowed.
 */
enum ServiceManagedIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * The type of IoT identity resolution to use with the destination.
 */
enum IotIdentityResolutionType {
  Create,
  Lookup,
}

/**
 * The kind of the service.
 */
enum FhirServiceKind {
  `fhir-Stu3`,
  `fhir-R4`,
}

/**
 * Controls how resources are versioned on the FHIR service
 */
enum FhirResourceVersionPolicy {
  `no-version`,
  versioned,
  `versioned-update`,
}

/**
 * The status of the operation being performed.
 */
enum OperationResultStatus {
  Canceled,
  Succeeded,
  Failed,
  Requested,
  Running,
}

/**
 * The kind of the service.
 */
@fixed
enum Kind {
  fhir,
  `fhir-Stu3`,
  `fhir-R4`,
}

/**
 * The reason for unavailability.
 */
@fixed
enum ServiceNameUnavailabilityReason {
  Invalid,
  AlreadyExists,
}

/**
 * The properties of a service instance.
 */
model ServicesProperties {
  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The access policies of the service instance.
   */
  accessPolicies?: ServiceAccessPolicyEntry[];

  /**
   * The settings for the Cosmos DB database backing the service.
   */
  cosmosDbConfiguration?: ServiceCosmosDbConfigurationInfo;

  /**
   * The authentication configuration for the service instance.
   */
  authenticationConfiguration?: ServiceAuthenticationConfigurationInfo;

  /**
   * The settings for the CORS configuration of the service instance.
   */
  corsConfiguration?: ServiceCorsConfigurationInfo;

  /**
   * The settings for the export operation of the service instance.
   */
  exportConfiguration?: ServiceExportConfigurationInfo;

  /**
   * The list of private endpoint connections that are set up for this resource.
   */
  privateEndpointConnections?: PrivateEndpointConnectionDescription[];

  /**
   * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * The azure container registry settings used for convert data operation of the service instance.
   */
  acrConfiguration?: ServiceAcrConfigurationInfo;

  /**
   * The settings for the import operation of the service instance.
   */
  importConfiguration?: ServiceImportConfigurationInfo;
}

/**
 * An access policy entry.
 */
model ServiceAccessPolicyEntry {
  /**
   * An Azure AD object ID (User or Apps) that is allowed access to the FHIR service.
   */
  @pattern("^(([0-9A-Fa-f]{8}[-]?(?:[0-9A-Fa-f]{4}[-]?){3}[0-9A-Fa-f]{12}){1})+$")
  objectId: string;
}

/**
 * The settings for the Cosmos DB database backing the service.
 */
model ServiceCosmosDbConfigurationInfo {
  /**
   * The provisioned throughput for the backing database.
   */
  @minValue(400)
  offerThroughput?: int32;

  /**
   * The URI of the customer-managed key for the backing database.
   */
  keyVaultKeyUri?: string;

  /**
   * The multi-tenant application id used to enable CMK access for services in a data sovereign region.
   */
  @pattern("^(([0-9A-Fa-f]{8}[-]?(?:[0-9A-Fa-f]{4}[-]?){3}[0-9A-Fa-f]{12}){1})+$")
  crossTenantCmkApplicationId?: string;
}

/**
 * Authentication configuration information
 */
model ServiceAuthenticationConfigurationInfo {
  /**
   * The authority url for the service
   */
  authority?: string;

  /**
   * The audience url for the service
   */
  audience?: string;

  /**
   * If the SMART on FHIR proxy is enabled
   */
  smartProxyEnabled?: boolean;
}

/**
 * The settings for the CORS configuration of the service instance.
 */
model ServiceCorsConfigurationInfo {
  /**
   * The origins to be allowed via CORS.
   */
  origins?: string[];

  /**
   * The headers to be allowed via CORS.
   */
  headers?: string[];

  /**
   * The methods to be allowed via CORS.
   */
  methods?: string[];

  /**
   * The max age to be allowed via CORS.
   */
  @maxValue(99999)
  maxAge?: int32;

  /**
   * If credentials are allowed via CORS.
   */
  allowCredentials?: boolean;
}

/**
 * Export operation configuration information
 */
model ServiceExportConfigurationInfo {
  /**
   * The name of the default export storage account.
   */
  storageAccountName?: string;
}

/**
 * The Private Endpoint Connection resource.
 */
model DummyPrivateEndpointConnection extends Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateEndpointConnectionProperties;
}

/**
 * Properties of the PrivateEndpointConnectProperties.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility("read")
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
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
}

/**
 * Azure container registry configuration information
 */
model ServiceAcrConfigurationInfo {
  /**
   * The list of the ACR login servers.
   */
  loginServers?: string[];

  /**
   * The list of Open Container Initiative (OCI) artifacts.
   */
  ociArtifacts?: ServiceOciArtifactEntry[];
}

/**
 * An Open Container Initiative (OCI) artifact.
 */
model ServiceOciArtifactEntry {
  /**
   * The Azure Container Registry login server.
   */
  loginServer?: string;

  /**
   * The artifact name.
   */
  imageName?: string;

  /**
   * The artifact digest.
   */
  digest?: string;
}

/**
 * Import operation configuration information
 */
model ServiceImportConfigurationInfo {
  /**
   * The name of the default integration storage account.
   */
  integrationDataStore?: string;

  /**
   * If the FHIR service is in InitialImportMode.
   */
  initialImportMode?: boolean;

  /**
   * If the import operation is enabled.
   */
  enabled?: boolean;
}

/**
 * The common properties of a service.
 */
model ServicesResource {
  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource name.
   */
  @visibility("read")
  @pattern("^[a-z0-9][a-z0-9-]{1,21}[a-z0-9]$")
  name?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * The kind of the service.
   */
  kind: Kind;

  /**
   * The resource location.
   */
  @visibility("read", "create")
  location: string;

  /**
   * The resource tags.
   */
  tags?: Record<string>;

  /**
   * An etag associated with the resource, used for optimistic concurrency when editing it.
   */
  etag?: string;

  /**
   * Setting indicating whether the service has a managed identity associated with it.
   */
  identity?: ServicesResourceIdentity;
}

/**
 * Setting indicating whether the service has a managed identity associated with it.
 */
model ServicesResourceIdentity {
  /**
   * The principal ID of the resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of the resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * Type of identity being specified, currently SystemAssigned and None are allowed.
   */
  type?: ManagedServiceIdentityType;
}

/**
 * Error details.
 */
@error
model ErrorDetails {
  /**
   * Error details
   */
  error?: ErrorDetailsInternal;
}

/**
 * Error details.
 */
model ErrorDetailsInternal {
  /**
   * The error code.
   */
  @visibility("read")
  code?: string;

  /**
   * The error message.
   */
  @visibility("read")
  message?: string;

  /**
   * The target of the particular error.
   */
  @visibility("read")
  target?: string;
}

/**
 * The description of the service.
 */
model ServicesPatchDescription {
  /**
   * Instance tags
   */
  tags?: Record<string>;

  /**
   * The properties for updating a service instance.
   */
  properties?: ServicesPropertiesUpdateParameters;
}

/**
 * The properties for updating a service instance.
 */
model ServicesPropertiesUpdateParameters {
  /**
   * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * Input values.
 */
model CheckNameAvailabilityParameters {
  /**
   * The name of the service instance to check.
   */
  name: string;

  /**
   * The fully qualified resource type which includes provider namespace.
   */
  type: string;
}

/**
 * The properties indicating whether a given service name is available.
 */
model ServicesNameAvailabilityInfo {
  /**
   * The value which indicates whether the provided name is available.
   */
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * The reason for unavailability.
   */
  @visibility("read")
  reason?: ServiceNameUnavailabilityReason;

  /**
   * The detailed reason message.
   */
  message?: string;
}

/**
 * A private link resource
 */
model DummyPrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Workspaces resource specific properties.
 */
model WorkspaceProperties {
  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The list of private endpoint connections that are set up for this resource.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionDescription[];

  /**
   * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * The common properties of tracked resources in the service.
 */
model TaggedResource {
  ...ResourceTags;
  ...LocationBasedResource;
}

/**
 * List of key value pairs that describe the resource. This will overwrite the existing tags.
 */
model ResourceTags {
  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

/**
 * The common properties for any location based resource, tracked or proxy.
 */
model LocationBasedResource extends ResourceCore {
  /**
   * The resource location.
   */
  @visibility("read", "create")
  location?: string;
}

/**
 * The common properties for any resource, tracked or proxy.
 */
model ResourceCore {
  /**
   * The resource identifier.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource name.
   */
  @visibility("read")
  @pattern("^[a-z0-9][a-z0-9-]{1,21}[a-z0-9]$")
  name?: string;

  /**
   * The resource type.
   */
  @visibility("read")
  type?: string;

  /**
   * An etag associated with the resource, used for optimistic concurrency when editing it.
   */
  etag?: string;
}

/**
 * Workspace patch properties
 */
model WorkspacePatchResource extends ResourceTags {}

/**
 * Error details.
 */
@error
model Error {
  /**
   * Error details
   */
  error?: ErrorDetailsInternal;
}

/**
 * Dicom Service properties.
 */
model DicomServiceProperties {
  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Dicom Service authentication configuration.
   */
  authenticationConfiguration?: DicomServiceAuthenticationConfiguration;

  /**
   * Dicom Service Cors configuration.
   */
  corsConfiguration?: CorsConfiguration;

  /**
   * The url of the Dicom Services.
   */
  @visibility("read")
  serviceUrl?: string;

  /**
   * The list of private endpoint connections that are set up for this resource.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionDescription[];

  /**
   * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * DICOM Service event support status.
   */
  @visibility("read")
  eventState?: ServiceEventState;

  /**
   * The encryption settings of the DICOM service
   */
  encryption?: Encryption;
}

/**
 * Authentication configuration information
 */
model DicomServiceAuthenticationConfiguration {
  /**
   * The authority url for the service
   */
  @visibility("read")
  authority?: string;

  /**
   * The audiences for the service
   */
  @visibility("read")
  audiences?: string[];
}

/**
 * The settings for the CORS configuration of the service instance.
 */
model CorsConfiguration {
  /**
   * The origins to be allowed via CORS.
   */
  origins?: string[];

  /**
   * The headers to be allowed via CORS.
   */
  headers?: string[];

  /**
   * The methods to be allowed via CORS.
   */
  methods?: string[];

  /**
   * The max age to be allowed via CORS.
   */
  @maxValue(99999)
  maxAge?: int32;

  /**
   * If credentials are allowed via CORS.
   */
  allowCredentials?: boolean;
}

/**
 * Settings to encrypt a service
 */
model Encryption {
  /**
   * The encryption settings for the customer-managed key
   */
  customerManagedKeyEncryption?: EncryptionCustomerManagedKeyEncryption;
}

/**
 * The encryption settings for the customer-managed key
 */
model EncryptionCustomerManagedKeyEncryption {
  /**
   * The URL of the key to use for encryption
   */
  keyEncryptionKeyUrl?: string;
}

/**
 * Managed service identity (system assigned and/or user assigned identities)
 */
model ServiceManagedIdentity {
  /**
   * Setting indicating whether the service has a managed identity associated with it.
   */
  identity?: ServiceManagedIdentityIdentity;
}

/**
 * Setting indicating whether the service has a managed identity associated with it.
 */
model ServiceManagedIdentityIdentity {
  /**
   * Type of identity being specified, currently SystemAssigned and None are allowed.
   */
  type: ServiceManagedIdentityType;

  /**
   * The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * Dicom Service patch properties
 */
model DicomServicePatchResource {
  ...ResourceTags;
  ...ServiceManagedIdentity;
}

/**
 * IoT Connector properties.
 */
model IotConnectorProperties {
  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Source configuration.
   */
  ingestionEndpointConfiguration?: IotEventHubIngestionEndpointConfiguration;

  /**
   * Device Mappings.
   */
  deviceMapping?: IotMappingProperties;
}

/**
 * Event Hub ingestion endpoint configuration
 */
model IotEventHubIngestionEndpointConfiguration {
  /**
   * Event Hub name to connect to.
   */
  eventHubName?: string;

  /**
   * Consumer group of the event hub to connected to.
   */
  consumerGroup?: string;

  /**
   * Fully qualified namespace of the Event Hub to connect to.
   */
  fullyQualifiedEventHubNamespace?: string;
}

/**
 * The mapping content.
 */
model IotMappingProperties {
  /**
   * The mapping.
   */
  content?: Record<unknown>;
}

/**
 * Iot Connector patch properties
 */
model IotConnectorPatchResource {
  ...ResourceTags;
  ...ServiceManagedIdentity;
}

/**
 * IoT Connector destination properties for an Azure FHIR service.
 */
model IotFhirDestinationProperties extends IotDestinationProperties {
  /**
   * Determines how resource identity is resolved on the destination.
   */
  resourceIdentityResolutionType: IotIdentityResolutionType;

  /**
   * Fully qualified resource id of the FHIR service to connect to.
   */
  fhirServiceResourceId: string;

  /**
   * FHIR Mappings
   */
  fhirMapping: IotMappingProperties;
}

/**
 * Common IoT Connector destination properties.
 */
model IotDestinationProperties {
  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * Fhir Service properties.
 */
model FhirServiceProperties {
  /**
   * The provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Fhir Service Azure container registry configuration.
   */
  acrConfiguration?: FhirServiceAcrConfiguration;

  /**
   * Fhir Service authentication configuration.
   */
  authenticationConfiguration?: FhirServiceAuthenticationConfiguration;

  /**
   * Fhir Service Cors configuration.
   */
  corsConfiguration?: FhirServiceCorsConfiguration;

  /**
   * Fhir Service export configuration.
   */
  exportConfiguration?: FhirServiceExportConfiguration;

  /**
   * The list of private endpoint connections that are set up for this resource.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionDescription[];

  /**
   * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Fhir Service event support status.
   */
  @visibility("read")
  eventState?: ServiceEventState;

  /**
   * Determines tracking of history for resources.
   */
  resourceVersionPolicyConfiguration?: ResourceVersionPolicyConfiguration;

  /**
   * Fhir Service import configuration.
   */
  importConfiguration?: FhirServiceImportConfiguration;

  /**
   * Implementation Guides configuration.
   */
  implementationGuidesConfiguration?: ImplementationGuidesConfiguration;

  /**
   * The encryption settings of the FHIR service
   */
  encryption?: Encryption;
}

/**
 * Azure container registry configuration information
 */
model FhirServiceAcrConfiguration {
  /**
   * The list of the Azure container registry login servers.
   */
  loginServers?: string[];

  /**
   * The list of Open Container Initiative (OCI) artifacts.
   */
  ociArtifacts?: ServiceOciArtifactEntry[];
}

/**
 * Authentication configuration information
 */
model FhirServiceAuthenticationConfiguration {
  /**
   * The authority url for the service
   */
  authority?: string;

  /**
   * The audience url for the service
   */
  audience?: string;

  /**
   * If the SMART on FHIR proxy is enabled
   */
  smartProxyEnabled?: boolean;
}

/**
 * The settings for the CORS configuration of the service instance.
 */
model FhirServiceCorsConfiguration {
  /**
   * The origins to be allowed via CORS.
   */
  origins?: string[];

  /**
   * The headers to be allowed via CORS.
   */
  headers?: string[];

  /**
   * The methods to be allowed via CORS.
   */
  methods?: string[];

  /**
   * The max age to be allowed via CORS.
   */
  @maxValue(99999)
  maxAge?: int32;

  /**
   * If credentials are allowed via CORS.
   */
  allowCredentials?: boolean;
}

/**
 * Export operation configuration information
 */
model FhirServiceExportConfiguration {
  /**
   * The name of the default export storage account.
   */
  storageAccountName?: string;
}

/**
 * The settings for history tracking for FHIR resources.
 */
model ResourceVersionPolicyConfiguration {
  /**
   * The default value for tracking history across all resources.
   */
  default?: FhirResourceVersionPolicy;

  /**
   * A list of FHIR Resources and their version policy overrides.
   */
  resourceTypeOverrides?: Record<FhirResourceVersionPolicy>;
}

/**
 * Import operation configuration information
 */
model FhirServiceImportConfiguration {
  /**
   * The name of the default integration storage account.
   */
  integrationDataStore?: string;

  /**
   * If the FHIR service is in InitialImportMode.
   */
  initialImportMode?: boolean;

  /**
   * If the import operation is enabled.
   */
  enabled?: boolean;
}

/**
 * The settings for Implementation Guides - defining capabilities for national standards, vendor consortiums, clinical societies, etc.
 */
model ImplementationGuidesConfiguration {
  /**
   * If US Core Missing Data requirement is enabled.
   */
  usCoreMissingData?: boolean;
}

/**
 * FhirService patch properties
 */
model FhirServicePatchResource {
  ...ResourceTags;
  ...ServiceManagedIdentity;
}

/**
 * Service REST API operation.
 */
model OperationDetail {
  /**
   * Name of the operation
   */
  @visibility("read")
  name?: string;

  /**
   * Whether the operation applies to data-plane. This is "true" for data-plane operations and "false" for ARM/control-plane operations.
   */
  @visibility("read")
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Default value is 'user,system'.
   */
  @visibility("read")
  origin?: string;

  /**
   * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
   */
  @visibility("read")
  actionType?: ActionType;

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
   * Pattern for the filter of the metric.
   */
  metricFilterPattern?: string;

  /**
   * Dimensions of the metric
   */
  dimensions?: MetricDimension[];

  /**
   * Whether the metric is internal.
   */
  isInternal?: boolean;

  /**
   * The source MDM account.
   */
  sourceMdmAccount?: string;

  /**
   * The source MDM namespace.
   */
  sourceMdmNamespace?: string;

  /**
   * Whether regional MDM account enabled.
   */
  enableRegionalMdmAccount?: boolean;

  /**
   * The resource Id dimension name override.
   */
  resourceIdDimensionNameOverride?: string;
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

/**
 * The properties indicating the operation result of an operation on a service.
 */
model OperationResultsDescription {
  /**
   * The ID of the operation returned.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the operation result.
   */
  @visibility("read")
  name?: string;

  /**
   * The status of the operation being performed.
   */
  @visibility("read")
  status?: OperationResultStatus;

  /**
   * The time that the operation was started.
   */
  @visibility("read")
  startTime?: string;

  /**
   * The time that the operation finished.
   */
  @visibility("read")
  endTime?: string;

  /**
   * Additional properties of the operation result.
   */
  properties?: Record<unknown>;
}

/**
 * List of private endpoint connection associated with the specified storage account
 */
model PrivateEndpointConnectionListResult {
  /**
   * Array of private endpoint connections
   */
  value?: DummyPrivateEndpointConnection[];
}

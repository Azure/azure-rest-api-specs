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

@doc("The provisioning state.")
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

@doc("The private endpoint connection status.")
enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

@doc("The current provisioning state.")
enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

@doc("Control permission for data plane traffic coming from public networks while private endpoint is enabled.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("Type of identity being specified, currently SystemAssigned and None are allowed.")
enum ManagedServiceIdentityType {
  SystemAssigned,
  None,
}

@doc("Indicates the current status of event support for the resource.")
enum ServiceEventState {
  Disabled,
  Enabled,
  Updating,
}

@doc("Type of identity being specified, currently SystemAssigned and None are allowed.")
enum ServiceManagedIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

@doc("The type of IoT identity resolution to use with the destination.")
enum IotIdentityResolutionType {
  Create,
  Lookup,
}

@doc("The kind of the service.")
enum FhirServiceKind {
  `fhir-Stu3`,
  `fhir-R4`,
}

@doc("Controls how resources are versioned on the FHIR service")
enum FhirResourceVersionPolicy {
  `no-version`,
  versioned,
  `versioned-update`,
}

@doc("The status of the operation being performed.")
enum OperationResultStatus {
  Canceled,
  Succeeded,
  Failed,
  Requested,
  Running,
}

@doc("The kind of the service.")
@fixed
enum Kind {
  fhir,
  `fhir-Stu3`,
  `fhir-R4`,
}

@doc("The reason for unavailability.")
@fixed
enum ServiceNameUnavailabilityReason {
  Invalid,
  AlreadyExists,
}

@doc("The properties of a service instance.")
model ServicesProperties {
  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The access policies of the service instance.")
  accessPolicies?: ServiceAccessPolicyEntry[];

  @doc("The settings for the Cosmos DB database backing the service.")
  cosmosDbConfiguration?: ServiceCosmosDbConfigurationInfo;

  @doc("The authentication configuration for the service instance.")
  authenticationConfiguration?: ServiceAuthenticationConfigurationInfo;

  @doc("The settings for the CORS configuration of the service instance.")
  corsConfiguration?: ServiceCorsConfigurationInfo;

  @doc("The settings for the export operation of the service instance.")
  exportConfiguration?: ServiceExportConfigurationInfo;

  @doc("The list of private endpoint connections that are set up for this resource.")
  privateEndpointConnections?: PrivateEndpointConnectionDescription[];

  @doc("Control permission for data plane traffic coming from public networks while private endpoint is enabled.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("The azure container registry settings used for convert data operation of the service instance.")
  acrConfiguration?: ServiceAcrConfigurationInfo;

  @doc("The settings for the import operation of the service instance.")
  importConfiguration?: ServiceImportConfigurationInfo;
}

@doc("An access policy entry.")
model ServiceAccessPolicyEntry {
  @doc("An Azure AD object ID (User or Apps) that is allowed access to the FHIR service.")
  @pattern("^(([0-9A-Fa-f]{8}[-]?(?:[0-9A-Fa-f]{4}[-]?){3}[0-9A-Fa-f]{12}){1})+$")
  objectId: string;
}

@doc("The settings for the Cosmos DB database backing the service.")
model ServiceCosmosDbConfigurationInfo {
  @doc("The provisioned throughput for the backing database.")
  @minValue(400)
  offerThroughput?: int32;

  @doc("The URI of the customer-managed key for the backing database.")
  keyVaultKeyUri?: string;

  @doc("The multi-tenant application id used to enable CMK access for services in a data sovereign region.")
  @pattern("^(([0-9A-Fa-f]{8}[-]?(?:[0-9A-Fa-f]{4}[-]?){3}[0-9A-Fa-f]{12}){1})+$")
  crossTenantCmkApplicationId?: string;
}

@doc("Authentication configuration information")
model ServiceAuthenticationConfigurationInfo {
  @doc("The authority url for the service")
  authority?: string;

  @doc("The audience url for the service")
  audience?: string;

  @doc("If the SMART on FHIR proxy is enabled")
  smartProxyEnabled?: boolean;
}

@doc("The settings for the CORS configuration of the service instance.")
model ServiceCorsConfigurationInfo {
  @doc("The origins to be allowed via CORS.")
  origins?: string[];

  @doc("The headers to be allowed via CORS.")
  headers?: string[];

  @doc("The methods to be allowed via CORS.")
  methods?: string[];

  @doc("The max age to be allowed via CORS.")
  @maxValue(99999)
  maxAge?: int32;

  @doc("If credentials are allowed via CORS.")
  allowCredentials?: boolean;
}

@doc("Export operation configuration information")
model ServiceExportConfigurationInfo {
  @doc("The name of the default export storage account.")
  storageAccountName?: string;
}

@doc("The Private Endpoint Connection resource.")
model DummyPrivateEndpointConnection extends Resource {
  @doc("Resource properties.")
  properties?: PrivateEndpointConnectionProperties;
}

@doc("Properties of the PrivateEndpointConnectProperties.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private end point.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  @doc("The provisioning state of the private endpoint connection resource.")
  @visibility("read")
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

@doc("The Private Endpoint resource.")
model PrivateEndpoint {
  @doc("The ARM identifier for Private Endpoint")
  @visibility("read")
  id?: string;
}

@doc("A collection of information about the state of the connection between service consumer and provider.")
model PrivateLinkServiceConnectionState {
  @doc("Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("A message indicating if changes on the service provider require any updates on the consumer.")
  actionsRequired?: string;
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
}

@doc("Azure container registry configuration information")
model ServiceAcrConfigurationInfo {
  @doc("The list of the ACR login servers.")
  loginServers?: string[];

  @doc("The list of Open Container Initiative (OCI) artifacts.")
  ociArtifacts?: ServiceOciArtifactEntry[];
}

@doc("An Open Container Initiative (OCI) artifact.")
model ServiceOciArtifactEntry {
  @doc("The Azure Container Registry login server.")
  loginServer?: string;

  @doc("The artifact name.")
  imageName?: string;

  @doc("The artifact digest.")
  digest?: string;
}

@doc("Import operation configuration information")
model ServiceImportConfigurationInfo {
  @doc("The name of the default integration storage account.")
  integrationDataStore?: string;

  @doc("If the FHIR service is in InitialImportMode.")
  initialImportMode?: boolean;

  @doc("If the import operation is enabled.")
  enabled?: boolean;
}

@doc("The common properties of a service.")
model ServicesResource {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  @pattern("^[a-z0-9][a-z0-9-]{1,21}[a-z0-9]$")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("The kind of the service.")
  kind: Kind;

  @doc("The resource location.")
  @visibility("read", "create")
  location: string;

  @doc("The resource tags.")
  tags?: Record<string>;

  @doc("An etag associated with the resource, used for optimistic concurrency when editing it.")
  etag?: string;

  @doc("Setting indicating whether the service has a managed identity associated with it.")
  identity?: ServicesResourceIdentity;
}

@doc("Setting indicating whether the service has a managed identity associated with it.")
model ServicesResourceIdentity {
  @doc("The principal ID of the resource identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of the resource.")
  @visibility("read")
  tenantId?: string;

  @doc("Type of identity being specified, currently SystemAssigned and None are allowed.")
  type?: ManagedServiceIdentityType;
}

@doc("Error details.")
@error
model ErrorDetails {
  @doc("Error details")
  error?: ErrorDetailsInternal;
}

@doc("Error details.")
model ErrorDetailsInternal {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The target of the particular error.")
  @visibility("read")
  target?: string;
}

@doc("The description of the service.")
model ServicesPatchDescription {
  @doc("Instance tags")
  tags?: Record<string>;

  @doc("The properties for updating a service instance.")
  properties?: ServicesPropertiesUpdateParameters;
}

@doc("The properties for updating a service instance.")
model ServicesPropertiesUpdateParameters {
  @doc("Control permission for data plane traffic coming from public networks while private endpoint is enabled.")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("Input values.")
model CheckNameAvailabilityParameters {
  @doc("The name of the service instance to check.")
  name: string;

  @doc("The fully qualified resource type which includes provider namespace.")
  type: string;
}

@doc("The properties indicating whether a given service name is available.")
model ServicesNameAvailabilityInfo {
  @doc("The value which indicates whether the provided name is available.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason for unavailability.")
  @visibility("read")
  reason?: ServiceNameUnavailabilityReason;

  @doc("The detailed reason message.")
  message?: string;
}

@doc("A private link resource")
model DummyPrivateLinkResource extends Resource {
  @doc("Resource properties.")
  properties?: PrivateLinkResourceProperties;
}

@doc("Properties of a private link resource.")
model PrivateLinkResourceProperties {
  @doc("The private link resource group id.")
  @visibility("read")
  groupId?: string;

  @doc("The private link resource required member names.")
  @visibility("read")
  requiredMembers?: string[];

  @doc("The private link resource Private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("Workspaces resource specific properties.")
model WorkspaceProperties {
  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The list of private endpoint connections that are set up for this resource.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionDescription[];

  @doc("Control permission for data plane traffic coming from public networks while private endpoint is enabled.")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("The common properties of tracked resources in the service.")
model TaggedResource {
  ...ResourceTags;
  ...LocationBasedResource;
}

@doc("List of key value pairs that describe the resource. This will overwrite the existing tags.")
model ResourceTags {
  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;
}

@doc("The common properties for any location based resource, tracked or proxy.")
model LocationBasedResource extends ResourceCore {
  @doc("The resource location.")
  @visibility("read", "create")
  location?: string;
}

@doc("The common properties for any resource, tracked or proxy.")
model ResourceCore {
  @doc("The resource identifier.")
  @visibility("read")
  id?: string;

  @doc("The resource name.")
  @visibility("read")
  @pattern("^[a-z0-9][a-z0-9-]{1,21}[a-z0-9]$")
  name?: string;

  @doc("The resource type.")
  @visibility("read")
  type?: string;

  @doc("An etag associated with the resource, used for optimistic concurrency when editing it.")
  etag?: string;
}

@doc("Workspace patch properties")
model WorkspacePatchResource extends ResourceTags {}

@doc("Error details.")
@error
model Error {
  @doc("Error details")
  error?: ErrorDetailsInternal;
}

@doc("Dicom Service properties.")
model DicomServiceProperties {
  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Dicom Service authentication configuration.")
  authenticationConfiguration?: DicomServiceAuthenticationConfiguration;

  @doc("Dicom Service Cors configuration.")
  corsConfiguration?: CorsConfiguration;

  @doc("The url of the Dicom Services.")
  @visibility("read")
  serviceUrl?: string;

  @doc("The list of private endpoint connections that are set up for this resource.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionDescription[];

  @doc("Control permission for data plane traffic coming from public networks while private endpoint is enabled.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("DICOM Service event support status.")
  @visibility("read")
  eventState?: ServiceEventState;

  @doc("The encryption settings of the DICOM service")
  encryption?: Encryption;
}

@doc("Authentication configuration information")
model DicomServiceAuthenticationConfiguration {
  @doc("The authority url for the service")
  @visibility("read")
  authority?: string;

  @doc("The audiences for the service")
  @visibility("read")
  audiences?: string[];
}

@doc("The settings for the CORS configuration of the service instance.")
model CorsConfiguration {
  @doc("The origins to be allowed via CORS.")
  origins?: string[];

  @doc("The headers to be allowed via CORS.")
  headers?: string[];

  @doc("The methods to be allowed via CORS.")
  methods?: string[];

  @doc("The max age to be allowed via CORS.")
  @maxValue(99999)
  maxAge?: int32;

  @doc("If credentials are allowed via CORS.")
  allowCredentials?: boolean;
}

@doc("Settings to encrypt a service")
model Encryption {
  @doc("The encryption settings for the customer-managed key")
  customerManagedKeyEncryption?: EncryptionCustomerManagedKeyEncryption;
}

@doc("The encryption settings for the customer-managed key")
model EncryptionCustomerManagedKeyEncryption {
  @doc("The URL of the key to use for encryption")
  keyEncryptionKeyUrl?: string;
}

@doc("Managed service identity (system assigned and/or user assigned identities)")
model ServiceManagedIdentity {
  @doc("Setting indicating whether the service has a managed identity associated with it.")
  identity?: ServiceManagedIdentityIdentity;
}

@doc("Setting indicating whether the service has a managed identity associated with it.")
model ServiceManagedIdentityIdentity {
  @doc("Type of identity being specified, currently SystemAssigned and None are allowed.")
  type: ServiceManagedIdentityType;

  @doc("The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  tenantId?: string;

  @doc("The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.")
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

@doc("Dicom Service patch properties")
model DicomServicePatchResource {
  ...ResourceTags;
  ...ServiceManagedIdentity;
}

@doc("IoT Connector properties.")
model IotConnectorProperties {
  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Source configuration.")
  ingestionEndpointConfiguration?: IotEventHubIngestionEndpointConfiguration;

  @doc("Device Mappings.")
  deviceMapping?: IotMappingProperties;
}

@doc("Event Hub ingestion endpoint configuration")
model IotEventHubIngestionEndpointConfiguration {
  @doc("Event Hub name to connect to.")
  eventHubName?: string;

  @doc("Consumer group of the event hub to connected to.")
  consumerGroup?: string;

  @doc("Fully qualified namespace of the Event Hub to connect to.")
  fullyQualifiedEventHubNamespace?: string;
}

@doc("The mapping content.")
model IotMappingProperties {
  @doc("The mapping.")
  content?: Record<unknown>;
}

@doc("Iot Connector patch properties")
model IotConnectorPatchResource {
  ...ResourceTags;
  ...ServiceManagedIdentity;
}

@doc("IoT Connector destination properties for an Azure FHIR service.")
model IotFhirDestinationProperties extends IotDestinationProperties {
  @doc("Determines how resource identity is resolved on the destination.")
  resourceIdentityResolutionType: IotIdentityResolutionType;

  @doc("Fully qualified resource id of the FHIR service to connect to.")
  fhirServiceResourceId: string;

  @doc("FHIR Mappings")
  fhirMapping: IotMappingProperties;
}

@doc("Common IoT Connector destination properties.")
model IotDestinationProperties {
  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}

@doc("Fhir Service properties.")
model FhirServiceProperties {
  @doc("The provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Fhir Service Azure container registry configuration.")
  acrConfiguration?: FhirServiceAcrConfiguration;

  @doc("Fhir Service authentication configuration.")
  authenticationConfiguration?: FhirServiceAuthenticationConfiguration;

  @doc("Fhir Service Cors configuration.")
  corsConfiguration?: FhirServiceCorsConfiguration;

  @doc("Fhir Service export configuration.")
  exportConfiguration?: FhirServiceExportConfiguration;

  @doc("The list of private endpoint connections that are set up for this resource.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnectionDescription[];

  @doc("Control permission for data plane traffic coming from public networks while private endpoint is enabled.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Fhir Service event support status.")
  @visibility("read")
  eventState?: ServiceEventState;

  @doc("Determines tracking of history for resources.")
  resourceVersionPolicyConfiguration?: ResourceVersionPolicyConfiguration;

  @doc("Fhir Service import configuration.")
  importConfiguration?: FhirServiceImportConfiguration;

  @doc("Implementation Guides configuration.")
  implementationGuidesConfiguration?: ImplementationGuidesConfiguration;

  @doc("The encryption settings of the FHIR service")
  encryption?: Encryption;
}

@doc("Azure container registry configuration information")
model FhirServiceAcrConfiguration {
  @doc("The list of the Azure container registry login servers.")
  loginServers?: string[];

  @doc("The list of Open Container Initiative (OCI) artifacts.")
  ociArtifacts?: ServiceOciArtifactEntry[];
}

@doc("Authentication configuration information")
model FhirServiceAuthenticationConfiguration {
  @doc("The authority url for the service")
  authority?: string;

  @doc("The audience url for the service")
  audience?: string;

  @doc("If the SMART on FHIR proxy is enabled")
  smartProxyEnabled?: boolean;
}

@doc("The settings for the CORS configuration of the service instance.")
model FhirServiceCorsConfiguration {
  @doc("The origins to be allowed via CORS.")
  origins?: string[];

  @doc("The headers to be allowed via CORS.")
  headers?: string[];

  @doc("The methods to be allowed via CORS.")
  methods?: string[];

  @doc("The max age to be allowed via CORS.")
  @maxValue(99999)
  maxAge?: int32;

  @doc("If credentials are allowed via CORS.")
  allowCredentials?: boolean;
}

@doc("Export operation configuration information")
model FhirServiceExportConfiguration {
  @doc("The name of the default export storage account.")
  storageAccountName?: string;
}

@doc("The settings for history tracking for FHIR resources.")
model ResourceVersionPolicyConfiguration {
  @doc("The default value for tracking history across all resources.")
  default?: FhirResourceVersionPolicy;

  @doc("A list of FHIR Resources and their version policy overrides.")
  resourceTypeOverrides?: Record<FhirResourceVersionPolicy>;
}

@doc("Import operation configuration information")
model FhirServiceImportConfiguration {
  @doc("The name of the default integration storage account.")
  integrationDataStore?: string;

  @doc("If the FHIR service is in InitialImportMode.")
  initialImportMode?: boolean;

  @doc("If the import operation is enabled.")
  enabled?: boolean;
}

@doc("The settings for Implementation Guides - defining capabilities for national standards, vendor consortiums, clinical societies, etc.")
model ImplementationGuidesConfiguration {
  @doc("If US Core Missing Data requirement is enabled.")
  usCoreMissingData?: boolean;
}

@doc("FhirService patch properties")
model FhirServicePatchResource {
  ...ResourceTags;
  ...ServiceManagedIdentity;
}

@doc("Service REST API operation.")
model OperationDetail {
  @doc("Name of the operation")
  @visibility("read")
  name?: string;

  @doc("Whether the operation applies to data-plane. This is \"true\" for data-plane operations and \"false\" for ARM/control-plane operations.")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Display of the operation")
  display?: OperationDisplay;

  @doc("Default value is 'user,system'.")
  @visibility("read")
  origin?: string;

  @doc("Enum. Indicates the action type. \"Internal\" refers to actions that are for internal only APIs.")
  @visibility("read")
  actionType?: ActionType;

  @doc("Properties of the operation")
  properties?: OperationProperties;
}

@doc("Extra Operation properties")
model OperationProperties {
  @doc("Service specifications of the operation")
  serviceSpecification?: ServiceSpecification;
}

@doc("Service specification payload")
model ServiceSpecification {
  @doc("Specifications of the Log for Azure Monitoring")
  logSpecifications?: LogSpecification[];

  @doc("Specifications of the Metrics for Azure Monitoring")
  metricSpecifications?: MetricSpecification[];
}

@doc("Specifications of the Log for Azure Monitoring")
model LogSpecification {
  @doc("Name of the log")
  name?: string;

  @doc("Localized friendly display name of the log")
  displayName?: string;

  @doc("Blob duration of the log")
  blobDuration?: string;
}

@doc("Specifications of the Metrics for Azure Monitoring")
model MetricSpecification {
  @doc("Name of the metric")
  name?: string;

  @doc("Localized friendly display name of the metric")
  displayName?: string;

  @doc("Localized friendly description of the metric")
  displayDescription?: string;

  @doc("Unit that makes sense for the metric")
  unit?: string;

  @doc("Name of the metric category that the metric belongs to. A metric can only belong to a single category.")
  category?: string;

  @doc("Only provide one value for this field. Valid values: Average, Minimum, Maximum, Total, Count.")
  aggregationType?: string;

  @doc("Supported aggregation types")
  supportedAggregationTypes?: string[];

  @doc("Supported time grain types")
  supportedTimeGrainTypes?: string[];

  @doc("Optional. If set to true, then zero will be returned for time duration where no metric is emitted/published.")
  fillGapWithZero?: boolean;

  @doc("Pattern for the filter of the metric.")
  metricFilterPattern?: string;

  @doc("Dimensions of the metric")
  dimensions?: MetricDimension[];

  @doc("Whether the metric is internal.")
  isInternal?: boolean;

  @doc("The source MDM account.")
  sourceMdmAccount?: string;

  @doc("The source MDM namespace.")
  sourceMdmNamespace?: string;

  @doc("Whether regional MDM account enabled.")
  enableRegionalMdmAccount?: boolean;

  @doc("The resource Id dimension name override.")
  resourceIdDimensionNameOverride?: string;
}

@doc("Specifications of the Dimension of metrics")
model MetricDimension {
  @doc("Name of the dimension")
  name?: string;

  @doc("Localized friendly display name of the dimension")
  displayName?: string;

  @doc("Whether this dimension should be included for the Shoebox export scenario")
  toBeExportedForShoebox?: boolean;
}

@doc("The properties indicating the operation result of an operation on a service.")
model OperationResultsDescription {
  @doc("The ID of the operation returned.")
  @visibility("read")
  id?: string;

  @doc("The name of the operation result.")
  @visibility("read")
  name?: string;

  @doc("The status of the operation being performed.")
  @visibility("read")
  status?: OperationResultStatus;

  @doc("The time that the operation was started.")
  @visibility("read")
  startTime?: string;

  @doc("The time that the operation finished.")
  @visibility("read")
  endTime?: string;

  @doc("Additional properties of the operation result.")
  properties?: Record<unknown>;
}

@doc("List of private endpoint connection associated with the specified storage account")
model PrivateEndpointConnectionListResult {
  @doc("Array of private endpoint connections")
  value?: DummyPrivateEndpointConnection[];
}

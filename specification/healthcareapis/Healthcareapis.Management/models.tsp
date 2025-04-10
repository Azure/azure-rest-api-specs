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

/**
 * The provisioning state.
 */
union ProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Accepted: "Accepted",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Verifying: "Verifying",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deprovisioned: "Deprovisioned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Moving: "Moving",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Suspended: "Suspended",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Warned: "Warned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemMaintenance: "SystemMaintenance",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
}

/**
 * The current provisioning state.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union PrivateEndpointConnectionProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
}

/**
 * Type of identity being specified, currently SystemAssigned and None are allowed.
 */
union ManagedServiceIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
}

/**
 * Indicates the current status of event support for the resource.
 */
union ServiceEventState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
}

/**
 * Type of identity being specified, currently SystemAssigned and None are allowed.
 */
union ServiceManagedIdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SystemAssigned: "SystemAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  UserAssigned: "UserAssigned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `SystemAssigned,UserAssigned`: "SystemAssigned,UserAssigned",
}

/**
 * The type of IoT identity resolution to use with the destination.
 */
union IotIdentityResolutionType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Create: "Create",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Lookup: "Lookup",
}

/**
 * The kind of the service.
 */
union FhirServiceKind {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `fhir-Stu3`: "fhir-Stu3",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `fhir-R4`: "fhir-R4",
}

/**
 * The Data Actions that can be enabled for a Smart Identity Provider Application.
 */
union SmartDataActions {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Read: "Read",
}

/**
 * Controls how resources are versioned on the FHIR service
 */
union FhirResourceVersionPolicy {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `no-version`: "no-version",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  versioned: "versioned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  `versioned-update`: "versioned-update",
}

/**
 * The status of the operation being performed.
 */
union OperationResultStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Requested: "Requested",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Running: "Running",
}

/**
 * The kind of the service.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Kind {
  fhir,
  `fhir-Stu3`,
  `fhir-R4`,
}

/**
 * The reason for unavailability.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
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
  privateEndpointConnections?: PrivateEndpointConnection[];

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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateEndpointConnection extends Resource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility(Lifecycle.Read)
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[a-z0-9][a-z0-9-]{1,21}[a-z0-9]$")
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The kind of the service.
   */
  kind: Kind;

  /**
   * The resource location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * The resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant ID of the resource.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * The error message.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * The target of the particular error.
   */
  @visibility(Lifecycle.Read)
  target?: string;
}

/**
 * The description of the service.
 */
model ServicesPatchDescription {
  /**
   * Instance tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The properties for updating a service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
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
  @visibility(Lifecycle.Read)
  nameAvailable?: boolean;

  /**
   * The reason for unavailability.
   */
  @visibility(Lifecycle.Read)
  reason?: ServiceNameUnavailabilityReason;

  /**
   * The detailed reason message.
   */
  message?: string;
}

/**
 * List of private endpoint connection associated with the specified storage account
 */
@pagedResult
model PrivateEndpointConnectionListResultDescription {
  /**
   * Array of private endpoint connections
   */
  @items
  value?: PrivateEndpointConnectionDescription[];
}

/**
 * A list of private link resources
 */
@pagedResult
model PrivateLinkResourceListResultDescription {
  /**
   * Array of private link resources
   */
  @items
  value?: PrivateLinkResourceDescription[];
}

/**
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource extends Resource {
  /**
   * Resource properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Collection of workspace object with a next link
 */
model WorkspaceList is Azure.Core.Page<Workspace>;

/**
 * Workspaces resource specific properties.
 */
model WorkspaceProperties {
  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The list of private endpoint connections that are set up for this resource.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * The common properties for any location based resource, tracked or proxy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model LocationBasedResource extends ResourceCore {
  /**
   * The resource location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

/**
 * The common properties for any resource, tracked or proxy.
 */
model ResourceCore {
  /**
   * The resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The resource name.
   */
  @visibility(Lifecycle.Read)
  @pattern("^[a-z0-9][a-z0-9-]{1,21}[a-z0-9]$")
  name?: string;

  /**
   * The resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * An etag associated with the resource, used for optimistic concurrency when editing it.
   */
  etag?: string;
}

/**
 * Workspace patch properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
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
 * The collection of Dicom Services.
 */
model DicomServiceCollection is Azure.Core.Page<DicomService>;

/**
 * Dicom Service properties.
 */
model DicomServiceProperties {
  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  serviceUrl?: string;

  /**
   * The list of private endpoint connections that are set up for this resource.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * DICOM Service event support status.
   */
  @visibility(Lifecycle.Read)
  eventState?: ServiceEventState;

  /**
   * The encryption settings of the DICOM service
   */
  encryption?: Encryption;

  /**
   * The configuration of external storage account
   */
  storageConfiguration?: StorageConfiguration;

  /**
   * If data partitions is enabled or not.
   */
  enableDataPartitions?: boolean;
}

/**
 * Authentication configuration information
 */
model DicomServiceAuthenticationConfiguration {
  /**
   * The authority url for the service
   */
  @visibility(Lifecycle.Read)
  authority?: string;

  /**
   * The audiences for the service
   */
  @visibility(Lifecycle.Read)
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
 * The configuration of connected storage
 */
model StorageConfiguration {
  /**
   * The resource id of connected storage account.
   */
  storageResourceId?: string;

  /**
   * The filesystem name of connected storage account.
   */
  fileSystemName?: string;

  /**
   * The configuration for monitoring changes in the specified storage account.
   */
  storageMonitorConfiguration?: StorageMonitorConfiguration;
}

/**
 * The configuration for monitoring changes in a connected storage.
 */
model StorageMonitorConfiguration {
  /**
   * The resource id of the Azure Event Grid Namespace.
   */
  namespaceResourceId?: string;

  /**
   * The name of the namespace topic within the specified namespace.
   */
  topicName?: string;

  /**
   * The name of the event subscription associated with the given namespace topic that contains storage events.
   */
  eventSubscriptionName?: string;
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
   * The set of user assigned identities associated with the resource. The userAssignedIdentities dictionary keys will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}. The dictionary values can be empty objects ({}) in requests.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
 * A collection of IoT Connectors.
 */
model IotConnectorCollection is Azure.Core.Page<IotConnector>;

/**
 * IoT Connector properties.
 */
model IotConnectorProperties {
  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
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
 * A collection of IoT Connector FHIR destinations.
 */
model IotFhirDestinationCollection is Azure.Core.Page<IotFhirDestination>;

/**
 * IoT Connector destination properties for an Azure FHIR service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.Private.conditionalClientFlatten
  provisioningState?: ProvisioningState;
}

/**
 * A collection of Fhir services.
 */
model FhirServiceCollection is Azure.Core.Page<FhirService>;

/**
 * Fhir Service properties.
 */
model FhirServiceProperties {
  /**
   * The provisioning state.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Control permission for data plane traffic coming from public networks while private endpoint is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Fhir Service event support status.
   */
  @visibility(Lifecycle.Read)
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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

  /**
   * The array of identity provider configurations for SMART on FHIR authentication.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  smartIdentityProviders?: SmartIdentityProviderConfiguration[];
}

/**
 * An object to configure an identity provider for use with SMART on FHIR authentication.
 */
model SmartIdentityProviderConfiguration {
  /**
   * The identity provider token authority also known as the token issuing authority.
   */
  authority?: string;

  /**
   * The array of identity provider applications for SMART on FHIR authentication.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  applications?: SmartIdentityProviderApplication[];
}

/**
 * An Application configured in the Identity Provider used to access FHIR resources.
 */
model SmartIdentityProviderApplication {
  /**
   * The application client id defined in the identity provider. This value will be used to validate bearer tokens against the given authority.
   */
  clientId?: string;

  /**
   * The audience that will be used to validate bearer tokens against the given authority.
   */
  audience?: string;

  /**
   * The actions that are permitted to be performed on FHIR resources for the application.
   */
  allowedDataActions?: SmartDataActions[];
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
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
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Whether the operation applies to data-plane. This is "true" for data-plane operations and "false" for ARM/control-plane operations.
   */
  @visibility(Lifecycle.Read)
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Default value is 'user,system'.
   */
  @visibility(Lifecycle.Read)
  origin?: string;

  /**
   * Enum. Indicates the action type. "Internal" refers to actions that are for internal only APIs.
   */
  @visibility(Lifecycle.Read)
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
  @OpenAPI.extension("x-ms-identifiers", #[])
  logSpecifications?: LogSpecification[];

  /**
   * Specifications of the Metrics for Azure Monitoring
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @OpenAPI.extension("x-ms-identifiers", #[])
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the operation result.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The status of the operation being performed.
   */
  @visibility(Lifecycle.Read)
  status?: OperationResultStatus;

  /**
   * The time that the operation was started.
   */
  @visibility(Lifecycle.Read)
  startTime?: string;

  /**
   * The time that the operation finished.
   */
  @visibility(Lifecycle.Read)
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
  value?: PrivateEndpointConnection[];
}

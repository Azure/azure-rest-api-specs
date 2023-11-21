import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace AzureAgFoodPlatformRPService;

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum ProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
}

enum PublicNetworkAccess {
  Enabled,
  Hybrid,
}

enum PrivateEndpointServiceConnectionStatus {
  Pending,
  Approved,
  Rejected,
}

enum PrivateEndpointConnectionProvisioningState {
  Succeeded,
  Creating,
  Deleting,
  Failed,
}

enum CheckNameAvailabilityReason {
  Invalid,
  AlreadyExists,
}

enum Origin {
  user,
  system,
  `user,system`,
}

enum ActionType {
  Internal,
}

@doc("Extension resource.")
model Extension {
  ...ProxyResource;

  @doc("Extension resource properties.")
  properties?: ExtensionProperties;

  @doc("The ETag value to implement optimistic concurrency.")
  @visibility("read")
  eTag?: string;
}

@doc("Extension resource properties.")
model ExtensionProperties {
  @doc("Extension Id.")
  @visibility("read")
  extensionId?: string;

  @doc("Extension category. e.g. weather/sensor/satellite.")
  @visibility("read")
  extensionCategory?: string;

  @doc("Installed extension version.")
  @visibility("read")
  installedExtensionVersion?: string;

  @doc("Extension auth link.")
  @visibility("read")
  extensionAuthLink?: string;

  @doc("Extension api docs link.")
  @visibility("read")
  extensionApiDocsLink?: string;
}

@doc("""
The resource model definition for a Azure Resource Manager proxy resource. It
will not have tags and a location
""")
model ProxyResource {
  ...Resource;
}

@doc("""
Common fields that are returned in the response for all Azure Resource Manager
resources
""")
model Resource {
  @doc("""
Fully qualified resource ID for the resource. Ex -
/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
""")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("""
The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or
\"Microsoft.Storage/storageAccounts\"
""")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @doc("The identity that created the resource.")
  createdBy?: string;

  @doc("The type of identity that created the resource.")
  createdByType?: CreatedByType;

  @doc("The timestamp of resource creation (UTC).")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  @doc("The identity that last modified the resource.")
  lastModifiedBy?: string;

  @doc("The type of identity that last modified the resource.")
  lastModifiedByType?: CreatedByType;

  @doc("The timestamp of resource last modification (UTC)")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

@doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
@error
model ErrorResponse {
  @doc("The error object.")
  error?: ErrorDetail;
}

@doc("The error detail.")
model ErrorDetail {
  @doc("The error code.")
  @visibility("read")
  code?: string;

  @doc("The error message.")
  @visibility("read")
  message?: string;

  @doc("The error target.")
  @visibility("read")
  target?: string;

  @doc("The error details.")
  @visibility("read")
  details?: ErrorDetail[];

  @doc("The error additional info.")
  @visibility("read")
  additionalInfo?: ErrorAdditionalInfo[];
}

@doc("The resource management error additional info.")
model ErrorAdditionalInfo {
  @doc("The additional info type.")
  @visibility("read")
  type?: string;

  @doc("The additional info.")
  @visibility("read")
  info?: unknown;
}

@doc("""
Paged response contains list of requested objects and a URL link to get the
next set of results.
""")
model ExtensionListResponse is Azure.Core.Page<Extension>;

@doc("""
Paged response contains list of requested objects and a URL link to get the
next set of results.
""")
model FarmBeatsExtensionListResponse is Azure.Core.Page<FarmBeatsExtension>;

@doc("FarmBeats extension resource.")
model FarmBeatsExtension {
  ...ProxyResource;

  @doc("FarmBeatsExtension properties.")
  properties?: FarmBeatsExtensionProperties;
}

@doc("FarmBeatsExtension properties.")
model FarmBeatsExtensionProperties {
  @doc("Target ResourceType of the farmBeatsExtension.")
  @visibility("read")
  targetResourceType?: string;

  @doc("FarmBeatsExtension ID.")
  @visibility("read")
  farmBeatsExtensionId?: string;

  @doc("FarmBeatsExtension name.")
  @visibility("read")
  farmBeatsExtensionName?: string;

  @doc("FarmBeatsExtension version.")
  @visibility("read")
  farmBeatsExtensionVersion?: string;

  @doc("Publisher ID.")
  @visibility("read")
  publisherId?: string;

  @doc("Textual description.")
  @visibility("read")
  description?: string;

  @doc("Category of the extension. e.g. weather/sensor/satellite.")
  @visibility("read")
  extensionCategory?: string;

  @doc("FarmBeatsExtension auth link.")
  @visibility("read")
  extensionAuthLink?: string;

  @doc("FarmBeatsExtension api docs link.")
  @visibility("read")
  extensionApiDocsLink?: string;

  @doc("""
Detailed information which shows summary of requested data.
Used in descriptive
get extension metadata call.
Information for weather category per api included
are apisSupported,
customParameters, PlatformParameters and Units supported.
""")
  @visibility("read")
  detailedInformation?: DetailedInformation[];
}

@doc("Model to capture detailed information for farmBeatsExtensions.")
model DetailedInformation {
  @doc("ApiName available for the farmBeatsExtension.")
  apiName?: string;

  @doc("List of customParameters.")
  customParameters?: string[];

  @doc("List of platformParameters.")
  platformParameters?: string[];

  @doc("Unit systems info for the data provider.")
  unitsSupported?: UnitSystemsInfo;

  @doc("List of apiInputParameters.")
  apiInputParameters?: string[];
}

@doc("Unit systems info for the data provider.")
model UnitSystemsInfo {
  @doc("UnitSystem key sent as part of ProviderInput.")
  key: string;

  @doc("List of unit systems supported by this data provider.")
  values: string[];
}

@doc("FarmBeats ARM Resource.")
model FarmBeats {
  ...TrackedResource;

  @doc("Identity for the resource.")
  identity?: Identity;

  @doc("FarmBeats ARM Resource properties.")
  properties?: FarmBeatsProperties;
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
  type?: "SystemAssigned";
}

@doc("FarmBeats ARM Resource properties.")
model FarmBeatsProperties {
  @doc("Uri of the FarmBeats instance.")
  @visibility("read")
  instanceUri?: string;

  @doc("FarmBeats instance provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("Sensor integration request model.")
  sensorIntegration?: SensorIntegration;

  @doc("Property to allow or block public traffic for an Azure FarmBeats resource.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("The Private Endpoint Connection resource.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection;
}

@doc("Sensor integration request model.")
model SensorIntegration {
  @doc("Sensor integration enable state. Allowed values are True, None")
  enabled?: string;

  @doc("Sensor integration instance provisioning state.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("""
Common error response for all Azure Resource Manager APIs to return error
details for failed operations. (This also follows the OData error response
format.).
""")
  provisioningInfo?: ErrorResponse;
}

@doc("The Private Endpoint Connection resource.")
model PrivateEndpointConnection {
  ...Resource;

  @doc("Resource properties.")
  properties?: PrivateEndpointConnectionProperties;
}

@doc("Properties of the PrivateEndpointConnectProperties.")
model PrivateEndpointConnectionProperties {
  @doc("The resource of private end point.")
  privateEndpoint?: PrivateEndpoint;

  @doc("""
A collection of information about the state of the connection between service
consumer and provider.
""")
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

@doc("""
A collection of information about the state of the connection between service
consumer and provider.
""")
model PrivateLinkServiceConnectionState {
  @doc("""
Indicates whether the connection has been Approved/Rejected/Removed by the
owner of the service.
""")
  status?: PrivateEndpointServiceConnectionStatus;

  @doc("The reason for approval/rejection of the connection.")
  description?: string;

  @doc("""
A message indicating if changes on the service provider require any updates on
the consumer.
""")
  actionsRequired?: string;
}

@doc("""
The resource model definition for an Azure Resource Manager tracked top level
resource which has 'tags' and a 'location'
""")
model TrackedResource {
  ...Resource;

  @doc("Resource tags.")
  tags?: Record<string>;

  @doc("The geo-location where the resource lives")
  location: string;
}

@doc("FarmBeats update request.")
model FarmBeatsUpdateRequestModel {
  @doc("Geo-location where the resource lives.")
  location?: string;

  @doc("Identity for the resource.")
  identity?: Identity;

  @doc("FarmBeats ARM Resource properties.")
  properties?: FarmBeatsUpdateProperties;

  @doc("Resource tags.")
  tags?: Record<string>;
}

@doc("FarmBeats ARM Resource properties.")
model FarmBeatsUpdateProperties {
  @doc("Sensor integration request model.")
  sensorIntegration?: SensorIntegration;

  @doc("Property to allow or block public traffic for an Azure FarmBeats resource.")
  publicNetworkAccess?: PublicNetworkAccess;
}

@doc("""
Paged response contains list of requested objects and a URL link to get the
next set of results.
""")
model FarmBeatsListResponse is Azure.Core.Page<FarmBeats>;

@doc("""
Arm async operation class.
Ref:
https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/async-operations.
""")
model ArmAsyncOperation {
  @doc("Status of the async operation.")
  status?: string;
}

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("The check availability result.")
model CheckNameAvailabilityResponse {
  @doc("Indicates if the resource name is available.")
  nameAvailable?: boolean;

  @doc("The reason why the given name is not available.")
  reason?: CheckNameAvailabilityReason;

  @doc("Detailed reason why the given name is available.")
  message?: string;
}

@doc("""
A list of REST API operations supported by an Azure Resource Provider. It
contains an URL link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("""
Details of a REST API operation, returned from the Resource Provider Operations
API
""")
model Operation {
  @doc("""
The name of the operation, as per Resource-Based Access Control (RBAC).
Examples: \"Microsoft.Compute/virtualMachines/write\",
\"Microsoft.Compute/virtualMachines/capture/action\"
""")
  @visibility("read")
  name?: string;

  @doc("""
Whether the operation applies to data-plane. This is \"true\" for data-plane
operations and \"false\" for ARM/control-plane operations.
""")
  @visibility("read")
  isDataAction?: boolean;

  @doc("Localized display information for this particular operation.")
  display?: OperationDisplay;

  @doc("""
The intended executor of the operation; as in Resource Based Access Control
(RBAC) and audit logs UX. Default value is \"user,system\"
""")
  @visibility("read")
  origin?: Origin;

  @doc("""
Enum. Indicates the action type. \"Internal\" refers to actions that are for
internal only APIs.
""")
  @visibility("read")
  actionType?: ActionType;
}

@doc("Localized display information for this particular operation.")
model OperationDisplay {
  @doc("""
The localized friendly form of the resource provider name, e.g. \"Microsoft
Monitoring Insights\" or \"Microsoft Compute\".
""")
  @visibility("read")
  provider?: string;

  @doc("""
The localized friendly name of the resource type related to this operation.
E.g. \"Virtual Machines\" or \"Job Schedule Collections\".
""")
  @visibility("read")
  resource?: string;

  @doc("""
The concise, localized friendly name for the operation; suitable for dropdowns.
E.g. \"Create or Update Virtual Machine\", \"Restart Virtual Machine\".
""")
  @visibility("read")
  operation?: string;

  @doc("""
The short, localized friendly description of the operation; suitable for tool
tips and detailed views.
""")
  @visibility("read")
  description?: string;
}

@doc("""
List of private endpoint connection associated with the specified storage
account
""")
@pagedResult
model PrivateEndpointConnectionListResult {
  @doc("Array of private endpoint connections")
  @items
  value?: PrivateEndpointConnection[];
}

@doc("A list of private link resources")
@pagedResult
model PrivateLinkResourceListResult {
  @doc("Array of private link resources")
  @items
  value?: PrivateLinkResource[];
}

@doc("A private link resource")
model PrivateLinkResource {
  ...Resource;

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

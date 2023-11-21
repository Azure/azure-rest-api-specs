import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace IotCentralClient;

enum ProvisioningState {
  Creating,
  Deleting,
  Updating,
  Succeeded,
  Failed,
  Canceled,
}

enum AppState {
  created,
  suspended,
}

enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

enum NetworkAction {
  Allow,
  Deny,
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

enum CreatedByType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

enum AppSku {
  ST0,
  ST1,
  ST2,
}

enum SystemAssignedServiceIdentityType {
  None,
  SystemAssigned,
}

@doc("The IoT Central application.")
model App {
  ...TrackedResource;

  @doc("The common properties of an IoT Central application.")
  properties?: AppProperties;

  @doc("A valid instance SKU.")
  sku: AppSkuInfo;

  @doc("The managed identities for the IoT Central application.")
  identity?: SystemAssignedServiceIdentity;
}

@doc("The properties of an IoT Central application.")
model AppProperties {
  @doc("The provisioning state of the application.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The ID of the application.")
  @visibility("read")
  applicationId?: string;

  @doc("The display name of the application.")
  displayName?: string;

  @doc("The subdomain of the application.")
  subdomain?: string;

  @doc("""
The ID of the application template, which is a blueprint that defines the
characteristics and behaviors of an application. Optional; if not specified,
defaults to a blank blueprint and allows the application to be defined from
scratch.
""")
  template?: string;

  @doc("The current state of the application.")
  @visibility("read")
  state?: AppState;

  @doc("Whether requests from the public network are allowed.")
  publicNetworkAccess?: PublicNetworkAccess;

  @doc("Network Rule Set Properties of this IoT Central application.")
  networkRuleSets?: NetworkRuleSets;

  @doc("Private endpoint connections created on this IoT Central application.")
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

@doc("Network Rule Set Properties of this IoT Central application.")
model NetworkRuleSets {
  @doc("""
Whether these rules apply for device connectivity to IoT Hub and Device
Provisioning service associated with this application.
""")
  applyToDevices?: boolean;

  @doc("Whether these rules apply for connectivity via IoT Central web portal and APIs.")
  applyToIoTCentral?: boolean;

  @doc("The default network action to apply.")
  defaultAction?: NetworkAction;

  @doc("List of IP rules.")
  ipRules?: NetworkRuleSetIpRule[];
}

@doc("An object for an IP range that will be allowed access.")
model NetworkRuleSetIpRule {
  @doc("The readable name of the IP rule.")
  filterName?: string;

  @doc("The CIDR block defining the IP range.")
  ipMask?: string;
}

@doc("The private endpoint connection resource.")
model PrivateEndpointConnection {
  ...Resource;

  @doc("Resource properties.")
  properties?: PrivateEndpointConnectionProperties;
}

@doc("Properties of the private endpoint connection.")
model PrivateEndpointConnectionProperties {
  @doc("The group ids for the private endpoint resource.")
  @visibility("read")
  groupIds?: string[];

  @doc("The private endpoint resource.")
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

@doc("The private endpoint resource.")
model PrivateEndpoint {
  @doc("The ARM identifier for private endpoint.")
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

@doc("Information about the SKU of the IoT Central application.")
model AppSkuInfo {
  @doc("The name of the SKU.")
  name: AppSku;
}

@doc("Managed service identity (either system assigned, or none)")
model SystemAssignedServiceIdentity {
  @doc("""
The service principal ID of the system assigned identity. This property will
only be provided for a system assigned identity.
""")
  @visibility("read")
  principalId?: string;

  @doc("""
The tenant ID of the system assigned identity. This property will only be
provided for a system assigned identity.
""")
  @visibility("read")
  tenantId?: string;

  @doc("Type of managed service identity (either system assigned, or none).")
  type: SystemAssignedServiceIdentityType;
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

@doc("The description of the IoT Central application.")
model AppPatch {
  @doc("Instance tags")
  tags?: Record<string>;

  @doc("A valid instance SKU.")
  sku?: AppSkuInfo;

  @doc("The common properties of an IoT Central application.")
  properties?: AppProperties;

  @doc("The managed identities for the IoT Central application.")
  identity?: SystemAssignedServiceIdentity;
}

@doc("A list of IoT Central Applications with a next link.")
model AppListResult is Azure.Core.Page<App>;

@doc("List of private endpoint connections associated with the specified resource.")
@pagedResult
model PrivateEndpointConnectionListResult {
  @doc("Array of private endpoint connections.")
  @items
  value?: PrivateEndpointConnection[];
}

@doc("A private link resource.")
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

  @doc("The private link resource private link DNS zone name.")
  requiredZoneNames?: string[];
}

@doc("A list of private link resources.")
@pagedResult
model PrivateLinkResourceListResult {
  @doc("Array of private link resources")
  @items
  value?: PrivateLinkResource[];
}

@doc("Input values.")
model OperationInputs {
  @doc("The name of the IoT Central application instance to check.")
  name: string;

  @doc("The type of the IoT Central resource to query.")
  type?: string;
}

@doc("""
The properties indicating whether a given IoT Central application name or
subdomain is available.
""")
model AppAvailabilityInfo {
  @doc("The value which indicates whether the provided name is available.")
  @visibility("read")
  nameAvailable?: boolean;

  @doc("The reason for unavailability.")
  @visibility("read")
  reason?: string;

  @doc("The detailed reason message.")
  @visibility("read")
  message?: string;
}

@doc("A list of IoT Central Application Templates with a next link.")
model AppTemplatesResult is Azure.Core.Page<AppTemplate>;

@doc("IoT Central Application Template.")
model AppTemplate {
  @doc("The ID of the template.")
  @visibility("read")
  manifestId?: string;

  @doc("The version of the template.")
  @visibility("read")
  manifestVersion?: string;

  @doc("The name of the template.")
  @visibility("read")
  name?: string;

  @doc("The title of the template.")
  @visibility("read")
  title?: string;

  @doc("The order of the template in the templates list.")
  @visibility("read")
  order?: float32;

  @doc("The description of the template.")
  @visibility("read")
  description?: string;

  @doc("The industry of the template.")
  @visibility("read")
  industry?: string;

  @doc("A list of locations that support the template.")
  @visibility("read")
  locations?: AppTemplateLocations[];
}

@doc("IoT Central Application Template Locations.")
model AppTemplateLocations {
  @doc("The ID of the location.")
  @visibility("read")
  id?: string;

  @doc("The display name of the location.")
  @visibility("read")
  displayName?: string;
}

@doc("""
A list of IoT Central operations. It contains a list of operations and a URL
link to get the next set of results.
""")
model OperationListResult is Azure.Core.Page<Operation>;

@doc("IoT Central REST API operation")
model Operation {
  @doc("Operation name: {provider}/{resource}/{read | write | action | delete}")
  @visibility("read")
  name?: string;

  @doc("The object that represents the operation.")
  display?: OperationDisplay;

  @doc("The intended executor of the operation.")
  @visibility("read")
  origin?: string;

  @doc("Additional descriptions for the operation.")
  @visibility("read")
  properties?: unknown;
}

@doc("The object that represents the operation.")
model OperationDisplay {
  @doc("Service provider: Microsoft IoT Central")
  @visibility("read")
  provider?: string;

  @doc("Resource Type: IoT Central")
  @visibility("read")
  resource?: string;

  @doc("Name of the operation")
  @visibility("read")
  operation?: string;

  @doc("Friendly description for the operation,")
  @visibility("read")
  description?: string;
}

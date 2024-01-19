import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.IoTCentral;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("The provisioning state of the application.")
enum ProvisioningState {
  Creating,
  Deleting,
  Updating,
  Succeeded,
  Failed,
  Canceled,
}

@doc("The current state of the application.")
enum AppState {
  created,
  suspended,
}

@doc("Whether requests from the public network are allowed.")
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

@doc("Whether to allow or deny network traffic.")
enum NetworkAction {
  Allow,
  Deny,
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

@doc("The name of the SKU.")
enum AppSku {
  ST0,
  ST1,
  ST2,
}

@doc("Type of managed service identity (either system assigned, or none).")
enum SystemAssignedServiceIdentityType {
  None,
  SystemAssigned,
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

  @doc("The ID of the application template, which is a blueprint that defines the characteristics and behaviors of an application. Optional; if not specified, defaults to a blank blueprint and allows the application to be defined from scratch.")
  @visibility("read", "create")
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
  @doc("Whether these rules apply for device connectivity to IoT Hub and Device Provisioning service associated with this application.")
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

@doc("Properties of the private endpoint connection.")
model PrivateEndpointConnectionProperties {
  @doc("The group ids for the private endpoint resource.")
  @visibility("read")
  groupIds?: string[];

  @doc("The private endpoint resource.")
  privateEndpoint?: PrivateEndpoint;

  @doc("A collection of information about the state of the connection between service consumer and provider.")
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

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("Information about the SKU of the IoT Central application.")
model AppSkuInfo {
  @doc("The name of the SKU.")
  name: AppSku;
}

@doc("Managed service identity (either system assigned, or none)")
model SystemAssignedServiceIdentity {
  @doc("The service principal ID of the system assigned identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  principalId?: string;

  @doc("The tenant ID of the system assigned identity. This property will only be provided for a system assigned identity.")
  @visibility("read")
  tenantId?: string;

  @doc("Type of managed service identity (either system assigned, or none).")
  type: SystemAssignedServiceIdentityType;
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

@doc("Input values.")
model OperationInputs {
  @doc("The name of the IoT Central application instance to check.")
  name: string;

  @doc("The type of the IoT Central resource to query.")
  type?: string;
}

@doc("The properties indicating whether a given IoT Central application name or subdomain is available.")
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
  order?: int32;

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

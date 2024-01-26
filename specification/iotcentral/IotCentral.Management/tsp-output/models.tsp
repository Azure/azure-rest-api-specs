import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.IoTCentral;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * The provisioning state of the application.
 */
enum ProvisioningState {
  Creating,
  Deleting,
  Updating,
  Succeeded,
  Failed,
  Canceled,
}

/**
 * The current state of the application.
 */
enum AppState {
  created,
  suspended,
}

/**
 * Whether requests from the public network are allowed.
 */
enum PublicNetworkAccess {
  Enabled,
  Disabled,
}

/**
 * Whether to allow or deny network traffic.
 */
enum NetworkAction {
  Allow,
  Deny,
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
 * The name of the SKU.
 */
enum AppSku {
  ST0,
  ST1,
  ST2,
}

/**
 * Type of managed service identity (either system assigned, or none).
 */
enum SystemAssignedServiceIdentityType {
  None,
  SystemAssigned,
}

/**
 * The properties of an IoT Central application.
 */
model AppProperties {
  /**
   * The provisioning state of the application.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The ID of the application.
   */
  @visibility("read")
  applicationId?: string;

  /**
   * The display name of the application.
   */
  displayName?: string;

  /**
   * The subdomain of the application.
   */
  subdomain?: string;

  /**
   * The ID of the application template, which is a blueprint that defines the characteristics and behaviors of an application. Optional; if not specified, defaults to a blank blueprint and allows the application to be defined from scratch.
   */
  @visibility("read", "create")
  template?: string;

  /**
   * The current state of the application.
   */
  @visibility("read")
  state?: AppState;

  /**
   * Whether requests from the public network are allowed.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Network Rule Set Properties of this IoT Central application.
   */
  networkRuleSets?: NetworkRuleSets;

  /**
   * Private endpoint connections created on this IoT Central application.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection[];
}

/**
 * Network Rule Set Properties of this IoT Central application.
 */
model NetworkRuleSets {
  /**
   * Whether these rules apply for device connectivity to IoT Hub and Device Provisioning service associated with this application.
   */
  applyToDevices?: boolean;

  /**
   * Whether these rules apply for connectivity via IoT Central web portal and APIs.
   */
  applyToIoTCentral?: boolean;

  /**
   * The default network action to apply.
   */
  defaultAction?: NetworkAction;

  /**
   * List of IP rules.
   */
  ipRules?: NetworkRuleSetIpRule[];
}

/**
 * An object for an IP range that will be allowed access.
 */
model NetworkRuleSetIpRule {
  /**
   * The readable name of the IP rule.
   */
  filterName?: string;

  /**
   * The CIDR block defining the IP range.
   */
  ipMask?: string;
}

/**
 * Properties of the private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The group ids for the private endpoint resource.
   */
  @visibility("read")
  groupIds?: string[];

  /**
   * The private endpoint resource.
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
 * The private endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for private endpoint.
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

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * Information about the SKU of the IoT Central application.
 */
model AppSkuInfo {
  /**
   * The name of the SKU.
   */
  name: AppSku;
}

/**
 * Managed service identity (either system assigned, or none)
 */
model SystemAssignedServiceIdentity {
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
   * Type of managed service identity (either system assigned, or none).
   */
  type: SystemAssignedServiceIdentityType;
}

/**
 * The description of the IoT Central application.
 */
model AppPatch {
  /**
   * Instance tags
   */
  tags?: Record<string>;

  /**
   * A valid instance SKU.
   */
  sku?: AppSkuInfo;

  /**
   * The common properties of an IoT Central application.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AppProperties;

  /**
   * The managed identities for the IoT Central application.
   */
  identity?: SystemAssignedServiceIdentity;
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
   * The private link resource private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Input values.
 */
model OperationInputs {
  /**
   * The name of the IoT Central application instance to check.
   */
  name: string;

  /**
   * The type of the IoT Central resource to query.
   */
  type?: string = "IoTApps";
}

/**
 * The properties indicating whether a given IoT Central application name or subdomain is available.
 */
model AppAvailabilityInfo {
  /**
   * The value which indicates whether the provided name is available.
   */
  @visibility("read")
  nameAvailable?: boolean;

  /**
   * The reason for unavailability.
   */
  @visibility("read")
  reason?: string;

  /**
   * The detailed reason message.
   */
  @visibility("read")
  message?: string;
}

/**
 * IoT Central Application Template.
 */
model AppTemplate {
  /**
   * The ID of the template.
   */
  @visibility("read")
  manifestId?: string;

  /**
   * The version of the template.
   */
  @visibility("read")
  manifestVersion?: string;

  /**
   * The name of the template.
   */
  @visibility("read")
  name?: string;

  /**
   * The title of the template.
   */
  @visibility("read")
  title?: string;

  /**
   * The order of the template in the templates list.
   */
  @visibility("read")
  order?: int32;

  /**
   * The description of the template.
   */
  @visibility("read")
  description?: string;

  /**
   * The industry of the template.
   */
  @visibility("read")
  industry?: string;

  /**
   * A list of locations that support the template.
   */
  @visibility("read")
  locations?: AppTemplateLocations[];
}

/**
 * IoT Central Application Template Locations.
 */
model AppTemplateLocations {
  /**
   * The ID of the location.
   */
  @visibility("read")
  id?: string;

  /**
   * The display name of the location.
   */
  @visibility("read")
  displayName?: string;
}

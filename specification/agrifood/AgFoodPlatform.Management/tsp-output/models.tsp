import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.AgFoodPlatform;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Sensor integration instance provisioning state.
 */
enum ProvisioningState {
  Creating,
  Updating,
  Deleting,
  Succeeded,
  Failed,
}

/**
 * Property to allow or block public traffic for an Azure FarmBeats resource.
 */
enum PublicNetworkAccess {
  Enabled,
  Hybrid,
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
 * Extension resource properties.
 */
model ExtensionProperties {
  /**
   * Extension Id.
   */
  @visibility("read")
  @pattern("^[a-zA-Z]{3,50}[.][a-zA-Z]{3,100}$")
  extensionId?: string;

  /**
   * Extension category. e.g. weather/sensor/satellite.
   */
  @visibility("read")
  extensionCategory?: string;

  /**
   * Installed extension version.
   */
  @visibility("read")
  @pattern("^([1-9]|10).\\d$")
  installedExtensionVersion?: string;

  /**
   * Extension auth link.
   */
  @visibility("read")
  extensionAuthLink?: string;

  /**
   * Extension api docs link.
   */
  @visibility("read")
  extensionApiDocsLink?: string;
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
 * FarmBeatsExtension properties.
 */
model FarmBeatsExtensionProperties {
  /**
   * Target ResourceType of the farmBeatsExtension.
   */
  @visibility("read")
  targetResourceType?: string;

  /**
   * FarmBeatsExtension ID.
   */
  @visibility("read")
  @maxLength(100)
  @minLength(2)
  @pattern("^[a-zA-Z]{3,50}[.][a-zA-Z]{3,100}$")
  farmBeatsExtensionId?: string;

  /**
   * FarmBeatsExtension name.
   */
  @visibility("read")
  @maxLength(100)
  @minLength(2)
  farmBeatsExtensionName?: string;

  /**
   * FarmBeatsExtension version.
   */
  @visibility("read")
  @maxLength(100)
  @minLength(2)
  @pattern("^([1-9]|10).\\d$")
  farmBeatsExtensionVersion?: string;

  /**
   * Publisher ID.
   */
  @visibility("read")
  @maxLength(100)
  @minLength(2)
  publisherId?: string;

  /**
   * Textual description.
   */
  @visibility("read")
  @maxLength(500)
  @minLength(2)
  description?: string;

  /**
   * Category of the extension. e.g. weather/sensor/satellite.
   */
  @visibility("read")
  @maxLength(100)
  @minLength(2)
  extensionCategory?: string;

  /**
   * FarmBeatsExtension auth link.
   */
  @visibility("read")
  extensionAuthLink?: string;

  /**
   * FarmBeatsExtension api docs link.
   */
  @visibility("read")
  extensionApiDocsLink?: string;

  /**
   * Detailed information which shows summary of requested data.
   * Used in descriptive get extension metadata call.
   * Information for weather category per api included are apisSupported,
   * customParameters, PlatformParameters and Units supported.
   */
  @visibility("read")
  detailedInformation?: DetailedInformation[];
}

/**
 * Model to capture detailed information for farmBeatsExtensions.
 */
model DetailedInformation {
  /**
   * ApiName available for the farmBeatsExtension.
   */
  apiName?: string;

  /**
   * List of customParameters.
   */
  customParameters?: string[];

  /**
   * List of platformParameters.
   */
  platformParameters?: string[];

  /**
   * Unit systems info for the data provider.
   */
  unitsSupported?: UnitSystemsInfo;

  /**
   * List of apiInputParameters.
   */
  apiInputParameters?: string[];
}

/**
 * Unit systems info for the data provider.
 */
model UnitSystemsInfo {
  /**
   * UnitSystem key sent as part of ProviderInput.
   */
  @maxLength(100)
  @minLength(2)
  key: string;

  /**
   * List of unit systems supported by this data provider.
   */
  values: string[];
}

/**
 * Identity for the resource.
 */
model Identity {
  /**
   * The principal ID of resource identity.
   */
  @visibility("read")
  principalId?: string;

  /**
   * The tenant ID of resource.
   */
  @visibility("read")
  tenantId?: string;

  /**
   * The identity type.
   */
  type?: "SystemAssigned";
}

/**
 * FarmBeats ARM Resource properties.
 */
model FarmBeatsProperties {
  /**
   * Uri of the FarmBeats instance.
   */
  @visibility("read")
  instanceUri?: url;

  /**
   * FarmBeats instance provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Sensor integration request model.
   */
  sensorIntegration?: SensorIntegration;

  /**
   * Property to allow or block public traffic for an Azure FarmBeats resource.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * The Private Endpoint Connection resource.
   */
  @visibility("read")
  privateEndpointConnections?: PrivateEndpointConnection;
}

/**
 * Sensor integration request model.
 */
model SensorIntegration {
  /**
   * Sensor integration enable state. Allowed values are True, None
   */
  enabled?: string;

  /**
   * Sensor integration instance provisioning state.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * Common error response for all Azure Resource Manager APIs to return error details for failed operations. (This also follows the OData error response format.).
   */
  provisioningInfo?: ErrorResponse;
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
 * FarmBeats update request.
 */
model FarmBeatsUpdateRequestModel {
  /**
   * Geo-location where the resource lives.
   */
  location?: string;

  /**
   * Identity for the resource.
   */
  identity?: Identity;

  /**
   * FarmBeats ARM Resource properties.
   */
  properties?: FarmBeatsUpdateProperties;

  /**
   * Resource tags.
   */
  tags?: Record<string>;
}

/**
 * FarmBeats ARM Resource properties.
 */
model FarmBeatsUpdateProperties {
  /**
   * Sensor integration request model.
   */
  sensorIntegration?: SensorIntegration;

  /**
   * Property to allow or block public traffic for an Azure FarmBeats resource.
   */
  publicNetworkAccess?: PublicNetworkAccess;
}

/**
 * Arm async operation class.
 * Ref: https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/async-operations.
 */
model ArmAsyncOperation {
  /**
   * Status of the async operation.
   */
  status?: string;
}

/**
 * The check availability request body.
 */
model CheckNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;
}

/**
 * The check availability result.
 */
model CheckNameAvailabilityResponse {
  /**
   * Indicates if the resource name is available.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the given name is not available.
   */
  reason?: CheckNameAvailabilityReason;

  /**
   * Detailed reason why the given name is available.
   */
  message?: string;
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

import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Relay;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union AccessRights {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Manage: "Manage",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Send: "Send",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Listen: "Listen",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
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
 * The access key to regenerate.
 */
union KeyType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  PrimaryKey: "PrimaryKey",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SecondaryKey: "SecondaryKey",
}

/**
 * Specifies the reason for the unavailability of the service.
 */
union UnavailableReason {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  None: "None",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  InvalidName: "InvalidName",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SubscriptionIsDisabled: "SubscriptionIsDisabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NameInUse: "NameInUse",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  NameInLockdown: "NameInLockdown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  TooManyNamespaceInCurrentSubscription: "TooManyNamespaceInCurrentSubscription",
}

/**
 * Name of this SKU.
 */
union SkuName {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
}

/**
 * The tier of this SKU.
 */
union SkuTier {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Standard: "Standard",
}

/**
 * Status of the connection.
 */
union PrivateLinkConnectionStatus {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disconnected: "Disconnected",
}

/**
 * Provisioning state of the Private Endpoint Connection.
 */
union EndPointProvisioningState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Creating: "Creating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Updating: "Updating",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deleting: "Deleting",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Succeeded: "Succeeded",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Canceled: "Canceled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Failed: "Failed",
}

/**
 * This determines if traffic is allowed over public network. By default it is enabled.
 */
union PublicNetworkAccess {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  SecuredByPerimeter: "SecuredByPerimeter",
}

/**
 * Default Action for Network Rule Set
 */
union DefaultAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Deny: "Deny",
}

/**
 * The IP Filter Action
 */
union NetworkRuleIPAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  Allow: "Allow",
}

/**
 * WCF relay type.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum Relaytype {
  NetTcp,
  Http,
}

/**
 * Properties supplied to create or update AuthorizationRule
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AuthorizationRuleProperties {
  /**
   * The rights associated with the rule.
   */
  rights: AccessRights[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model ProxyResource {
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
   * The type of the resource. E.g. "Microsoft.EventHub/Namespaces" or "Microsoft.EventHub/Namespaces/EventHubs"
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

/**
 * Namespace/Relay Connection String
 */
model AccessKeys {
  /**
   * Primary connection string of the created namespace authorization rule.
   */
  primaryConnectionString?: string;

  /**
   * Secondary connection string of the created namespace authorization rule.
   */
  secondaryConnectionString?: string;

  /**
   * A base64-encoded 256-bit primary key for signing and validating the SAS token.
   */
  primaryKey?: string;

  /**
   * A base64-encoded 256-bit secondary key for signing and validating the SAS token.
   */
  secondaryKey?: string;

  /**
   * A string that describes the authorization rule.
   */
  keyName?: string;
}

/**
 * Parameters supplied to the regenerate authorization rule operation, specifies which key needs to be reset.
 */
model RegenerateAccessKeyParameters {
  /**
   * The access key to regenerate.
   */
  keyType: KeyType;

  /**
   * Optional. If the key value is provided, this is set to key type, or autogenerated key value set for key type.
   */
  key?: string;
}

/**
 * Properties of the HybridConnection.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model HybridConnectionProperties {
  /**
   * The time the hybrid connection was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The time the namespace was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * The number of listeners for this hybrid connection. Note that min : 1 and max:25 are supported.
   */
  @visibility(Lifecycle.Read)
  @maxValue(25)
  listenerCount?: int32;

  /**
   * Returns true if client authorization is needed for this hybrid connection; otherwise, false.
   */
  requiresClientAuthorization?: boolean;

  /**
   * The usermetadata is a placeholder to store user-defined string data for the hybrid connection endpoint. For example, it can be used to store descriptive data, such as a list of teams and their contact information. Also, user-defined configuration settings can be stored.
   */
  userMetadata?: string;
}

/**
 * Description of the check name availability request properties.
 */
model CheckNameAvailability {
  /**
   * The namespace name to check for availability. The namespace name can contain only letters, numbers, and hyphens. The namespace must start with a letter, and it must end with a letter or number.
   */
  name: string;
}

/**
 * Description of the check name availability request properties.
 */
model CheckNameAvailabilityResult {
  /**
   * The detailed info regarding the reason associated with the namespace.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Value indicating namespace is available. Returns true if the namespace is available; otherwise, false.
   */
  nameAvailable?: boolean;

  /**
   * The reason for unavailability of a namespace.
   */
  reason?: UnavailableReason;
}

/**
 * SKU of the namespace.
 */
model Sku {
  /**
   * Name of this SKU.
   */
  name: SkuName;

  /**
   * The tier of this SKU.
   */
  tier?: SkuTier;
}

/**
 * Properties of the namespace.
 */
model RelayNamespaceProperties {
  /**
   * Provisioning state of the Namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  /**
   * Status of the Namespace.
   */
  @visibility(Lifecycle.Read)
  status?: string;

  /**
   * The time the namespace was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The time the namespace was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * Endpoint you can use to perform Service Bus operations.
   */
  @visibility(Lifecycle.Read)
  serviceBusEndpoint?: string;

  /**
   * Identifier for Azure Insights metrics.
   */
  @visibility(Lifecycle.Read)
  metricId?: string;

  /**
   * List of private endpoint connections.
   */
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * This determines if traffic is allowed over public network. By default it is enabled.
   */
  publicNetworkAccess?: PublicNetworkAccess = "Enabled";
}

/**
 * Properties of the private endpoint connection resource.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The Private Endpoint resource for this Connection.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * Details about the state of the connection.
   */
  privateLinkServiceConnectionState?: ConnectionState;

  /**
   * Provisioning state of the Private Endpoint Connection.
   */
  provisioningState?: EndPointProvisioningState;
}

/**
 * PrivateEndpoint information.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint.
   */
  id?: string;
}

/**
 * ConnectionState information.
 */
model ConnectionState {
  /**
   * Status of the connection.
   */
  status?: PrivateLinkConnectionStatus;

  /**
   * Description of the connection state.
   */
  description?: string;
}

/**
 * Definition of resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model TrackedResource extends Resource {
  /**
   * Resource location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * The resource definition.
 */
model Resource {
  /**
   * Resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * Description of a namespace resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model RelayUpdateParameters extends ResourceNamespacePatch {
  /**
   * SKU of the namespace.
   */
  sku?: Sku;

  /**
   * Description of Relay namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: RelayNamespaceProperties;
}

/**
 * Definition of resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ResourceNamespacePatch extends Resource {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Properties of PrivateLinkResource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  requiredMembers?: string[];

  /**
   * The private link resource Private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * NetworkRuleSet properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model NetworkRuleSetProperties {
  /**
   * Value that indicates whether Trusted Service Access is Enabled or not.
   */
  trustedServiceAccessEnabled?: boolean;

  /**
   * Default Action for Network Rule Set
   */
  defaultAction?: DefaultAction;

  /**
   * This determines if traffic is allowed over public network. By default it is enabled
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * List of IpRules
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  ipRules?: NWRuleSetIpRules[];
}

/**
 * The response from the List namespace operation.
 */
model NWRuleSetIpRules {
  /**
   * IP Mask
   */
  ipMask?: string;

  /**
   * The IP Filter Action
   */
  action?: NetworkRuleIPAction;
}

/**
 * A Relay REST API operation
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  @visibility(Lifecycle.Read)
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  @visibility(Lifecycle.Read)
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  @visibility(Lifecycle.Read)
  origin?: string;

  /**
   * Properties of the operation
   */
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @Azure.ResourceManager.Private.conditionalClientFlatten
  properties?: Record<unknown>;
}

/**
 * Operation display payload
 */
model OperationDisplay {
  /**
   * Resource provider of the operation
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * Resource of the operation
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * Localized friendly name for the operation
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * Localized friendly description for the operation
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Properties of the WCF relay.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WcfRelayProperties {
  /**
   * Returns true if the relay is dynamic; otherwise, false.
   */
  @visibility(Lifecycle.Read)
  isDynamic?: boolean;

  /**
   * The time the WCF relay was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The time the namespace was updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  updatedAt?: utcDateTime;

  /**
   * The number of listeners for this relay. Note that min :1 and max:25 are supported.
   */
  @visibility(Lifecycle.Read)
  @maxValue(25)
  listenerCount?: int32;

  /**
   * WCF relay type.
   */
  relayType?: Relaytype;

  /**
   * Returns true if client authorization is needed for this relay; otherwise, false.
   */
  requiresClientAuthorization?: boolean;

  /**
   * Returns true if transport security is needed for this relay; otherwise, false.
   */
  requiresTransportSecurity?: boolean;

  /**
   * The usermetadata is a placeholder to store user-defined string data for the WCF Relay endpoint. For example, it can be used to store descriptive data, such as list of teams and their contact information. Also, user-defined configuration settings can be stored.
   */
  userMetadata?: string;
}

/**
 * Result of the List private link resources operation.
 */
model PrivateLinkResourcesListResult{
  @doc("A collection of private link resources")
  value: PrivateLinkResource[];

  @doc("A link for the next page of private link resources.")
  nextLink?: ResourceLocation<PrivateLinkResource>;
};

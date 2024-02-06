import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedNetworkFabric;

/**
 * Specify action.
 */
enum Action {
  @doc("This will allow the HTTP requests")
  Allow,

  @doc("This will not allow the HTTP requests")
  Deny,
}

/**
 * Specify condition.
 */
enum Condition {
  @doc("and condition for all proxy rules")
  and,

  @doc("or condition for all proxy rules")
  or,
}

/**
 * The current provisioning state.
 */
enum ProvisioningState {
  @doc("Requested provisioing state has been accepted")
  Accepted,

  @doc("Requested provisioing state has been successfully applied")
  Succeeded,

  @doc("Requested provisioing state is being applied")
  Updating,

  @doc("Requested provisioing state is deleting a resource")
  Deleting,

  @doc("Requested provisioing state could not be applied")
  Failed,

  @doc("Requested provisioing state has been has been canceled")
  Canceled,
}

/**
 * IP Address type that needs to be matched.
 */
enum SourceDestinationType {
  @doc("IP Address that needs to be matched is from source")
  SourceIP,

  @doc("Destination IP Address that needs to be matched")
  DestinationIP,
}

/**
 * IP Address type.
 */
enum IPAddressType {
  @doc("IPv4 type IP address has been used")
  IPv4,

  @doc("IPv6 type IP address has been used")
  IPv6,
}

/**
 * Boolean Enum. Example- True/False
 */
enum BooleanEnumProperty {
  @doc("Represent true for boolean enum")
  True,

  @doc("Represent false for boolean enum")
  False,
}

/**
 * community action types. Example: Permit | Deny.
 */
enum CommunityActionTypes {
  @doc("Represent community action is permitted")
  Permit,

  @doc("Represent community action is permitted")
  Deny,
}

/**
 * Internet Gateway Rule Properties defines the resource properties.
 */
model InternetGatewayRuleProperties {
  /**
   * Rules for the InternetGateways
   */
  ruleProperties: RuleProperties;

  /**
   * Provisioning state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * List of Internet Gateway resource Id.
   */
  @visibility("read")
  internetGatewayIds?: string[];
}

/**
 * Rules for the InternetGateways
 */
model RuleProperties {
  /**
   * Specify action.
   */
  action: Action;

  /**
   * Specify condition.
   */
  condition?: Condition;

  /**
   * List of Addresses to be allowed or denied.
   */
  addressList: string[];

  /**
   * List of source remote ip to be allowed or denied.
   */
  sourceAddressList?: string[];
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. E.g. "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}"
   */
  @visibility("read")
  id?: ResourceIdentifier;

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
 * The Internet Gateway Rules patch resource definition.
 */
model InternetGatewayRulePatch is TagsUpdate;

/**
 * Base tracked resource type for PATCH updates.
 */
model TagsUpdate {
  /**
   * Resource tags
   */
  tags?: Record<string>;
}

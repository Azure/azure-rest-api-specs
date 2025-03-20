import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ManagedNetworkFabric;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Specify action.
 */
enum action {
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
  @doc("Requested provisioning state has been accepted")
  Accepted,

  @doc("Requested provisioning state has been successfully applied")
  Succeeded,

  @doc("Requested provisioning state is being applied")
  Updating,

  @doc("Requested provisioning state is deleting a resource")
  Deleting,

  @doc("Requested provisioning state could not be applied")
  Failed,

  @doc("Requested provisioning state has been has been canceled")
  Canceled,
}

/**
 * Internet Gateway Rule Properties defines the resource properties.
 */
model InternetGatewayRuleProperties is AnnotationResource {
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
  action: action;

  /**
   * Specify condition.
   */
  condition: Condition;

  /**
   * List of Addresses to be allowed or denied.
   */
  destinationAddressList?: string[];

  /**
   * List of source remote ip to be allowed or denied.
   */
  sourceAddressList?: string[];
}

/**
 * Switch configuration entries require a description to discern between configuration groups.
 */
model AnnotationResource {
  /**
   * Switch configuration description.
   */
  annotation?: string;
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

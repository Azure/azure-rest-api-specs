import "./common.tsp";

namespace Microsoft.ManagedNetworkFabric;
/**
 * Internet Gateway Rule Properties defines the resource properties.
 */
model InternetGatewayRuleProperties {
  /*
   * @allof is currently not supported in Typespec. One wat to inherity all properties is using the spread operator.
   */
  ...AnnotationResource;

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
   * List of Addresses to be allowed or denied.
   */
  addressList: string[];
}

/**
 * The Internet Gateway Rules patch resource definition.
 */
model InternetGatewayRulePatch is TagsUpdate;

/**
 * Specify action.
 */
union Action {
  @doc("Action Allow")
  Allow: "Allow",

  @doc("Action Deny")
  Deny: "Deny",

  string,
}

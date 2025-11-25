import "./common.tsp";

using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("Internet Gateway Rule Properties defines the resource properties.")
model InternetGatewayRuleProperties {
  ...AnnotationResource;

  @doc("Rules for the InternetGateways")
  ruleProperties: RuleProperties;

  @doc("Details of the last operation performed on the resource")
  @visibility(Lifecycle.Read)
  @added(Versions.v2024_06_15_preview)
  lastOperation?: LastOperationProperties;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("List of Internet Gateway resource Id.")
  @visibility(Lifecycle.Read)
  internetGatewayIds?: string[];
}

@doc("Rules for the InternetGateways")
model RuleProperties {
  @doc("Specify action.")
  action: Action;

  @doc("List of Addresses to be allowed or denied.")
  @madeOptional(Versions.v2024_06_15_preview)
  addressList?: string[];

  @doc("Specify rule condition.")
  @added(Versions.v2024_06_15_preview)
  condition?: RuleCondition;

  @doc("List of Addresses to be allowed or denied.")
  @added(Versions.v2024_06_15_preview)
  destinationAddressList?: string[];

  @doc("List of source IPv4 and IPv6 address to be allowed or denied.")
  @added(Versions.v2024_06_15_preview)
  sourceAddressList?: string[];

  @doc("List of header Name and source addresses associated with the header.")
  @added(Versions.v2024_06_15_preview)
  @Azure.ResourceManager.identifiers(#[])
  headerAddressList?: HeaderAddressProperties[];
}

@doc("The Internet Gateway Rules patch resource definition.")
model InternetGatewayRulePatch is TagsUpdate;

@doc("Specify action.")
union Action {
  @doc("Action Allow")
  Allow: "Allow",

  @doc("Action Deny")
  Deny: "Deny",

  string,
}

@doc("Header name and source addresses associated with the header.")
@added(Versions.v2024_06_15_preview)
model HeaderAddressProperties {
  @doc("Name of the header.")
  headerName?: string;

  @doc("List of source remote IP to be allowed or denied.")
  @minItems(1)
  addressList?: string[];
}

@added(Versions.v2024_06_15_preview)
@doc("Specify Rule condition.")
union RuleCondition {
  @doc("And Rule-Condition.")
  And: "And",

  @doc("Or Rule-Condition.")
  Or: "Or",

  string,
}

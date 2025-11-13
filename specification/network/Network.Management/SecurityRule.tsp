import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSecurityGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Network security rule.
 */
@parentResource(NetworkSecurityGroup)
model SecurityRule
  is Azure.ResourceManager.ProxyResource<SecurityRulePropertiesFormat> {
  ...ResourceNameParameter<
    Resource = SecurityRule,
    KeyName = "securityRuleName",
    SegmentName = "securityRules",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

alias SecurityRuleOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the network security group. */
    @path
    @segment("networkSecurityGroups")
    @key
    networkSecurityGroupName: string;
  },
  {
    /** The name of the security rule. */
    @path
    @segment("securityRules")
    @key
    securityRuleName: string;
  }
>;

@armResourceOperations
interface SecurityRules {
  /**
   * Get the specified network security rule.
   */
  get is SecurityRuleOps.Read<SecurityRule>;

  /**
   * Creates or updates a security rule in the specified network security group.
   */
  createOrUpdate is SecurityRuleOps.CreateOrUpdateAsync<SecurityRule>;

  /**
   * Deletes the specified network security rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is SecurityRuleOps.DeleteWithoutOkAsync<
    SecurityRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all security rules in a network security group.
   */
  list is SecurityRuleOps.List<SecurityRule>;
}
alias DefaultSecurityRuleOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the network security group. */
    @path
    @segment("networkSecurityGroups")
    @key
    networkSecurityGroupName: string;
  },
  {
    /** The name of the default security rule. */
    @path
    @segment("defaultSecurityRules")
    @key
    defaultSecurityRuleName: string;
  }
>;

@armResourceOperations
interface DefaultSecurityRules {
  /**
   * Get the specified default network security rule.
   */
  get is DefaultSecurityRuleOps.Read<SecurityRule>;

  /**
   * Gets all default security rules in a network security group.
   */
  list is DefaultSecurityRuleOps.List<SecurityRule>;
}

@@doc(SecurityRule.name, "The name of the security rule.");
@@doc(SecurityRule.properties, "Properties of the security rule.");
@@doc(SecurityRules.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network security rule operation."
);

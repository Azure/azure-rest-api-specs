import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkSecurityGroup.tsp";
import "../Common/SecurityRule.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Network;

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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations
interface SecurityRules {
  /**
   * Get the specified network security rule.
   */
  get is SecurityRuleOps.Read<SecurityRule, OverrideErrorType = CloudError>;

  /**
   * Creates or updates a security rule in the specified network security group.
   */
  createOrUpdate is SecurityRuleOps.CreateOrUpdateAsync<
    SecurityRule,
    OverrideErrorType = CloudError
  >;

  /**
   * Deletes the specified network security rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is SecurityRuleOps.DeleteWithoutOkAsync<
    SecurityRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all security rules in a network security group.
   */
  list is SecurityRuleOps.List<SecurityRule, OverrideErrorType = CloudError>;
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

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@armResourceOperations(#{ omitTags: true })
interface DefaultSecurityRules {
  /**
   * Get the specified default network security rule.
   */
  @tag("SecurityRules")
  get is DefaultSecurityRuleOps.Read<
    SecurityRule,
    OverrideErrorType = CloudError
  >;

  /**
   * Gets all default security rules in a network security group.
   */
  @tag("SecurityRules")
  list is DefaultSecurityRuleOps.List<
    SecurityRule,
    OverrideErrorType = CloudError
  >;
}

@@doc(SecurityRule.name, "The name of the security rule.");
@@doc(SecurityRule.properties, "Properties of the security rule.");
@@doc(SecurityRules.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network security rule operation."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An Azure SQL DB Server Outbound Firewall Rule.
 */
@parentResource(Server)
model OutboundFirewallRule
  is Azure.ResourceManager.ProxyResource<OutboundFirewallRuleProperties> {
  ...ResourceNameParameter<
    Resource = OutboundFirewallRule,
    KeyName = "outboundRuleFqdn",
    SegmentName = "outboundFirewallRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface OutboundFirewallRules {
  /**
   * Gets an outbound firewall rule.
   */
  get is ArmResourceRead<OutboundFirewallRule>;

  /**
   * Create a outbound firewall rule with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    OutboundFirewallRule,
    Request = void,
    Response = ArmResourceUpdatedResponse<OutboundFirewallRule> | ArmResourceCreatedResponse<
      OutboundFirewallRule,
      ArmLroLocationHeader<FinalResult = OutboundFirewallRule> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a outbound firewall rule with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    OutboundFirewallRule,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all outbound firewall rules on a server.
   */
  listByServer is ArmResourceListByParent<OutboundFirewallRule>;
}

@@doc(OutboundFirewallRule.name, "");
@@doc(OutboundFirewallRule.properties, "Resource properties.");

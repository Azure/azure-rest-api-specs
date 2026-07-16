import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * IP firewall rule
 */
@parentResource(Workspace)
model IpFirewallRuleInfo
  is Azure.ResourceManager.ProxyResource<IpFirewallRuleProperties> {
  ...ResourceNameParameter<
    Resource = IpFirewallRuleInfo,
    KeyName = "ruleName",
    SegmentName = "firewallRules",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IpFirewallRuleInfos {
  /**
   * Get a firewall rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IpFirewallRules_Get")
  get is ArmResourceRead<IpFirewallRuleInfo>;

  /**
   * Creates or updates a firewall rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("IpFirewallRules_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IpFirewallRuleInfo,
    Response =
      | ArmResourceUpdatedResponse<IpFirewallRuleInfo>
      | ArmResourceCreatedResponse<
          IpFirewallRuleInfo,
          ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a firewall rule
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IpFirewallRules_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    IpFirewallRuleInfo,
    Response =
      | ArmResponse<IpFirewallRuleInfo>
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of firewall rules
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("IpFirewallRules_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<IpFirewallRuleInfo>;
}

@@doc(IpFirewallRuleInfo.name, "The IP firewall rule name");
@@doc(IpFirewallRuleInfo.properties, "IP firewall rule properties");
@@doc(
  IpFirewallRuleInfos.createOrUpdate::parameters.resource,
  "IP firewall rule properties"
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FirewallPolicy.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Rule Collection Group resource.
 */
@parentResource(FirewallPolicy)
model FirewallPolicyRuleCollectionGroup
  is Azure.ResourceManager.ProxyResource<FirewallPolicyRuleCollectionGroupProperties> {
  ...ResourceNameParameter<
    Resource = FirewallPolicyRuleCollectionGroup,
    KeyName = "ruleCollectionGroupName",
    SegmentName = "ruleCollectionGroups",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface FirewallPolicyRuleCollectionGroups {
  /**
   * Gets the specified FirewallPolicyRuleCollectionGroup.
   */
  get is ArmResourceRead<FirewallPolicyRuleCollectionGroup, Error = CloudError>;

  /**
   * Creates or updates the specified FirewallPolicyRuleCollectionGroup.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<FirewallPolicyRuleCollectionGroup, Error = CloudError>;

  /**
   * Deletes the specified FirewallPolicyRuleCollectionGroup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<FirewallPolicyRuleCollectionGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,  Error = CloudError>;

  /**
   * Lists all FirewallPolicyRuleCollectionGroups in a FirewallPolicy resource.
   */
  list is ArmResourceListByParent<FirewallPolicyRuleCollectionGroup, Error = CloudError>;
}

@@doc(FirewallPolicyRuleCollectionGroup.name,
  "The name of the FirewallPolicyRuleCollectionGroup."
);
@@doc(FirewallPolicyRuleCollectionGroup.properties,
  "The properties of the firewall policy rule collection group."
);
@@doc(FirewallPolicyRuleCollectionGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update FirewallPolicyRuleCollectionGroup operation."
);

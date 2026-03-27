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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(FirewallPolicy)
@Http.Private.includeInapplicableMetadataInPayload(false)
model FirewallPolicyRuleCollectionGroup extends SubResourceModel {
  properties?: FirewallPolicyRuleCollectionGroupProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("ruleCollectionGroupName")
  @segment("ruleCollectionGroups")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FirewallPolicyRuleCollectionGroup,
    Error = CloudError
  >;

  /**
   * Deletes the specified FirewallPolicyRuleCollectionGroup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    FirewallPolicyRuleCollectionGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all FirewallPolicyRuleCollectionGroups in a FirewallPolicy resource.
   */
  list is ArmResourceListByParent<
    FirewallPolicyRuleCollectionGroup,
    Error = CloudError
  >;
}

@@doc(FirewallPolicyRuleCollectionGroup.name,
  "The name of the FirewallPolicyRuleCollectionGroup."
);
@@doc(FirewallPolicyRuleCollectionGroup.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(FirewallPolicyRuleCollectionGroup.properties,
  "The properties of the firewall policy rule collection group."
);
@@doc(FirewallPolicyRuleCollectionGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update FirewallPolicyRuleCollectionGroup operation."
);

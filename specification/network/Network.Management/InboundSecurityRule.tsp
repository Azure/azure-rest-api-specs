import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkVirtualAppliance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * NVA Inbound Security Rule resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.feature(Features.virtualNetwork)
@parentResource(NetworkVirtualAppliance)
@Http.Private.includeInapplicableMetadataInPayload(false)
model InboundSecurityRule extends SubResourceModel {
  properties?: InboundSecurityRuleProperties;

  /**
   * The name of the resource that is unique within a resource group. This name can be used to access the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("ruleCollectionName")
  @segment("inboundSecurityRules")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface InboundSecurityRuleOperationGroup {
  /**
   * Retrieves the available specified Network Virtual Appliance Inbound Security Rules Collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("InboundSecurityRule_Get")
  get is ArmResourceRead<InboundSecurityRule, Error = CloudError>;

  /**
   * Creates or updates the specified Network Virtual Appliance Inbound Security Rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("InboundSecurityRule_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InboundSecurityRule,
    Error = CloudError
  >;
}

@@doc(InboundSecurityRule.name, "The name of security rule collection.");
@@doc(InboundSecurityRule.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(InboundSecurityRule.properties,
  "The properties of the Inbound Security Rules."
);
@@doc(InboundSecurityRuleOperationGroup.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Network Virtual Appliance Inbound Security Rules operation."
);

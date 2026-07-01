import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkVirtualAppliance.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Common;

namespace Microsoft.Network;
/**
 * NVA Inbound Security Rule resource.
 */
@featureFile(Features.virtualNetwork)
@parentResource(NetworkVirtualAppliance)
model InboundSecurityRule
  is SubResourceInstance<InboundSecurityRuleProperties> {
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
@featureFile(Features.virtualNetwork)
@armResourceOperations(#{ omitTags: true })
interface InboundSecurityRuleOperationGroup {
  /**
   * Retrieves the available specified Network Virtual Appliance Inbound Security Rules Collection.
   */
  get is ArmResourceRead<InboundSecurityRule, Error = CloudError>;

  /**
   * Creates or updates the specified Network Virtual Appliance Inbound Security Rules.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InboundSecurityRule,
    Error = CloudError
  >;
}

@@doc(InboundSecurityRule.name, "The name of security rule collection.");
@@doc(
  InboundSecurityRule.name,
  "The name of the resource that is unique within a resource group. This name can be used to access the resource."
);
@@doc(
  InboundSecurityRule.properties,
  "The properties of the Inbound Security Rules."
);
@@doc(
  InboundSecurityRuleOperationGroup.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Network Virtual Appliance Inbound Security Rules operation."
);

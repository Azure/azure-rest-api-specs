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
@parentResource(NetworkVirtualAppliance)
model InboundSecurityRule
  is Azure.ResourceManager.ProxyResource<InboundSecurityRuleProperties> {
  ...ResourceNameParameter<
    Resource = InboundSecurityRule,
    KeyName = "ruleCollectionName",
    SegmentName = "inboundSecurityRules",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

@armResourceOperations
interface InboundSecurityRuleOperationGroup {
  /**
   * Retrieves the available specified Network Virtual Appliance Inbound Security Rules Collection.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("InboundSecurityRule_Get")
  get is ArmResourceRead<InboundSecurityRule, Error = CloudError>;

  /**
   * Creates or updates the specified Network Virtual Appliance Inbound Security Rules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("InboundSecurityRule_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    InboundSecurityRule,
    Error = CloudError
  >;
}

@@doc(InboundSecurityRule.name, "The name of security rule collection.");
@@doc(InboundSecurityRule.properties,
  "The properties of the Inbound Security Rules."
);
@@doc(InboundSecurityRuleOperationGroup.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Network Virtual Appliance Inbound Security Rules operation."
);

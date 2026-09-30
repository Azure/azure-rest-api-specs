import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SBNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Description of NetworkRuleSet resource.
 */
@singleton("default")
@parentResource(SBNamespace)
model NetworkRuleSet
  is Azure.ResourceManager.ProxyResource<NetworkRuleSetProperties> {
  ...ResourceNameParameter<
    Resource = NetworkRuleSet,
    KeyName = "networkRuleSet",
    SegmentName = "networkRuleSets",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Required to preserve wire compatibility with the legacy Service Bus ARM REST contract during OpenAPI-to-TypeSpec conversion; changing this shape would be a breaking change."
  @visibility(Lifecycle.Read)
  location?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Required to preserve wire compatibility with the legacy Service Bus ARM REST contract during OpenAPI-to-TypeSpec conversion; changing this shape would be a breaking change."
@armResourceOperations
@tag("Namespaces")
interface NetworkRuleSets {
  /**
   * Gets NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to preserve wire compatibility with the legacy Service Bus ARM REST contract during OpenAPI-to-TypeSpec conversion; changing this shape would be a breaking change."
  getNetworkRuleSet is ArmResourceRead<NetworkRuleSet, Error = ErrorResponse>;

  /**
   * Create or update NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to preserve wire compatibility with the legacy Service Bus ARM REST contract during OpenAPI-to-TypeSpec conversion; changing this shape would be a breaking change."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Required to preserve wire compatibility with the legacy Service Bus ARM REST contract during OpenAPI-to-TypeSpec conversion; changing this shape would be a breaking change."
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<
    NetworkRuleSet,
    Response = ArmResourceUpdatedResponse<NetworkRuleSet>,
    Error = ErrorResponse
  >;

  /**
   * Gets list of NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Required to preserve wire compatibility with the legacy Service Bus ARM REST contract during OpenAPI-to-TypeSpec conversion; changing this shape would be a breaking change."
  listNetworkRuleSets is ArmResourceListByParent<
    NetworkRuleSet,
    Error = ErrorResponse
  >;
}

@@doc(NetworkRuleSet.name, "");
@@doc(NetworkRuleSet.properties, "NetworkRuleSet properties");
@@doc(
  NetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "The Namespace IpFilterRule."
);

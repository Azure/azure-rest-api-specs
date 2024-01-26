import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ServiceBusNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ServiceBus;
/**
 * Description of NetworkRuleSet resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(ServiceBusNamespace)
@includeInapplicableMetadataInPayload(false)
model ServiceBusNetworkRuleSet extends ProxyResource {
  @key("networkRuleSet")
  @segment("networkRuleSets")
  @visibility("read")
  name: string;

  /**
   * The system meta data relating to this resource.
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * NetworkRuleSet properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: NetworkRuleSetProperties;
}

@armResourceOperations
interface ServiceBusNetworkRuleSets {
  /**
   * Gets NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_GetNetworkRuleSet")
  getNetworkRuleSet is ArmResourceRead<ServiceBusNetworkRuleSet>;

  /**
   * Create or update NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_CreateOrUpdateNetworkRuleSet")
  createOrUpdateNetworkRuleSet is ArmResourceCreateOrReplaceSync<ServiceBusNetworkRuleSet>;

  /**
   * Gets list of NetworkRuleSet for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Namespaces_ListNetworkRuleSets")
  listNetworkRuleSets is ArmResourceListByParent<ServiceBusNetworkRuleSet>;
}

@@projectedName(ServiceBusNetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServiceBusNetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServiceBusNetworkRuleSets.createOrUpdateNetworkRuleSet::parameters.resource,
  "The Namespace IpFilterRule."
);

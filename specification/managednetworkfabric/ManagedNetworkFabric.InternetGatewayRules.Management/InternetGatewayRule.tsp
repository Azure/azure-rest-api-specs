import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Internet Gateway Rule resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  InternetGatewayRuleProperties
)
model InternetGatewayRule extends TrackedResourceBase {
  /**
   * Name of the Internet Gateway rule.
   */
  @path
  @key("internetGatewayRuleName")
  @segment("internetGatewayRules")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: InternetGatewayRuleProperties;
}

@armResourceOperations
interface InternetGatewayRules {
  /**
   * Gets an Internet Gateway Rule resource.
   */
  get is ArmResourceRead<InternetGatewayRule>;

  /**
   * Creates an Internet Gateway rule resource.
   */
  create is ArmResourceCreateOrReplaceAsync<
    InternetGatewayRule,
    BaseParameters<InternetGatewayRule>,
    ArmAsyncOperationHeader
  >;

  /**
   * API to update certain properties of the Internet Gateway Rule resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    InternetGatewayRule,
    InternetGatewayRulePatch,
    BaseParameters<InternetGatewayRule>,
    ArmLroLocationHeader
  >;

  /**
   * Implements Internet Gateway Rules DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    InternetGatewayRule,
    BaseParameters<InternetGatewayRule>,
    ArmAsyncOperationHeader
  >;

  /**
   * Implements Internet Gateway Rules list by resource group GET method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("InternetGatewayRules_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<InternetGatewayRule>;

  /**
   * List all Internet Gateway rules in the given subscription.
   */
  listBySubscription is ArmListBySubscription<InternetGatewayRule>;
}

@@projectedName(InternetGatewayRules.create::parameters.resource,
  "json",
  "body"
);
@@extension(InternetGatewayRules.create::parameters.resource,
  "x-ms-client-name",
  "Request payload body"
);
@@doc(InternetGatewayRules.create::parameters.resource, "Request payload.");
@@projectedName(InternetGatewayRules.update::parameters.properties,
  "json",
  "body"
);
@@extension(InternetGatewayRules.update::parameters.properties,
  "x-ms-client-name",
  "Internet Gateway Rule properties to update body"
);
@@doc(InternetGatewayRules.update::parameters.properties,
  "Internet Gateway Rule properties to update."
);

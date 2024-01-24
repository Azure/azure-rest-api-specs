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
 * The NetworkTapRule resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(NetworkTapRuleProperties)
@includeInapplicableMetadataInPayload(false)
model NetworkTapRule extends TrackedResourceBase {
  /**
   * Name of the Network Tap Rule.
   */
  @path
  @key("networkTapRuleName")
  @segment("networkTapRules")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: NetworkTapRuleProperties;
}

@armResourceOperations
interface NetworkTapRules {
  /**
   * Get Network Tap Rule resource details.
   */
  get is ArmResourceRead<NetworkTapRule>;

  /**
   * Create Network Tap Rule resource.
   */
  create is ArmResourceCreateOrReplaceAsync<
    NetworkTapRule,
    BaseParameters<NetworkTapRule>,
    ArmAsyncOperationHeader
  >;

  /**
   * Update certain properties of the Network Tap Rule resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    NetworkTapRule,
    NetworkTapRulePatch,
    BaseParameters<NetworkTapRule>,
    ArmLroLocationHeader
  >;

  /**
   * Delete Network Tap Rule resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkTapRule,
    BaseParameters<NetworkTapRule>,
    ArmLroLocationHeader
  >;

  /**
   * List all the Network Tap Rule resources in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NetworkTapRules_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<NetworkTapRule>;

  /**
   * List all the Network Tap Rule resources in the given subscription.
   */
  listBySubscription is ArmListBySubscription<NetworkTapRule>;

  /**
   * Implements the operation to the underlying resources.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkTapRule,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkTapRule>,
    ArmLroLocationHeader
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  resync is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkTapRule>,
    ArmLroLocationHeader
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    ValidateConfigurationResponse,
    BaseParameters<NetworkTapRule>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkTapRules.create::parameters.resource, "json", "body");
@@extension(NetworkTapRules.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkTapRules.create::parameters.resource, "Request payload.");
@@projectedName(NetworkTapRules.update::parameters.properties, "json", "body");
@@extension(NetworkTapRules.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkTapRules.update::parameters.properties,
  "Network Tap Rule properties to update."
);
@@doc(NetworkTapRules.updateAdministrativeState::parameters.body,
  "Request payload."
);

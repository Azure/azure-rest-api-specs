import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The NetworkTapRule resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@includeInapplicableMetadataInPayload(false)
model NetworkTapRule extends Azure.ResourceManager.Foundations.TrackedResource {
  /**
   * Name of the Network Tap Rule.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkTapRuleName")
  @segment("networkTapRules")
  @visibility("read")
  name: string;

  /** The NetworkTapRule Properties */
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
  create is ArmResourceCreateOrReplaceAsync<NetworkTapRule>;

  /**
   * Update certain properties of the Network Tap Rule resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<NetworkTapRule, NetworkTapRulePatch>;

  /**
   * Delete Network Tap Rule resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkTapRule>;

  /**
   * List all the Network Tap Rule resources in the given resource group.
   */
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
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  resync is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    ValidateConfigurationResponse
  >;
}

@@doc(NetworkTapRules.create::parameters.resource, "Request payload.");
@@doc(NetworkTapRules.update::parameters.properties,
  "Network Tap Rule properties to update."
);
@@doc(NetworkTapRules.updateAdministrativeState::parameters.body,
  "Request payload."
);

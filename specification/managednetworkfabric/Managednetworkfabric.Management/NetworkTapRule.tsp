import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The NetworkTapRule resource definition.
 */
model NetworkTapRule
  is Azure.ResourceManager.TrackedResource<NetworkTapRuleProperties, false> {
  ...ResourceNameParameter<
    Resource = NetworkTapRule,
    KeyName = "networkTapRuleName",
    SegmentName = "networkTapRules",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkTapRule,
    PatchModel = NetworkTapRulePatch
  >;

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
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  resync is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Implements the operation to the underlying resources.
   */
  validateConfiguration is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    ArmResponse<ValidateConfigurationResponse>
  >;
}

@@doc(NetworkTapRule.name, "Name of the Network Tap Rule.");
@@doc(NetworkTapRule.properties, "Resource properties.");
@@doc(NetworkTapRules.create::parameters.resource, "Request payload.");
@@doc(NetworkTapRules.update::parameters.properties,
  "Network Tap Rule properties to update."
);
@@doc(NetworkTapRules.updateAdministrativeState::parameters.body,
  "Request payload."
);

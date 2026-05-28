import "../models/common.tsp";
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
@doc("The NetworkTapRule resource definition.")
model NetworkTapRule
  is Azure.ResourceManager.TrackedResource<NetworkTapRuleProperties, false> {
  @doc("Name of the Network Tap Rule.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkTapRuleName")
  @segment("networkTapRules")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

@@doc(NetworkTapRule.properties, "The NetworkTapRule Properties");
@armResourceOperations
interface NetworkTapRules {
  @doc("Get Network Tap Rule resource details.")
  get is ArmResourceRead<NetworkTapRule>;

  @doc("Create Network Tap Rule resource.")
  create is ArmResourceCreateOrReplaceAsync<NetworkTapRule>;

  @doc("Update certain properties of the Network Tap Rule resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<NetworkTapRule, NetworkTapRulePatch>;

  @doc("Delete Network Tap Rule resource.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkTapRule>;

  @doc("List all the Network Tap Rule resources in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<
    NetworkTapRule,
    Response = NetworkTapRulesListResult
  >;

  @doc("List all the Network Tap Rule resources in the given subscription.")
  listBySubscription is ArmListBySubscription<
    NetworkTapRule,
    Response = NetworkTapRulesListResult
  >;

  @doc("Implements the operation to the underlying resources.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkTapRule,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Implements the operation to the underlying resources.")
  @action("resync")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "resync")
  @sharedRoute
  resyncDeprecated is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Implements the operation to the underlying resources.")
  @action("resync")
  @added(Versions.v2025_07_15)
  @sharedRoute
  resync is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    NetworkTapRuleResyncResponse
  >;

  @doc("Implements the operation to the underlying resources.")
  validateConfiguration is ArmResourceActionAsync<
    NetworkTapRule,
    void,
    ValidateConfigurationResponse
  >;
}

@@doc(NetworkTapRules.create::parameters.resource, "Request payload.");
@@doc(
  NetworkTapRules.update::parameters.properties,
  "Network Tap Rule properties to update."
);
@@doc(
  NetworkTapRules.updateAdministrativeState::parameters.body,
  "Request payload."
);

import "../models/common.tsp";
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The NetworkTapRule resource definition.")
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkTapRule extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the Network Tap Rule.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkTapRuleName")
  @segment("networkTapRules")
  @visibility(Lifecycle.Read)
  name: string;

  /** The NetworkTapRule Properties */
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated: NetworkTapRuleProperties;

  /** The NetworkTapRule Properties */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties: NetworkTapRuleProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @added(Versions.v2025_07_15)
  @doc("The managed service identities assigned to this resource.")
  identity?: Azure.ResourceManager.Foundations.ManagedServiceIdentity;
}

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
  listByResourceGroup is ArmResourceListByParent<NetworkTapRule>;

  @doc("List all the Network Tap Rule resources in the given subscription.")
  listBySubscription is ArmListBySubscription<NetworkTapRule>;

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
@@doc(NetworkTapRules.update::parameters.properties,
  "Network Tap Rule properties to update."
);
@@doc(NetworkTapRules.updateAdministrativeState::parameters.body,
  "Request payload."
);

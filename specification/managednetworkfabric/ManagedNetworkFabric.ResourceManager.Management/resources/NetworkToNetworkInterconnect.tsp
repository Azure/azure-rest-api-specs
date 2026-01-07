import "./NetworkFabric.tsp";
import "../models/common.tsp";
import "../models/NetworkToNetworkInterconnect.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.Rest;

namespace Microsoft.ManagedNetworkFabric;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The Network To Network Interconnect resource definition.")
@Azure.ResourceManager.Private.armResourceInternal(L2IsolationDomainProperties)
@parentResource(NetworkFabric)
@Http.Private.includeInapplicableMetadataInPayload(false)
model NetworkToNetworkInterconnect
  extends Azure.ResourceManager.Foundations.ProxyResource {
  @doc("Name of the Network to Network Interconnect.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkToNetworkInterconnectName")
  @segment("networkToNetworkInterconnects")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @doc("The NetworkToNetworkInterconnect Properties")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "properties")
  propertiesDeprecated: NetworkToNetworkInterconnectProperties;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @doc("The NetworkToNetworkInterconnect Properties")
  @added(Versions.v2025_07_15)
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  properties: NetworkToNetworkInterconnectProperties;
}

@armResourceOperations
interface NetworkToNetworkInterconnects {
  @doc("Implements NetworkToNetworkInterconnects GET method.")
  get is ArmResourceRead<NetworkToNetworkInterconnect>;

  @doc("Configuration used to setup CE-PE connectivity PUT Method.")
  create is ArmResourceCreateOrReplaceAsync<NetworkToNetworkInterconnect>;

  @doc("Update certain properties of the Network To NetworkInterconnects resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkToNetworkInterconnect,
    NetworkToNetworkInterconnectPatch
  >;

  @doc("Implements NetworkToNetworkInterconnects DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<NetworkToNetworkInterconnect>;

  @doc("Implements Network To Network Interconnects list by Network Fabric GET method.")
  listByNetworkFabric is ArmResourceListByParent<NetworkToNetworkInterconnect>;

  @doc("Updates the NPB Static Route BFD Administrative State.")
  @removed(Versions.v2024_06_15_preview)
  @renamedFrom(
    Versions.v2025_07_15,
    "updateNpbStaticRouteBfdAdministrativeState"
  )
  @action("updateNpbStaticRouteBfdAdministrativeState")
  @sharedRoute
  updateNpbStaticRouteBfdAdministrativeStateDeprecated is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the NPB Static Route BFD Administrative State.")
  @added(Versions.v2025_07_15)
  @action("updateNpbStaticRouteBfdAdministrativeState")
  @sharedRoute
  updateNpbStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    UpdateAdministrativeStateResponse
  >;

  @doc("Updates the Admin State.")
  @action("updateAdministrativeState")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateAdministrativeState")
  @sharedRoute
  updateAdministrativeStateDeprecated is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Admin State.")
  @action("updateAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    UpdateAdministrativeStateResponse
  >;

  @doc("Updates the Admin State.")
  @added(Versions.v2024_06_15_preview)
  @action("updateBfdAdministrativeState")
  @removed(Versions.v2025_07_15)
  @renamedFrom(Versions.v2025_07_15, "updateBfdAdministrativeState")
  @sharedRoute
  updateBfdAdministrativeStateDeprecated is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    NniBfdAdministrativeStateRequest,
    NniBfdAdministrativeStateResponse
  >;

  @doc("Updates the Admin State.")
  @action("updateBfdAdministrativeState")
  @added(Versions.v2025_07_15)
  @sharedRoute
  updateBfdAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    NniUpdateBfdAdministrativeStateRequest,
    NniUpdateBfdAdministrativeStateResponse
  >;
}

@@doc(NetworkToNetworkInterconnects.create::parameters.resource,
  "Request payload."
);
@@doc(NetworkToNetworkInterconnects.update::parameters.properties,
  "Network to Network Interconnect properties to update."
);
@@doc(NetworkToNetworkInterconnects.updateNpbStaticRouteBfdAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkToNetworkInterconnects.updateNpbStaticRouteBfdAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(NetworkToNetworkInterconnects.updateAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(NetworkToNetworkInterconnects.updateBfdAdministrativeState::parameters.body,
  "Request payload."
);
@@doc(NetworkToNetworkInterconnects.updateAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);
@@doc(NetworkToNetworkInterconnects.updateBfdAdministrativeStateDeprecated::parameters.body,
  "Request payload."
);

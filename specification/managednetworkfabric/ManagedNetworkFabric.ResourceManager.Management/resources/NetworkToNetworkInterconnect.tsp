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
  updateNpbStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Admin State.")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  @doc("Updates the Admin State.")
  @added(Versions.v2024_06_15_preview)
  updateBfdAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    NniBfdAdministrativeStateRequest,
    NniBfdAdministrativeStateResponse
  >;
}

@@doc(NetworkToNetworkInterconnects.create::parameters.resource,
  "Request payload."
);
@@doc(NetworkToNetworkInterconnects.update::parameters.properties,
  "Network to Network Interconnect properties to update."
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

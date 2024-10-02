import "./NetworkFabric.tsp";
import "../models/common.tsp";
import "../models/NetworkToNetworkInterconnect.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network To Network Interconnect resource definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@parentResource(NetworkFabric)
@Azure.ResourceManager.Private.armResourceInternal(
  NetworkToNetworkInterconnectProperties
)
@includeInapplicableMetadataInPayload(false)
model NetworkToNetworkInterconnect
  extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Name of the Network to Network Interconnect.
   */
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("networkToNetworkInterconnectName")
  @segment("networkToNetworkInterconnects")
  @visibility("read")
  name: string;

  /** The NetworkToNetworkInterconnect Properties */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  properties: NetworkToNetworkInterconnectProperties;
}

@armResourceOperations
interface NetworkToNetworkInterconnects {
  /**
   * Implements NetworkToNetworkInterconnects GET method.
   */
  get is ArmResourceRead<NetworkToNetworkInterconnect>;

  /**
   * Configuration used to setup CE-PE connectivity PUT Method.
   */
  create is ArmResourceCreateOrReplaceAsync<NetworkToNetworkInterconnect>;

  /**
   * Update certain properties of the Network To NetworkInterconnects resource.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<
    NetworkToNetworkInterconnect,
    NetworkToNetworkInterconnectPatch
  >;

  /**
   * Implements NetworkToNetworkInterconnects DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkToNetworkInterconnect>;

  /**
   * Implements Network To Network Interconnects list by Network Fabric GET method.
   */
  listByNetworkFabric is ArmResourceListByParent<NetworkToNetworkInterconnect>;

  /**
   * Updates the NPB Static Route BFD Administrative State.
   */
  updateNpbStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
  >;

  /**
   * Updates the Admin State.
   */
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate
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

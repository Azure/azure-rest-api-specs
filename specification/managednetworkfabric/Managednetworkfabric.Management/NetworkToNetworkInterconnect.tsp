import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkFabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
/**
 * The Network To Network Interconnect resource definition.
 */
@parentResource(NetworkFabric)
model NetworkToNetworkInterconnect
  is Azure.ResourceManager.ProxyResource<
    NetworkToNetworkInterconnectProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = NetworkToNetworkInterconnect,
    KeyName = "networkToNetworkInterconnectName",
    SegmentName = "networkToNetworkInterconnects",
    NamePattern = ""
  >;
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
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    NetworkToNetworkInterconnect,
    PatchModel = NetworkToNetworkInterconnectPatch
  >;

  /**
   * Implements NetworkToNetworkInterconnects DELETE method.
   */
  delete is ArmResourceDeleteWithoutOkAsync<NetworkToNetworkInterconnect>;

  /**
   * Implements Network To Network Interconnects list by Network Fabric GET method.
   */
  listByNetworkFabric is ArmResourceListByParent<
    NetworkToNetworkInterconnect,
    Response = ArmResponse<NetworkToNetworkInterconnectsList>
  >;

  /**
   * Updates the NPB Static Route BFD Administrative State.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkToNetworkInterconnects_updateNpbStaticRouteBfdAdministrativeState")
  updateNpbStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;

  /**
   * Updates the Admin State.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NetworkToNetworkInterconnects_updateAdministrativeState")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    ArmResponse<CommonPostActionResponseForStateUpdate>
  >;
}

@@doc(NetworkToNetworkInterconnect.name,
  "Name of the Network to Network Interconnect."
);
@@doc(NetworkToNetworkInterconnect.properties, "Resource properties.");
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

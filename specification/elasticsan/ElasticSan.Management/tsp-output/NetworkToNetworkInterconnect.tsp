import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NetworkFabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ManagedNetworkFabric;
@doc("The Network To Network Interconnect resource definition.")
@parentResource(NetworkFabric)
model NetworkToNetworkInterconnect
  is ProxyResource<NetworkToNetworkInterconnectProperties> {
  @doc("Name of the Network to Network Interconnect.")
  @path
  @key("networkToNetworkInterconnectName")
  @segment("networkToNetworkInterconnects")
  name: string;
}

@armResourceOperations
interface NetworkToNetworkInterconnects {
  @doc("Implements NetworkToNetworkInterconnects GET method.")
  get is ArmResourceRead<NetworkToNetworkInterconnect>;

  @doc("Configuration used to setup CE-PE connectivity PUT Method.")
  create is ArmResourceCreateOrUpdateAsync<
    NetworkToNetworkInterconnect,
    BaseParameters<NetworkToNetworkInterconnect>,
    ArmAsyncOperationHeader
  >;

  @doc("Update certain properties of the Network To NetworkInterconnects resource.")
  update is ArmCustomPatchAsync<
    NetworkToNetworkInterconnect,
    NetworkToNetworkInterconnectPatch,
    BaseParameters<NetworkToNetworkInterconnect>,
    ArmLroLocationHeader
  >;

  @doc("Implements NetworkToNetworkInterconnects DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetworkToNetworkInterconnect,
    BaseParameters<NetworkToNetworkInterconnect>,
    ArmLroLocationHeader
  >;

  @doc("Implements Network To Network Interconnects list by Network Fabric GET method.")
  listByNetworkFabric is ArmResourceListByParent<NetworkToNetworkInterconnect>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the NPB Static Route BFD Administrative State.")
  @operationId("NetworkToNetworkInterconnects_updateNpbStaticRouteBfdAdministrativeState")
  updateNpbStaticRouteBfdAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkToNetworkInterconnect>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates the Admin State.")
  @operationId("NetworkToNetworkInterconnects_updateAdministrativeState")
  updateAdministrativeState is ArmResourceActionAsync<
    NetworkToNetworkInterconnect,
    UpdateAdministrativeState,
    CommonPostActionResponseForStateUpdate,
    BaseParameters<NetworkToNetworkInterconnect>,
    ArmLroLocationHeader
  >;
}

@@projectedName(NetworkToNetworkInterconnects.create::parameters.resource,
  "json",
  "body"
);
@@extension(NetworkToNetworkInterconnects.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetworkToNetworkInterconnects.create::parameters.resource,
  "Request payload."
);
@@projectedName(NetworkToNetworkInterconnects.update::parameters.properties,
  "json",
  "body"
);
@@extension(NetworkToNetworkInterconnects.update::parameters.properties,
  "x-ms-client-name",
  "body"
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

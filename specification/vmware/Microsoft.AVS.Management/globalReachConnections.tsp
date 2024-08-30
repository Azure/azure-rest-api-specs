namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@armResourceOperations
interface GlobalReachConnections {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("GlobalReachConnections_List")
  list is ArmResourceListByParent<
    GlobalReachConnection,
    Response = ArmResponse<ResourceList<GlobalReachConnection>>
  >;

  get is ArmResourceRead<GlobalReachConnection>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    GlobalReachConnection,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<GlobalReachConnection>;
}

@@encodedName(GlobalReachConnections.createOrUpdate::parameters.resource,
  "application/json",
  "globalReachConnection"
);
@@clientName(GlobalReachConnections.createOrUpdate::parameters.resource,
  "globalReachConnection"
);
@@OpenAPI.extension(GlobalReachConnections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "globalReachConnection"
);

@doc("Global Reach Connection provisioning state")
union GlobalReachConnectionProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is updating")
  Updating: "Updating",
}

@doc("Global Reach Connection status")
union GlobalReachConnectionStatus {
  string,

  @doc("is connected")
  Connected: "Connected",

  @doc("is connecting")
  Connecting: "Connecting",

  @doc("is disconnected")
  Disconnected: "Disconnected",
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SyncGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.StorageSync;
@doc("Server Endpoint object.")
@parentResource(SyncGroup)
model ServerEndpoint is ProxyResource<ServerEndpointProperties> {
  @doc("Name of Server Endpoint object.")
  @path
  @key("serverEndpointName")
  @segment("serverEndpoints")
  name: string;
}

@armResourceOperations
interface ServerEndpoints {
  @doc("Get a ServerEndpoint.")
  get is ArmResourceRead<ServerEndpoint>;

  @doc("Create a new ServerEndpoint.")
  create is ArmResourceCreateOrUpdateAsync<ServerEndpoint>;

  @doc("Patch a given ServerEndpoint.")
  update is ArmCustomPatchAsync<ServerEndpoint, ServerEndpointUpdateParameters>;

  @doc("Delete a given ServerEndpoint.")
  delete is ArmResourceDeleteAsync<ServerEndpoint>;

  @doc("Get a ServerEndpoint list.")
  listBySyncGroup is ArmResourceListByParent<ServerEndpoint>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Recall a server endpoint.")
  @operationId("ServerEndpoints_recallAction")
  recallAction is ArmResourceActionAsync<
    ServerEndpoint,
    RecallActionParameters,
    void
  >;
}

@@projectedName(ServerEndpoints.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerEndpoints.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerEndpoints.create::parameters.resource,
  "Body of Server Endpoint object."
);
@@projectedName(ServerEndpoints.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ServerEndpoints.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerEndpoints.update::parameters.properties,
  "Any of the properties applicable in PUT request."
);
@@projectedName(ServerEndpoints.recallAction::parameters.body,
  "json",
  "parameters"
);
@@extension(ServerEndpoints.recallAction::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerEndpoints.recallAction::parameters.body,
  "Body of Recall Action object."
);

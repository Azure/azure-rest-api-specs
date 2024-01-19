import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A server trust group.")
model ServerTrustGroup is ProxyResource<ServerTrustGroupProperties> {
  @doc("The name of the server trust group.")
  @path
  @key("serverTrustGroupName")
  @segment("serverTrustGroups")
  name: string;
}

@armResourceOperations
interface ServerTrustGroups {
  @doc("Gets a server trust group.")
  get is ArmResourceRead<ServerTrustGroup>;

  @doc("Creates or updates a server trust group.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerTrustGroup>;

  @doc("Deletes a server trust group.")
  delete is ArmResourceDeleteAsync<ServerTrustGroup>;

  @doc("Lists a server trust group.")
  listByLocation is ArmResourceListByParent<ServerTrustGroup>;
}

@@projectedName(ServerTrustGroups.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerTrustGroups.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerTrustGroups.createOrUpdate::parameters.resource,
  "The server trust group parameters."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("Server communication link.")
@parentResource(Server)
model ServerCommunicationLink
  is ProxyResource<ServerCommunicationLinkProperties> {
  @doc("The name of the server communication link.")
  @path
  @key("communicationLinkName")
  @segment("communicationLinks")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ServerCommunicationLinks {
  @doc("Returns a server communication link.")
  get is ArmResourceRead<ServerCommunicationLink>;

  @doc("Creates a server communication link.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ServerCommunicationLink>;

  @doc("Deletes a server communication link.")
  delete is ArmResourceDeleteSync<ServerCommunicationLink>;

  @doc("Gets a list of server communication links.")
  listByServer is ArmResourceListByParent<ServerCommunicationLink>;
}

@@projectedName(ServerCommunicationLinks.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerCommunicationLinks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerCommunicationLinks.createOrUpdate::parameters.resource,
  "The required parameters for creating a server communication link."
);

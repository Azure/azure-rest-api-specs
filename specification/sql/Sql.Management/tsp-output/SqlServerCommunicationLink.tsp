import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlServer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Server communication link.")
@parentResource(SqlServer)
model SqlServerCommunicationLink
  is ProxyResource<ServerCommunicationLinkProperties> {
  @doc("The name of the server communication link.")
  @path
  @key("communicationLinkName")
  @segment("communicationLinks")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SqlServerCommunicationLinks {
  @doc("Returns a server communication link.")
  get is ArmResourceRead<SqlServerCommunicationLink>;
  @doc("Creates a server communication link.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<SqlServerCommunicationLink>;
  @doc("Deletes a server communication link.")
  delete is ArmResourceDeleteSync<SqlServerCommunicationLink>;
  @doc("Gets a list of server communication links.")
  listByServer is ArmResourceListByParent<SqlServerCommunicationLink>;
}

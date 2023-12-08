import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./KustoDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Kusto;
// FIXME: KustoDataConnection has no properties property
@doc("Class representing an data connection.")
@parentResource(KustoDatabase)
model KustoDataConnection is ProxyResource<{}> {
  @doc("The name of the data connection.")
  @pattern("^.*$")
  @path
  @key("dataConnectionName")
  @segment("dataConnections")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface KustoDataConnections {
  @doc("Returns a data connection.")
  get is ArmResourceRead<KustoDataConnection>;
  @doc("Creates or updates a data connection.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KustoDataConnection>;
  // FIXME: (ArmResourcePatch): ArmResourcePatchSync/ArmResourcePatchAsync should have a body parameter with either properties property or tag property
  @doc("Updates a data connection.")
  update is ArmCustomPatchAsync<KustoDataConnection, KustoDataConnection>;
  @doc("Deletes the data connection with the given name.")
  delete is ArmResourceDeleteAsync<KustoDataConnection>;
  @doc("Returns the list of data connections of the given Kusto database.")
  listByDatabase is ArmResourceListByParent<KustoDataConnection>;
}

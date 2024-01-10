import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Kusto;
// FIXME: DataConnection has no properties property
@doc("Class representing an data connection.")
@parentResource(Database)
model DataConnection is ProxyResource<{}> {
  @doc("The name of the data connection.")
  @pattern("^.*$")
  @key("dataConnectionName")
  @segment("dataConnections")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataConnections {
  @doc("Returns a data connection.")
  get is ArmResourceRead<DataConnection>;

  @doc("Creates or updates a data connection.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DataConnection>;

  @doc("Updates a data connection.")
  update is ArmCustomPatchAsync<DataConnection, DataConnection>;

  @doc("Deletes the data connection with the given name.")
  delete is ArmResourceDeleteAsync<DataConnection>;

  @doc("Returns the list of data connections of the given Kusto database.")
  listByDatabase is ArmResourceListByParent<DataConnection>;
}

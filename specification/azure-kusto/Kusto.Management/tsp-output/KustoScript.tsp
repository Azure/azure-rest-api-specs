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
@doc("Class representing a database script.")
@parentResource(KustoDatabase)
model KustoScript is ProxyResource<ScriptProperties> {
  @doc("The name of the Kusto database script.")
  @pattern("^.*$")
  @path
  @key("scriptName")
  @segment("scripts")
  name: string;
}

@armResourceOperations
interface KustoScripts {
  @doc("Gets a Kusto cluster database script.")
  get is ArmResourceRead<KustoScript>;
  @doc("Creates a Kusto database script.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<KustoScript>;
  @doc("Updates a database script.")
  update is ArmResourcePatchAsync<KustoScript, ScriptProperties>;
  @doc("Deletes a Kusto database script.")
  delete is ArmResourceDeleteAsync<KustoScript>;
  @doc("Returns the list of database scripts for given database.")
  listByDatabase is ArmResourceListByParent<KustoScript>;
}

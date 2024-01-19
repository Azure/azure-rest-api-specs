import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Kusto;
@doc("Class representing a database script.")
@parentResource(Database)
model Script is ProxyResource<ScriptProperties> {
  @doc("The name of the Kusto database script.")
  @pattern("^.*$")
  @path
  @key("scriptName")
  @segment("scripts")
  name: string;
}

@armResourceOperations
interface Scripts {
  @doc("Gets a Kusto cluster database script.")
  get is ArmResourceRead<Script>;

  @doc("Creates a Kusto database script.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Script>;

  @doc("Updates a database script.")
  update is ArmCustomPatchAsync<Script, Script>;

  @doc("Deletes a Kusto database script.")
  delete is ArmResourceDeleteAsync<Script>;

  @doc("Returns the list of database scripts for given database.")
  listByDatabase is ArmResourceListByParent<Script>;
}

@@projectedName(Scripts.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Scripts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Scripts.createOrUpdate::parameters.resource,
  "The Kusto Script parameters contains the KQL to run."
);
@@projectedName(Scripts.update::parameters.properties, "json", "parameters");
@@extension(Scripts.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Scripts.update::parameters.properties,
  "The Kusto Script parameters contains to the KQL to run."
);

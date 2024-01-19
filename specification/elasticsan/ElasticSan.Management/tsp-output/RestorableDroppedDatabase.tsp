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
@doc("A restorable dropped database resource.")
@parentResource(Server)
model RestorableDroppedDatabase
  is TrackedResource<RestorableDroppedDatabaseProperties> {
  @path
  @key("restorableDroppedDatabaseId")
  @segment("restorableDroppedDatabases")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface RestorableDroppedDatabases {
  @doc("Gets a restorable dropped database.")
  get is ArmResourceRead<
    RestorableDroppedDatabase,
    {
      ...BaseParameters<RestorableDroppedDatabase>;

      @doc("The child resources to include in the response.")
      @query("$expand")
      $expand?: string;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Gets a list of restorable dropped databases.")
  listByServer is ArmResourceListByParent<RestorableDroppedDatabase>;
}

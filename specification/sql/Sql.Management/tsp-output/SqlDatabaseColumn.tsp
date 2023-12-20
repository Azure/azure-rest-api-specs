import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./SqlDatabaseTable.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A database column resource.")
@parentResource(SqlDatabaseTable)
model SqlDatabaseColumn is ProxyResource<DatabaseColumnProperties> {
  @doc("The name of the column.")
  @path
  @key("columnName")
  @segment("columns")
  name: string;
}

@armResourceOperations
interface SqlDatabaseColumns {
  @doc("Get database column")
  get is ArmResourceRead<SqlDatabaseColumn>;
  @doc("List database columns")
  listByTable is ArmResourceListByParent<
    SqlDatabaseColumn,
    {
      ...BaseParameters<SqlDatabaseColumn>;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Enables sensitivity recommendations on a given column (recommendations are enabled by default on all columns)")
  enableRecommendation is ArmResourceActionSync<
    SqlDatabaseColumn,
    void,
    void,
    {
      ...BaseParameters<SqlDatabaseColumn>;

      @path
      sensitivityLabelSource: "recommended";
    }
  >;
  @doc("Disables sensitivity recommendations on a given column")
  disableRecommendation is ArmResourceActionSync<
    SqlDatabaseColumn,
    void,
    void,
    {
      ...BaseParameters<SqlDatabaseColumn>;

      @path
      sensitivityLabelSource: "recommended";
    }
  >;
}

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DatabaseTable.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
@doc("A database column resource.")
@parentResource(DatabaseTable)
model DatabaseColumn is ProxyResource<DatabaseColumnProperties> {
  @doc("The name of the column.")
  @path
  @key("columnName")
  @segment("columns")
  name: string;
}

@armResourceOperations
interface DatabaseColumns {
  @doc("Get database column")
  get is ArmResourceRead<DatabaseColumn>;

  @doc("List database columns")
  listByTable is ArmResourceListByParent<
    DatabaseColumn,
    {
      ...BaseParameters<DatabaseColumn>;

      @doc("An OData filter expression that filters elements in the collection.")
      @query("$filter")
      $filter?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Enables sensitivity recommendations on a given column (recommendations are enabled by default on all columns)")
  @operationId("SensitivityLabels_EnableRecommendation")
  enableRecommendation is ArmResourceActionSync<
    DatabaseColumn,
    void,
    void,
    {
      ...BaseParameters<DatabaseColumn>;

      @path
      sensitivityLabelSource: "recommended";
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Disables sensitivity recommendations on a given column")
  @operationId("SensitivityLabels_DisableRecommendation")
  disableRecommendation is ArmResourceActionSync<
    DatabaseColumn,
    void,
    void,
    {
      ...BaseParameters<DatabaseColumn>;

      @path
      sensitivityLabelSource: "recommended";
    }
  >;
}

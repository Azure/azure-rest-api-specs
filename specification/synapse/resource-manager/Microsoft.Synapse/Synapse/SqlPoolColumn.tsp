import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPoolTable.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * A Sql pool column resource.
 */
@parentResource(SqlPoolTable)
model SqlPoolColumn
  is Azure.ResourceManager.ProxyResource<SqlPoolColumnProperties> {
  ...ResourceNameParameter<
    Resource = SqlPoolColumn,
    KeyName = "columnName",
    SegmentName = "columns",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SqlPoolColumns {
  /**
   * Get Sql pool column
   */
  get is ArmResourceRead<SqlPoolColumn>;

  /**
   * Gets columns in a given table in a SQL pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolTableColumns_ListByTableName")
  listByTableName is ArmResourceListByParent<
    SqlPoolColumn,
    Parameters = {
      /**
       * An OData filter expression that filters elements in the collection.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Enables sensitivity recommendations on a given column (recommendations are enabled by default on all columns)
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("enable")
  @operationId("SqlPoolSensitivityLabels_EnableRecommendation")
  enableRecommendation is ArmResourceActionSync<
    SqlPoolColumn,
    void,
    OkResponse,
    Parameters = {
      /**
       * The source of the sensitivity label.
       */
      @path
      sensitivityLabelSource: "recommended";
    }
  >;

  /**
   * Disables sensitivity recommendations on a given column
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("disable")
  @operationId("SqlPoolSensitivityLabels_DisableRecommendation")
  disableRecommendation is ArmResourceActionSync<
    SqlPoolColumn,
    void,
    OkResponse,
    Parameters = {
      /**
       * The source of the sensitivity label.
       */
      @path
      sensitivityLabelSource: "recommended";
    }
  >;
}

@@doc(SqlPoolColumn.name, "The name of the column.");
@@doc(SqlPoolColumn.properties, "Resource properties.");

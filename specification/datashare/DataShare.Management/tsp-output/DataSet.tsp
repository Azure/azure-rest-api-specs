import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
// FIXME: DataSet has no properties property
/**
 * A DataSet data transfer object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Share)
@Azure.ResourceManager.Private.armResourceInternal({})
@includeInapplicableMetadataInPayload(false)
model DataSet extends ProxyDto {
  /**
   * The name of the dataSet.
   */
  @path
  @key("dataSetName")
  @segment("dataSets")
  name: string;

  /**
   * Kind of data set.
   */
  kind: DataSetKind;

  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties?: {};
}

@armResourceOperations
interface DataSets {
  /**
   * Get a DataSet in a share
   */
  get is ArmResourceRead<DataSet>;

  /**
   * Create a DataSet
   */
  create is ArmResourceCreateOrReplaceSync<DataSet>;

  /**
   * Delete a DataSet in a share
   */
  delete is ArmResourceDeleteAsync<DataSet>;

  /**
   * List DataSets in a share
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataSets_ListByShare")
  listByShare is ArmResourceListByParent<
    DataSet,
    {
      ...BaseParameters<DataSet>;

      /**
       * continuation token
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Filters the results using OData syntax.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results using OData syntax.
       */
      @query("$orderby")
      $orderby?: string;
    }
  >;
}

@@projectedName(DataSets.create::parameters.resource, "json", "dataSet");
@@extension(DataSets.create::parameters.resource,
  "x-ms-client-name",
  "dataSet"
);
@@doc(DataSets.create::parameters.resource, "The new data set information.");

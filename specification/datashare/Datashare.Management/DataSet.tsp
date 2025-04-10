import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Share.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
// FIXME: DataSet has no properties property
/**
 * A DataSet data transfer object.
 */
@parentResource(Share)
model DataSet is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = DataSet,
    KeyName = "dataSetName",
    SegmentName = "dataSets",
    NamePattern = ""
  >;

  /**
   * Kind of data set.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: DataSetKind;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    DataSet,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List DataSets in a share
   */
  listByShare is ArmResourceListByParent<
    DataSet,
    Parameters = {
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
    },
    Response = ArmResponse<DataSetList>
  >;
}

@@doc(DataSet.name, "The name of the dataSet.");
@@doc(DataSets.create::parameters.resource, "The new data set information.");

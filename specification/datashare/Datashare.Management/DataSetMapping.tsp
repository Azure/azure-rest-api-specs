import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ShareSubscription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
// FIXME: DataSetMapping has no properties property
/**
 * A data set mapping data transfer object.
 */
@parentResource(ShareSubscription)
model DataSetMapping is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = DataSetMapping,
    KeyName = "dataSetMappingName",
    SegmentName = "dataSetMappings",
    NamePattern = ""
  >;

  /**
   * Kind of data set mapping.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: DataSetMappingKind;
}

@armResourceOperations
interface DataSetMappings {
  /**
   * Get a DataSetMapping in a shareSubscription
   */
  get is ArmResourceRead<DataSetMapping>;

  /**
   * Create a DataSetMapping
   */
  create is ArmResourceCreateOrReplaceSync<DataSetMapping>;

  /**
   * Delete a DataSetMapping in a shareSubscription
   */
  delete is ArmResourceDeleteSync<DataSetMapping>;

  /**
   * List DataSetMappings in a share subscription
   */
  listByShareSubscription is ArmResourceListByParent<
    DataSetMapping,
    Parameters = {
      /**
       * Continuation token
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
    Response = ArmResponse<DataSetMappingList>
  >;
}

@@doc(DataSetMapping.name, "The name of the dataSetMapping.");
@@doc(DataSetMappings.create::parameters.resource,
  "Destination data set configuration details."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ShareSubscription.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataShare;
// FIXME: DataSetMapping has no properties property
/**
 * A data set mapping data transfer object.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ShareSubscription)
@includeInapplicableMetadataInPayload(false)
model DataSetMapping extends ProxyDto {
  /**
   * The name of the dataSetMapping.
   */
  @path
  @key("dataSetMappingName")
  @segment("dataSetMappings")
  @visibility("read")
  name: string;

  /**
   * Kind of data set mapping.
   */
  kind: DataSetMappingKind;

  @extension("x-ms-client-flatten", true)
  @visibility("read,create")
  properties?: {};
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DataSetMappings_ListByShareSubscription")
  listByShareSubscription is ArmResourceListByParent<
    DataSetMapping,
    {
      ...BaseParameters<DataSetMapping>;

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
    }
  >;
}

@@projectedName(DataSetMappings.create::parameters.resource,
  "json",
  "dataSetMapping"
);
@@extension(DataSetMappings.create::parameters.resource,
  "x-ms-client-name",
  "dataSetMapping"
);
@@doc(DataSetMappings.create::parameters.resource,
  "Destination data set configuration details."
);

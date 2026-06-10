import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataContainerData.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(DataContainerData)
model DataVersionBaseData
  is Azure.ResourceManager.ProxyResource<DataVersionBaseDetails, false> {
  ...ResourceNameParameter<
    Resource = DataVersionBaseData,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DataVersions {
  /**
   * Get version.
   */
  get is ArmResourceRead<DataVersionBaseData>;

  /**
   * Create or update version.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataVersionBaseData>;

  /**
   * Delete version.
   */
  delete is ArmResourceDeleteSync<DataVersionBaseData>;

  /**
   * List data versions in the data container
   */
  list is ArmResourceListByParent<
    DataVersionBaseData,
    Parameters = {
      /**
       * Please choose OrderBy value from ['createdtime', 'modifiedtime']
       */
      @query("$orderBy")
      $orderBy?: string;

      /**
       * Top count of results, top count cannot be greater than the page size.
       *                               If topCount > page size, results with be default page size count will be returned
       */
      @query("$top")
      $top?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
       */
      @query("$tags")
      $tags?: string;

      /**
       * [ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All]View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<DataVersionBaseResourceArmPaginatedResult>
  >;
}

@@doc(DataVersionBaseData.name, "Version identifier.");
@@doc(
  DataVersionBaseData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  DataVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);

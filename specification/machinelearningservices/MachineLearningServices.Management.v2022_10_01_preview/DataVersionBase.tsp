import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(DataContainer)
model DataVersionBase
  is Azure.ResourceManager.ProxyResource<DataVersionBaseProperties, false> {
  ...ResourceNameParameter<
    Resource = DataVersionBase,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DataVersionBases {
  /**
   * Get version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataVersions_Get")
  get is ArmResourceRead<DataVersionBase>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataVersions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataVersionBase>;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataVersions_Delete")
  delete is ArmResourceDeleteSync<DataVersionBase>;

  /**
   * List data versions in the data container
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataVersions_List")
  list is ArmResourceListByParent<
    DataVersionBase,
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

@@doc(DataVersionBase.name, "Version identifier.");
@@doc(
  DataVersionBase.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  DataVersionBases.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);

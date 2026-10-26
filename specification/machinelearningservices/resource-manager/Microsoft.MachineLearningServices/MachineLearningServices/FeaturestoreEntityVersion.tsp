import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FeaturestoreEntityContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(FeaturestoreEntityContainer)
model FeaturestoreEntityVersion is Azure.ResourceManager.ProxyResource<
  FeaturestoreEntityVersionProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = FeaturestoreEntityVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

alias FeaturestoreEntityVersionsListParameters = {
  /**
   * Continuation token for pagination.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing FeaturestoreEntityVersionsListParameters.$skip retains the $skip query parameter; preserve wire compatibility."
  @query("$skip")
  $skip?: string;

  /**
   * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing FeaturestoreEntityVersionsListParameters.tags retains the tags query parameter; preserve wire compatibility."
  @query("tags")
  tags?: string;

  /**
   * [ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All]View type for including/excluding (for example) archived entities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing FeaturestoreEntityVersionsListParameters.listViewType retains the listViewType query parameter; preserve wire compatibility."
  @query("listViewType")
  listViewType?: ListViewType = ListViewType.ActiveOnly;

  /**
   * page size
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing FeaturestoreEntityVersionsListParameters.pageSize retains the pageSize query parameter; preserve wire compatibility."
  @query("pageSize")
  pageSize?: int32 = 20;

  /**
   * name for the featurestore entity version
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing FeaturestoreEntityVersionsListParameters.versionName retains the versionName query parameter; preserve wire compatibility."
  @query("versionName")
  versionName?: string;

  /**
   * featurestore entity version
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing FeaturestoreEntityVersionsListParameters.version retains the version query parameter; preserve wire compatibility."
  @query("version")
  version?: string;

  /**
   * description for the feature entity version
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing FeaturestoreEntityVersionsListParameters.description retains the description query parameter; preserve wire compatibility."
  @query("description")
  description?: string;

  /**
   * createdBy user name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing FeaturestoreEntityVersionsListParameters.createdBy retains the createdBy query parameter; preserve wire compatibility."
  @query("createdBy")
  createdBy?: string;

  /**
   * Specifies the featurestore stage
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing FeaturestoreEntityVersionsListParameters.stage retains the stage query parameter; preserve wire compatibility."
  @query("stage")
  stage?: string;
};

@armResourceOperations
interface FeaturestoreEntityVersions {
  /**
   * Get version.
   */
  @summary("Get version.")
  get is ArmResourceRead<FeaturestoreEntityVersion>;

  /**
   * Create or update version.
   */
  @summary("Create or update version.")
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FeaturestoreEntityVersion,
    Response =
      | ArmResourceUpdatedResponse<FeaturestoreEntityVersion>
      | (ArmResourceCreatedResponse<
          FeaturestoreEntityVersion,
          ArmAsyncOperationHeader
        > &
          Azure.Core.Foundations.RetryAfterHeader & {
            /**
             * Timeout for the client to use when polling the asynchronous operation.
             */
            @header("x-ms-async-operation-timeout")
            timeout: duration;
          })
  >;

  /**
   * Delete version.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  @summary("Delete version.")
  delete is ArmResourceDeleteWithoutOkAsync<
    FeaturestoreEntityVersion,
    Response =
      | ArmDeletedResponse
      | (ArmDeleteAcceptedLroResponse & {
          /**
           * Timeout for the client to use when polling the asynchronous operation.
           */
          @header("x-ms-async-operation-timeout")
          timeout: duration;
        })
      | ArmDeletedNoContentResponse
  >;

  /**
   * List versions.
   */
  @summary("List versions.")
  list is ArmResourceListByParent<
    FeaturestoreEntityVersion,
    Parameters = FeaturestoreEntityVersionsListParameters,
    Response = ArmResponse<FeaturestoreEntityVersionResourceArmPaginatedResult>
  >;
}

@@doc(
  FeaturestoreEntityVersion.name,
  "Version identifier. This is case-sensitive."
);
@@doc(
  FeaturestoreEntityVersion.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  FeaturestoreEntityVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);

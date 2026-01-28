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
model FeaturestoreEntityVersion
  is Azure.ResourceManager.ProxyResource<
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
  @query("$skip")
  $skip?: string;

  /**
   * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
   */
  @query("tags")
  tags?: string;

  /**
   * [ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All]View type for including/excluding (for example) archived entities.
   */
  @query("listViewType")
  listViewType?: ListViewType = ListViewType.ActiveOnly;

  /**
   * page size
   */
  @query("pageSize")
  pageSize?: int32 = 20;

  /**
   * name for the featurestore entity version
   */
  @query("versionName")
  versionName?: string;

  /**
   * featurestore entity version
   */
  @query("version")
  version?: string;

  /**
   * description for the feature entity version
   */
  @query("description")
  description?: string;

  /**
   * createdBy user name
   */
  @query("createdBy")
  createdBy?: string;

  /**
   * Specifies the featurestore stage
   */
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
    Response = ArmResourceUpdatedResponse<FeaturestoreEntityVersion> | (ArmResourceCreatedResponse<
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
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
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

@@doc(FeaturestoreEntityVersion.name,
  "Version identifier. This is case-sensitive."
);
@@doc(FeaturestoreEntityVersion.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(FeaturestoreEntityVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);

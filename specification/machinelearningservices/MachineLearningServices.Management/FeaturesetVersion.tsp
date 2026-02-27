import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./FeaturesetContainer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(FeaturesetContainer)
model FeaturesetVersion
  is Azure.ResourceManager.ProxyResource<FeaturesetVersionProperties, false> {
  ...ResourceNameParameter<
    Resource = FeaturesetVersion,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

alias FeaturesetVersionsListParameters = {
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
   * name for the featureset version
   */
  @query("versionName")
  versionName?: string;

  /**
   * featureset version
   */
  @query("version")
  version?: string;

  /**
   * description for the feature set version
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
interface FeaturesetVersions {
  /**
   * Get version.
   */
  @summary("Get version.")
  get is ArmResourceRead<FeaturesetVersion>;

  /**
   * Create or update version.
   */
  @summary("Create or update version.")
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FeaturesetVersion,
    Response = ArmResourceUpdatedResponse<FeaturesetVersion> | (ArmResourceCreatedResponse<
      FeaturesetVersion,
      LroHeaders = ArmAsyncOperationHeader
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete version.")
  delete is ArmResourceDeleteWithoutOkAsync<
    FeaturesetVersion,
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
    FeaturesetVersion,
    Parameters = FeaturesetVersionsListParameters,
    Response = ArmResponse<FeaturesetVersionResourceArmPaginatedResult>
  >;

  /**
   * Backfill.
   */
  @summary("Backfill.")
  backfill is ArmResourceActionAsync<
    FeaturesetVersion,
    FeaturesetVersionBackfillRequest,
    FeaturesetVersionBackfillResponse
  >;
}

@@doc(FeaturesetVersion.name, "Version identifier. This is case-sensitive.");
@@doc(FeaturesetVersion.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(FeaturesetVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);
@@doc(FeaturesetVersions.backfill::parameters.body,
  "Feature set version backfill request entity."
);

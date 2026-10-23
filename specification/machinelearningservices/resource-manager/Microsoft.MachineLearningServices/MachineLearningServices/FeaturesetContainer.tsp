import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(Workspace)
model FeaturesetContainer is Azure.ResourceManager.ProxyResource<
  FeaturesetContainerProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = FeaturesetContainer,
    KeyName = "name",
    SegmentName = "featuresets",
    NamePattern = ""
  >;
}

alias FeaturesetContainersListParameters = {
  /**
   * Continuation token for pagination.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesetContainersListParameters.$skip retains the $skip query parameter; preserve wire compatibility."
  @query("$skip")
  $skip?: string;

  /**
   * Comma-separated list of tag names (and optionally values). Example: tag1,tag2=value2
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesetContainersListParameters.tags retains the tags query parameter; preserve wire compatibility."
  @query("tags")
  tags?: string;

  /**
   * [ListViewType.ActiveOnly, ListViewType.ArchivedOnly, ListViewType.All]View type for including/excluding (for example) archived entities.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesetContainersListParameters.listViewType retains the listViewType query parameter; preserve wire compatibility."
  @query("listViewType")
  listViewType?: ListViewType = ListViewType.ActiveOnly;

  /**
   * page size
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesetContainersListParameters.pageSize retains the pageSize query parameter; preserve wire compatibility."
  @query("pageSize")
  pageSize?: int32 = 20;

  /**
   * name for the featureset
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesetContainersListParameters.name retains the name query parameter; preserve wire compatibility."
  @query("name")
  name?: string;

  /**
   * description for the feature set
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesetContainersListParameters.description retains the description query parameter; preserve wire compatibility."
  @query("description")
  description?: string;

  /**
   * createdBy user name
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing FeaturesetContainersListParameters.createdBy retains the createdBy query parameter; preserve wire compatibility."
  @query("createdBy")
  createdBy?: string;
};

@armResourceOperations
interface FeaturesetContainers {
  /**
   * Get container.
   */
  @summary("Get container.")
  getEntity is ArmResourceRead<FeaturesetContainer>;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FeaturesetContainer,
    Response =
      | ArmResourceUpdatedResponse<FeaturesetContainer>
      | (ArmResourceCreatedResponse<
          FeaturesetContainer,
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
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Existing API returns additional response codes for LRO delete"
  @summary("Delete container.")
  delete is ArmResourceDeleteWithoutOkAsync<
    FeaturesetContainer,
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
   * List featurestore entity containers.
   */
  @summary("List featurestore entity containers.")
  list is ArmResourceListByParent<
    FeaturesetContainer,
    Parameters = FeaturesetContainersListParameters,
    Response = ArmResponse<FeaturesetContainerResourceArmPaginatedResult>
  >;
}

@@doc(FeaturesetContainer.name, "Container name. This is case-sensitive.");
@@doc(
  FeaturesetContainer.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  FeaturesetContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);

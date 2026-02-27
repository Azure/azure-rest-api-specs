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
model FeaturestoreEntityContainer
  is Azure.ResourceManager.ProxyResource<
    FeaturestoreEntityContainerProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = FeaturestoreEntityContainer,
    KeyName = "name",
    SegmentName = "featurestoreEntities",
    NamePattern = ""
  >;
}

alias FeaturestoreEntityContainersListParameters = {
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
   * name for the featurestore entity
   */
  @query("name")
  name?: string;

  /**
   * description for the featurestore entity
   */
  @query("description")
  description?: string;

  /**
   * createdBy user name
   */
  @query("createdBy")
  createdBy?: string;
};

@armResourceOperations
interface FeaturestoreEntityContainers {
  /**
   * Get container.
   */
  @summary("Get container.")
  getEntity is ArmResourceRead<FeaturestoreEntityContainer>;

  /**
   * Create or update container.
   */
  @summary("Create or update container.")
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FeaturestoreEntityContainer,
    Response = ArmResourceUpdatedResponse<FeaturestoreEntityContainer> | (ArmResourceCreatedResponse<
      FeaturestoreEntityContainer,
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
   * Delete container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete container.")
  delete is ArmResourceDeleteWithoutOkAsync<
    FeaturestoreEntityContainer,
    Response = ArmDeletedResponse | (ArmDeleteAcceptedLroResponse & {
      /**
       * Timeout for the client to use when polling the asynchronous operation.
       */
      @header("x-ms-async-operation-timeout")
      timeout: duration;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * List featurestore entity containers.
   */
  @summary("List featurestore entity containers.")
  list is ArmResourceListByParent<
    FeaturestoreEntityContainer,
    Parameters = FeaturestoreEntityContainersListParameters,
    Response = ArmResponse<FeaturestoreEntityContainerResourceArmPaginatedResult>
  >;
}

@@doc(FeaturestoreEntityContainer.name,
  "Container name. This is case-sensitive."
);
@@doc(FeaturestoreEntityContainer.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(FeaturestoreEntityContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);

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
model ModelContainerData
  is Azure.ResourceManager.ProxyResource<ModelContainerDetails, false> {
  ...ResourceNameParameter<
    Resource = ModelContainerData,
    KeyName = "name",
    SegmentName = "models",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ModelContainers {
  /**
   * Get container.
   */
  get is ArmResourceRead<ModelContainerData>;

  /**
   * Create or update container.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ModelContainerData>;

  /**
   * Delete container.
   */
  delete is ArmResourceDeleteSync<ModelContainerData>;

  /**
   * List model containers.
   */
  list is ArmResourceListByParent<
    ModelContainerData,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * Maximum number of results to return.
       */
      @query("count")
      count?: int32;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<ModelContainerResourceArmPaginatedResult>
  >;
}

@@doc(ModelContainerData.name, "Container name. This is case-sensitive.");
@@doc(
  ModelContainerData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  ModelContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);

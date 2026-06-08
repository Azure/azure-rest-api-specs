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
model ComponentContainerData
  is Azure.ResourceManager.ProxyResource<ComponentContainerDetails, false> {
  ...ResourceNameParameter<
    Resource = ComponentContainerData,
    KeyName = "name",
    SegmentName = "components",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ComponentContainers {
  /**
   * Get container.
   */
  get is ArmResourceRead<ComponentContainerData>;

  /**
   * Create or update container.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<ComponentContainerData>;

  /**
   * Delete container.
   */
  delete is ArmResourceDeleteSync<ComponentContainerData>;

  /**
   * List component containers.
   */
  list is ArmResourceListByParent<
    ComponentContainerData,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skip")
      $skip?: string;

      /**
       * View type for including/excluding (for example) archived entities.
       */
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<ComponentContainerResourceArmPaginatedResult>
  >;
}

@@doc(ComponentContainerData.name, "Container name.");
@@doc(
  ComponentContainerData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  ComponentContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);

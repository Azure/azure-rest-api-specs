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
model DataContainerData
  is Azure.ResourceManager.ProxyResource<DataContainerDetails, false> {
  ...ResourceNameParameter<
    Resource = DataContainerData,
    KeyName = "name",
    SegmentName = "data",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DataContainers {
  /**
   * Get container.
   */
  get is ArmResourceRead<DataContainerData>;

  /**
   * Create or update container.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<DataContainerData>;

  /**
   * Delete container.
   */
  delete is ArmResourceDeleteSync<DataContainerData>;

  /**
   * List data containers.
   */
  list is ArmResourceListByParent<
    DataContainerData,
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
    Response = ArmResponse<DataContainerResourceArmPaginatedResult>
  >;
}

@@doc(DataContainerData.name, "Container name.");
@@doc(
  DataContainerData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  DataContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);

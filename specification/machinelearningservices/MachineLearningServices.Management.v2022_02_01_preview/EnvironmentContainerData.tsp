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
model EnvironmentContainerData
  is Azure.ResourceManager.ProxyResource<EnvironmentContainerDetails, false> {
  ...ResourceNameParameter<
    Resource = EnvironmentContainerData,
    KeyName = "name",
    SegmentName = "environments",
    NamePattern = ""
  >;
}

@armResourceOperations
interface EnvironmentContainers {
  /**
   * Get container.
   */
  get is ArmResourceRead<EnvironmentContainerData>;

  /**
   * Create or update container.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<EnvironmentContainerData>;

  /**
   * Delete container.
   */
  delete is ArmResourceDeleteSync<EnvironmentContainerData>;

  /**
   * List environment containers.
   */
  list is ArmResourceListByParent<
    EnvironmentContainerData,
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
    Response = ArmResponse<EnvironmentContainerResourceArmPaginatedResult>
  >;
}

@@doc(EnvironmentContainerData.name, "Container name. This is case-sensitive.");
@@doc(
  EnvironmentContainerData.properties,
  "[Required] Additional attributes of the entity."
);
@@doc(
  EnvironmentContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);

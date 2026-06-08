import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ComponentContainerData,
    Response = ArmResourceCreatedSyncResponse<ComponentContainerData>
  >;

  /**
   * Delete container.
   */
  delete is ArmResourceDeleteSync<ComponentContainerData>;

  /**
   * List containers.
   */
  list is ArmResourceListByParent<
    ComponentContainerData,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Response = ArmResponse<ComponentContainerResourceArmPaginatedResult>
  >;
}

@@doc(ComponentContainerData.name, "Container name.");
@@doc(
  ComponentContainerData.properties,
  "Additional attributes of the entity."
);
@@doc(
  ComponentContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);

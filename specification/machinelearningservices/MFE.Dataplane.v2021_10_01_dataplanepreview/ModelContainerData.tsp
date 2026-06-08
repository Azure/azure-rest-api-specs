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
   * Create or update model container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ModelContainerData,
    Response = ArmResourceCreatedResponse<
      ModelContainerData,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

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
      @query("$skiptoken")
      $skiptoken?: string;

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
@@doc(ModelContainerData.properties, "Additional attributes of the entity.");
@@doc(
  ModelContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);

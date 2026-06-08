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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataContainerData,
    Response = ArmResourceCreatedSyncResponse<DataContainerData>
  >;

  /**
   * Delete container.
   */
  delete is ArmResourceDeleteSync<DataContainerData>;

  /**
   * List containers.
   */
  list is ArmResourceListByParent<
    DataContainerData,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skiptoken")
      $skiptoken?: string;

      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @query("listViewType")
      listViewType?: ListViewType;
    },
    Response = ArmResponse<DataContainerResourceArmPaginatedResult>
  >;
}

@@doc(DataContainerData.name, "Container name.");
@@doc(DataContainerData.properties, "Additional attributes of the entity.");
@@doc(
  DataContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);

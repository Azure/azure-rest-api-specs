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
model CodeContainerData
  is Azure.ResourceManager.ProxyResource<CodeContainerDetails, false> {
  ...ResourceNameParameter<
    Resource = CodeContainerData,
    KeyName = "name",
    SegmentName = "codes",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CodeContainers {
  /**
   * Get container.
   */
  get is ArmResourceRead<CodeContainerData>;

  /**
   * Create or update container.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CodeContainerData,
    Response = ArmResourceCreatedSyncResponse<CodeContainerData>
  >;

  /**
   * Delete container.
   */
  delete is ArmResourceDeleteSync<CodeContainerData>;

  /**
   * List containers.
   */
  list is ArmResourceListByParent<
    CodeContainerData,
    Parameters = {
      /**
       * Continuation token for pagination.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Response = ArmResponse<CodeContainerResourceArmPaginatedResult>
  >;
}

@@doc(CodeContainerData.name, "Container name.");
@@doc(CodeContainerData.properties, "Additional attributes of the entity.");
@@doc(
  CodeContainers.createOrUpdate::parameters.resource,
  "Container entity to create or update."
);

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ComponentContainerData.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(ComponentContainerData)
model ComponentVersionData
  is Azure.ResourceManager.ProxyResource<ComponentVersionDetails, false> {
  ...ResourceNameParameter<
    Resource = ComponentVersionData,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ComponentVersions {
  /**
   * Get version.
   */
  get is ArmResourceRead<ComponentVersionData>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ComponentVersionData,
    Response = ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete version.
   */
  delete is ArmResourceDeleteSync<ComponentVersionData>;

  /**
   * List versions.
   */
  list is ArmResourceListByParent<
    ComponentVersionData,
    Parameters = {
      /**
       * Ordering of list.
       */
      @query("$orderBy")
      $orderBy?: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      $top?: int32;

      /**
       * Continuation token for pagination.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    Response = ArmResponse<ComponentVersionResourceArmPaginatedResult>
  >;
}

@@doc(ComponentVersionData.name, "Version identifier.");
@@doc(ComponentVersionData.properties, "Additional attributes of the entity.");
@@doc(
  ComponentVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);

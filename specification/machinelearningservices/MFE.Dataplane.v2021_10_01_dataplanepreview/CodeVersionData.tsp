import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CodeContainerData.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MachineLearningServices;
/**
 * Azure Resource Manager resource envelope.
 */
@parentResource(CodeContainerData)
model CodeVersionData
  is Azure.ResourceManager.ProxyResource<CodeVersionDetails, false> {
  ...ResourceNameParameter<
    Resource = CodeVersionData,
    KeyName = "version",
    SegmentName = "versions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface CodeVersions {
  /**
   * Get version.
   */
  get is ArmResourceRead<CodeVersionData>;

  /**
   * Create or update version.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    CodeVersionData,
    Response = ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete version.
   */
  delete is ArmResourceDeleteSync<CodeVersionData>;

  /**
   * List versions.
   */
  list is ArmResourceListByParent<
    CodeVersionData,
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
    Response = ArmResponse<CodeVersionResourceArmPaginatedResult>
  >;
}

@@doc(CodeVersionData.name, "Version identifier.");
@@doc(CodeVersionData.properties, "Additional attributes of the entity.");
@@doc(
  CodeVersions.createOrUpdate::parameters.resource,
  "Version entity to create or update."
);

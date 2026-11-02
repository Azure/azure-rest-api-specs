import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace BigDataPools;
/**
 * A Big Data pool
 */
model BigDataPoolResourceInfo
  is Azure.ResourceManager.TrackedResource<BigDataPoolResourceProperties> {
  ...ResourceNameParameter<
    Resource = BigDataPoolResourceInfo,
    KeyName = "bigDataPoolName",
    SegmentName = "bigDataPools",
    NamePattern = ""
  >;
}

alias BigDataPoolOps = Azure.ResourceManager.Legacy.LegacyOperations<
  WorkspaceParentParameters,
  {
    /** Big Data pool name */
    @segment("bigDataPools")
    @key
    @path
    bigDataPoolName: string;
  }
>;

@armResourceOperations
interface BigDataPoolResourceInfos {
  /**
   * Get a Big Data pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BigDataPools_Get")
  get is BigDataPoolOps.Read<BigDataPoolResourceInfo>;

  /**
   * Create a new Big Data pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("BigDataPools_CreateOrUpdate")
  createOrUpdate is BigDataPoolOps.CreateOrUpdateAsync<
    BigDataPoolResourceInfo,
    Parameters = {
      /**
       * Whether to stop any running jobs in the Big Data pool
       */
      @query("force")
      force?: boolean = false;
    },
    Response =
      | ArmResourceUpdatedResponse<BigDataPoolResourceInfo>
      | (ArmAcceptedLroResponse<
          "Resource operation accepted.",
          ArmAsyncOperationHeader<FinalResult = BigDataPoolResourceInfo> &
            Azure.Core.Foundations.RetryAfterHeader
        > & {
          @bodyRoot
          _: BigDataPoolResourceInfo;
        })
  >;

  /**
   * Patch a Big Data pool.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BigDataPools_Update")
  @patch(#{ implicitOptionality: false })
  update is BigDataPoolOps.CustomPatchSync<
    BigDataPoolResourceInfo,
    PatchModel = BigDataPoolPatchInfo
  >;

  /**
   * Delete a Big Data pool from the workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("BigDataPools_Delete")
  delete is BigDataPoolOps.DeleteWithoutOkAsync<
    BigDataPoolResourceInfo,
    Response =
      | ArmResponse<BigDataPoolResourceInfo>
      | (ArmDeleteAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = BigDataPoolResourceInfo> &
          Azure.Core.Foundations.RetryAfterHeader> & {
          @bodyRoot
          _: BigDataPoolResourceInfo;
        })
      | ArmDeletedNoContentResponse
  >;

  /**
   * List Big Data pools in a workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BigDataPools_ListByWorkspace")
  listByWorkspace is BigDataPoolOps.List<
    BigDataPoolResourceInfo,
    Response = ArmResponse<BigDataPoolResourceInfoListResult>
  >;
}

@@doc(BigDataPoolResourceInfo.name, "Big Data pool name");
@@doc(BigDataPoolResourceInfo.properties, "Big Data pool properties");
@@doc(
  BigDataPoolResourceInfos.createOrUpdate::parameters.resource,
  "The Big Data pool to create."
);
@@doc(
  BigDataPoolResourceInfos.update::parameters.properties,
  "The updated Big Data pool properties"
);

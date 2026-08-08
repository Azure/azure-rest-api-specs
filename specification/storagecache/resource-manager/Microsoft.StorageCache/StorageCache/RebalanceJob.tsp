import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./AmlFilesystem.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.StorageCache;

/**
 * A rebalance job instance. Rebalances OST data across storage targets after a cluster expansion.
 * Follows Azure Resource Manager standards: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/resource-api-reference.md
 */
@added(Versions.v2026_08_01)
@parentResource(AmlFilesystem)
model RebalanceJob
  is Azure.ResourceManager.ProxyResource<RebalanceJobProperties> {
  ...ResourceNameParameter<
    Resource = RebalanceJob,
    KeyName = "rebalanceJobName",
    SegmentName = "rebalanceJobs",
    NamePattern = "^[0-9a-zA-Z][-0-9a-zA-Z_]{0,78}[0-9a-zA-Z]$"
  >;
}

@added(Versions.v2026_08_01)
@armResourceOperations(#{ omitTags: true })
interface RebalanceJobs {
  /**
   * Returns a rebalance job.
   */
  @tag("rebalanceJobs")
  get is ArmResourceRead<RebalanceJob, Error = ErrorResponse>;

  /**
   * Update a rebalance job instance.
   */
  @tag("rebalanceJobs")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    RebalanceJob,
    PatchModel = RebalanceJobUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = RebalanceJob> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = ErrorResponse
  >;

  /**
   * Schedules a rebalance job for deletion.
   */
  @tag("rebalanceJobs")
  delete is ArmResourceDeleteWithoutOkAsync<
    RebalanceJob,
    Response =
      | ArmDeleteAcceptedLroResponse<ArmCombinedLroHeaders<FinalResult = void> &
          Azure.Core.Foundations.RetryAfterHeader>
      | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Returns all the rebalance jobs the user has access to under an AML File System.
   */
  @tag("rebalanceJobs")
  listByAmlFilesystem is ArmResourceListByParent<
    RebalanceJob,
    Response = ArmResponse<RebalanceJobsListResult>,
    Error = ErrorResponse
  >;
}

@@maxLength(RebalanceJob.name, 80);
@@minLength(RebalanceJob.name, 2);
@@doc(
  RebalanceJob.name,
  "Name for the rebalance job. Allows alphanumerics, underscores, and hyphens. Start and end with alphanumeric."
);
@@doc(RebalanceJob.properties, "Properties of the rebalance job.");
@@doc(
  RebalanceJobs.update::parameters.properties,
  "Object containing the user-selectable properties of the rebalance job. If read-only properties are included, they must match the existing values of those properties."
);

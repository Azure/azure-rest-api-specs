import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeAnalyticsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeAnalytics;
/**
 * Data Lake Analytics compute policy information.
 */
@parentResource(DataLakeAnalyticsAccount)
model ComputePolicy
  is Azure.ResourceManager.ProxyResource<ComputePolicyProperties> {
  ...ResourceNameParameter<
    Resource = ComputePolicy,
    KeyName = "computePolicyName",
    SegmentName = "computePolicies",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ComputePolicies {
  /**
   * Gets the specified Data Lake Analytics compute policy.
   */
  get is ArmResourceRead<ComputePolicy>;

  /**
   * Creates or updates the specified compute policy. During update, the compute policy with the specified name will be replaced with this new compute policy. An account supports, at most, 50 policies
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ComputePolicy,
    Response = ArmResourceUpdatedResponse<ComputePolicy>
  >;

  /**
   * Updates the specified compute policy.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ComputePolicy,
    PatchModel = UpdateComputePolicyParameters
  >;

  /**
   * Deletes the specified compute policy from the specified Data Lake Analytics account
   */
  delete is ArmResourceDeleteSync<ComputePolicy>;

  /**
   * Lists the Data Lake Analytics compute policies within the specified Data Lake Analytics account. An account supports, at most, 50 policies
   */
  listByAccount is ArmResourceListByParent<ComputePolicy>;
}

@@doc(ComputePolicy.name, "The name of the compute policy to retrieve.");
@@doc(ComputePolicy.properties, "The compute policy properties.");
@@doc(ComputePolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update the compute policy. The max degree of parallelism per job property, min priority per job property, or both must be present."
);
@@doc(ComputePolicies.update::parameters.properties,
  "Parameters supplied to update the compute policy."
);

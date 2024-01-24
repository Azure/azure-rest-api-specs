import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataLakeAnalyticsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataLakeAnalytics;
/**
 * Data Lake Analytics compute policy information.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DataLakeAnalyticsAccount)
@Azure.ResourceManager.Private.armResourceInternal(ComputePolicyProperties)
@includeInapplicableMetadataInPayload(false)
model ComputePolicy extends ProxyResourceBase {
  /**
   * The name of the compute policy to retrieve.
   */
  @path
  @key("computePolicyName")
  @segment("computePolicies")
  name: string;

  /**
   * The compute policy properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ComputePolicyProperties;
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
  createOrUpdate is ArmResourceCreateOrReplaceSync<ComputePolicy>;

  /**
   * Updates the specified compute policy.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ComputePolicy, UpdateComputePolicyParameters>;

  /**
   * Deletes the specified compute policy from the specified Data Lake Analytics account
   */
  delete is ArmResourceDeleteSync<ComputePolicy>;

  /**
   * Lists the Data Lake Analytics compute policies within the specified Data Lake Analytics account. An account supports, at most, 50 policies
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ComputePolicies_ListByAccount")
  listByAccount is ArmResourceListByParent<ComputePolicy>;
}

@@projectedName(ComputePolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ComputePolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ComputePolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to create or update the compute policy. The max degree of parallelism per job property, min priority per job property, or both must be present."
);
@@projectedName(ComputePolicies.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(ComputePolicies.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ComputePolicies.update::parameters.properties,
  "Parameters supplied to update the compute policy."
);

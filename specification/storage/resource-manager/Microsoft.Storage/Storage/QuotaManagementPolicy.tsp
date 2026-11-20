import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Storage;
/**
 * A regional policy that defines quota limits for quota management groups.
 */
@added(Versions.v2026_12_01)
model QuotaManagementPolicy is Azure.ResourceManager.TrackedResource<
  QuotaManagementPolicyProperties,
  false
> {
  /**
   * The name of the quota management policy.
   */
  @pattern("^[a-z0-9][a-z0-9-]{1,22}[a-z0-9]$")
  @key("policyName")
  @segment("quotaManagementPolicies")
  @path
  name: string;
}

@armResourceOperations
@added(Versions.v2026_12_01)
interface QuotaManagementPolicies {
  /**
   * Get a quota management policy.
   */
  get is ArmResourceRead<QuotaManagementPolicy>;

  /**
   * Create or update a quota management policy.
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<QuotaManagementPolicy>;

  /**
   * Update a quota management policy.
   */
  update is ArmCustomPatchAsync<
    QuotaManagementPolicy,
    QuotaManagementPolicyUpdate
  >;

  /**
   * Delete a quota management policy. The request fails if the policy is referenced by a quota management group.
   */
  delete is ArmResourceDeleteWithoutOkAsync<QuotaManagementPolicy>;

  /**
   * List quota management policies by resource group.
   */
  listByResourceGroup is ArmResourceListByParent<QuotaManagementPolicy>;

  /**
   * List quota management policies by subscription.
   */
  listBySubscription is ArmListBySubscription<QuotaManagementPolicy>;
}

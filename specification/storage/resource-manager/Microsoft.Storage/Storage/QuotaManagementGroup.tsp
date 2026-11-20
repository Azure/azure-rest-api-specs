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
 * A regional quota management group containing storage accounts or storage containers.
 */
@added(Versions.v2026_12_01)
model QuotaManagementGroup is Azure.ResourceManager.TrackedResource<
  QuotaManagementGroupProperties,
  false
> {
  /**
   * The name of the quota management group.
   */
  @pattern("^[a-z0-9][a-z0-9-]{1,22}[a-z0-9]$")
  @key("quotaManagementGroupName")
  @segment("quotaManagementGroups")
  @path
  name: string;
}

@armResourceOperations
@added(Versions.v2026_12_01)
interface QuotaManagementGroups {
  /**
   * Get a quota management group.
   */
  get is ArmResourceRead<QuotaManagementGroup>;

  /**
   * Create or update a quota management group.
   */
  createOrUpdate is ArmResourceCreateOrUpdateAsync<QuotaManagementGroup>;

  /**
   * Update a quota management group.
   */
  update is ArmCustomPatchAsync<
    QuotaManagementGroup,
    QuotaManagementGroupUpdate
  >;

  /**
   * Delete a quota management group.
   */
  delete is ArmResourceDeleteWithoutOkAsync<QuotaManagementGroup>;

  /**
   * List quota management groups by resource group.
   */
  listByResourceGroup is ArmResourceListByParent<QuotaManagementGroup>;

  /**
   * List quota management groups by subscription.
   */
  listBySubscription is ArmListBySubscription<QuotaManagementGroup>;
}

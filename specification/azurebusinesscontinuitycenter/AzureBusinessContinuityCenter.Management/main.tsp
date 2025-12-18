import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/unifiedprotecteditem.tsp";
import "./models/deletedunifiedprotecteditem.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

/** microsoft.azurebusinesscontinuity Resource Provider management API. */
@armProviderNamespace
@service(#{ title: "Microsoft.AzureBusinessContinuity management service." })
@versioned(Microsoft.AzureBusinessContinuity.Versions)
namespace Microsoft.AzureBusinessContinuity;

@doc("Microsoft.AzureBusinessContinuity Resource Provider supported API versions.")
enum Versions {
  @doc("Microsoft.AzureBusinessContinuity Resource Provider management API version 2024-09-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2024_09_01_preview: "2024-09-01-preview",

  @doc("Microsoft.AzureBusinessContinuity Resource Provider management API version 2025-11-01-preview.")
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2025_11_01_preview: "2025-11-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@armResourceOperations
interface UnifiedProtectedItem {
  get is ArmResourceRead<UnifiedProtectedItemResource>;
  @renamedFrom(Versions.v2025_11_01_preview, "listByResourceGroup")
  listByResource is ArmResourceListByParent<UnifiedProtectedItemResource>;
}

@armResourceOperations
interface DeletedUnifiedProtectedItem {
  get is ArmResourceRead<DeletedUnifiedProtectedItemResource>;
  listByResourceGroup is ArmResourceListByParent<DeletedUnifiedProtectedItemResource>;
  listBySubscription is ArmListBySubscription<DeletedUnifiedProtectedItemResource>;
}

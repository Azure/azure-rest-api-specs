import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.CognitiveServices;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "'ManagedComputeUsagesOperationGroup' is a non-standard operation that doesn't map to ARM CRUD resource interface patterns"
@added(Versions.v2026_03_15_preview)
interface ManagedComputeUsagesOperationGroup {
  /**
   * List managed compute quota usages for a subscription and location.
   */
  @autoRoute
  @get
  @action("managedComputeUsages")
  @list
  @tag("ManagedComputeUsages")
  list is ArmProviderActionSync<
    Response = ManagedComputeUsageListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

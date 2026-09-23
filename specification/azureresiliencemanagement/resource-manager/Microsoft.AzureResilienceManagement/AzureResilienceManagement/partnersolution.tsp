import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/partnersolution/unifiedresilienceitem.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@armResourceOperations
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "UnifiedResilienceItems")
interface UnifiedResilienceItemsOld {
  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<UnifiedResilienceItem, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<
    UnifiedResilienceItem,
    ServiceGroupTenantParameters
  >;
}

@armResourceOperations
@added(Versions.v2026_09_30_preview)
interface UnifiedResilienceItems {
  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<UnifiedResilienceItem, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  list is ArmResourceListByParent<
    UnifiedResilienceItem,
    ServiceGroupTenantParameters
  >;
}

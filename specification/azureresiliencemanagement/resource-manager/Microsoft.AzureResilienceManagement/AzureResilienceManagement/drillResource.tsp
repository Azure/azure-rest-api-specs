import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/drill/drillResource.models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.CommonTypes;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureResilienceManagement;

@armResourceOperations(DrillResource)
@removed(Versions.v2026_09_30_preview)
@renamedFrom(Versions.v2026_09_30_preview, "DrillResources")
interface DrillResourcesOld {
  // ONLY Get and List are exposed to the user.

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  get is ArmResourceRead<DrillResource, ServiceGroupParameters>;

  #deprecated "API versions 2025-02-01-preview through 2026-08-31-preview are deprecated. Use 2026-09-30-preview or a later supported API version."
  @route(ServiceGroupRoute)
  @summary("Deprecated API version. Use 2026-09-30-preview or a later supported API version.")
  @sharedRoute
  list is ArmResourceListByParent<DrillResource, ServiceGroupTenantParameters>;
}

@armResourceOperations(DrillResource)
@added(Versions.v2026_09_30_preview)
interface DrillResources {
  // ONLY Get and List are exposed to the user.

  @route(ServiceGroupRoute)
  @sharedRoute
  get is ArmResourceRead<DrillResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  @sharedRoute
  list is ArmResourceListByParent<DrillResource, ServiceGroupTenantParameters>;
}

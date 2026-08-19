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
interface DrillResources {
  // ONLY Get and List are exposed to the user.

  @route(ServiceGroupRoute)
  get is ArmResourceRead<DrillResource, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<DrillResource, ServiceGroupTenantParameters>;
}

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/partnersolution/unifiedresiliencyitem.tsp";

using TypeSpec.Http;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@armResourceOperations
interface UnifiedResiliencyItems {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<UnifiedResiliencyItem, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<
    UnifiedResiliencyItem,
    ServiceGroupTenantParameters
  >;
}

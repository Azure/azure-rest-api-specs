import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./models/partnersolution/unifiedresilienceitem.tsp";

using TypeSpec.Http;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@armResourceOperations
interface UnifiedResilienceItems {
  @route(ServiceGroupRoute)
  get is ArmResourceRead<UnifiedResilienceItem, ServiceGroupParameters>;

  @route(ServiceGroupRoute)
  list is ArmResourceListByParent<
    UnifiedResilienceItem,
    ServiceGroupTenantParameters
  >;
}

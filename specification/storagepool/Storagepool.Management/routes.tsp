// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.StoragePool;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DiskPoolZonesOperationGroup {
  /**
   * Lists available Disk Pool Skus in an Azure location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiskPoolZones_List")
  @autoRoute
  @get
  @action("diskPoolZones")
  list is ArmProviderActionSync<
    Response = DiskPoolZoneListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ResourceSkusOperationGroup {
  /**
   * Lists available StoragePool resources and skus in an Azure location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ResourceSkus_List")
  @autoRoute
  @get
  @action("skus")
  list is ArmProviderActionSync<
    Response = ResourceSkuListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

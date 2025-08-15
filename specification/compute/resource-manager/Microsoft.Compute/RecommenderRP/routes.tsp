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

namespace Microsoft.Compute;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CapacityBlocksOperationGroup {
  /**
   * Get available capacity blocks.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CapacityBlocks_Get")
  @autoRoute
  @get
  @action("capacityBlocks")
  get is ArmProviderActionSync<
    Response = CapacityBlocks,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * An OData filter expression that describes a subset of capacity blocks to return. Mandatory parameters are sku, capacity, durationhours, start-date-range and end-date-range. Optional parameters are zone and location. The supported operator is eq. Example: $filter = sku eq Standard_D16s_v4 and capacity eq 4 and start-date-range eq 2025-06-25T00:00:00-07:00 and end-date-range eq 2025-06-27T00:00:00-07:00 and durationhours eq 24 and zone eq 1 and location eq westus
       */
      @query("$filter")
      $filter: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface RegionalCapacityBlocksOperationGroup {
  /**
   * Get available capacity blocks by location.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RegionalCapacityBlocks_Get")
  @autoRoute
  @get
  @action("capacityBlocks")
  get is ArmProviderActionSync<
    Response = CapacityBlocks,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * An OData filter expression that describes a subset of capacity blocks to return. Mandatory parameters are sku, capacity, durationhours, start-date-range and end-date-range. Optional parameters are zone. The supported operator is eq. Example: $filter = sku eq Standard_D16s_v4 and capacity eq 4 and start-date-range eq 2025-06-25T00:00:00-07:00 and end-date-range eq 2025-06-27T00:00:00-07:00 and durationhours eq 24 and zone eq 1
       */
      @query("$filter")
      $filter: string;
    }
  >;
}

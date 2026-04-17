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

namespace Microsoft.DataMigration;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ResourceSkusOperationGroup {
  /**
   * The skus action returns the list of SKUs that DMS (classic) supports.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get supported SKUs")
  @tag("Standard operation")
  @tag("GET")
  @autoRoute
  @get
  @list
  @action("skus")
  listSkus is ArmProviderActionSync<
    Response = ResourceSkusResult,
    Scope = SubscriptionActionScope,
    Error = ApiError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ServicesOperationGroup {
  /**
   * This method checks whether a proposed top-level resource name is valid and available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Check name validity and availability")
  @tag("Standard operation")
  @tag("POST")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = NameAvailabilityRequest,
    Response = NameAvailabilityResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ApiError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface UsagesOperationGroup {
  /**
   * This method returns region-specific quotas and resource usage information for the Azure Database Migration Service (classic).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Get resource quotas and usage information")
  @tag("Standard operation")
  @tag("GET")
  @autoRoute
  @get
  @list
  @action("usages")
  list is ArmProviderActionSync<
    Response = QuotaList,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter,
    Error = ApiError
  >;
}

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

namespace KustoPools;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface KustoOperationsOperationGroup {
  /**
   * Lists available operations for the Kusto sub-resources inside Microsoft.Synapse provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoOperations_List")
  @autoRoute
  @list
  @get
  @action("kustooperations")
  list is ArmProviderActionSync<Response = OperationListResult>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface KustoPoolsOperationGroup {
  /**
   * Lists eligible SKUs for Kusto Pool resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPools_ListSkus")
  @autoRoute
  @list
  @get
  @action("skus")
  listSkus is ArmProviderActionSync<
    Response = SkuDescriptionList,
    Scope = SubscriptionActionScope
  >;
  /**
   * Checks that the kusto pool name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("KustoPools_CheckNameAvailability")
  @autoRoute
  @action("kustoPoolCheckNameAvailability")
  checkNameAvailability is ArmProviderActionSync<
    Request = KustoPoolCheckNameRequest,
    Response = CheckNameResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

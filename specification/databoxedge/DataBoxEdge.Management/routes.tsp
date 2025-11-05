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

namespace Microsoft.DataBoxEdge;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface AvailableSkusOperationGroup {
  /**
   * List all the available Skus and information related to them.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List all the available Skus and information related to them.")
  @operationId("AvailableSkus_List")
  @autoRoute
  @get
  @action("availableSkus")
  list is ArmProviderActionSync<
    Response = DataBoxEdgeSkuList,
    Scope = SubscriptionActionScope
  >;
}

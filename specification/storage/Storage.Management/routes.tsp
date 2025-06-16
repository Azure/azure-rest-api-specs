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

namespace Microsoft.Storage;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface Skus {
  /**
   * Lists the available SKUs supported by Microsoft.Storage for given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Skus_List")
  @autoRoute
  @get
  @action("skus")
  @tag("Skus")
  list is ArmProviderActionSync<
    Response = StorageSkuListResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface Usages {
  /**
   * Gets the current usage count and the limit for the resources of the location under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  @get
  @action("usages")
  @tag("LocationUsage")
  listByLocation is ArmProviderActionSync<
    Response = UsageListResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
@@doc(Usages.listByLocation::parameters.location,
  "The location of the Azure Storage resource."
);

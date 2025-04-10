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

namespace Microsoft.AppPlatform;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ServicesOperationGroup {
  /**
   * Checks that the resource name is valid and is not already in use.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_CheckNameAvailability")
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = NameAvailabilityParameters,
    Response = NameAvailability,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface RuntimeVersionsOperationGroup {
  /**
   * Lists all of the available runtime versions supported by Microsoft.AppPlatform provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("RuntimeVersions_ListRuntimeVersions")
  @autoRoute
  @get
  @action("runtimeVersions")
  listRuntimeVersions is ArmProviderActionSync<Response = AvailableRuntimeVersions>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SkusOperationGroup {
  /**
   * Lists all of the available skus of the Microsoft.AppPlatform provider.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Skus_List")
  @autoRoute
  @get
  @action("skus")
  list is ArmProviderActionSync<
    Response = ResourceSkuCollection,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

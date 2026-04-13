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

namespace Microsoft.ResourceHealth;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface EventsOperationGroup {
  /**
   * Lists current service health events for given resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Events_ListBySingleResource")
  @autoRoute
  @get
  @action("events")
  listBySingleResource is ArmProviderActionSync<
    Response = Events,
    Scope = ExtensionResourceActionScope,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ChildResourcesOperationGroup {
  /**
   * Lists the all the children and its current health status for a parent resource. Use the nextLink property in the response to get the next page of children current health
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ChildResources_List")
  @autoRoute
  @get
  @action("childResources")
  list is ArmProviderActionSync<
    Response = ResourceListResult<AvailabilityStatus>,
    Scope = ExtensionResourceActionScope,
    Parameters = {
      /**
       * The filter to apply on the operation. For more information please see https://docs.microsoft.com/en-us/rest/api/apimanagement/apis?redirectedfrom=MSDN
       */
      @query("$filter")
      $filter?: string;

      /**
       * Setting $expand=recommendedactions in url query expands the recommendedactions in the response.
       */
      @query("$expand")
      $expand?: string;
    }
  >;
}

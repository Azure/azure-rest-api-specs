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

namespace WebTestLocation;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface webTestLocationsOperationGroup {
  /**
   * Gets a list of web test locations available to this Application Insights component.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @get
  @list
  @action("syntheticmonitorlocations")
  @operationId("webTestLocations_List")
  list is ArmProviderActionSync<
    Response = ApplicationInsightsWebTestLocationsListResult,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the Application Insights component resource.
       */
      @path
      @segment("components")
      resourceName: string;
    },
    Error = never
  >;
}

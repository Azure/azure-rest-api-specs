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

namespace Microsoft.ElasticSan;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SkusOperationGroup {
  /**
   * List all the available Skus in the region and information related to them
   */
  @summary("List all the available Skus in the region and information related to them")
  @autoRoute
  @get
  @action("skus")
  @list
  list is ArmProviderActionSync<
    Response = SkuInformationList,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Specify $filter='location eq <location>' to filter on location.
       */
      @query("$filter")
      $filter?: string;
    }
  >;
}

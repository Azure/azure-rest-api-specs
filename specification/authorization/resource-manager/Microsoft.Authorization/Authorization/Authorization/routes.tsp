// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Authorization;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface EligibleChildResourcesOperationGroup {
  /**
   * Get the child resources of a resource on which user has eligible access
   */
  @tag("eligibleChildResources")
  @autoRoute
  @list
  @get
  @action("eligibleChildResources")
  get is ArmProviderActionSync<
    Response = EligibleChildResourcesListResult,
    Scope = ExtensionActionScope,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=resourceType+eq+'Subscription' to filter on only resource of type = 'Subscription'. Use $filter=resourceType+eq+'subscription'+or+resourceType+eq+'resourcegroup' to filter on resource of type = 'Subscription' or 'ResourceGroup'
       */
      @query("$filter")
      $filter?: string;
    },
    Error = CloudError
  >;
}

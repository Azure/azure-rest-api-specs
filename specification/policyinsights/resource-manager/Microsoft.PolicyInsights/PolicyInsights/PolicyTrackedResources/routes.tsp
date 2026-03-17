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

namespace PolicyTrackedResourcesApi;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface PolicyTrackedResourcesOperationGroup {
  /**
   * Queries policy tracked resources under the management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PolicyTrackedResources_ListQueryResultsForManagementGroup")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyTrackedResources/{policyTrackedResourcesResource}/queryResults")
  @list
  @post
  listQueryResultsForManagementGroup(
    ...ApiVersionParameter,

    /**
     * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
     */
    @path
    managementGroupsNamespace: "Microsoft.Management",

    /**
     * Management group name.
     */
    @path
    managementGroupName: string,

    /**
     * The name of the virtual resource under PolicyTrackedResources resource type; only "default" is allowed.
     */
    @path
    policyTrackedResourcesResource: PolicyTrackedResourcesResourceType,

    ...QueryOptions,
  ): PolicyTrackedResourcesQueryResults | QueryFailure;
  /**
   * Queries policy tracked resources under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PolicyTrackedResources_ListQueryResultsForSubscription")
  @autoRoute
  @list
  @action("queryResults")
  listQueryResultsForSubscription is ArmProviderActionSync<
    Response = PolicyTrackedResourcesQueryResults,
    Error = QueryFailure,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The name of the virtual resource under PolicyTrackedResources resource type; only "default" is allowed.
       */
      @path
      @segment("policyTrackedResources")
      policyTrackedResourcesResource: PolicyTrackedResourcesResourceType;

      ...QueryOptions;
    }
  >;
  /**
   * Queries policy tracked resources under the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PolicyTrackedResources_ListQueryResultsForResourceGroup")
  @autoRoute
  @list
  @action("queryResults")
  listQueryResultsForResourceGroup is ArmProviderActionSync<
    Response = PolicyTrackedResourcesQueryResults,
    Error = QueryFailure,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The name of the virtual resource under PolicyTrackedResources resource type; only "default" is allowed.
       */
      @path
      @segment("policyTrackedResources")
      policyTrackedResourcesResource: PolicyTrackedResourcesResourceType;

      ...QueryOptions;
    }
  >;
  /**
   * Queries policy tracked resources under the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PolicyTrackedResources_ListQueryResultsForResource")
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/policyTrackedResources/{policyTrackedResourcesResource}/queryResults")
  @list
  @post
  listQueryResultsForResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * The name of the virtual resource under PolicyTrackedResources resource type; only "default" is allowed.
     */
    @path
    policyTrackedResourcesResource: PolicyTrackedResourcesResourceType,

    ...QueryOptions,
  ): PolicyTrackedResourcesQueryResults | QueryFailure;
}

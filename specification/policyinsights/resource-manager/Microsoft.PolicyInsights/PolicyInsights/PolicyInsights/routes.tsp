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

namespace PolicyInsightsApi;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface RemediationsOperationGroup {
  /**
   * Gets all deployments for a remediation at management group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Remediations_ListDeploymentsAtManagementGroup")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupId}/providers/Microsoft.PolicyInsights/remediations/{remediationName}/listDeployments")
  @list
  @post
  listDeploymentsAtManagementGroup(
    ...ApiVersionParameter,

    /**
     * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
     */
    @path
    managementGroupsNamespace: "Microsoft.Management",

    /**
     * Management group ID.
     */
    @path
    managementGroupId: string,

    /**
     * The name of the remediation.
     */
    @path
    remediationName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,
  ): RemediationDeploymentsListResult | ErrorResponse;
  /**
   * Cancels a remediation at management group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Remediations_CancelAtManagementGroup")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupId}/providers/Microsoft.PolicyInsights/remediations/{remediationName}/cancel")
  @post
  cancelAtManagementGroup(
    ...ApiVersionParameter,

    /**
     * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
     */
    @path
    managementGroupsNamespace: "Microsoft.Management",

    /**
     * Management group ID.
     */
    @path
    managementGroupId: string,

    /**
     * The name of the remediation.
     */
    @path
    remediationName: string,
  ): Remediation | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PolicyEventsOperationGroup {
  /**
   * Queries policy events for the resources under the management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyEvents_ListQueryResultsForManagementGroup")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @list
  @post
  listQueryResultsForManagementGroup(
    ...ApiVersionParameter,

    /**
     * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
     */
    @path
    policyEventsResource: PolicyEventsResourceType,

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
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyEventsQueryResults | QueryFailure;
  /**
   * Queries policy events for the resources under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyEvents_ListQueryResultsForSubscription")
  @autoRoute
  @list
  @action("queryResults")
  listQueryResultsForSubscription is ArmProviderActionSync<
    Response = PolicyEventsQueryResults,
    Scope = SubscriptionActionScope,
    Error = QueryFailure,
    Parameters = {
      /**
       * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
       */
      @path
      @segment("policyEvents")
      policyEventsResource: PolicyEventsResourceType;

      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$skiptoken")
      SkipToken?: string;
    }
  >;
  /**
   * Queries policy events for the resources under the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyEvents_ListQueryResultsForResourceGroup")
  @autoRoute
  @list
  @action("queryResults")
  listQueryResultsForResourceGroup is ArmProviderActionSync<
    Response = PolicyEventsQueryResults,
    Scope = Extension.ResourceGroup,
    Error = QueryFailure,
    Parameters = {
      /**
       * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
       */
      @path
      @segment("policyEvents")
      policyEventsResource: PolicyEventsResourceType;

      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$skiptoken")
      SkipToken?: string;
    }
  >;
  /**
   * Queries policy events for the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyEvents_ListQueryResultsForResource")
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @list
  @post
  listQueryResultsForResource(
    ...ApiVersionParameter,

    /**
     * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
     */
    @path
    policyEventsResource: PolicyEventsResourceType,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * The $expand query parameter. For example, to expand components use $expand=components
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$expand")
    Expand?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyEventsQueryResults | QueryFailure;
  /**
   * Queries policy events for the subscription level policy set definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyEvents_ListQueryResultsForPolicySetDefinition")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @list
  @post
  listQueryResultsForPolicySetDefinition(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
     */
    @path
    policyEventsResource: PolicyEventsResourceType,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy set definition name.
     */
    @path
    policySetDefinitionName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyEventsQueryResults | QueryFailure;
  /**
   * Queries policy events for the subscription level policy definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyEvents_ListQueryResultsForPolicyDefinition")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @list
  @post
  listQueryResultsForPolicyDefinition(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
     */
    @path
    policyEventsResource: PolicyEventsResourceType,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy definition name.
     */
    @path
    policyDefinitionName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyEventsQueryResults | QueryFailure;
  /**
   * Queries policy events for the subscription level policy assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyEvents_ListQueryResultsForSubscriptionLevelPolicyAssignment")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @list
  @post
  listQueryResultsForSubscriptionLevelPolicyAssignment(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
     */
    @path
    policyEventsResource: PolicyEventsResourceType,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy assignment name.
     */
    @path
    policyAssignmentName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyEventsQueryResults | QueryFailure;
  /**
   * Queries policy events for the resource group level policy assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyEvents_ListQueryResultsForResourceGroupLevelPolicyAssignment")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @list
  @post
  listQueryResultsForResourceGroupLevelPolicyAssignment(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * Resource group name.
     */
    @path
    resourceGroupName: string,

    /**
     * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
     */
    @path
    policyEventsResource: PolicyEventsResourceType,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy assignment name.
     */
    @path
    policyAssignmentName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyEventsQueryResults | QueryFailure;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PolicyStatesOperationGroup {
  /**
   * Queries policy states for the resources under the management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_ListQueryResultsForManagementGroup")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @list
  @post
  listQueryResultsForManagementGroup(
    ...ApiVersionParameter,

    /**
     * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
     */
    @path
    policyStatesResource: PolicyStatesResource,

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
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyStatesQueryResults | QueryFailure;
  /**
   * Summarizes policy states for the resources under the management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_SummarizeForManagementGroup")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForManagementGroup(
    ...ApiVersionParameter,

    /**
     * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
     */
    @path
    policyStatesSummaryResource: PolicyStatesSummaryResourceType,

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
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,
  ): SummarizeResults | QueryFailure;
  /**
   * Queries policy states for the resources under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_ListQueryResultsForSubscription")
  @autoRoute
  @list
  @action("queryResults")
  listQueryResultsForSubscription is ArmProviderActionSync<
    Response = PolicyStatesQueryResults,
    Scope = SubscriptionActionScope,
    Error = QueryFailure,
    Parameters = {
      /**
       * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
       */
      @path
      @segment("policyStates")
      policyStatesResource: PolicyStatesResource;

      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$skiptoken")
      SkipToken?: string;
    }
  >;
  /**
   * Summarizes policy states for the resources under the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_SummarizeForSubscription")
  @autoRoute
  @action("summarize")
  summarizeForSubscription is ArmProviderActionSync<
    Response = SummarizeResults,
    Scope = SubscriptionActionScope,
    Error = QueryFailure,
    Parameters = {
      /**
       * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
       */
      @path
      @segment("policyStates")
      policyStatesSummaryResource: PolicyStatesSummaryResourceType;

      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$filter")
      Filter?: string;
    }
  >;
  /**
   * Queries policy states for the resources under the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_ListQueryResultsForResourceGroup")
  @autoRoute
  @list
  @action("queryResults")
  listQueryResultsForResourceGroup is ArmProviderActionSync<
    Response = PolicyStatesQueryResults,
    Scope = Extension.ResourceGroup,
    Error = QueryFailure,
    Parameters = {
      /**
       * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
       */
      @path
      @segment("policyStates")
      policyStatesResource: PolicyStatesResource;

      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$skiptoken")
      SkipToken?: string;
    }
  >;
  /**
   * Summarizes policy states for the resources under the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_SummarizeForResourceGroup")
  @autoRoute
  @action("summarize")
  summarizeForResourceGroup is ArmProviderActionSync<
    Response = SummarizeResults,
    Scope = Extension.ResourceGroup,
    Error = QueryFailure,
    Parameters = {
      /**
       * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
       */
      @path
      @segment("policyStates")
      policyStatesSummaryResource: PolicyStatesSummaryResourceType;

      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$filter")
      Filter?: string;
    }
  >;
  /**
   * Queries policy states for the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_ListQueryResultsForResource")
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @list
  @post
  listQueryResultsForResource(
    ...ApiVersionParameter,

    /**
     * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
     */
    @path
    policyStatesResource: PolicyStatesResource,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * The $expand query parameter. For example, to expand components use $expand=components
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$expand")
    Expand?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyStatesQueryResults | QueryFailure;
  /**
   * Summarizes policy states for the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_SummarizeForResource")
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForResource(
    ...ApiVersionParameter,

    /**
     * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
     */
    @path
    policyStatesSummaryResource: PolicyStatesSummaryResourceType,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,
  ): SummarizeResults | QueryFailure;

  /**
   * Triggers a policy evaluation scan for all the resources under the subscription
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" ""
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_TriggerSubscriptionEvaluation")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation")
  @post
  triggerSubscriptionEvaluation(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
  ): {
    @statusCode statusCode: 200;
  } | ArmAcceptedLroResponse<
    "The scan was successfully triggered.",
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  > | QueryFailure;

  /**
   * Triggers a policy evaluation scan for all the resources under the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_TriggerResourceGroupEvaluation")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation")
  @post
  triggerResourceGroupEvaluation(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * Resource group name.
     */
    @path
    resourceGroupName: string,
  ): {
    @statusCode statusCode: 200;
  } | ArmAcceptedLroResponse<
    "The scan was successfully triggered.",
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  > | QueryFailure;

  /**
   * Queries policy states for the subscription level policy set definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_ListQueryResultsForPolicySetDefinition")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @list
  @post
  listQueryResultsForPolicySetDefinition(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
     */
    @path
    policyStatesResource: PolicyStatesResource,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy set definition name.
     */
    @path
    policySetDefinitionName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyStatesQueryResults | QueryFailure;

  /**
   * Summarizes policy states for the subscription level policy set definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_SummarizeForPolicySetDefinition")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForPolicySetDefinition(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
     */
    @path
    policyStatesSummaryResource: PolicyStatesSummaryResourceType,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy set definition name.
     */
    @path
    policySetDefinitionName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,
  ): SummarizeResults | QueryFailure;

  /**
   * Queries policy states for the subscription level policy definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_ListQueryResultsForPolicyDefinition")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @list
  @post
  listQueryResultsForPolicyDefinition(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
     */
    @path
    policyStatesResource: PolicyStatesResource,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy definition name.
     */
    @path
    policyDefinitionName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyStatesQueryResults | QueryFailure;

  /**
   * Summarizes policy states for the subscription level policy definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_SummarizeForPolicyDefinition")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForPolicyDefinition(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
     */
    @path
    policyStatesSummaryResource: PolicyStatesSummaryResourceType,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy definition name.
     */
    @path
    policyDefinitionName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,
  ): SummarizeResults | QueryFailure;

  /**
   * Queries policy states for the subscription level policy assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_ListQueryResultsForSubscriptionLevelPolicyAssignment")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @list
  @post
  listQueryResultsForSubscriptionLevelPolicyAssignment(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
     */
    @path
    policyStatesResource: PolicyStatesResource,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy assignment name.
     */
    @path
    policyAssignmentName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyStatesQueryResults | QueryFailure;

  /**
   * Summarizes policy states for the subscription level policy assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_SummarizeForSubscriptionLevelPolicyAssignment")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForSubscriptionLevelPolicyAssignment(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
     */
    @path
    policyStatesSummaryResource: PolicyStatesSummaryResourceType,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy assignment name.
     */
    @path
    policyAssignmentName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,
  ): SummarizeResults | QueryFailure;

  /**
   * Queries policy states for the resource group level policy assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_ListQueryResultsForResourceGroupLevelPolicyAssignment")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @list
  @post
  listQueryResultsForResourceGroupLevelPolicyAssignment(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * Resource group name.
     */
    @path
    resourceGroupName: string,

    /**
     * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
     */
    @path
    policyStatesResource: PolicyStatesResource,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy assignment name.
     */
    @path
    policyAssignmentName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$skiptoken")
    SkipToken?: string,
  ): PolicyStatesQueryResults | QueryFailure;

  /**
   * Summarizes policy states for the resource group level policy assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyStates_SummarizeForResourceGroupLevelPolicyAssignment")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForResourceGroupLevelPolicyAssignment(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * Resource group name.
     */
    @path
    resourceGroupName: string,

    /**
     * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
     */
    @path
    policyStatesSummaryResource: PolicyStatesSummaryResourceType,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy assignment name.
     */
    @path
    policyAssignmentName: string,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,
  ): SummarizeResults | QueryFailure;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PolicyMetadataNonResourceOperationGroup {
  /**
   * Get a list of the policy metadata resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyMetadata_List")
  @autoRoute
  @list
  @get
  @action("policyMetadata")
  list is ArmProviderActionSync<
    Response = PolicyMetadataCollection,
    Parameters = {
      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;
    },
    Error = ErrorResponse
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface PolicyRestrictionsOperationGroup {
  /**
   * Checks what restrictions Azure Policy will place on a resource within a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyRestrictions_CheckAtSubscriptionScope")
  @autoRoute
  @action("checkPolicyRestrictions")
  checkAtSubscriptionScope is ArmProviderActionSync<
    Request = CheckRestrictionsRequest,
    Response = CheckRestrictionsResult,
    Scope = SubscriptionActionScope,
    Error = ErrorResponse
  >;
  /**
   * Checks what restrictions Azure Policy will place on a resource within a resource group. Use this when the resource group the resource will be created in is already known.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyRestrictions_CheckAtResourceGroupScope")
  @autoRoute
  @action("checkPolicyRestrictions")
  checkAtResourceGroupScope is ArmProviderActionSync<
    Request = CheckRestrictionsRequest,
    Response = CheckRestrictionsResult,
    Scope = Extension.ResourceGroup,
    Error = ErrorResponse
  >;
  /**
   * Checks what restrictions Azure Policy will place on resources within a management group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PolicyRestrictions_CheckAtManagementGroupScope")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupId}/providers/Microsoft.PolicyInsights/checkPolicyRestrictions")
  @post
  checkAtManagementGroupScope(
    ...ApiVersionParameter,

    /**
     * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
     */
    @path
    managementGroupsNamespace: "Microsoft.Management",

    /**
     * Management group ID.
     */
    @path
    managementGroupId: string,

    /**
     * The check policy restrictions parameters.
     */
    @body
    body: CheckManagementGroupRestrictionsRequest,
  ): CheckRestrictionsResult | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ComponentPolicyStatesOperationGroup {
  /**
   * Queries component policy states under subscription scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentPolicyStates_ListQueryResultsForSubscription")
  @autoRoute
  @action("queryResults")
  listQueryResultsForSubscription is ArmProviderActionSync<
    Response = ComponentPolicyStatesQueryResults,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The virtual resource under ComponentPolicyStates resource type. In a given time range, 'latest' represents the latest component policy state(s).
       */
      @path
      @segment("componentPolicyStates")
      componentPolicyStatesResource: ComponentPolicyStatesResource;

      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$apply")
      Apply?: string;
    },
    Error = ErrorResponse
  >;
  /**
   * Queries component policy states under resource group scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentPolicyStates_ListQueryResultsForResourceGroup")
  @autoRoute
  @action("queryResults")
  listQueryResultsForResourceGroup is ArmProviderActionSync<
    Response = ComponentPolicyStatesQueryResults,
    Scope = Extension.ResourceGroup,
    Parameters = {
      /**
       * The virtual resource under ComponentPolicyStates resource type. In a given time range, 'latest' represents the latest component policy state(s).
       */
      @path
      @segment("componentPolicyStates")
      componentPolicyStatesResource: ComponentPolicyStatesResource;

      /**
       * Maximum number of records to return.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$top")
      @minValue(0)
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
      @query("$apply")
      Apply?: string;
    },
    Error = ErrorResponse
  >;
  /**
   * Queries component policy states for the resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentPolicyStates_ListQueryResultsForResource")
  @route("/{+resourceId}/providers/Microsoft.PolicyInsights/componentPolicyStates/{componentPolicyStatesResource}/queryResults")
  @post
  listQueryResultsForResource(
    ...ApiVersionParameter,

    /**
     * Resource ID.
     */
    @path
    resourceId: string,

    /**
     * The virtual resource under ComponentPolicyStates resource type. In a given time range, 'latest' represents the latest component policy state(s).
     */
    @path
    componentPolicyStatesResource: ComponentPolicyStatesResource,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,

    /**
     * The $expand query parameter.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$expand")
    Expand?: string,
  ): ComponentPolicyStatesQueryResults | ErrorResponse;
  /**
   * Queries component policy states for the subscription level policy definition.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentPolicyStates_ListQueryResultsForPolicyDefinition")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/componentPolicyStates/{componentPolicyStatesResource}/queryResults")
  @post
  listQueryResultsForPolicyDefinition(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy definition name.
     */
    @maxLength(64)
    @minLength(1)
    @pattern("^[^<>%&:\\\\?/#]*$")
    @path
    policyDefinitionName: string,

    /**
     * The virtual resource under ComponentPolicyStates resource type. In a given time range, 'latest' represents the latest component policy state(s).
     */
    @path
    componentPolicyStatesResource: ComponentPolicyStatesResource,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,
  ): ComponentPolicyStatesQueryResults | ErrorResponse;
  /**
   * Queries component policy states for the subscription level policy assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentPolicyStates_ListQueryResultsForSubscriptionLevelPolicyAssignment")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/componentPolicyStates/{componentPolicyStatesResource}/queryResults")
  @post
  listQueryResultsForSubscriptionLevelPolicyAssignment(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy assignment name.
     */
    @maxLength(64)
    @minLength(1)
    @pattern("^[^<>%&:\\\\?/#]*$")
    @path
    policyAssignmentName: string,

    /**
     * The virtual resource under ComponentPolicyStates resource type. In a given time range, 'latest' represents the latest component policy state(s).
     */
    @path
    componentPolicyStatesResource: ComponentPolicyStatesResource,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,
  ): ComponentPolicyStatesQueryResults | ErrorResponse;
  /**
   * Queries component policy states for the resource group level policy assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ComponentPolicyStates_ListQueryResultsForResourceGroupLevelPolicyAssignment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/componentPolicyStates/{componentPolicyStatesResource}/queryResults")
  @post
  listQueryResultsForResourceGroupLevelPolicyAssignment(
    ...ApiVersionParameter,

    /**
     * Azure subscription ID.
     */
    @path
    subscriptionId: string,

    /**
     * Resource group name.
     */
    @path
    resourceGroupName: string,

    /**
     * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
     */
    @path
    authorizationNamespace: "Microsoft.Authorization",

    /**
     * Policy assignment name.
     */
    @maxLength(64)
    @minLength(1)
    @pattern("^[^<>%&:\\\\?/#]*$")
    @path
    policyAssignmentName: string,

    /**
     * The virtual resource under ComponentPolicyStates resource type. In a given time range, 'latest' represents the latest component policy state(s).
     */
    @path
    componentPolicyStatesResource: ComponentPolicyStatesResource,

    /**
     * Maximum number of records to return.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$top")
    @minValue(0)
    Top?: int32,

    /**
     * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$orderby")
    OrderBy?: string,

    /**
     * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$select")
    Select?: string,

    /**
     * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$from")
    From?: utcDateTime,

    /**
     * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$to")
    To?: utcDateTime,

    /**
     * OData filter expression.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$filter")
    Filter?: string,

    /**
     * OData apply expression for aggregations.
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "Existing property from original swagger"
    @query("$apply")
    Apply?: string,
  ): ComponentPolicyStatesQueryResults | ErrorResponse;
}

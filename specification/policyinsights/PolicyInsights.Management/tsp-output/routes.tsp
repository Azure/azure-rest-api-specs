import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.PolicyInsights;

interface PolicyTrackedResourcesOperations {
  /**
   * Queries policy tracked resources under the management group.
   */
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyTrackedResources/{policyTrackedResourcesResource}/queryResults")
  @post
  listQueryResultsForManagementGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
       */
      @path
      managementGroupsNamespace: "Microsoft.Management";

      /**
       * Management group name.
       */
      @path
      managementGroupName: string;

      /**
       * The name of the virtual resource under PolicyTrackedResources resource type; only "default" is allowed.
       */
      @path
      policyTrackedResourceType: PolicyTrackedResourcesResourceType;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    },
    PolicyTrackedResourcesQueryResults
  >;

  /**
   * Queries policy tracked resources under the subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyTrackedResources/{policyTrackedResourcesResource}/queryResults")
  @post
  listQueryResultsForSubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the virtual resource under PolicyTrackedResources resource type; only "default" is allowed.
       */
      @path
      policyTrackedResourceType: PolicyTrackedResourcesResourceType;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    PolicyTrackedResourcesQueryResults
  >;

  /**
   * Queries policy tracked resources under the resource group.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyTrackedResources/{policyTrackedResourcesResource}/queryResults")
  @post
  listQueryResultsForResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * Resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the virtual resource under PolicyTrackedResources resource type; only "default" is allowed.
       */
      @path
      policyTrackedResourceType: PolicyTrackedResourcesResourceType;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    PolicyTrackedResourcesQueryResults
  >;

  /**
   * Queries policy tracked resources under the resource.
   */
  @route("/{resourceId}/providers/Microsoft.PolicyInsights/policyTrackedResources/{policyTrackedResourcesResource}/queryResults")
  @post
  listQueryResultsForResource is Azure.Core.Foundations.Operation<
    {
      /**
       * Resource ID.
       */
      @path
      resourceId: string;

      /**
       * The name of the virtual resource under PolicyTrackedResources resource type; only "default" is allowed.
       */
      @path
      policyTrackedResourceType: PolicyTrackedResourcesResourceType;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    },
    PolicyTrackedResourcesQueryResults
  >;
}

interface PolicyEventsOperations {
  /**
   * Queries policy events for the resources under the management group.
   */
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  listQueryResultsForManagementGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
       */
      @path
      policyEventType: PolicyEventsResourceType;

      /**
       * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
       */
      @path
      managementGroupsNamespace: "Microsoft.Management";

      /**
       * Management group name.
       */
      @path
      managementGroupName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  /**
   * Queries policy events for the resources under the subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  listQueryResultsForSubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
       */
      @path
      policyEventType: PolicyEventsResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  /**
   * Queries policy events for the resources under the resource group.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  listQueryResultsForResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
       */
      @path
      policyEventType: PolicyEventsResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  /**
   * Queries policy events for the resource.
   */
  @route("/{resourceId}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  listQueryResultsForResource is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
       */
      @path
      policyEventType: PolicyEventsResourceType;

      /**
       * Resource ID.
       */
      @path
      resourceId: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * The $expand query parameter. For example, to expand components use $expand=components
       */
      @query("$expand")
      Expand?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  /**
   * Queries policy events for the subscription level policy set definition.
   */
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  listQueryResultsForPolicySetDefinition is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
       */
      @path
      policyEventType: PolicyEventsResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy set definition name.
       */
      @path
      policySetDefinitionName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  /**
   * Queries policy events for the subscription level policy definition.
   */
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  listQueryResultsForPolicyDefinition is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
       */
      @path
      policyEventType: PolicyEventsResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy definition name.
       */
      @path
      policyDefinitionName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  /**
   * Queries policy events for the subscription level policy assignment.
   */
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  listQueryResultsForSubscriptionLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
       */
      @path
      policyEventType: PolicyEventsResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy assignment name.
       */
      @path
      policyAssignmentName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  /**
   * Queries policy events for the resource group level policy assignment.
   */
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  listQueryResultsForResourceGroupLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the virtual resource under PolicyEvents resource type; only "default" is allowed.
       */
      @path
      policyEventType: PolicyEventsResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy assignment name.
       */
      @path
      policyAssignmentName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;
}

interface PolicyStatesOperations {
  /**
   * Queries policy states for the resources under the management group.
   */
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  listQueryResultsForManagementGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
       */
      @path
      policyStateType: PolicyStatesResource;

      /**
       * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
       */
      @path
      managementGroupsNamespace: "Microsoft.Management";

      /**
       * Management group name.
       */
      @path
      managementGroupName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  /**
   * Summarizes policy states for the resources under the management group.
   */
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForManagementGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
       */
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      /**
       * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
       */
      @path
      managementGroupsNamespace: "Microsoft.Management";

      /**
       * Management group name.
       */
      @path
      managementGroupName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  /**
   * Queries policy states for the resources under the subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  listQueryResultsForSubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
       */
      @path
      policyStateType: PolicyStatesResource;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  /**
   * Summarizes policy states for the resources under the subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForSubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
       */
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  /**
   * Queries policy states for the resources under the resource group.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  listQueryResultsForResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
       */
      @path
      policyStateType: PolicyStatesResource;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  /**
   * Summarizes policy states for the resources under the resource group.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
       */
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  /**
   * Queries policy states for the resource.
   */
  @route("/{resourceId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  listQueryResultsForResource is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
       */
      @path
      policyStateType: PolicyStatesResource;

      /**
       * Resource ID.
       */
      @path
      resourceId: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * The $expand query parameter. For example, to expand components use $expand=components
       */
      @query("$expand")
      Expand?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  /**
   * Summarizes policy states for the resource.
   */
  @route("/{resourceId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForResource is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
       */
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      /**
       * Resource ID.
       */
      @path
      resourceId: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  /**
   * Triggers a policy evaluation scan for all the resources under the subscription
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation")
  @post
  triggerSubscriptionEvaluation is Azure.Core.Foundations.Operation<
    {
      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Triggers a policy evaluation scan for all the resources under the resource group.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation")
  @post
  triggerResourceGroupEvaluation is Azure.Core.Foundations.Operation<
    {
      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name.
       */
      @path
      resourceGroupName: string;
    },
    void
  >;

  /**
   * Queries policy states for the subscription level policy set definition.
   */
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  listQueryResultsForPolicySetDefinition is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
       */
      @path
      policyStateType: PolicyStatesResource;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy set definition name.
       */
      @path
      policySetDefinitionName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  /**
   * Summarizes policy states for the subscription level policy set definition.
   */
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForPolicySetDefinition is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
       */
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy set definition name.
       */
      @path
      policySetDefinitionName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  /**
   * Queries policy states for the subscription level policy definition.
   */
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  listQueryResultsForPolicyDefinition is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
       */
      @path
      policyStateType: PolicyStatesResource;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy definition name.
       */
      @path
      policyDefinitionName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  /**
   * Summarizes policy states for the subscription level policy definition.
   */
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForPolicyDefinition is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
       */
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy definition name.
       */
      @path
      policyDefinitionName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  /**
   * Queries policy states for the subscription level policy assignment.
   */
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  listQueryResultsForSubscriptionLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
       */
      @path
      policyStateType: PolicyStatesResource;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy assignment name.
       */
      @path
      policyAssignmentName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  /**
   * Summarizes policy states for the subscription level policy assignment.
   */
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForSubscriptionLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
       */
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy assignment name.
       */
      @path
      policyAssignmentName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  /**
   * Queries policy states for the resource group level policy assignment.
   */
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  listQueryResultsForResourceGroupLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).
       */
      @path
      policyStateType: PolicyStatesResource;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy assignment name.
       */
      @path
      policyAssignmentName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * Ordering expression using OData notation. One or more comma-separated column names with an optional "desc" (the default) or "asc", e.g. "$orderby=PolicyAssignmentId, ResourceId asc".
       */
      @query("$orderby")
      OrderBy?: string;

      /**
       * Select expression using OData notation. Limits the columns on each record to just those requested, e.g. "$select=PolicyAssignmentId, ResourceId".
       */
      @query("$select")
      Select?: string;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;

      /**
       * OData apply expression for aggregations.
       */
      @query("$apply")
      Apply?: string;

      /**
       * Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.
       */
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  /**
   * Summarizes policy states for the resource group level policy assignment.
   */
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  summarizeForResourceGroupLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      /**
       * The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.
       */
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Resource group name.
       */
      @path
      resourceGroupName: string;

      /**
       * The namespace for Microsoft Authorization resource provider; only "Microsoft.Authorization" is allowed.
       */
      @path
      authorizationNamespace: "Microsoft.Authorization";

      /**
       * Policy assignment name.
       */
      @path
      policyAssignmentName: string;

      /**
       * Maximum number of records to return.
       */
      @query("$top")
      Top?: int32;

      /**
       * ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).
       */
      @query("$from")
      From?: utcDateTime;

      /**
       * ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.
       */
      @query("$to")
      To?: utcDateTime;

      /**
       * OData filter expression.
       */
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;
}

interface PolicyRestrictionsOperations {
  /**
   * Checks what restrictions Azure Policy will place on a resource within a subscription.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/checkPolicyRestrictions")
  @post
  checkAtSubscriptionScope is Azure.Core.Foundations.Operation<
    {
      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The check policy restrictions parameters.
       */
      @body
      parameters: CheckRestrictionsRequest;
    },
    CheckRestrictionsResult
  >;

  /**
   * Checks what restrictions Azure Policy will place on a resource within a resource group. Use this when the resource group the resource will be created in is already known.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/checkPolicyRestrictions")
  @post
  checkAtResourceGroupScope is Azure.Core.Foundations.Operation<
    {
      /**
       * Microsoft Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The check policy restrictions parameters.
       */
      @body
      parameters: CheckRestrictionsRequest;
    },
    CheckRestrictionsResult
  >;

  /**
   * Checks what restrictions Azure Policy will place on resources within a management group.
   */
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupId}/providers/Microsoft.PolicyInsights/checkPolicyRestrictions")
  @post
  checkAtManagementGroupScope is Azure.Core.Foundations.Operation<
    {
      /**
       * The namespace for Microsoft Management RP; only "Microsoft.Management" is allowed.
       */
      @path
      managementGroupsNamespace: "Microsoft.Management";

      /**
       * Management group ID.
       */
      @path
      managementGroupId: string;

      /**
       * The check policy restrictions parameters.
       */
      @body
      parameters: CheckManagementGroupRestrictionsRequest;
    },
    CheckRestrictionsResult
  >;
}

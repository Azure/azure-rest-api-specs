import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.PolicyInsights;

interface PolicyTrackedResourcesOperations {
  @doc("Queries policy tracked resources under the management group.")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyTrackedResources/{policyTrackedResourcesResource}/queryResults")
  @post
  ListQueryResultsForManagementGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The namespace for Microsoft Management RP; only \"Microsoft.Management\" is allowed.")
      @path
      managementGroupsNamespace: "Microsoft.Management";

      @doc("Management group name.")
      @path
      managementGroupName: string;

      @doc("The name of the virtual resource under PolicyTrackedResources resource type; only \"default\" is allowed.")
      @path
      policyTrackedResourceType: PolicyTrackedResourcesResourceType;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    },
    PolicyTrackedResourcesQueryResults
  >;

  @doc("Queries policy tracked resources under the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyTrackedResources/{policyTrackedResourcesResource}/queryResults")
  @post
  ListQueryResultsForSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the virtual resource under PolicyTrackedResources resource type; only \"default\" is allowed.")
      @path
      policyTrackedResourceType: PolicyTrackedResourcesResourceType;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PolicyTrackedResourcesQueryResults
  >;

  @doc("Queries policy tracked resources under the resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyTrackedResources/{policyTrackedResourcesResource}/queryResults")
  @post
  ListQueryResultsForResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("Resource group name.")
      @path
      resourceGroupName: string;

      @doc("The name of the virtual resource under PolicyTrackedResources resource type; only \"default\" is allowed.")
      @path
      policyTrackedResourceType: PolicyTrackedResourcesResourceType;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    PolicyTrackedResourcesQueryResults
  >;

  @doc("Queries policy tracked resources under the resource.")
  @route("/{resourceId}/providers/Microsoft.PolicyInsights/policyTrackedResources/{policyTrackedResourcesResource}/queryResults")
  @post
  ListQueryResultsForResource is Azure.Core.Foundations.Operation<
    {
      @doc("Resource ID.")
      @path
      resourceId: string;

      @doc("The name of the virtual resource under PolicyTrackedResources resource type; only \"default\" is allowed.")
      @path
      policyTrackedResourceType: PolicyTrackedResourcesResourceType;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    },
    PolicyTrackedResourcesQueryResults
  >;
}

interface PolicyEventsOperations {
  @doc("Queries policy events for the resources under the management group.")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  ListQueryResultsForManagementGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the virtual resource under PolicyEvents resource type; only \"default\" is allowed.")
      @path
      policyEventType: PolicyEventsResourceType;

      @doc("The namespace for Microsoft Management RP; only \"Microsoft.Management\" is allowed.")
      @path
      managementGroupsNamespace: "Microsoft.Management";

      @doc("Management group name.")
      @path
      managementGroupName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  @doc("Queries policy events for the resources under the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  ListQueryResultsForSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the virtual resource under PolicyEvents resource type; only \"default\" is allowed.")
      @path
      policyEventType: PolicyEventsResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  @doc("Queries policy events for the resources under the resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  ListQueryResultsForResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the virtual resource under PolicyEvents resource type; only \"default\" is allowed.")
      @path
      policyEventType: PolicyEventsResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Resource group name.")
      @path
      resourceGroupName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  @doc("Queries policy events for the resource.")
  @route("/{resourceId}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  ListQueryResultsForResource is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the virtual resource under PolicyEvents resource type; only \"default\" is allowed.")
      @path
      policyEventType: PolicyEventsResourceType;

      @doc("Resource ID.")
      @path
      resourceId: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("The $expand query parameter. For example, to expand components use $expand=components")
      @query("$expand")
      Expand?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  @doc("Queries policy events for the subscription level policy set definition.")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  ListQueryResultsForPolicySetDefinition is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the virtual resource under PolicyEvents resource type; only \"default\" is allowed.")
      @path
      policyEventType: PolicyEventsResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy set definition name.")
      @path
      policySetDefinitionName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  @doc("Queries policy events for the subscription level policy definition.")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  ListQueryResultsForPolicyDefinition is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the virtual resource under PolicyEvents resource type; only \"default\" is allowed.")
      @path
      policyEventType: PolicyEventsResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy definition name.")
      @path
      policyDefinitionName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  @doc("Queries policy events for the subscription level policy assignment.")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  ListQueryResultsForSubscriptionLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the virtual resource under PolicyEvents resource type; only \"default\" is allowed.")
      @path
      policyEventType: PolicyEventsResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy assignment name.")
      @path
      policyAssignmentName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;

  @doc("Queries policy events for the resource group level policy assignment.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyEvents/{policyEventsResource}/queryResults")
  @post
  ListQueryResultsForResourceGroupLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the virtual resource under PolicyEvents resource type; only \"default\" is allowed.")
      @path
      policyEventType: PolicyEventsResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Resource group name.")
      @path
      resourceGroupName: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy assignment name.")
      @path
      policyAssignmentName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyEventsQueryResults
  >;
}

interface PolicyStatesOperations {
  @doc("Queries policy states for the resources under the management group.")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  ListQueryResultsForManagementGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).")
      @path
      policyStateType: PolicyStatesResource;

      @doc("The namespace for Microsoft Management RP; only \"Microsoft.Management\" is allowed.")
      @path
      managementGroupsNamespace: "Microsoft.Management";

      @doc("Management group name.")
      @path
      managementGroupName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  @doc("Summarizes policy states for the resources under the management group.")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  SummarizeForManagementGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.")
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      @doc("The namespace for Microsoft Management RP; only \"Microsoft.Management\" is allowed.")
      @path
      managementGroupsNamespace: "Microsoft.Management";

      @doc("Management group name.")
      @path
      managementGroupName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  @doc("Queries policy states for the resources under the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  ListQueryResultsForSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).")
      @path
      policyStateType: PolicyStatesResource;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  @doc("Summarizes policy states for the resources under the subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  SummarizeForSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.")
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  @doc("Queries policy states for the resources under the resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  ListQueryResultsForResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).")
      @path
      policyStateType: PolicyStatesResource;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Resource group name.")
      @path
      resourceGroupName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  @doc("Summarizes policy states for the resources under the resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  SummarizeForResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.")
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Resource group name.")
      @path
      resourceGroupName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  @doc("Queries policy states for the resource.")
  @route("/{resourceId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  ListQueryResultsForResource is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).")
      @path
      policyStateType: PolicyStatesResource;

      @doc("Resource ID.")
      @path
      resourceId: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("The $expand query parameter. For example, to expand components use $expand=components")
      @query("$expand")
      Expand?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  @doc("Summarizes policy states for the resource.")
  @route("/{resourceId}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  SummarizeForResource is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.")
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      @doc("Resource ID.")
      @path
      resourceId: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  @doc("Triggers a policy evaluation scan for all the resources under the subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation")
  @post
  TriggerSubscriptionEvaluation is Azure.Core.Foundations.Operation<
    {
      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Triggers a policy evaluation scan for all the resources under the resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/policyStates/latest/triggerEvaluation")
  @post
  TriggerResourceGroupEvaluation is Azure.Core.Foundations.Operation<
    {
      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Resource group name.")
      @path
      resourceGroupName: string;
    },
    void
  >;

  @doc("Queries policy states for the subscription level policy set definition.")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  ListQueryResultsForPolicySetDefinition is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).")
      @path
      policyStateType: PolicyStatesResource;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy set definition name.")
      @path
      policySetDefinitionName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  @doc("Summarizes policy states for the subscription level policy set definition.")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policySetDefinitions/{policySetDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  SummarizeForPolicySetDefinition is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.")
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy set definition name.")
      @path
      policySetDefinitionName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  @doc("Queries policy states for the subscription level policy definition.")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  ListQueryResultsForPolicyDefinition is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).")
      @path
      policyStateType: PolicyStatesResource;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy definition name.")
      @path
      policyDefinitionName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  @doc("Summarizes policy states for the subscription level policy definition.")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyDefinitions/{policyDefinitionName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  SummarizeForPolicyDefinition is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.")
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy definition name.")
      @path
      policyDefinitionName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  @doc("Queries policy states for the subscription level policy assignment.")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  ListQueryResultsForSubscriptionLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).")
      @path
      policyStateType: PolicyStatesResource;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy assignment name.")
      @path
      policyAssignmentName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  @doc("Summarizes policy states for the subscription level policy assignment.")
  @route("/subscriptions/{subscriptionId}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  SummarizeForSubscriptionLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.")
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy assignment name.")
      @path
      policyAssignmentName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;

  @doc("Queries policy states for the resource group level policy assignment.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesResource}/queryResults")
  @post
  ListQueryResultsForResourceGroupLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type. In a given time range, 'latest' represents the latest policy state(s), whereas 'default' represents all policy state(s).")
      @path
      policyStateType: PolicyStatesResource;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Resource group name.")
      @path
      resourceGroupName: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy assignment name.")
      @path
      policyAssignmentName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("Ordering expression using OData notation. One or more comma-separated column names with an optional \"desc\" (the default) or \"asc\", e.g. \"$orderby=PolicyAssignmentId, ResourceId asc\".")
      @query("$orderby")
      OrderBy?: string;

      @doc("Select expression using OData notation. Limits the columns on each record to just those requested, e.g. \"$select=PolicyAssignmentId, ResourceId\".")
      @query("$select")
      Select?: string;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;

      @doc("OData apply expression for aggregations.")
      @query("$apply")
      Apply?: string;

      @doc("Skiptoken is only provided if a previous response returned a partial result as a part of nextLink element.")
      @query("$skiptoken")
      SkipToken?: string;
    },
    PolicyStatesQueryResults
  >;

  @doc("Summarizes policy states for the resource group level policy assignment.")
  @route("/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{authorizationNamespace}/policyAssignments/{policyAssignmentName}/providers/Microsoft.PolicyInsights/policyStates/{policyStatesSummaryResource}/summarize")
  @post
  SummarizeForResourceGroupLevelPolicyAssignment is Azure.Core.Foundations.Operation<
    {
      @doc("The virtual resource under PolicyStates resource type for summarize action. In a given time range, 'latest' represents the latest policy state(s) and is the only allowed value.")
      @path
      policyStateSummaryType: PolicyStatesSummaryResourceType;

      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Resource group name.")
      @path
      resourceGroupName: string;

      @doc("The namespace for Microsoft Authorization resource provider; only \"Microsoft.Authorization\" is allowed.")
      @path
      authorizationNamespace: "Microsoft.Authorization";

      @doc("Policy assignment name.")
      @path
      policyAssignmentName: string;

      @doc("Maximum number of records to return.")
      @query("$top")
      Top?: int32;

      @doc("ISO 8601 formatted timestamp specifying the start time of the interval to query. When not specified, the service uses ($to - 1-day).")
      @query("$from")
      From?: utcDateTime;

      @doc("ISO 8601 formatted timestamp specifying the end time of the interval to query. When not specified, the service uses request time.")
      @query("$to")
      To?: utcDateTime;

      @doc("OData filter expression.")
      @query("$filter")
      Filter?: string;
    },
    SummarizeResults
  >;
}

interface PolicyRestrictionsOperations {
  @doc("Checks what restrictions Azure Policy will place on a resource within a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.PolicyInsights/checkPolicyRestrictions")
  @post
  CheckAtSubscriptionScope is Azure.Core.Foundations.Operation<
    {
      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The check policy restrictions parameters.")
      @body
      parameters: CheckRestrictionsRequest;
    },
    CheckRestrictionsResult
  >;

  @doc("Checks what restrictions Azure Policy will place on a resource within a resource group. Use this when the resource group the resource will be created in is already known.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.PolicyInsights/checkPolicyRestrictions")
  @post
  CheckAtResourceGroupScope is Azure.Core.Foundations.Operation<
    {
      @doc("Microsoft Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The check policy restrictions parameters.")
      @body
      parameters: CheckRestrictionsRequest;
    },
    CheckRestrictionsResult
  >;

  @doc("Checks what restrictions Azure Policy will place on resources within a management group.")
  @route("/providers/{managementGroupsNamespace}/managementGroups/{managementGroupId}/providers/Microsoft.PolicyInsights/checkPolicyRestrictions")
  @post
  CheckAtManagementGroupScope is Azure.Core.Foundations.Operation<
    {
      @doc("The namespace for Microsoft Management RP; only \"Microsoft.Management\" is allowed.")
      @path
      managementGroupsNamespace: "Microsoft.Management";

      @doc("Management group ID.")
      @path
      managementGroupId: string;

      @doc("The check policy restrictions parameters.")
      @body
      parameters: CheckManagementGroupRestrictionsRequest;
    },
    CheckRestrictionsResult
  >;
}

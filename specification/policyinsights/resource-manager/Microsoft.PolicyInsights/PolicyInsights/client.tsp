import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./PolicyInsights/main.tsp";
import "./PolicyTrackedResources/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Azure.ResourceManager;

using PolicyInsightsCommon;
using PolicyInsightsApi;
using PolicyTrackedResourcesApi;

@client({
  name: "PolicyInsightsManagementClient",
  service: [PolicyInsightsApi, PolicyTrackedResourcesApi],
  autoMergeService: true,
})
namespace PolicyInsightsManagementClient;

@@clientName(PolicyInsightsManagementClient,
  "PolicyInsightsClient",
  "javascript,python,java"
);

// Section: Explicit subscriptionId parameter
@@clientLocation(PolicyEventsListQueryResultsForPolicySetDefinitionBaseParam.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition
);
@@clientLocation(policyEventsListQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  policyEventsListQueryResultsForPolicySetDefinition
);
@@clientLocation(PolicyEventsListQueryResultsForPolicyDefinitionBaseParam.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition
);
@@clientLocation(PolicyEventsListQueryResultsForSubscriptionLevelPolicyAssignmentBaseParam.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(PolicyEventsListQueryResultsForResourceGroupLevelPolicyAssignmentBaseParam.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(PolicyStatesListQueryResultsForPolicySetDefinitionBaseParam.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition
);
@@clientLocation(PolicyStatesSummarizeForPolicySetDefinitionBaseParam.subscriptionId,
  PolicyStatesOperationGroup.summarizeForPolicySetDefinition
);
@@clientLocation(PolicyStatesListQueryResultsForPolicyDefinitionBaseParam.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition
);
@@clientLocation(PolicyStatesSummarizeForPolicyDefinitionBaseParam.subscriptionId,
  PolicyStatesOperationGroup.summarizeForPolicyDefinition
);
@@clientLocation(PolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignmentBaseParam.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(PolicyStatesSummarizeForSubscriptionLevelPolicyAssignmentBaseParam.subscriptionId,
  PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment
);
@@clientLocation(PolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignmentBaseParam.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(PolicyStatesSummarizeForResourceGroupLevelPolicyAssignmentBaseParam.subscriptionId,
  PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment
);
@@clientLocation(ComponentPolicyStatesListQueryResultsForPolicyDefinitionBaseParam.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition
);
@@clientLocation(ComponentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignmentBaseParam.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(ComponentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignmentBaseParam.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment
);

/**
 * Parameter group for OData query options.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
model QueryOptions {
  /** Maximum number of records to return. */
  @query("$top")
  @minValue(0)
  Top?: int32;

  /** Ordering expression using OData notation. */
  @query("$orderby")
  OrderBy?: string;

  /** Select expression using OData notation. */
  @query("$select")
  Select?: string;

  /** ISO 8601 formatted timestamp specifying the start time of the interval to query. */
  @query("$from")
  From?: utcDateTime;

  /** ISO 8601 formatted timestamp specifying the end time of the interval to query. */
  @query("$to")
  To?: utcDateTime;

  /** OData filter expression. */
  @query("$filter")
  Filter?: string;

  /** OData apply expression for aggregations. */
  @query("$apply")
  Apply?: string;

  /**
   * The $expand query parameter. For example, to expand components use $expand=components
   */
  @query("$expand")
  Expand?: string;

  /** Skiptoken provided if a previous response returned a partial result. */
  @query("$skiptoken")
  SkipToken?: string;
}

/**
 * Group C: Query options for Summarize operations.
 * Params: all except $expand
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
model QueryOptionsB {
  /** Maximum number of records to return. */
  @query("$top")
  @minValue(0)
  Top?: int32;

  /** Ordering expression using OData notation. */
  @query("$orderby")
  OrderBy?: string;

  /** Select expression using OData notation. */
  @query("$select")
  Select?: string;

  /** ISO 8601 formatted timestamp specifying the start time of the interval to query. */
  @query("$from")
  From?: utcDateTime;

  /** ISO 8601 formatted timestamp specifying the end time of the interval to query. */
  @query("$to")
  To?: utcDateTime;

  /** OData filter expression. */
  @query("$filter")
  Filter?: string;

  /** OData apply expression for aggregations. */
  @query("$apply")
  Apply?: string;

  /** Skiptoken provided if a previous response returned a partial result. */
  @query("$skiptoken")
  SkipToken?: string;
}

@@alternateType(QueryOptionsB, QueryOptions);
@@alternateType(QueryOptionsC, QueryOptions);
@@alternateType(QueryOptionsD, QueryOptions);
@@alternateType(QueryOptionsE, QueryOptions);
@@alternateType(QueryOptionsF, QueryOptions);
@@alternateType(QueryOptionsG, QueryOptions);
@@alternateType(QueryOptionsH, QueryOptions);

/**
 * Group C: Query options for Summarize operations.
 * Params: $top, $from, $to, $filter
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
model QueryOptionsC {
  /** Maximum number of records to return. */
  @query("$top")
  @minValue(0)
  Top?: int32;

  /** ISO 8601 formatted timestamp specifying the start time of the interval to query. */
  @query("$from")
  From?: utcDateTime;

  /** ISO 8601 formatted timestamp specifying the end time of the interval to query. */
  @query("$to")
  To?: utcDateTime;

  /** OData filter expression. */
  @query("$filter")
  Filter?: string;
}

/**
 * Group D: Query options for ComponentPolicyStates (non-resource scoped).
 * Params: $top, $orderby, $select, $from, $to, $filter, $apply
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
model QueryOptionsD {
  /** Maximum number of records to return. */
  @query("$top")
  @minValue(0)
  Top?: int32;

  /** Ordering expression using OData notation. */
  @query("$orderby")
  OrderBy?: string;

  /** Select expression using OData notation. */
  @query("$select")
  Select?: string;

  /** ISO 8601 formatted timestamp specifying the start time of the interval to query. */
  @query("$from")
  From?: utcDateTime;

  /** ISO 8601 formatted timestamp specifying the end time of the interval to query. */
  @query("$to")
  To?: utcDateTime;

  /** OData filter expression. */
  @query("$filter")
  Filter?: string;

  /** OData apply expression for aggregations. */
  @query("$apply")
  Apply?: string;
}

/**
 * Group E: Query options for ComponentPolicyStates ForResource.
 * Params: $top, $orderby, $select, $from, $to, $filter, $apply, $expand
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
model QueryOptionsE {
  /** Maximum number of records to return. */
  @query("$top")
  @minValue(0)
  Top?: int32;

  /** Ordering expression using OData notation. */
  @query("$orderby")
  OrderBy?: string;

  /** Select expression using OData notation. */
  @query("$select")
  Select?: string;

  /** ISO 8601 formatted timestamp specifying the start time of the interval to query. */
  @query("$from")
  From?: utcDateTime;

  /** ISO 8601 formatted timestamp specifying the end time of the interval to query. */
  @query("$to")
  To?: utcDateTime;

  /** OData filter expression. */
  @query("$filter")
  Filter?: string;

  /** OData apply expression for aggregations. */
  @query("$apply")
  Apply?: string;

  /**
   * The $expand query parameter. For example, to expand components use $expand=components
   */
  @query("$expand")
  Expand?: string;
}

/**
 * Group F: Query options for NextLink operations.
 * Params: $skiptoken
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
model QueryOptionsF {
  /** Skiptoken provided if a previous response returned a partial result. */
  @query("$skiptoken")
  SkipToken?: string;
}

/**
 * Group G: Query options for ListDeployments and PolicyMetadata_List.
 * Params: $top
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
model QueryOptionsG {
  /** Maximum number of records to return. */
  @query("$top")
  @minValue(0)
  Top?: int32;
}

/**
 * Group H: Query options for Remediations ListFor* and Attestations ListFor*.
 * Params: $top, $filter
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
model QueryOptionsH {
  /** Maximum number of records to return. */
  @query("$top")
  @minValue(0)
  Top?: int32;

  /** OData filter expression. */
  @query("$filter")
  Filter?: string;
}

// PolicyTrackedResources overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyTrackedResourcesListQueryResultsForManagementGroup(
  ...ApiVersionParameter,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupName: string,

  @path
  policyTrackedResourcesResource: PolicyTrackedResourcesResourceType,

  queryOptions?: QueryOptionsH,
): PolicyTrackedResourcesQueryResults | QueryFailure;
@@override(PolicyTrackedResourcesOperationGroup.listQueryResultsForManagementGroup,
  policyTrackedResourcesListQueryResultsForManagementGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyTrackedResourcesListQueryResultsForSubscription(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  @bodyRoot body: void,

  @path
  @key
  @segment("subscription")
  name: string,

  ...ProviderNamespace<SubscriptionActionScope>,

  @path
  @segment("policyTrackedResources")
  policyTrackedResourcesResource: PolicyTrackedResourcesResourceType,

  queryOptions?: QueryOptionsH,
): PolicyTrackedResourcesQueryResults | QueryFailure;
@@override(PolicyTrackedResourcesOperationGroup.listQueryResultsForSubscription,
  policyTrackedResourcesListQueryResultsForSubscription
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyTrackedResourcesListQueryResultsForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,

  @path
  @segment("policyTrackedResources")
  policyTrackedResourcesResource: PolicyTrackedResourcesResourceType,

  queryOptions?: QueryOptionsH,
): PolicyTrackedResourcesQueryResults | QueryFailure;
@@override(PolicyTrackedResourcesOperationGroup.listQueryResultsForResourceGroup,
  policyTrackedResourcesListQueryResultsForResourceGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyTrackedResourcesListQueryResultsForResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  @path
  policyTrackedResourcesResource: PolicyTrackedResourcesResourceType,

  queryOptions?: QueryOptionsH,
): PolicyTrackedResourcesQueryResults | QueryFailure;
@@override(PolicyTrackedResourcesOperationGroup.listQueryResultsForResource,
  policyTrackedResourcesListQueryResultsForResource
);

// PolicyEvents overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForManagementGroup(
  ...ApiVersionParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupName: string,

  queryOptions?: QueryOptionsB,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForManagementGroup,
  policyEventsListQueryResultsForManagementGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForSubscription(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  @bodyRoot body: void,

  @path
  @key
  @segment("subscription")
  name: string,

  ...ProviderNamespace<SubscriptionActionScope>,

  @path
  @segment("policyEvents")
  policyEventsResource: PolicyEventsResourceType,

  queryOptions?: QueryOptionsB,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForSubscription,
  policyEventsListQueryResultsForSubscription
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,

  @path
  @segment("policyEvents")
  policyEventsResource: PolicyEventsResourceType,

  queryOptions?: QueryOptionsB,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForResourceGroup,
  policyEventsListQueryResultsForResourceGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForResource(
  ...ApiVersionParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  resourceId: string,

  queryOptions?: QueryOptions,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForResource,
  policyEventsListQueryResultsForResource
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForPolicySetDefinition(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: QueryOptionsB,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition,
  policyEventsListQueryResultsForPolicySetDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForPolicyDefinition(
  ...PolicyEventsListQueryResultsForPolicyDefinitionBaseParam,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: QueryOptionsB,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition,
  policyEventsListQueryResultsForPolicyDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment(
  ...PolicyEventsListQueryResultsForSubscriptionLevelPolicyAssignmentBaseParam,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: QueryOptionsB,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForResourceGroupLevelPolicyAssignment(
  ...PolicyEventsListQueryResultsForResourceGroupLevelPolicyAssignmentBaseParam,

  @path
  resourceGroupName: string,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: QueryOptionsB,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  policyEventsListQueryResultsForResourceGroupLevelPolicyAssignment
);

// PolicyStates overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForManagementGroup(
  ...ApiVersionParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupName: string,

  queryOptions?: QueryOptionsB,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForManagementGroup,
  policyStatesListQueryResultsForManagementGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForManagementGroup(
  ...ApiVersionParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupName: string,

  queryOptions?: QueryOptionsC,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForManagementGroup,
  policyStatesSummarizeForManagementGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForSubscription(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  @bodyRoot body: void,

  @path
  @key
  @segment("subscription")
  name: string,

  ...ProviderNamespace<SubscriptionActionScope>,

  @path
  @segment("policyStates")
  policyStatesResource: PolicyStatesResource,

  queryOptions?: QueryOptionsB,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForSubscription,
  policyStatesListQueryResultsForSubscription
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForSubscription(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  @bodyRoot body: void,

  @path
  @key
  @segment("subscription")
  name: string,

  ...ProviderNamespace<SubscriptionActionScope>,

  @path
  @segment("policyStates")
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  queryOptions?: QueryOptionsC,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForSubscription,
  policyStatesSummarizeForSubscription
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,

  @path
  @segment("policyStates")
  policyStatesResource: PolicyStatesResource,

  queryOptions?: QueryOptionsB,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForResourceGroup,
  policyStatesListQueryResultsForResourceGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,

  @path
  @segment("policyStates")
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  queryOptions?: QueryOptionsC,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForResourceGroup,
  policyStatesSummarizeForResourceGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForResource(
  ...ApiVersionParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  resourceId: string,

  queryOptions?: QueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForResource,
  policyStatesListQueryResultsForResource
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForResource(
  ...ApiVersionParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  resourceId: string,

  queryOptions?: QueryOptionsC,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForResource,
  policyStatesSummarizeForResource
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForPolicySetDefinition(
  ...PolicyStatesListQueryResultsForPolicySetDefinitionBaseParam,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: QueryOptionsB,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition,
  policyStatesListQueryResultsForPolicySetDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForPolicySetDefinition(
  ...PolicyStatesSummarizeForPolicySetDefinitionBaseParam,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: QueryOptionsC,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForPolicySetDefinition,
  policyStatesSummarizeForPolicySetDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForPolicyDefinition(
  ...PolicyStatesListQueryResultsForPolicyDefinitionBaseParam,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: QueryOptionsB,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  policyStatesListQueryResultsForPolicyDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForPolicyDefinition(
  ...PolicyStatesSummarizeForPolicyDefinitionBaseParam,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: QueryOptionsC,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForPolicyDefinition,
  policyStatesSummarizeForPolicyDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment(
  ...PolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignmentBaseParam,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: QueryOptionsB,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForSubscriptionLevelPolicyAssignment(
  ...PolicyStatesSummarizeForSubscriptionLevelPolicyAssignmentBaseParam,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: QueryOptionsC,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment,
  policyStatesSummarizeForSubscriptionLevelPolicyAssignment
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment(
  ...PolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignmentBaseParam,

  @path
  resourceGroupName: string,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: QueryOptionsB,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForResourceGroupLevelPolicyAssignment(
  ...PolicyStatesSummarizeForResourceGroupLevelPolicyAssignmentBaseParam,

  @path
  resourceGroupName: string,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: QueryOptionsC,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment,
  policyStatesSummarizeForResourceGroupLevelPolicyAssignment
);

// PolicyMetadata overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyMetadataList(
  ...Azure.ResourceManager.Foundations.DefaultBaseParameters<TenantActionScope>,
  ...TenantActionScope,
  ...ProviderNamespace<TenantActionScope>,
  body: void,
  queryOptions?: QueryOptionsG,
): PolicyMetadataCollection | PolicyInsightsApi.ErrorResponse;
@@override(PolicyMetadataNonResourceOperationGroup.list, policyMetadataList);

// ComponentPolicyStates overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op componentPolicyStatesListQueryResultsForSubscription(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  @bodyRoot body: void,

  @path
  @key
  @segment("subscription")
  name: string,

  ...ProviderNamespace<SubscriptionActionScope>,

  @path
  @segment("componentPolicyStates")
  componentPolicyStatesResource: ComponentPolicyStatesResource,

  queryOptions?: QueryOptionsD,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;
@@override(ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription,
  componentPolicyStatesListQueryResultsForSubscription
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op componentPolicyStatesListQueryResultsForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,

  @path
  @segment("componentPolicyStates")
  componentPolicyStatesResource: ComponentPolicyStatesResource,

  queryOptions?: QueryOptionsD,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;
@@override(ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup,
  componentPolicyStatesListQueryResultsForResourceGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op componentPolicyStatesListQueryResultsForResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  @path
  componentPolicyStatesResource: ComponentPolicyStatesResource,

  queryOptions?: QueryOptionsE,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;
@@override(ComponentPolicyStatesOperationGroup.listQueryResultsForResource,
  componentPolicyStatesListQueryResultsForResource
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op componentPolicyStatesListQueryResultsForPolicyDefinition(
  ...ComponentPolicyStatesListQueryResultsForPolicyDefinitionBaseParam,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @maxLength(64)
  @minLength(1)
  @pattern("^[^<>%&:\\\\?/#]*$")
  @path
  policyDefinitionName: string,

  @path
  componentPolicyStatesResource: ComponentPolicyStatesResource,

  queryOptions?: QueryOptionsD,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;
@@override(ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  componentPolicyStatesListQueryResultsForPolicyDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment(
  ...ComponentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignmentBaseParam,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @maxLength(64)
  @minLength(1)
  @pattern("^[^<>%&:\\\\?/#]*$")
  @path
  policyAssignmentName: string,

  @path
  componentPolicyStatesResource: ComponentPolicyStatesResource,

  queryOptions?: QueryOptionsD,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;
@@override(ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op componentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignment(
  ...ComponentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignmentBaseParam,

  @path
  resourceGroupName: string,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @maxLength(64)
  @minLength(1)
  @pattern("^[^<>%&:\\\\?/#]*$")
  @path
  policyAssignmentName: string,

  @path
  componentPolicyStatesResource: ComponentPolicyStatesResource,

  queryOptions?: QueryOptionsD,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;
@@override(ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  componentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignment
);

// Remediations overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListDeploymentsAtManagementGroup(
  ...ApiVersionParameter,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupId: string,

  @path
  remediationName: string,

  queryOptions?: QueryOptionsG,
): RemediationDeploymentsListResult | PolicyInsightsApi.ErrorResponse;
@@override(RemediationsOperationGroup.listDeploymentsAtManagementGroup,
  remediationsListDeploymentsAtManagementGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListForManagementGroup(
  ...ApiVersionParameter,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupId: string,

  queryOptions?: QueryOptionsH,
): ArmResponse<RemediationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(Remediations.listForManagementGroup,
  remediationsListForManagementGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListDeploymentsAtSubscription(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.PolicyInsights",

  @path
  @segment("remediations")
  @key
  remediationName: string,

  queryOptions?: QueryOptionsG,
  body: void,
): ArmResponse<RemediationDeploymentsListResult> | PolicyInsightsApi.ErrorResponse;
@@override(RemediationSubscriptionOperations.listDeploymentsAtSubscription,
  remediationsListDeploymentsAtSubscription
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListForSubscription(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.PolicyInsights",

  queryOptions?: QueryOptionsH,
): ArmResponse<RemediationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(RemediationSubscriptionOperations.listForSubscription,
  remediationsListForSubscription
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListDeploymentsAtResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  @path
  @segment("remediations")
  @key
  remediationName: string,

  queryOptions?: QueryOptionsG,
  body: void,
): ArmResponse<RemediationDeploymentsListResult> | PolicyInsightsApi.ErrorResponse;
@@override(RemediationResourceGroupOperations.listDeploymentsAtResourceGroup,
  remediationsListDeploymentsAtResourceGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  queryOptions?: QueryOptionsH,
): ArmResponse<RemediationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(RemediationResourceGroupOperations.listForResourceGroup,
  remediationsListForResourceGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListDeploymentsAtResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  @path
  remediationName: string,

  queryOptions?: QueryOptionsG,
): ArmResponse<RemediationDeploymentsListResult> | PolicyInsightsApi.ErrorResponse;
@@override(RemediationResourceOperations.listDeploymentsAtResource,
  remediationsListDeploymentsAtResource
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListForResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  queryOptions?: QueryOptionsH,
): ArmResponse<RemediationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(RemediationResourceOperations.listForResource,
  remediationsListForResource
);

// Attestations overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op attestationsListForSubscription(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.PolicyInsights",

  queryOptions?: QueryOptionsH,
): ArmResponse<AttestationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(Attestations.listForSubscription, attestationsListForSubscription);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op attestationsListForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  queryOptions?: QueryOptionsH,
): ArmResponse<AttestationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(AttestationResourceGroupOperations.listForResourceGroup,
  attestationsListForResourceGroup
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op attestationsListForResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  queryOptions?: QueryOptionsH,
): ArmResponse<AttestationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(AttestationOperationGroup.listForResource,
  attestationsListForResource
);

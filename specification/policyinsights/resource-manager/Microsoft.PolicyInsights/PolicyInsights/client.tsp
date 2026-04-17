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
@@clientLocation(PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition
);
@@clientLocation(PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition
);
@@clientLocation(PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition
);
@@clientLocation(PolicyStatesOperationGroup.summarizeForPolicySetDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForPolicySetDefinition
);
@@clientLocation(PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition
);
@@clientLocation(PolicyStatesOperationGroup.summarizeForPolicyDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForPolicyDefinition
);
@@clientLocation(PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment
);
@@clientLocation(PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment
);
@@clientLocation(ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition
);
@@clientLocation(ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
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

// QueryOptions for operations

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyTrackedResourcesListQueryResultsForManagementGroupQueryOptions {
  ...QueryOptionsH;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyTrackedResourcesListQueryResultsForSubscriptionQueryOptions {
  ...QueryOptionsH;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyTrackedResourcesListQueryResultsForResourceGroupQueryOptions {
  ...QueryOptionsH;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyTrackedResourcesListQueryResultsForResourceQueryOptions {
  ...QueryOptionsH;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyEventsListQueryResultsForManagementGroupQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyEventsListQueryResultsForSubscriptionQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyEventsListQueryResultsForResourceGroupQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyEventsListQueryResultsForResourceQueryOptions {
  ...QueryOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyEventsListQueryResultsForPolicySetDefinitionQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyEventsListQueryResultsForPolicyDefinitionQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyEventsListQueryResultsForSubscriptionLevelPolicyAssignmentQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyEventsListQueryResultsForResourceGroupLevelPolicyAssignmentQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesListQueryResultsForManagementGroupQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesSummarizeForManagementGroupQueryOptions {
  ...QueryOptionsC;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesListQueryResultsForSubscriptionQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesSummarizeForSubscriptionQueryOptions {
  ...QueryOptionsC;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesListQueryResultsForResourceGroupQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesSummarizeForResourceGroupQueryOptions {
  ...QueryOptionsC;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesListQueryResultsForResourceQueryOptions {
  ...QueryOptions;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesSummarizeForResourceQueryOptions {
  ...QueryOptionsC;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesListQueryResultsForPolicySetDefinitionQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesSummarizeForPolicySetDefinitionQueryOptions {
  ...QueryOptionsC;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesListQueryResultsForPolicyDefinitionQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesSummarizeForPolicyDefinitionQueryOptions {
  ...QueryOptionsC;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignmentQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesSummarizeForSubscriptionLevelPolicyAssignmentQueryOptions {
  ...QueryOptionsC;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignmentQueryOptions {
  ...QueryOptionsB;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyStatesSummarizeForResourceGroupLevelPolicyAssignmentQueryOptions {
  ...QueryOptionsC;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PolicyMetadataListQueryOptions {
  ...QueryOptionsG;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ComponentPolicyStatesListQueryResultsForSubscriptionQueryOptions {
  ...QueryOptionsD;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ComponentPolicyStatesListQueryResultsForResourceGroupQueryOptions {
  ...QueryOptionsD;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ComponentPolicyStatesListQueryResultsForResourceQueryOptions {
  ...QueryOptionsE;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ComponentPolicyStatesListQueryResultsForPolicyDefinitionQueryOptions {
  ...QueryOptionsD;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ComponentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignmentQueryOptions {
  ...QueryOptionsD;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model ComponentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignmentQueryOptions {
  ...QueryOptionsD;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RemediationsListDeploymentsAtManagementGroupQueryOptions {
  ...QueryOptionsG;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RemediationsListForManagementGroupQueryOptions {
  ...QueryOptionsH;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RemediationsListDeploymentsAtSubscriptionQueryOptions {
  ...QueryOptionsG;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RemediationsListForSubscriptionQueryOptions {
  ...QueryOptionsH;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RemediationsListDeploymentsAtResourceGroupQueryOptions {
  ...QueryOptionsG;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RemediationsListForResourceGroupQueryOptions {
  ...QueryOptionsH;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RemediationsListDeploymentsAtResourceQueryOptions {
  ...QueryOptionsG;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RemediationsListForResourceQueryOptions {
  ...QueryOptionsH;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AttestationsListForSubscriptionQueryOptions {
  ...QueryOptionsH;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AttestationsListForResourceGroupQueryOptions {
  ...QueryOptionsH;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AttestationsListForResourceQueryOptions {
  ...QueryOptionsH;
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

  queryOptions?: PolicyTrackedResourcesListQueryResultsForManagementGroupQueryOptions,
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

  queryOptions?: PolicyTrackedResourcesListQueryResultsForSubscriptionQueryOptions,
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

  queryOptions?: PolicyTrackedResourcesListQueryResultsForResourceGroupQueryOptions,
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

  queryOptions?: PolicyTrackedResourcesListQueryResultsForResourceQueryOptions,
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

  queryOptions?: PolicyEventsListQueryResultsForManagementGroupQueryOptions,
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

  queryOptions?: PolicyEventsListQueryResultsForSubscriptionQueryOptions,
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

  queryOptions?: PolicyEventsListQueryResultsForResourceGroupQueryOptions,
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

  queryOptions?: PolicyEventsListQueryResultsForResourceQueryOptions,
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

  queryOptions?: PolicyEventsListQueryResultsForPolicySetDefinitionQueryOptions,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition,
  policyEventsListQueryResultsForPolicySetDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForPolicyDefinition(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: PolicyEventsListQueryResultsForPolicyDefinitionQueryOptions,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition,
  policyEventsListQueryResultsForPolicyDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyEventsListQueryResultsForSubscriptionLevelPolicyAssignmentQueryOptions,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForResourceGroupLevelPolicyAssignment(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  resourceGroupName: string,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyEventsListQueryResultsForResourceGroupLevelPolicyAssignmentQueryOptions,
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

  queryOptions?: PolicyStatesListQueryResultsForManagementGroupQueryOptions,
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

  queryOptions?: PolicyStatesSummarizeForManagementGroupQueryOptions,
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

  queryOptions?: PolicyStatesListQueryResultsForSubscriptionQueryOptions,
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

  queryOptions?: PolicyStatesSummarizeForSubscriptionQueryOptions,
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

  queryOptions?: PolicyStatesListQueryResultsForResourceGroupQueryOptions,
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

  queryOptions?: PolicyStatesSummarizeForResourceGroupQueryOptions,
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

  queryOptions?: PolicyStatesListQueryResultsForResourceQueryOptions,
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

  queryOptions?: PolicyStatesSummarizeForResourceQueryOptions,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForResource,
  policyStatesSummarizeForResource
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForPolicySetDefinition(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: PolicyStatesListQueryResultsForPolicySetDefinitionQueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition,
  policyStatesListQueryResultsForPolicySetDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForPolicySetDefinition(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: PolicyStatesSummarizeForPolicySetDefinitionQueryOptions,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForPolicySetDefinition,
  policyStatesSummarizeForPolicySetDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForPolicyDefinition(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: PolicyStatesListQueryResultsForPolicyDefinitionQueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  policyStatesListQueryResultsForPolicyDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForPolicyDefinition(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: PolicyStatesSummarizeForPolicyDefinitionQueryOptions,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForPolicyDefinition,
  policyStatesSummarizeForPolicyDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignmentQueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForSubscriptionLevelPolicyAssignment(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyStatesSummarizeForSubscriptionLevelPolicyAssignmentQueryOptions,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment,
  policyStatesSummarizeForSubscriptionLevelPolicyAssignment
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  resourceGroupName: string,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignmentQueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForResourceGroupLevelPolicyAssignment(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  resourceGroupName: string,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyStatesSummarizeForResourceGroupLevelPolicyAssignmentQueryOptions,
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
  queryOptions?: PolicyMetadataListQueryOptions,
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

  queryOptions?: ComponentPolicyStatesListQueryResultsForSubscriptionQueryOptions,
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

  queryOptions?: ComponentPolicyStatesListQueryResultsForResourceGroupQueryOptions,
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

  queryOptions?: ComponentPolicyStatesListQueryResultsForResourceQueryOptions,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;
@@override(ComponentPolicyStatesOperationGroup.listQueryResultsForResource,
  componentPolicyStatesListQueryResultsForResource
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op componentPolicyStatesListQueryResultsForPolicyDefinition(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @maxLength(64)
  @minLength(1)
  @pattern("^[^<>%&:\\\\?/#]*$")
  @path
  policyDefinitionName: string,

  @path
  componentPolicyStatesResource: ComponentPolicyStatesResource,

  queryOptions?: ComponentPolicyStatesListQueryResultsForPolicyDefinitionQueryOptions,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;
@@override(ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  componentPolicyStatesListQueryResultsForPolicyDefinition
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @maxLength(64)
  @minLength(1)
  @pattern("^[^<>%&:\\\\?/#]*$")
  @path
  policyAssignmentName: string,

  @path
  componentPolicyStatesResource: ComponentPolicyStatesResource,

  queryOptions?: ComponentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignmentQueryOptions,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;
@@override(ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op componentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignment(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

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

  queryOptions?: ComponentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignmentQueryOptions,
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

  queryOptions?: RemediationsListDeploymentsAtManagementGroupQueryOptions,
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

  queryOptions?: RemediationsListForManagementGroupQueryOptions,
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

  queryOptions?: RemediationsListDeploymentsAtSubscriptionQueryOptions,
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

  queryOptions?: RemediationsListForSubscriptionQueryOptions,
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

  queryOptions?: RemediationsListDeploymentsAtResourceGroupQueryOptions,
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
  queryOptions?: RemediationsListForResourceGroupQueryOptions,
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

  queryOptions?: RemediationsListDeploymentsAtResourceQueryOptions,
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

  queryOptions?: RemediationsListForResourceQueryOptions,
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

  queryOptions?: AttestationsListForSubscriptionQueryOptions,
): ArmResponse<AttestationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(Attestations.listForSubscription, attestationsListForSubscription);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op attestationsListForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  queryOptions?: AttestationsListForResourceGroupQueryOptions,
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

  queryOptions?: AttestationsListForResourceQueryOptions,
): ArmResponse<AttestationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(AttestationOperationGroup.listForResource,
  attestationsListForResource
);

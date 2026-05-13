import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "./PolicyInsightsApi/main.tsp";
import "./PolicyTrackedResourcesApi/main.tsp";

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
@@clientLocation(policyEventsListQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  policyEventsListQueryResultsForPolicySetDefinition
);
@@clientLocation(policyEventsListQueryResultsForPolicyDefinition::parameters.subscriptionId,
  policyEventsListQueryResultsForPolicyDefinition
);
@@clientLocation(policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(policyEventsListQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  policyEventsListQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(policyStatesListQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  policyStatesListQueryResultsForPolicySetDefinition
);
@@clientLocation(policyStatesSummarizeForPolicySetDefinition::parameters.subscriptionId,
  policyStatesSummarizeForPolicySetDefinition
);
@@clientLocation(policyStatesListQueryResultsForPolicyDefinition::parameters.subscriptionId,
  policyStatesListQueryResultsForPolicyDefinition
);
@@clientLocation(policyStatesSummarizeForPolicyDefinition::parameters.subscriptionId,
  policyStatesSummarizeForPolicyDefinition
);
@@clientLocation(policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(policyStatesSummarizeForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  policyStatesSummarizeForSubscriptionLevelPolicyAssignment
);
@@clientLocation(policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(policyStatesSummarizeForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  policyStatesSummarizeForResourceGroupLevelPolicyAssignment
);
@@clientLocation(componentPolicyStatesListQueryResultsForPolicyDefinition::parameters.subscriptionId,
  componentPolicyStatesListQueryResultsForPolicyDefinition
);
@@clientLocation(componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(componentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  componentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(componentPolicyStatesListQueryResultsForResourceGroup::parameters.subscriptionId,
  componentPolicyStatesListQueryResultsForResourceGroup
);
@@clientLocation(componentPolicyStatesListQueryResultsForSubscription::parameters.subscriptionId,
  componentPolicyStatesListQueryResultsForSubscription
);
@@clientLocation(PolicyStatesOperationGroup.triggerResourceGroupEvaluation::parameters.subscriptionId,
  PolicyStatesOperationGroup.triggerResourceGroupEvaluation
);
@@clientLocation(PolicyStatesOperationGroup.triggerSubscriptionEvaluation::parameters.subscriptionId,
  PolicyStatesOperationGroup.triggerSubscriptionEvaluation
);
@@clientLocation(policyEventsListQueryResultsForResourceGroup::parameters.subscriptionId,
  policyEventsListQueryResultsForResourceGroup
);
@@clientLocation(policyEventsListQueryResultsForSubscription::parameters.subscriptionId,
  policyEventsListQueryResultsForSubscription
);
@@clientLocation(policyStatesListQueryResultsForResourceGroup::parameters.subscriptionId,
  policyStatesListQueryResultsForResourceGroup
);
@@clientLocation(policyStatesListQueryResultsForSubscription::parameters.subscriptionId,
  policyStatesListQueryResultsForSubscription
);
@@clientLocation(policyStatesSummarizeForResourceGroup::parameters.subscriptionId,
  policyStatesSummarizeForResourceGroup
);
@@clientLocation(policyStatesSummarizeForSubscription::parameters.subscriptionId,
  policyStatesSummarizeForSubscription
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
  policyTrackedResourcesListQueryResultsForManagementGroup,
  "!java,!python"
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
  policyTrackedResourcesListQueryResultsForSubscription,
  "!java,!python"
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
  policyTrackedResourcesListQueryResultsForResourceGroup,
  "!java,!python"
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
  policyTrackedResourcesListQueryResultsForResource,
  "!java,!python"
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
  policyEventsListQueryResultsForManagementGroup,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForSubscription(
  ...ApiVersionParameter,

  @path
  @segment("policyEvents")
  policyEventsResource: PolicyEventsResourceType,

  ...SubscriptionIdParameter,
  @bodyRoot body: void,

  @path
  @key
  @segment("subscription")
  name: string,

  ...ProviderNamespace<SubscriptionActionScope>,
  queryOptions?: PolicyEventsListQueryResultsForSubscriptionQueryOptions,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForSubscription,
  policyEventsListQueryResultsForSubscription,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForResourceGroup(
  ...ApiVersionParameter,

  @path
  @segment("policyEvents")
  policyEventsResource: PolicyEventsResourceType,

  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,
  queryOptions?: PolicyEventsListQueryResultsForResourceGroupQueryOptions,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForResourceGroup,
  policyEventsListQueryResultsForResourceGroup,
  "!java,!python"
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
  policyEventsListQueryResultsForResource,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForPolicySetDefinition(
  ...ApiVersionParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: PolicyEventsListQueryResultsForPolicySetDefinitionQueryOptions,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition,
  policyEventsListQueryResultsForPolicySetDefinition,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForPolicyDefinition(
  ...ApiVersionParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: PolicyEventsListQueryResultsForPolicyDefinitionQueryOptions,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition,
  policyEventsListQueryResultsForPolicyDefinition,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment(
  ...ApiVersionParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyEventsListQueryResultsForSubscriptionLevelPolicyAssignmentQueryOptions,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyEventsListQueryResultsForResourceGroupLevelPolicyAssignment(
  ...ApiVersionParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  ...SubscriptionIdParameter,

  @path
  resourceGroupName: string,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyEventsListQueryResultsForResourceGroupLevelPolicyAssignmentQueryOptions,
): PolicyEventsQueryResults | QueryFailure;
@@override(PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  policyEventsListQueryResultsForResourceGroupLevelPolicyAssignment,
  "!java,!python"
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
  policyStatesListQueryResultsForManagementGroup,
  "!java,!python"
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
  policyStatesSummarizeForManagementGroup,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForSubscription(
  ...ApiVersionParameter,

  @path
  @segment("policyStates")
  policyStatesResource: PolicyStatesResource,

  ...SubscriptionIdParameter,
  @bodyRoot body: void,

  @path
  @key
  @segment("subscription")
  name: string,

  ...ProviderNamespace<SubscriptionActionScope>,
  queryOptions?: PolicyStatesListQueryResultsForSubscriptionQueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForSubscription,
  policyStatesListQueryResultsForSubscription,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForSubscription(
  ...ApiVersionParameter,

  @path
  @segment("policyStates")
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  ...SubscriptionIdParameter,
  @bodyRoot body: void,

  @path
  @key
  @segment("subscription")
  name: string,

  ...ProviderNamespace<SubscriptionActionScope>,
  queryOptions?: PolicyStatesSummarizeForSubscriptionQueryOptions,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForSubscription,
  policyStatesSummarizeForSubscription,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForResourceGroup(
  ...ApiVersionParameter,

  @path
  @segment("policyStates")
  policyStatesResource: PolicyStatesResource,

  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,
  queryOptions?: PolicyStatesListQueryResultsForResourceGroupQueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForResourceGroup,
  policyStatesListQueryResultsForResourceGroup,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForResourceGroup(
  ...ApiVersionParameter,

  @path
  @segment("policyStates")
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,
  queryOptions?: PolicyStatesSummarizeForResourceGroupQueryOptions,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForResourceGroup,
  policyStatesSummarizeForResourceGroup,
  "!java,!python"
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
  policyStatesListQueryResultsForResource,
  "!java,!python"
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
  policyStatesSummarizeForResource,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForPolicySetDefinition(
  ...ApiVersionParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: PolicyStatesListQueryResultsForPolicySetDefinitionQueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition,
  policyStatesListQueryResultsForPolicySetDefinition,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForPolicySetDefinition(
  ...ApiVersionParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: PolicyStatesSummarizeForPolicySetDefinitionQueryOptions,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForPolicySetDefinition,
  policyStatesSummarizeForPolicySetDefinition,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForPolicyDefinition(
  ...ApiVersionParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: PolicyStatesListQueryResultsForPolicyDefinitionQueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  policyStatesListQueryResultsForPolicyDefinition,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForPolicyDefinition(
  ...ApiVersionParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: PolicyStatesSummarizeForPolicyDefinitionQueryOptions,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForPolicyDefinition,
  policyStatesSummarizeForPolicyDefinition,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment(
  ...ApiVersionParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignmentQueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForSubscriptionLevelPolicyAssignment(
  ...ApiVersionParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  ...SubscriptionIdParameter,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyStatesSummarizeForSubscriptionLevelPolicyAssignmentQueryOptions,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment,
  policyStatesSummarizeForSubscriptionLevelPolicyAssignment,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment(
  ...ApiVersionParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  ...SubscriptionIdParameter,

  @path
  resourceGroupName: string,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignmentQueryOptions,
): PolicyStatesQueryResults | QueryFailure;
@@override(PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op policyStatesSummarizeForResourceGroupLevelPolicyAssignment(
  ...ApiVersionParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  ...SubscriptionIdParameter,

  @path
  resourceGroupName: string,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: PolicyStatesSummarizeForResourceGroupLevelPolicyAssignmentQueryOptions,
): SummarizeResults | QueryFailure;
@@override(PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment,
  policyStatesSummarizeForResourceGroupLevelPolicyAssignment,
  "!java,!python"
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
@@override(PolicyMetadataNonResourceOperationGroup.list,
  policyMetadataList,
  "!java,!python"
);

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
  componentPolicyStatesListQueryResultsForSubscription,
  "!java,!python,!javascript"
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
  componentPolicyStatesListQueryResultsForResourceGroup,
  "!java,!python,!javascript"
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
  componentPolicyStatesListQueryResultsForResource,
  "!java,!python,!javascript"
);
@@clientName(ComponentPolicyStatesOperationGroup.listQueryResultsForResource::parameters.From,
  "$DO_NOT_NORMALIZE$from",
  "javascript"
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
  componentPolicyStatesListQueryResultsForPolicyDefinition,
  "!java,!python,!javascript"
);
@@clientName(ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition::parameters.From,
  "$DO_NOT_NORMALIZE$from",
  "javascript"
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
  componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment,
  "!java,!python,!javascript"
);
@@clientName(ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.From,
  "$DO_NOT_NORMALIZE$from",
  "javascript"
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
  componentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignment,
  "!java,!python,!javascript"
);
@@clientName(ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.From,
  "$DO_NOT_NORMALIZE$from",
  "javascript"
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
  remediationsListDeploymentsAtManagementGroup,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListForManagementGroup(
  ...ApiVersionParameter,
  managementGroupsNamespace: ManagementGroupsNamespaceType,

  @path
  managementGroupId: string,

  ...Azure.ResourceManager.Legacy.Provider,
  queryOptions?: RemediationsListForManagementGroupQueryOptions,
): ArmResponse<RemediationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(Remediations.listForManagementGroup,
  remediationsListForManagementGroup,
  "!java,!python"
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
  remediationsListDeploymentsAtSubscription,
  "!java,!python"
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
  remediationsListForSubscription,
  "!java,!python"
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
  remediationsListDeploymentsAtResourceGroup,
  "!java,!python"
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
  remediationsListForResourceGroup,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListDeploymentsAtResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  ...Azure.ResourceManager.Legacy.Provider,

  @path
  remediationName: string,

  queryOptions?: RemediationsListDeploymentsAtResourceQueryOptions,
  body: void,
): ArmResponse<RemediationDeploymentsListResult> | PolicyInsightsApi.ErrorResponse;
@@override(RemediationResourceOperations.listDeploymentsAtResource,
  remediationsListDeploymentsAtResource,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op remediationsListForResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  ...Azure.ResourceManager.Legacy.Provider,
  queryOptions?: RemediationsListForResourceQueryOptions,
): ArmResponse<RemediationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(RemediationResourceOperations.listForResource,
  remediationsListForResource,
  "!java,!python"
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
@@override(Attestations.listForSubscription,
  attestationsListForSubscription,
  "!java,!python"
);

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
  attestationsListForResourceGroup,
  "!java,!python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
op attestationsListForResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  ...Azure.ResourceManager.Legacy.Provider,
  queryOptions?: AttestationsListForResourceQueryOptions,
): ArmResponse<AttestationListResult> | PolicyInsightsApi.ErrorResponse;
@@override(AttestationOperationGroup.listForResource,
  attestationsListForResource,
  "!java,!python"
);

// PolicyEventsOperationGroup
@@clientLocation(PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition,
  "python,java"
);
@@clientLocation(PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition,
  "python,java"
);
@@clientLocation(PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(PolicyEventsOperationGroup.listQueryResultsForSubscription::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForSubscription,
  "python,java"
);
@@clientLocation(PolicyEventsOperationGroup.listQueryResultsForResourceGroup::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForResourceGroup,
  "python,java"
);

// PolicyStatesOperationGroup
@@clientLocation(PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.summarizeForPolicySetDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForPolicySetDefinition,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.summarizeForPolicyDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForPolicyDefinition,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.listQueryResultsForSubscription::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForSubscription,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.summarizeForSubscription::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForSubscription,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.listQueryResultsForResourceGroup::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForResourceGroup,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.summarizeForResourceGroup::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForResourceGroup,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.triggerSubscriptionEvaluation::parameters.subscriptionId,
  PolicyStatesOperationGroup.triggerSubscriptionEvaluation,
  "python,java"
);
@@clientLocation(PolicyStatesOperationGroup.triggerResourceGroupEvaluation::parameters.subscriptionId,
  PolicyStatesOperationGroup.triggerResourceGroupEvaluation,
  "python,java"
);

// ComponentPolicyStatesOperationGroup
@@clientLocation(ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  "python,java"
);
@@clientLocation(ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription,
  "python,java"
);
@@clientLocation(ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup,
  "python,java"
);
@@clientName(QueryOptions.Top, "top", "javascript");
@@clientName(QueryOptions.SkipToken, "skipToken", "javascript");
@@clientName(QueryOptions.Filter, "filter", "javascript");
@@clientName(QueryOptions.From, "from", "javascript");
@@clientName(QueryOptions.To, "to", "javascript");
@@clientName(QueryOptions.Select, "select", "javascript");
@@clientName(QueryOptions.OrderBy, "orderBy", "javascript");
@@clientName(QueryOptions.Expand, "expand", "javascript");
@@clientName(QueryOptions.Apply, "apply", "javascript");
@@clientName(QueryOptionsB.Apply, "apply", "javascript");
@@clientName(QueryOptionsB.Filter, "filter", "javascript");
@@clientName(QueryOptionsB.Top, "top", "javascript");
@@clientName(QueryOptionsB.OrderBy, "orderBy", "javascript");
@@clientName(QueryOptionsB.Select, "select", "javascript");
@@clientName(QueryOptionsB.From, "from", "javascript");
@@clientName(QueryOptionsB.To, "to", "javascript");
@@clientName(QueryOptionsB.SkipToken, "skipToken", "javascript");
@@clientName(QueryOptionsC.Top, "top", "javascript");
@@clientName(QueryOptionsC.From, "from", "javascript");
@@clientName(QueryOptionsC.To, "to", "javascript");
@@clientName(QueryOptionsC.Filter, "filter", "javascript");
@@clientName(QueryOptionsD.Top, "top", "javascript");
@@clientName(QueryOptionsD.OrderBy, "orderBy", "javascript");
@@clientName(QueryOptionsD.Select, "select", "javascript");
@@clientName(QueryOptionsD.From, "from", "javascript");
@@clientName(QueryOptionsD.To, "to", "javascript");
@@clientName(QueryOptionsD.Filter, "filter", "javascript");
@@clientName(QueryOptionsD.Apply, "apply", "javascript");
@@clientName(QueryOptionsE.Top, "top", "javascript");
@@clientName(QueryOptionsE.OrderBy, "orderBy", "javascript");
@@clientName(QueryOptionsE.Select, "select", "javascript");
@@clientName(QueryOptionsE.From, "from", "javascript");
@@clientName(QueryOptionsE.To, "to", "javascript");
@@clientName(QueryOptionsE.Filter, "filter", "javascript");
@@clientName(QueryOptionsE.Apply, "apply", "javascript");
@@clientName(QueryOptionsE.Expand, "expand", "javascript");
@@clientName(QueryOptionsF.SkipToken, "skipToken", "javascript");
@@clientName(QueryOptionsG.Top, "top", "javascript");
@@clientName(QueryOptionsH.Top, "top", "javascript");
@@clientName(QueryOptionsH.Filter, "filter", "javascript");
@@clientName(listQueryResultsParameters.From,
  "$DO_NOT_NORMALIZE$from",
  "javascript"
);
@@alternateType(ManagementGroupsNamespaceType, "Microsoft.Management");

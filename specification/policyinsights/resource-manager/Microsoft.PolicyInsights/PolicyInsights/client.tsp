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

@@clientName(
  PolicyInsightsManagementClient,
  "PolicyInsightsClient",
  "javascript,python,java"
);

// Section: Explicit subscriptionId parameter
@@clientLocation(
  policyEventsListQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  policyEventsListQueryResultsForPolicySetDefinition
);
@@clientLocation(
  policyEventsListQueryResultsForPolicyDefinition::parameters.subscriptionId,
  policyEventsListQueryResultsForPolicyDefinition
);
@@clientLocation(
  policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(
  policyEventsListQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  policyEventsListQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(
  policyStatesListQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  policyStatesListQueryResultsForPolicySetDefinition
);
@@clientLocation(
  policyStatesSummarizeForPolicySetDefinition::parameters.subscriptionId,
  policyStatesSummarizeForPolicySetDefinition
);
@@clientLocation(
  policyStatesListQueryResultsForPolicyDefinition::parameters.subscriptionId,
  policyStatesListQueryResultsForPolicyDefinition
);
@@clientLocation(
  policyStatesSummarizeForPolicyDefinition::parameters.subscriptionId,
  policyStatesSummarizeForPolicyDefinition
);
@@clientLocation(
  policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(
  policyStatesSummarizeForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  policyStatesSummarizeForSubscriptionLevelPolicyAssignment
);
@@clientLocation(
  policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(
  policyStatesSummarizeForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  policyStatesSummarizeForResourceGroupLevelPolicyAssignment
);
@@clientLocation(
  componentPolicyStatesListQueryResultsForPolicyDefinition::parameters.subscriptionId,
  componentPolicyStatesListQueryResultsForPolicyDefinition
);
@@clientLocation(
  componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment
);
@@clientLocation(
  componentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  componentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(
  componentPolicyStatesListQueryResultsForResourceGroup::parameters.subscriptionId,
  componentPolicyStatesListQueryResultsForResourceGroup
);
@@clientLocation(
  componentPolicyStatesListQueryResultsForSubscription::parameters.subscriptionId,
  componentPolicyStatesListQueryResultsForSubscription
);
@@clientLocation(
  PolicyStatesOperationGroup.triggerResourceGroupEvaluation::parameters.subscriptionId,
  PolicyStatesOperationGroup.triggerResourceGroupEvaluation
);
@@clientLocation(
  PolicyStatesOperationGroup.triggerSubscriptionEvaluation::parameters.subscriptionId,
  PolicyStatesOperationGroup.triggerSubscriptionEvaluation
);
@@clientLocation(
  policyEventsListQueryResultsForResourceGroup::parameters.subscriptionId,
  policyEventsListQueryResultsForResourceGroup
);
@@clientLocation(
  policyEventsListQueryResultsForSubscription::parameters.subscriptionId,
  policyEventsListQueryResultsForSubscription
);
@@clientLocation(
  policyStatesListQueryResultsForResourceGroup::parameters.subscriptionId,
  policyStatesListQueryResultsForResourceGroup
);
@@clientLocation(
  policyStatesListQueryResultsForSubscription::parameters.subscriptionId,
  policyStatesListQueryResultsForSubscription
);
@@clientLocation(
  policyStatesSummarizeForResourceGroup::parameters.subscriptionId,
  policyStatesSummarizeForResourceGroup
);
@@clientLocation(
  policyStatesSummarizeForSubscription::parameters.subscriptionId,
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
@@override(
  PolicyTrackedResourcesOperationGroup.listQueryResultsForManagementGroup,
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
@@override(
  PolicyTrackedResourcesOperationGroup.listQueryResultsForSubscription,
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
@@override(
  PolicyTrackedResourcesOperationGroup.listQueryResultsForResourceGroup,
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
@@override(
  PolicyTrackedResourcesOperationGroup.listQueryResultsForResource,
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
@@override(
  PolicyEventsOperationGroup.listQueryResultsForManagementGroup,
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
@@override(
  PolicyEventsOperationGroup.listQueryResultsForSubscription,
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
@@override(
  PolicyEventsOperationGroup.listQueryResultsForResourceGroup,
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
@@override(
  PolicyEventsOperationGroup.listQueryResultsForResource,
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
@@override(
  PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition,
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
@@override(
  PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition,
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
@@override(
  PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
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
@@override(
  PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
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
@@override(
  PolicyStatesOperationGroup.listQueryResultsForManagementGroup,
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
@@override(
  PolicyStatesOperationGroup.summarizeForManagementGroup,
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
@@override(
  PolicyStatesOperationGroup.listQueryResultsForSubscription,
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
@@override(
  PolicyStatesOperationGroup.summarizeForSubscription,
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
@@override(
  PolicyStatesOperationGroup.listQueryResultsForResourceGroup,
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
@@override(
  PolicyStatesOperationGroup.summarizeForResourceGroup,
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
@@override(
  PolicyStatesOperationGroup.listQueryResultsForResource,
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
@@override(
  PolicyStatesOperationGroup.summarizeForResource,
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
@@override(
  PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition,
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
@@override(
  PolicyStatesOperationGroup.summarizeForPolicySetDefinition,
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
@@override(
  PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
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
@@override(
  PolicyStatesOperationGroup.summarizeForPolicyDefinition,
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
@@override(
  PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
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
@@override(
  PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment,
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
@@override(
  PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
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
@@override(
  PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment,
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
@@override(
  PolicyMetadataNonResourceOperationGroup.list,
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
@@override(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription,
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
@@override(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup,
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
@@override(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResource,
  componentPolicyStatesListQueryResultsForResource,
  "!java,!python,!javascript"
);
@@clientName(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResource::parameters.From,
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
@@override(
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  componentPolicyStatesListQueryResultsForPolicyDefinition,
  "!java,!python,!javascript"
);
@@clientName(
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition::parameters.From,
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
@@override(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment,
  "!java,!python,!javascript"
);
@@clientName(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.From,
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
@@override(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  componentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignment,
  "!java,!python,!javascript"
);
@@clientName(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.From,
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
@@override(
  RemediationsOperationGroup.listDeploymentsAtManagementGroup,
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
@@override(
  Remediations.listForManagementGroup,
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
):
  | ArmResponse<RemediationDeploymentsListResult>
  | PolicyInsightsApi.ErrorResponse;
@@override(
  Remediations.listDeploymentsAtSubscription,
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
@@override(
  Remediations.listForSubscription,
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
):
  | ArmResponse<RemediationDeploymentsListResult>
  | PolicyInsightsApi.ErrorResponse;
@@override(
  Remediations.listDeploymentsAtResourceGroup,
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
@@override(
  Remediations.listForResourceGroup,
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
):
  | ArmResponse<RemediationDeploymentsListResult>
  | PolicyInsightsApi.ErrorResponse;
@@override(
  Remediations.listDeploymentsAtResource,
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
@@override(
  Remediations.listForResource,
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
@@override(
  Attestations.listForSubscription,
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
@@override(
  Attestations.listForResourceGroup,
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
@@override(
  Attestations.listForResource,
  attestationsListForResource,
  "!java,!python"
);

// PolicyEventsOperationGroup
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition,
  "python,java"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition,
  "python,java"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForSubscription::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForSubscription,
  "python,java"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForResourceGroup::parameters.subscriptionId,
  PolicyEventsOperationGroup.listQueryResultsForResourceGroup,
  "python,java"
);

// PolicyStatesOperationGroup
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForPolicySetDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForPolicySetDefinition,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForPolicyDefinition::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForPolicyDefinition,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForSubscription::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForSubscription,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForSubscription::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForSubscription,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForResourceGroup::parameters.subscriptionId,
  PolicyStatesOperationGroup.listQueryResultsForResourceGroup,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForResourceGroup::parameters.subscriptionId,
  PolicyStatesOperationGroup.summarizeForResourceGroup,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.triggerSubscriptionEvaluation::parameters.subscriptionId,
  PolicyStatesOperationGroup.triggerSubscriptionEvaluation,
  "python,java"
);
@@clientLocation(
  PolicyStatesOperationGroup.triggerResourceGroupEvaluation::parameters.subscriptionId,
  PolicyStatesOperationGroup.triggerResourceGroupEvaluation,
  "python,java"
);

// ComponentPolicyStatesOperationGroup
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  "python,java"
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "python,java"
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription,
  "python,java"
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup::parameters.subscriptionId,
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
@@clientName(
  listQueryResultsParameters.From,
  "$DO_NOT_NORMALIZE$from",
  "javascript"
);
@@alternateType(ManagementGroupsNamespaceType, "Microsoft.Management");

// ============================================================================
// C# customizations
//
// Rationale:
// 1) Back-compat renames preserve the GA C# SDK surface (Summary/SummaryResults
//    were renamed to PolicySummary/PolicySummaryResults via the prior autorest
//    config). Also works around a current C# mgmt generator inconsistency where
//    ArmPolicyInsightsModelFactory references `Models.PolicySummaryResults`
//    while only `Models.SummaryResults` is emitted.
// 2) CheckRestrictionEvaluationDetails is referenced as a parameter on the
//    public Arm*ModelFactory.PolicyEvaluationResult overload, but generated as
//    internal. Make it public for C#.
// 3) The spec defines per-scope LegacyOperations aliases (management group,
//    subscription, resource group, and generic AtResource) for both Attestation
//    and Remediation, all sharing the same ResourceName. The current C# mgmt
//    generator emits one ArmClient extension set per alias, producing
//    duplicate method signatures (CS0111) and per-scope helper extensions that
//    did not exist on the GA C# SDK. Suppressing every alias except the
//    generic AtResource one for C# only restores the GA surface (ArmClient
//    extensions only) without changing the swagger emitted for other
//    languages. The remaining AtResource alias uses `{resourceId}` which
//    accepts any subscription/resource-group/management-group scope at runtime.
// ============================================================================

@@clientName(Summary, "PolicySummary", "csharp");
@@clientName(SummaryResults, "PolicySummaryResults", "csharp");
@@clientName(
  CheckRestrictionsRequest,
  "CheckPolicyRestrictionsContent",
  "csharp"
);
@@clientName(
  CheckManagementGroupRestrictionsRequest,
  "CheckManagementGroupPolicyRestrictionsContent",
  "csharp"
);
@@clientName(
  CheckRestrictionsResult,
  "CheckPolicyRestrictionsResult",
  "csharp"
);
@@clientName(
  CheckRestrictionsResult.contentEvaluationResult,
  "PolicyEvaluations",
  "csharp"
);
@@clientName(
  PolicyEvaluationResult.evaluationDetails,
  "CheckRestrictionEvaluationDetails",
  "csharp"
);
// Back-compat class renames (previously done via the autorest rename-mapping).
@@clientName(Attestation, "PolicyAttestation", "csharp");
@@clientName(Remediation, "PolicyRemediation", "csharp");
@@clientName(ComplianceState, "PolicyComplianceState", "csharp");
@@clientName(PolicyEventsResourceType, "PolicyEventType", "csharp");
@@clientName(PolicyStatesResource, "PolicyStateType", "csharp");
@@clientName(
  PolicyStatesSummaryResourceType,
  "PolicyStateSummaryType",
  "csharp"
);
@@clientName(PolicyTrackedResource, "PolicyTrackedResourceRecord", "csharp");
@@clientName(
  PolicyTrackedResourcesResourceType,
  "PolicyTrackedResourceType",
  "csharp"
);
// Back-compat property renames.
@@clientName(AttestationProperties.expiresOn, "expireOn", "csharp");
@@clientName(AttestationProperties.assessmentDate, "assessOn", "csharp");
@@clientName(RemediationProperties.filters, "filter", "csharp");
@@clientName(PolicyTrackedResource.lastUpdateUtc, "lastUpdateOn", "csharp");
@@clientName(PolicyEvent.resourceType, "resourceTypeString", "csharp");
@@clientName(PolicyState.resourceType, "resourceTypeString", "csharp");

// Back-compat property types: ARM ID strings should be typed as ResourceIdentifier.
@@alternateType(
  AttestationProperties.policyAssignmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RemediationProperties.policyAssignmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyAssignmentSummary.policyAssignmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyAssignmentSummary.policySetDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyDetails.policyDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyDetails.policyAssignmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyDetails.policySetDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyEvent.policyAssignmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyEvent.policyDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyEvent.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyEvent.policySetDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyReference.policyDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyReference.policySetDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyReference.policyAssignmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyState.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyState.policyAssignmentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyState.policyDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyState.policySetDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  IfNotExistsEvaluationDetails.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyDefinitionSummary.policyDefinitionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  PolicyTrackedResource.trackedResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RemediationDeployment.remediatedResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RemediationDeployment.deploymentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  TrackedResourceModificationDetails.deploymentId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Back-compat property types: location strings should be typed as AzureLocation.
@@alternateType(
  PolicyEvent.resourceLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  PolicyState.resourceLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  RemediationDeployment.resourceLocation,
  Azure.Core.azureLocation,
  "csharp"
);
// GA autorest's `format-by-name-rules: '*Uri': 'Uri'` retyped the slim
// metadata's additionalContentUrl to System.Uri; preserve that.
@@alternateType(
  PolicyMetadataSlimProperties.additionalContentUrl,
  url,
  "csharp"
);

@@access(CheckRestrictionEvaluationDetails, Access.public, "csharp");
// The generator emits a model PolicyMetadataCollection (paging envelope for
// SlimPolicyMetadata) that conflicts with the ArmCollection type of the same
// name. The GA C# SDK only exposed the ArmCollection publicly.
@@access(PolicyMetadataCollection, Access.internal, "csharp");
// GA C# SDK did not expose the Operations RP model publicly.
@@access(PolicyInsightsApi.Operation, Access.internal, "csharp");
@@access(OperationsListResults, Access.internal, "csharp");
@@scope(PolicyInsightsApi.Operations.list, "!csharp");
// NOTE: ComponentPolicyStatesQueryResults and SummarizeResults are paging
// envelopes that GA hid by returning Pageable<T> (autorest's automatic
// pageable detection via x-ms-pageable). The new spec ops are non-pageable
// (no @pageItems / @nextLink on response models), so the C# emitter exposes
// the envelopes directly. @@Legacy.markAsPageable is ineffective without
// those markers. Accepted as additive new public surface; revisit if the
// generator gains support for marking these as pageable without modifying
// the shared models.tsp.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PolicyStatesOperationGroup.summarizeForResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PolicyStatesOperationGroup.summarizeForResourceGroup,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PolicyStatesOperationGroup.summarizeForSubscription,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PolicyStatesOperationGroup.summarizeForManagementGroup,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PolicyStatesOperationGroup.summarizeForPolicyDefinition,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PolicyStatesOperationGroup.summarizeForPolicySetDefinition,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "compat GA"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "csharp"
);

// Remediations: hide management-group, subscription, resource-group scope operations from C#
@@scope(Remediations.getAtManagementGroup, "!csharp");
@@scope(Remediations.createOrUpdateAtManagementGroup, "!csharp");
@@scope(Remediations.deleteAtManagementGroup, "!csharp");
@@scope(Remediations.listForManagementGroup, "!csharp");
@@scope(RemediationsOperationGroup.listDeploymentsAtManagementGroup, "!csharp");
@@scope(RemediationsOperationGroup.cancelAtManagementGroup, "!csharp");
@@scope(Remediations.getAtSubscription, "!csharp");
@@scope(Remediations.createOrUpdateAtSubscription, "!csharp");
@@scope(Remediations.deleteAtSubscription, "!csharp");
@@scope(Remediations.listForSubscription, "!csharp");
@@scope(Remediations.listDeploymentsAtSubscription, "!csharp");
@@scope(Remediations.cancelAtSubscription, "!csharp");
@@scope(Remediations.getAtResourceGroup, "!csharp");
@@scope(Remediations.createOrUpdateAtResourceGroup, "!csharp");
@@scope(Remediations.deleteAtResourceGroup, "!csharp");
@@scope(Remediations.listForResourceGroup, "!csharp");
@@scope(Remediations.listDeploymentsAtResourceGroup, "!csharp");
@@scope(Remediations.cancelAtResourceGroup, "!csharp");

// Attestations: hide subscription and resource-group scope operations from C#
@@scope(Attestations.getAtSubscription, "!csharp");
@@scope(Attestations.createOrUpdateAtSubscription, "!csharp");
@@scope(Attestations.deleteAtSubscription, "!csharp");
@@scope(Attestations.listForSubscription, "!csharp");
@@scope(Attestations.getAtResourceGroup, "!csharp");
@@scope(Attestations.createOrUpdateAtResourceGroup, "!csharp");
@@scope(Attestations.deleteAtResourceGroup, "!csharp");
@@scope(Attestations.listForResourceGroup, "!csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "GA back-compat"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SlimPolicyMetadata,
  Azure.ResourceManager.CommonTypes.Resource,
  "csharp"
);

@@clientName(QueryOptions, "PolicyQuerySettings", "csharp");

// Restore GA OData property names (uppercase D after O) on the user-facing models.
@@clientName(PolicyEvent.`@odata.id`, "ODataId", "csharp");
@@clientName(PolicyEvent.`@odata.context`, "ODataContext", "csharp");
@@clientName(PolicyState.`@odata.id`, "ODataId", "csharp");
@@clientName(PolicyState.`@odata.context`, "ODataContext", "csharp");
@@clientName(ComponentPolicyState.`@odata.id`, "ODataId", "csharp");
@@clientName(ComponentPolicyState.`@odata.context`, "ODataContext", "csharp");
@@clientName(Summary.`@odata.id`, "ODataId", "csharp");
@@clientName(Summary.`@odata.context`, "ODataContext", "csharp");

// Rename auto-emitted Mockable*Resource / PolicyInsightsExtensions extension
// method names back to GA. Per skill ref §9.35 the C# emitter ignores
// @@clientName on the @@override-shimmed top-level ops (e.g.
// policyStatesSummarizeForSubscriptionLevelPolicyAssignment) but DOES honour
// @@clientName when applied to the ARM-template-derived interface op
// (PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment).
//
// NOTE: GA used the same C# name for the 4 scope-bound variants (sub/rg/mg/
// resource) of each query/summarize family — autorest combined them at source
// level. The new emitter emits one ArmClient extension + REST method per op,
// so renaming all 4 to the same name causes CS0111 on the ArmClient extension
// class and the REST operations class. The renames below avoid that pattern —
// only ops whose default name doesn't already match GA AND whose new name does
// not collide with another rename in the same target class.

@@clientName(
  PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition,
  "GetQueryResultsForPolicyDefinitionPolicyEvents",
  "csharp"
);
@@clientName(
  PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition,
  "GetQueryResultsForPolicySetDefinitionPolicyEvents",
  "csharp"
);
@@clientName(
  PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "GetQueryResultsForSubscriptionLevelPolicyAssignmentPolicyEvents",
  "csharp"
);
@@clientName(
  PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "GetQueryResultsForResourceGroupLevelPolicyAssignmentPolicyEvents",
  "csharp"
);

@@clientName(
  PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  "GetQueryResultsForPolicyDefinitionPolicyStates",
  "csharp"
);
@@clientName(
  PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition,
  "GetQueryResultsForPolicySetDefinitionPolicyStates",
  "csharp"
);
@@clientName(
  PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "GetQueryResultsForSubscriptionLevelPolicyAssignmentPolicyStates",
  "csharp"
);
@@clientName(
  PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "GetQueryResultsForResourceGroupLevelPolicyAssignmentPolicyStates",
  "csharp"
);
@@clientName(
  PolicyStatesOperationGroup.summarizeForPolicyDefinition,
  "SummarizeForPolicyDefinitionPolicyStates",
  "csharp"
);
@@clientName(
  PolicyStatesOperationGroup.summarizeForPolicySetDefinition,
  "SummarizeForPolicySetDefinitionPolicyStates",
  "csharp"
);
@@clientName(
  PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment,
  "SummarizeForSubscriptionLevelPolicyAssignmentPolicyStates",
  "csharp"
);
@@clientName(
  PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment,
  "SummarizeForResourceGroupLevelPolicyAssignmentPolicyStates",
  "csharp"
);

@@clientName(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription,
  "GetQueryResultsForSubscriptionComponentPolicyStates",
  "csharp"
);
@@clientName(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup,
  "GetQueryResultsForResourceGroupComponentPolicyStates",
  "csharp"
);
@@clientName(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResource,
  "GetQueryResultsForResourceComponentPolicyStates",
  "csharp"
);
@@clientName(
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  "GetQueryResultsForPolicyDefinitionComponentPolicyStates",
  "csharp"
);
@@clientName(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "GetQueryResultsForSubscriptionLevelPolicyAssignmentComponentPolicyStates",
  "csharp"
);
@@clientName(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "GetQueryResultsForResourceGroupLevelPolicyAssignmentComponentPolicyStates",
  "csharp"
);

@@clientName(PolicyMetadataNonResourceOperationGroup.list, "GetAll", "csharp");

@@clientName(
  Remediations.listDeploymentsAtResource,
  "GetDeployments",
  "csharp"
);
@@clientName(Remediations.cancelAtResource, "Cancel", "csharp");
@@alternateType(
  attestationsListForResource::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyTrackedResourcesListQueryResultsForManagementGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyTrackedResourcesListQueryResultsForSubscription::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyTrackedResourcesListQueryResultsForResourceGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyTrackedResourcesListQueryResultsForResource::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyEventsListQueryResultsForManagementGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyEventsListQueryResultsForSubscription::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyEventsListQueryResultsForResourceGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyEventsListQueryResultsForResource::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyEventsListQueryResultsForPolicySetDefinition::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyEventsListQueryResultsForPolicyDefinition::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyEventsListQueryResultsForResourceGroupLevelPolicyAssignment::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesListQueryResultsForManagementGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesSummarizeForManagementGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesListQueryResultsForSubscription::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesSummarizeForSubscription::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesListQueryResultsForResourceGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesSummarizeForResourceGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesListQueryResultsForResource::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesSummarizeForResource::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesListQueryResultsForPolicySetDefinition::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesSummarizeForPolicySetDefinition::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesListQueryResultsForPolicyDefinition::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesSummarizeForPolicyDefinition::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesSummarizeForSubscriptionLevelPolicyAssignment::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesListQueryResultsForResourceGroupLevelPolicyAssignment::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyStatesSummarizeForResourceGroupLevelPolicyAssignment::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  policyMetadataList::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  componentPolicyStatesListQueryResultsForSubscription::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  componentPolicyStatesListQueryResultsForResourceGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  componentPolicyStatesListQueryResultsForResource::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  componentPolicyStatesListQueryResultsForPolicyDefinition::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  componentPolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignment::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  componentPolicyStatesListQueryResultsForResourceGroupLevelPolicyAssignment::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  remediationsListDeploymentsAtManagementGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  remediationsListForManagementGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  remediationsListDeploymentsAtSubscription::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  remediationsListForSubscription::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  remediationsListDeploymentsAtResourceGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  remediationsListForResourceGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  remediationsListDeploymentsAtResource::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  remediationsListForResource::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  attestationsListForSubscription::parameters.queryOptions,
  QueryOptions,
  "csharp"
);
@@alternateType(
  attestationsListForResourceGroup::parameters.queryOptions,
  QueryOptions,
  "csharp"
);

#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "for csharp sdk compat"
@@clientName(
  PolicyStatesOperationGroup.triggerResourceGroupEvaluation,
  "TriggerPolicyStateEvaluation",
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "for csharp sdk compat"
@@clientName(
  PolicyStatesOperationGroup.triggerSubscriptionEvaluation,
  "TriggerPolicyStateEvaluation",
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "csharp sdk compat"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ComponentEventDetails,
  Foundations.Resource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "csharp sdk compat"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  ComponentStateDetails,
  Foundations.Resource,
  "csharp"
);

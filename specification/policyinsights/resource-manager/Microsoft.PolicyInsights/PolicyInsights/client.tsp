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
// @@clientLocation(PolicyEventsListQueryResultsForPolicySetDefinitionBaseParam.subscriptionId,
//   PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition
// );
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
model QueryOptions {
  /** Maximum number of records to return. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
  @query("$top")
  @minValue(0)
  Top?: int32;

  /** Ordering expression using OData notation. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
  @query("$orderby")
  OrderBy?: string;

  /** Select expression using OData notation. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
  @query("$select")
  Select?: string;

  /** ISO 8601 formatted timestamp specifying the start time of the interval to query. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
  @query("$from")
  From?: utcDateTime;

  /** ISO 8601 formatted timestamp specifying the end time of the interval to query. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
  @query("$to")
  To?: utcDateTime;

  /** OData filter expression. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
  @query("$filter")
  Filter?: string;

  /** OData apply expression for aggregations. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
  @query("$apply")
  Apply?: string;

  /**
   * The $expand query parameter. For example, to expand components use $expand=components
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
  @query("$expand")
  Expand?: string;

  /** Skiptoken provided if a previous response returned a partial result. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Matching OData convention"
  @query("$skiptoken")
  SkipToken?: string;
}

// PolicyTrackedResources overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(
  PolicyTrackedResourcesOperationGroup.listQueryResultsForManagementGroup
)
op policyTrackedResourcesListQueryResultsForManagementGroup(
  ...ApiVersionParameter,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupName: string,

  @path
  policyTrackedResourcesResource: PolicyTrackedResourcesResourceType,

  queryOptions?: QueryOptions,
): PolicyTrackedResourcesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyTrackedResourcesOperationGroup.listQueryResultsForSubscription)
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

  queryOptions?: QueryOptions,
): PolicyTrackedResourcesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyTrackedResourcesOperationGroup.listQueryResultsForResourceGroup)
op policyTrackedResourcesListQueryResultsForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,

  @path
  @segment("policyTrackedResources")
  policyTrackedResourcesResource: PolicyTrackedResourcesResourceType,

  queryOptions?: QueryOptions,
): PolicyTrackedResourcesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyTrackedResourcesOperationGroup.listQueryResultsForResource)
op policyTrackedResourcesListQueryResultsForResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  @path
  policyTrackedResourcesResource: PolicyTrackedResourcesResourceType,

  queryOptions?: QueryOptions,
): PolicyTrackedResourcesQueryResults | QueryFailure;

// PolicyEvents overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyEventsOperationGroup.listQueryResultsForManagementGroup)
op policyEventsListQueryResultsForManagementGroup(
  ...ApiVersionParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupName: string,

  queryOptions?: QueryOptions,
): PolicyEventsQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyEventsOperationGroup.listQueryResultsForSubscription)
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

  queryOptions?: QueryOptions,
): PolicyEventsQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyEventsOperationGroup.listQueryResultsForResourceGroup)
op policyEventsListQueryResultsForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,

  @path
  @segment("policyEvents")
  policyEventsResource: PolicyEventsResourceType,

  queryOptions?: QueryOptions,
): PolicyEventsQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyEventsOperationGroup.listQueryResultsForResource)
op policyEventsListQueryResultsForResource(
  ...ApiVersionParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  resourceId: string,

  queryOptions?: QueryOptions,
): PolicyEventsQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@list
@override(PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition)
op policyEventsListQueryResultsForPolicySetDefinition(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: QueryOptions,
): PolicyEventsQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@list
@post
@override(PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition)
op policyEventsListQueryResultsForPolicyDefinition(
  ...PolicyEventsListQueryResultsForPolicyDefinitionBaseParam,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: QueryOptions,
): PolicyEventsQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(
  PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment
)
op policyEventsListQueryResultsForSubscriptionLevelPolicyAssignment(
  ...PolicyEventsListQueryResultsForSubscriptionLevelPolicyAssignmentBaseParam,

  @path
  policyEventsResource: PolicyEventsResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: QueryOptions,
): PolicyEventsQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(
  PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment
)
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

  queryOptions?: QueryOptions,
): PolicyEventsQueryResults | QueryFailure;

// PolicyStates overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.listQueryResultsForManagementGroup)
op policyStatesListQueryResultsForManagementGroup(
  ...ApiVersionParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupName: string,

  queryOptions?: QueryOptions,
): PolicyStatesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.summarizeForManagementGroup)
op policyStatesSummarizeForManagementGroup(
  ...ApiVersionParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupName: string,

  queryOptions?: QueryOptions,
): SummarizeResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.listQueryResultsForSubscription)
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

  queryOptions?: QueryOptions,
): PolicyStatesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.summarizeForSubscription)
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

  queryOptions?: QueryOptions,
): SummarizeResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.listQueryResultsForResourceGroup)
op policyStatesListQueryResultsForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,

  @path
  @segment("policyStates")
  policyStatesResource: PolicyStatesResource,

  queryOptions?: QueryOptions,
): PolicyStatesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.summarizeForResourceGroup)
op policyStatesSummarizeForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,

  @path
  @segment("policyStates")
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  queryOptions?: QueryOptions,
): SummarizeResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.listQueryResultsForResource)
op policyStatesListQueryResultsForResource(
  ...ApiVersionParameter,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  resourceId: string,

  queryOptions?: QueryOptions,
): PolicyStatesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.summarizeForResource)
op policyStatesSummarizeForResource(
  ...ApiVersionParameter,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  resourceId: string,

  queryOptions?: QueryOptions,
): SummarizeResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition)
op policyStatesListQueryResultsForPolicySetDefinition(
  ...PolicyStatesListQueryResultsForPolicySetDefinitionBaseParam,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: QueryOptions,
): PolicyStatesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.summarizeForPolicySetDefinition)
op policyStatesSummarizeForPolicySetDefinition(
  ...PolicyStatesSummarizeForPolicySetDefinitionBaseParam,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policySetDefinitionName: string,

  queryOptions?: QueryOptions,
): SummarizeResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition)
op policyStatesListQueryResultsForPolicyDefinition(
  ...PolicyStatesListQueryResultsForPolicyDefinitionBaseParam,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: QueryOptions,
): PolicyStatesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyStatesOperationGroup.summarizeForPolicyDefinition)
op policyStatesSummarizeForPolicyDefinition(
  ...PolicyStatesSummarizeForPolicyDefinitionBaseParam,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyDefinitionName: string,

  queryOptions?: QueryOptions,
): SummarizeResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(
  PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment
)
op policyStatesListQueryResultsForSubscriptionLevelPolicyAssignment(
  ...PolicyStatesListQueryResultsForSubscriptionLevelPolicyAssignmentBaseParam,

  @path
  policyStatesResource: PolicyStatesResource,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: QueryOptions,
): PolicyStatesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(
  PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment
)
op policyStatesSummarizeForSubscriptionLevelPolicyAssignment(
  ...PolicyStatesSummarizeForSubscriptionLevelPolicyAssignmentBaseParam,

  @path
  policyStatesSummaryResource: PolicyStatesSummaryResourceType,

  @path
  authorizationNamespace: "Microsoft.Authorization",

  @path
  policyAssignmentName: string,

  queryOptions?: QueryOptions,
): SummarizeResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(
  PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment
)
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

  queryOptions?: QueryOptions,
): PolicyStatesQueryResults | QueryFailure;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(
  PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment
)
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

  queryOptions?: QueryOptions,
): SummarizeResults | QueryFailure;

// PolicyMetadata overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(PolicyMetadataNonResourceOperationGroup.list)
op policyMetadataList(
  ...ApiVersionParameter,
  queryOptions?: QueryOptions,
): PolicyMetadataCollection | PolicyInsightsApi.ErrorResponse;

// ComponentPolicyStates overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription)
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

  queryOptions?: QueryOptions,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup)
op componentPolicyStatesListQueryResultsForResourceGroup(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  @bodyRoot body: void,
  ...ProviderNamespace<Extension.ResourceGroup>,

  @path
  @segment("componentPolicyStates")
  componentPolicyStatesResource: ComponentPolicyStatesResource,

  queryOptions?: QueryOptions,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(ComponentPolicyStatesOperationGroup.listQueryResultsForResource)
op componentPolicyStatesListQueryResultsForResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  @path
  componentPolicyStatesResource: ComponentPolicyStatesResource,

  queryOptions?: QueryOptions,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition
)
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

  queryOptions?: QueryOptions,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment
)
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

  queryOptions?: QueryOptions,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment
)
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

  queryOptions?: QueryOptions,
): ComponentPolicyStatesQueryResults | PolicyInsightsApi.ErrorResponse;

// Remediations overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(RemediationsOperationGroup.listDeploymentsAtManagementGroup)
op remediationsListDeploymentsAtManagementGroup(
  ...ApiVersionParameter,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupId: string,

  @path
  remediationName: string,

  queryOptions?: QueryOptions,
): RemediationDeploymentsListResult | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(Remediations.listForManagementGroup)
op remediationsListForManagementGroup(
  ...ApiVersionParameter,

  @path
  managementGroupsNamespace: "Microsoft.Management",

  @path
  managementGroupId: string,

  queryOptions?: QueryOptions,
): ArmResponse<RemediationListResult> | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(RemediationSubscriptionOperations.listDeploymentsAtSubscription)
op remediationsListDeploymentsAtSubscription(
  ...ApiVersionParameter,
  queryOptions?: QueryOptions,
): ArmResponse<RemediationDeploymentsListResult> | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(RemediationSubscriptionOperations.listForSubscription)
op remediationsListForSubscription(
  ...ApiVersionParameter,
  queryOptions?: QueryOptions,
): ArmResponse<RemediationListResult> | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(RemediationResourceGroupOperations.listDeploymentsAtResourceGroup)
op remediationsListDeploymentsAtResourceGroup(
  ...ApiVersionParameter,
  queryOptions?: QueryOptions,
): ArmResponse<RemediationDeploymentsListResult> | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(RemediationResourceGroupOperations.listForResourceGroup)
op remediationsListForResourceGroup(
  ...ApiVersionParameter,
  queryOptions?: QueryOptions,
): ArmResponse<RemediationListResult> | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(RemediationResourceOperations.listDeploymentsAtResource)
op remediationsListDeploymentsAtResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  @path
  remediationName: string,

  queryOptions?: QueryOptions,
): ArmResponse<RemediationDeploymentsListResult> | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(RemediationResourceOperations.listForResource)
op remediationsListForResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  queryOptions?: QueryOptions,
): ArmResponse<RemediationListResult> | PolicyInsightsApi.ErrorResponse;

// Attestations overrides

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(Attestations.listForSubscription)
op attestationsListForSubscription(
  ...ApiVersionParameter,
  queryOptions?: QueryOptions,
): ArmResponse<AttestationListResult> | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(AttestationResourceGroupOperations.listForResourceGroup)
op attestationsListForResourceGroup(
  ...ApiVersionParameter,
  queryOptions?: QueryOptions,
): ArmResponse<AttestationListResult> | PolicyInsightsApi.ErrorResponse;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@override(AttestationOperationGroup.listForResource)
op attestationsListForResource(
  ...ApiVersionParameter,

  @path
  resourceId: string,

  queryOptions?: QueryOptions,
): ArmResponse<AttestationListResult> | PolicyInsightsApi.ErrorResponse;

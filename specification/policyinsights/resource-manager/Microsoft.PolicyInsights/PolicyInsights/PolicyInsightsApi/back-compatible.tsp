import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using PolicyInsightsApi;

// @@clientName(PolicyEventsQueryResults.`@odata.context`, "OdataContext");
// @@clientName(PolicyEventsQueryResults.`@odata.count`, "OdataCount");
// @@clientName(PolicyEventsQueryResults.`@odata.nextLink`, "OdataNextLink");

// @@clientName(PolicyEvent.`@odata.id`, "OdataId");
// @@clientName(PolicyEvent.`@odata.context`, "OdataContext");

// @@clientName(PolicyStatesQueryResults.`@odata.context`, "OdataContext");
// @@clientName(PolicyStatesQueryResults.`@odata.count`, "OdataCount");
// @@clientName(PolicyStatesQueryResults.`@odata.nextLink`, "OdataNextLink");

// @@clientName(PolicyState.`@odata.id`, "OdataId");
// @@clientName(PolicyState.`@odata.context`, "OdataContext");

// @@clientName(SummarizeResults.`@odata.context`, "OdataContext");
// @@clientName(SummarizeResults.`@odata.count`, "OdataCount");

// @@clientName(Summary.`@odata.id`, "OdataId");
// @@clientName(Summary.`@odata.context`, "OdataContext");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SlimPolicyMetadata.properties);

// @@clientName(ComponentPolicyStatesQueryResults.`@odata.context`,
//   "OdataContext"
// );
// @@clientName(ComponentPolicyStatesQueryResults.`@odata.count`, "OdataCount");

// @@clientName(ComponentPolicyState.`@odata.id`, "OdataId");
// @@clientName(ComponentPolicyState.`@odata.context`, "OdataContext");

@@clientName(
  Remediations.createOrUpdateAtManagementGroup::parameters.resource,
  "parameters"
);
@@clientLocation(
  RemediationSubscriptionOperations.getAtSubscription,
  Remediations
);
@@clientLocation(
  RemediationSubscriptionOperations.createOrUpdateAtSubscription,
  Remediations
);
@@clientName(
  RemediationSubscriptionOperations.createOrUpdateAtSubscription::parameters.resource,
  "parameters"
);
@@clientLocation(
  RemediationSubscriptionOperations.deleteAtSubscription,
  Remediations
);
@@clientLocation(
  RemediationSubscriptionOperations.listForSubscription,
  Remediations
);
@@clientLocation(
  RemediationSubscriptionOperations.listDeploymentsAtSubscription,
  Remediations
);
@@clientLocation(
  RemediationSubscriptionOperations.cancelAtSubscription,
  Remediations
);
@@clientLocation(
  RemediationResourceGroupOperations.getAtResourceGroup,
  Remediations
);
@@clientLocation(
  RemediationResourceGroupOperations.createOrUpdateAtResourceGroup,
  Remediations
);
@@clientName(
  RemediationResourceGroupOperations.createOrUpdateAtResourceGroup::parameters.resource,
  "parameters"
);
@@clientLocation(
  RemediationResourceGroupOperations.deleteAtResourceGroup,
  Remediations
);
@@clientLocation(
  RemediationResourceGroupOperations.listForResourceGroup,
  Remediations
);
@@clientLocation(
  RemediationResourceGroupOperations.listDeploymentsAtResourceGroup,
  Remediations
);
@@clientLocation(
  RemediationResourceGroupOperations.cancelAtResourceGroup,
  Remediations
);
@@clientLocation(RemediationResourceOperations.getAtResource, Remediations);
@@clientLocation(
  RemediationResourceOperations.createOrUpdateAtResource,
  Remediations
);
@@clientName(
  RemediationResourceOperations.createOrUpdateAtResource::parameters.resource,
  "parameters"
);
@@clientLocation(RemediationResourceOperations.deleteAtResource, Remediations);
@@clientLocation(RemediationResourceOperations.listForResource, Remediations);
@@clientLocation(
  RemediationResourceOperations.listDeploymentsAtResource,
  Remediations
);
@@clientLocation(RemediationResourceOperations.cancelAtResource, Remediations);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Remediation.properties);

@@clientLocation(PolicyMetadataOperationGroup.getResource, "PolicyMetadata");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PolicyMetadata.properties);

@@clientName(
  Attestations.createOrUpdateAtSubscription::parameters.resource,
  "parameters"
);
@@clientLocation(
  AttestationResourceGroupOperations.getAtResourceGroup,
  Attestations
);
@@clientLocation(
  AttestationResourceGroupOperations.createOrUpdateAtResourceGroup,
  Attestations
);
@@clientName(
  AttestationResourceGroupOperations.createOrUpdateAtResourceGroup::parameters.resource,
  "parameters"
);
@@clientLocation(
  AttestationResourceGroupOperations.deleteAtResourceGroup,
  Attestations
);
@@clientLocation(
  AttestationResourceGroupOperations.listForResourceGroup,
  Attestations
);
@@clientLocation(AttestationOperationGroup.getAtResource, Attestations);
@@clientLocation(
  AttestationOperationGroup.createOrUpdateAtResource,
  Attestations
);
@@clientName(
  AttestationOperationGroup.createOrUpdateAtResource::parameters.resource,
  "parameters"
);
@@clientLocation(AttestationOperationGroup.deleteAtResource, Attestations);
@@clientLocation(AttestationOperationGroup.listForResource, Attestations);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Attestation.properties);

@@clientLocation(
  RemediationsOperationGroup.listDeploymentsAtManagementGroup,
  Remediations
);
@@clientLocation(
  RemediationsOperationGroup.cancelAtManagementGroup,
  Remediations
);

@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForManagementGroup,
  "PolicyEvents"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForSubscription,
  "PolicyEvents"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForResourceGroup,
  "PolicyEvents"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForResource,
  "PolicyEvents"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForPolicySetDefinition,
  "PolicyEvents"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForPolicyDefinition,
  "PolicyEvents"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "PolicyEvents"
);
@@clientLocation(
  PolicyEventsOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "PolicyEvents"
);

@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForManagementGroup,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForManagementGroup,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForSubscription,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForSubscription,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForResourceGroup,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForResourceGroup,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForResource,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForResource,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.triggerSubscriptionEvaluation,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.triggerResourceGroupEvaluation,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForPolicySetDefinition,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForPolicySetDefinition,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForPolicyDefinition,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForSubscriptionLevelPolicyAssignment,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "PolicyStates"
);
@@clientLocation(
  PolicyStatesOperationGroup.summarizeForResourceGroupLevelPolicyAssignment,
  "PolicyStates"
);

@@clientLocation(
  PolicyMetadataNonResourceOperationGroup.list,
  "PolicyMetadata"
);

@@clientLocation(
  PolicyRestrictionsOperationGroup.checkAtSubscriptionScope,
  "PolicyRestrictions"
);
@@clientLocation(
  PolicyRestrictionsOperationGroup.checkAtResourceGroupScope,
  "PolicyRestrictions"
);
@@clientLocation(
  PolicyRestrictionsOperationGroup.checkAtManagementGroupScope,
  "PolicyRestrictions"
);

@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription,
  "ComponentPolicyStates"
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup,
  "ComponentPolicyStates"
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResource,
  "ComponentPolicyStates"
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition,
  "ComponentPolicyStates"
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment,
  "ComponentPolicyStates"
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment,
  "ComponentPolicyStates"
);

@@clientName(
  PolicyRestrictionsOperationGroup.checkAtManagementGroupScope::parameters.body,
  "parameters"
);
@@clientName(
  PolicyRestrictionsOperationGroup.checkAtSubscriptionScope::parameters.body,
  "parameters"
);
@@clientName(
  PolicyRestrictionsOperationGroup.checkAtResourceGroupScope::parameters.body,
  "parameters"
);

@@visibility(AttestationListResult.value, Lifecycle.Read);
@@visibility(PolicyMetadataCollection.value, Lifecycle.Read);
@@visibility(RemediationDeploymentsListResult.value, Lifecycle.Read);
@@Azure.ResourceManager.identifiers(
  RemediationDeploymentsListResult.value,
  #["remediatedResourceId"]
);
@@visibility(RemediationListResult.value, Lifecycle.Read);

@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForPolicyDefinition
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroup
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForResourceGroupLevelPolicyAssignment
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscription
);
@@clientLocation(
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment::parameters.subscriptionId,
  ComponentPolicyStatesOperationGroup.listQueryResultsForSubscriptionLevelPolicyAssignment
);

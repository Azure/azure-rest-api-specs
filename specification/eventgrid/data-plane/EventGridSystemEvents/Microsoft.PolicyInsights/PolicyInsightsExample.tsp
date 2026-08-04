import "./PolicyInsights.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftPolicyInsightsPolicyStateCreatedExample: PolicyInsightsPolicyStateCreatedEventData = #{
  timestamp: utcDateTime.fromISO("2021-03-27T18:37:42.4496956Z"),
  policyAssignmentId: "{policy-assignment-scope}/providers/microsoft.authorization/policyassignments/{policy-assignment-name}",
  policyDefinitionId: "{policy-definition-scope}/providers/microsoft.authorization/policydefinitions/{policy-definition-name}",
  policyDefinitionReferenceId: "",
  complianceState: "NonCompliant",
  subscriptionId: "{subscription-id}",
  complianceReasonCode: "",
};

const MicrosoftPolicyInsightsPolicyStateChangedExample: PolicyInsightsPolicyStateChangedEventData = #{
  timestamp: utcDateTime.fromISO("2021-03-27T18:37:42.4496956Z"),
  policyAssignmentId: "{policy-assignment-scope}/providers/microsoft.authorization/policyassignments/{policy-assignment-name}",
  policyDefinitionId: "{policy-definition-scope}/providers/microsoft.authorization/policydefinitions/{policy-definition-name}",
  policyDefinitionReferenceId: "",
  complianceState: "NonCompliant",
  subscriptionId: "{subscription-id}",
  complianceReasonCode: "",
};

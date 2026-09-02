import "@typespec/versioning";
import "./PolicyInsightsExample.tsp";
using TypeSpec.Versioning;
/** Describes the schema of the Azure Policy events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.PolicyInsights.PolicyStateCreated event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  @example(MicrosoftPolicyInsightsPolicyStateCreatedExample)
  model PolicyInsightsPolicyStateCreatedEventData {
    ...PolicyInsightsBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.PolicyInsights.PolicyStateChanged event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  @example(MicrosoftPolicyInsightsPolicyStateChangedExample)
  model PolicyInsightsPolicyStateChangedEventData {
    ...PolicyInsightsBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.PolicyInsights.PolicyStateDeleted event. */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-type-name-conflict" "Name kept for backward compatibility"
  model PolicyInsightsPolicyStateDeletedEventData {
    ...PolicyInsightsBaseEventData;
  }

  alias PolicyInsightsBaseEventData = {
    /** The time that the resource was scanned by Azure Policy in the Universal ISO 8601 DateTime format yyyy-MM-ddTHH:mm:ss.fffffffZ. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    timestamp: utcDateTime;

    /** The resource ID of the policy assignment. */
    policyAssignmentId: string;

    /** The resource ID of the policy definition. */
    policyDefinitionId: string;

    /** The reference ID for the policy definition inside the initiative definition, if the policy assignment is for an initiative. May be empty. */
    policyDefinitionReferenceId: string;

    /** The compliance state of the resource with respect to the policy assignment. */
    complianceState: string;

    /** The subscription ID of the resource. */
    subscriptionId: string;

    /** The compliance reason code. May be empty. */
    complianceReasonCode: string;
  };
}

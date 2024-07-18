import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Azure Policy events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.PolicyInsights.PolicyStateCreated event. */
  model PolicyInsightsPolicyStateCreatedEventData {
    ...PolicyInsightsBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.PolicyInsights.PolicyStateChanged event. */
  model PolicyInsightsPolicyStateChangedEventData {
    ...PolicyInsightsBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.PolicyInsights.PolicyStateDeleted event. */
  model PolicyInsightsPolicyStateDeletedEventData {
    ...PolicyInsightsBaseEventData;
  }

  alias PolicyInsightsBaseEventData = {
    /** The time that the resource was scanned by Azure Policy in the Universal ISO 8601 DateTime format yyyy-MM-ddTHH:mm:ss.fffffffZ. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    timestamp: utcDateTime;

    /** The resource ID of the policy assignment. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    policyAssignmentId: string;

    /** The resource ID of the policy definition. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    policyDefinitionId: string;

    /** The reference ID for the policy definition inside the initiative definition, if the policy assignment is for an initiative. May be empty. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    policyDefinitionReferenceId: string;

    /** The compliance state of the resource with respect to the policy assignment. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    complianceState: string;

    /** The subscription ID of the resource. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    subscriptionId: string;

    /** The compliance reason code. May be empty. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    complianceReasonCode: string;
  };
}

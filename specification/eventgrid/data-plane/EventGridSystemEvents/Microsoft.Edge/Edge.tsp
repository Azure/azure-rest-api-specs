import "@typespec/versioning";
using TypeSpec.Versioning;
/** EG Edge Data Model */
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Edge.SolutionVersionPublished event. */
  model EdgeSolutionVersionPublishedEventData {
    /** A GUID to uniquely track External Solution Validation */
    externalValidationId: string;

    /** ARM ID of the Target resource */
    targetId: string;

    /** ARM ID of the Solution Template resource */
    solutionTemplateId: string;

    /** ARM ID of the Solution Template Version resource */
    solutionTemplateVersionId: string;

    /** ARM ID of the Solution Version resource */
    solutionVersionId: string;

    /** API Version supported for the resources */
    apiVersion: string;

    /** Direct URL to callback for updating validation status */
    callbackUrl: url;
  }
}

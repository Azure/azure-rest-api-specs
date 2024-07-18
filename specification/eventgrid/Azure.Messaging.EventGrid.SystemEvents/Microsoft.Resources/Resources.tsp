import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Azure resource events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteSuccess event. This is raised when a resource create or update operation succeeds. */
  model ResourceWriteSuccessEventData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteFailure event. This is raised when a resource create or update operation fails. */
  model ResourceWriteFailureEventData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteCancel event. This is raised when a resource create or update operation is canceled. */
  model ResourceWriteCancelEventData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteSuccess event. This is raised when a resource delete operation succeeds. */
  model ResourceDeleteSuccessEventData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteFailure event. This is raised when a resource delete operation fails. */
  model ResourceDeleteFailureEventData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteCancel event. This is raised when a resource delete operation is canceled. */
  model ResourceDeleteCancelEventData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionSuccess event. This is raised when a resource action operation succeeds. */
  model ResourceActionSuccessEventData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionFailure event. This is raised when a resource action operation fails. */
  model ResourceActionFailureEventData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionCancel event. This is raised when a resource action operation is canceled. */
  model ResourceActionCancelEventData {
    ...ResourceBaseEventData;
  }

  /** The details of the HTTP request. */
  model ResourceHttpRequest {
    /** The client request ID. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    clientRequestId: string;

    /** The client IP address. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    clientIpAddress: string;

    /** The request method. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    method: string;

    /** The url used in the request. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    url: string;
  }

  /** The details of the authorization for the resource. */
  model ResourceAuthorization {
    /** The scope of the authorization. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    scope: string;

    /** The action being requested. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    action: string;

    /** The evidence for the authorization. */
    evidence: Record<string>;
  }

  alias ResourceBaseEventData = {
    /** The tenant ID of the resource. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    tenantId: string;

    /** The subscription ID of the resource. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    subscriptionId: string;

    /** The resource group of the resource. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    resourceGroup: string;

    /** The resource provider performing the operation. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    resourceProvider: string;

    /** The URI of the resource in the operation. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    resourceUri: string;

    /** The operation that was performed. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    operationName: string;

    /** The status of the operation. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    status: string;

    /** The requested authorization for the operation. */
    authorization: ResourceAuthorization;

    /** The properties of the claims. */
    claims: Record<string>;

    /** An operation ID used for troubleshooting. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    correlationId: string;

    /** The details of the operation. */
    httpRequest: ResourceHttpRequest;
  };
}

/** Describes the schema of the Azure resource events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteSuccess event. This is raised when a resource create or update operation succeeds. */
  model ResourceWriteSuccessData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteFailure event. This is raised when a resource create or update operation fails. */
  model ResourceWriteFailureData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteCancel event. This is raised when a resource create or update operation is canceled. */
  model ResourceWriteCancelData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteSuccess event. This is raised when a resource delete operation succeeds. */
  model ResourceDeleteSuccessData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteFailure event. This is raised when a resource delete operation fails. */
  model ResourceDeleteFailureData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteCancel event. This is raised when a resource delete operation is canceled. */
  model ResourceDeleteCancelData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionSuccess event. This is raised when a resource action operation succeeds. */
  model ResourceActionSuccessData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionFailure event. This is raised when a resource action operation fails. */
  model ResourceActionFailureData {
    ...ResourceBaseEventData;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionCancel event. This is raised when a resource action operation is canceled. */
  model ResourceActionCancelData {
    ...ResourceBaseEventData;
  }

  /** The details of the HTTP request. */
  model ResourceHttpRequest {
    /** The client request ID. */
    clientRequestId?: string;

    /** The client IP address. */
    clientIpAddress?: string;

    /** The request method. */
    method?: string;

    /** The url used in the request. */
    url?: string;
  }

  /** The details of the authorization for the resource. */
  model ResourceAuthorization {
    /** The scope of the authorization. */
    scope?: string;

    /** The action being requested. */
    action?: string;

    /** The evidence for the authorization. */
    evidence?: Record<string>;
  }

  alias ResourceBaseEventData = {
    /** The tenant ID of the resource. */
    tenantId?: string;

    /** The subscription ID of the resource. */
    subscriptionId?: string;

    /** The resource group of the resource. */
    resourceGroup?: string;

    /** The resource provider performing the operation. */
    resourceProvider?: string;

    /** The URI of the resource in the operation. */
    resourceUri?: string;

    /** The operation that was performed. */
    operationName?: string;

    /** The status of the operation. */
    status?: string;

    /** The requested authorization for the operation. */
    authorization?: ResourceAuthorization;

    /** The properties of the claims. */
    claims?: Record<string>;

    /** An operation ID used for troubleshooting. */
    correlationId?: string;

    /** The details of the operation. */
    httpRequest?: ResourceHttpRequest;
  };
}

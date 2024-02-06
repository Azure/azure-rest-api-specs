@doc("Describes the schema of the Azure resource events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace Microsoft.EventGrid {
  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteSuccess event. This is raised when a resource create or update operation succeeds.")
  model ResourceWriteSuccessData {
    ...ResourceBaseEventData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteFailure event. This is raised when a resource create or update operation fails.")
  model ResourceWriteFailureData {
    ...ResourceBaseEventData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceWriteCancel event. This is raised when a resource create or update operation is canceled.")
  model ResourceWriteCancelData {
    ...ResourceBaseEventData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteSuccess event. This is raised when a resource delete operation succeeds.")
  model ResourceDeleteSuccessData {
    ...ResourceBaseEventData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteFailure event. This is raised when a resource delete operation fails.")
  model ResourceDeleteFailureData {
    ...ResourceBaseEventData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceDeleteCancel event. This is raised when a resource delete operation is canceled.")
  model ResourceDeleteCancelData {
    ...ResourceBaseEventData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionSuccess event. This is raised when a resource action operation succeeds.")
  model ResourceActionSuccessData {
    ...ResourceBaseEventData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionFailure event. This is raised when a resource action operation fails.")
  model ResourceActionFailureData {
    ...ResourceBaseEventData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Resources.ResourceActionCancel event. This is raised when a resource action operation is canceled.")
  model ResourceActionCancelData {
    ...ResourceBaseEventData;
  }

  @doc("The details of the HTTP request.")
  model ResourceHttpRequest {
    @doc("The client request ID.")
    clientRequestId?: string;

    @doc("The client IP address.")
    clientIpAddress?: string;

    @doc("The request method.")
    method?: string;

    @doc("The url used in the request.")
    url?: string;
  }

  @doc("The details of the authorization for the resource.")
  model ResourceAuthorization {
    @doc("The scope of the authorization.")
    scope?: string;

    @doc("The action being requested.")
    action?: string;

    @doc("The evidence for the authorization.")
    evidence?: Record<string>;
  }

  alias ResourceBaseEventData = {
    @doc("The tenant ID of the resource.")
    tenantId?: string;

    @doc("The subscription ID of the resource.")
    subscriptionId?: string;

    @doc("The resource group of the resource.")
    resourceGroup?: string;

    @doc("The resource provider performing the operation.")
    resourceProvider?: string;

    @doc("The URI of the resource in the operation.")
    resourceUri?: string;

    @doc("The operation that was performed.")
    operationName?: string;

    @doc("The status of the operation.")
    status?: string;

    @doc("The requested authorization for the operation.")
    authorization?: ResourceAuthorization;

    @doc("The properties of the claims.")
    claims?: Record<string>;

    @doc("An operation ID used for troubleshooting.")
    correlationId?: string;

    @doc("The details of the operation.")
    httpRequest?: ResourceHttpRequest;
  };
}

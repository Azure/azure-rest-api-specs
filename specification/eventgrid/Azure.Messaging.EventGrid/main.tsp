import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "SharedAccessKey">
)

@service({
  title: "Azure.Messaging.EventGridClient",
})

//
// Supported operations.
//
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}:publish?api-version={apiVersion}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:receive?api-Version={apiVersion}&maxWaitTime=60&maxEvents={maxEvents}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:acknowledge?api-Version={apiVersion}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:release?api-version={apiVersion}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:reject?api-version={apiVersion}


@server(
  "{endpoint}",
  "The host name of the namespace",
  {
    @doc("The host name of the namespace, e.g. namespaceName1.westus-1.eventgrid.azure.net")
    endpoint: url,
  }
)

@doc("Azure Messaging EventGrid Client")
@versioned(ServiceApiVersions)
namespace Azure.Messaging.EventGrid {
  using TypeSpec.Http;
  using TypeSpec.Rest;
  using TypeSpec.Versioning;
  using Azure.Core;
  using Azure.Core.Foundations;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
  enum ServiceApiVersions {
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    v2023_06_01_preview: "2023-06-01-preview"
  }

  @doc("Properties of an event published to an Azure Messaging EventGrid Namespace topic using the CloudEvent 1.0 Schema.")
  model CloudEvent {
    @doc("An identifier for the event. The combination of id and source must be unique for each distinct event.")
    id: string;

    @doc("Identifies the context in which an event happened. The combination of id and source must be unique for each distinct event.")
    source: string;

    @doc("Event data specific to the event type.")
    data?: unknown;

    @doc("Event data specific to the event type, encoded as a base64 string.")
    data_base64?: bytes;
    
    @doc("Type of event related to the originating occurrence.")
    type: string;

    @doc("The time (in UTC) the event was generated, in RFC3339 format.")
    time?: utcDateTime;

    @doc("The version of the CloudEvents specification which the event uses.")
    specversion: string;

    @doc("Identifies the schema that data adheres to.")
    dataschema?: string;

    @doc("Content type of data value.")
    datacontenttype?: string;

    @doc("This describes the subject of the event in the context of the event producer (identified by source).")
    subject?: string;
  }

  @doc("Properties of the Event Broker operation.")
  model BrokerProperties {
    @doc("The token used to lock the event.")
    lockToken: string;

    @doc("The attempt count for delivering the event.")
    deliveryCount: int32;
  }

  @doc("Receive operation details per Cloud Event.")
  model ReceiveDetails {
    @doc("The Event Broker details.")
    brokerProperties: BrokerProperties;

    @doc("Cloud Event details.")
    event: CloudEvent;
  }

  @doc("Details of the Receive operation response.")
  model ReceiveResult {
    @doc("Array of receive responses, one per cloud event.")
    value: ReceiveDetails[];
  }
   
  @doc("Failed LockToken information.")
  model FailedLockToken {
    @doc("LockToken value")
    lockToken: string;

    @doc("Error code related to the token. Example of such error codes are BadToken: which indicates the Token is not formatted correctly, TokenLost: which indicates that token is not found, and InternalServerError: For any internal server errors.")
    errorCode: string;

    @doc("Description of the token error.")
    errorDescription: string; 
  }

  @doc("The result of the Publish operation.")
  model PublishResult {}

  @doc("The result of the Acknowledge operation.")
  model AcknowledgeResult {
    @doc("Array of LockToken values for failed cloud events. Each LockToken includes the lock token value along with the related error information (namely, the error code and description).")
    failedLockTokens: FailedLockToken[];

    @doc("Array of lock tokens values for the successfully acknowledged cloud events.")
    succeededLockTokens: string[];
  }

  @doc("The result of the Release operation.")
  model ReleaseResult {
    @doc("Array of LockToken values for failed cloud events. Each LockToken includes the lock token value along with the related error information (namely, the error code and description).")
    failedLockTokens: FailedLockToken[];

    @doc("Array of lock tokens values for the successfully released cloud events.")
    succeededLockTokens: string[];
  }

  @doc("The result of the Reject operation.")
  model RejectResult {
    @doc("Array of LockToken values for failed cloud events. Each LockToken includes the lock token value along with the related error information (namely, the error code and description).")
    failedLockTokens: FailedLockToken[];

    @doc("Array of lock tokens values for the successfully rejected cloud events.")
    succeededLockTokens: string[];
  }

  @doc("Array of lock token strings for the corresponding received Cloud Events to be released.")
  model ReleaseOptions {
    @doc("String array of lock tokens.")
    lockTokens: string[];
  }

  @doc("Array of lock token strings for the corresponding received Cloud Events to be acknowledged.")
  model AcknowledgeOptions {
    @doc("String array of lock tokens.")
    lockTokens: string[];
  }

  @doc("Array of lock token strings for the corresponding received Cloud Events to be rejected.")
  model RejectOptions {
    @doc("String array of lock tokens.")
    lockTokens: string[];
  }

  // Publish Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}:publish?api-version={apiVersion}}

  @doc("Publish Single Cloud Event to namespace topic. In case of success, the server responds with an HTTP 200 status code with an empty JSON object in response. Otherwise, the server can return various error codes. For example, 401: which indicates authorization failure, 403: which indicates quota exceeded or message is too large, 410: which indicates that specific topic is not found, 400: for bad request, and 500: for internal server error. ")
  @route("/topics/{topicName}:publish", {shared: true})
  @post op PublishCloudEvent is Azure.Core.RpcOperation<{
    @doc("content type")
    @header("content-type")
    contentType: "application/cloudevents+json; charset=utf-8";

    @doc("Topic Name.")
    @path
    topicName: string;

    @doc("Single Cloud Event being published.")
    @body 
    event: CloudEvent;
  }, PublishResult>;


  @doc("Publish Batch Cloud Event to namespace topic. In case of success, the server responds with an HTTP 200 status code with an empty JSON object in response. Otherwise, the server can return various error codes. For example, 401: which indicates authorization failure, 403: which indicates quota exceeded or message is too large, 410: which indicates that specific topic is not found, 400: for bad request, and 500: for internal server error. ")  
  @route("/topics/{topicName}:publish", {shared: true})
  @post op PublishCloudEvents is Azure.Core.RpcOperation<{
    @doc("content type")
    @header("content-type")
    contentType: "application/cloudevents-batch+json; charset=utf-8";

    @doc("Topic Name.")
    @path
    topicName: string;

    @doc("Array of Cloud Events being published.")
    @body
    events: CloudEvent[];
  }, PublishResult>;

  // Receive Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:receive?api-Version={apiVersion}&maxWaitTime=60&maxEvents={maxEvents}
   
  @doc("Receive Batch of Cloud Events from the Event Subscription.")
  @route("/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:receive")
  @post op ReceiveCloudEvents is Azure.Core.RpcOperation<{
    @doc("Topic Name.")
    @path
    topicName: string;

    @doc("Event Subscription Name.")
    @path
    eventSubscriptionName: string;

    @doc("Max Events count to be received. Minimum value is 1, while maximum value is 100 events. If not specified, the default value is 1.")
    @query
    maxEvents?: int32 = 1;

    @doc("Max wait time value for receive operation in Seconds. It is the time in seconds that the server approximately waits for the availability of an event and responds to the request. If an event is available, the broker responds immediately to the client. Minimum value is 10 seconds, while maximum value is 120 seconds. If not specified, the default value is 60 seconds.")
    @encode("seconds", int32)
    @query
    maxWaitTime?: duration;
  }, ReceiveResult>;

  // Acknowledge Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:acknowledge&apiVersion={apiVersion}

  @doc("Acknowledge batch of Cloud Events. The server responds with an HTTP 200 status code if at least one event is successfully acknowledged. The response body will include the set of successfully acknowledged lockTokens, along with other failed lockTokens with their corresponding error information. Successfully acknowledged events will no longer be available to any consumer.")

  @route("/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:acknowledge")
  @post op AcknowledgeCloudEvents is Azure.Core.RpcOperation<{
    @doc("content type")
    @header("content-type")
    contentType: "application/json; charset=utf-8";

    @doc("Topic Name.")
    @path
    topicName: string;

    @doc("Event Subscription Name.")
    @path
    eventSubscriptionName: string;

    @doc("AcknowledgeOptions.")
    @body
    lockTokens: AcknowledgeOptions;
  }, AcknowledgeResult>;

  // Release Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:release?api-version={apiVersion}
  
  @doc("Release batch of Cloud Events. The server responds with an HTTP 200 status code if at least one event is successfully released. The response body will include the set of successfully released lockTokens, along with other failed lockTokens with their corresponding error information.")
  @route("/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:release")
  @post op ReleaseCloudEvents is Azure.Core.RpcOperation<{
    @doc("content type")
    @header("content-type")
    contentType: "application/json; charset=utf-8";

    @doc("Topic Name.")
    @path
    topicName: string;

    @doc("Event Subscription Name.")
    @path
    eventSubscriptionName: string;

    @doc("ReleaseOptions")
    @body    
    lockTokens : ReleaseOptions;
  }, ReleaseResult>;

  // Reject Operation:
  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:reject?api-version={apiVersion}

  @doc("Reject batch of Cloud Events.")
  @route("/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:reject")
  @post op RejectCloudEvents is Azure.Core.RpcOperation<{
    @doc("content type")
    @header("content-type")
    contentType: "application/json; charset=utf-8";

    @doc("Topic Name.")
    @path
    topicName: string;

    @doc("Event Subscription Name.")
    @path
    eventSubscriptionName: string;

    @doc("RejectOptions")
    @body
    lockTokens : RejectOptions;
  }, RejectResult>;
}

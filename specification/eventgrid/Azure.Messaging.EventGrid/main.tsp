import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

enum ServiceApiVersions {
  v2023_06_01_preview: "2023-06-01-preview"
}

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "SharedAccessKey">
)

@service({
  title: "Azure.Messaging.EventGridClient",
})

//
// Supported operations.
//
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}:publish?api-version={apiVersion}}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:receive?api-Version={apiVersion}&timeout=60&maxEvents={maxEvents}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:acknowledge?api-Version={apiVersion}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:release?api-version={apiVersion}
//

@server(
  "{endpoint}",
  "The host name of the topic",
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

  @doc("LockToken information.")
  model LockToken {
    @doc("The token used to lock the event.")
    lockToken: string;
  }

  @doc("Properties of the Event Broker operation.")
  model BrokerProperties {
    @doc("The token used to lock the event.")
    lockToken: LockToken;
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
    lockToken: LockToken;

    @doc("Error code")
    errorCode: int32;

    @doc("Description of the error")
    errorDescription: string; 
  }
   
  @doc("The result of the Acknowledge operation.")
  model AcknowledgeResult {
    @doc("Array of LockToken values for failed cloud events.")
    failedLockTokens: FailedLockToken[];

    @doc("Array of LockToken values for succeeded cloud events.")
    succeededLockTokens: string[];
  }

  @doc("The result of the Release operation.")
  model ReleaseResult {
    @doc("Array of LockToken values for failed cloud events.")
    failedLockTokens: FailedLockToken[];

    @doc("Array of LockToken values for succeeded cloud events.")
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

  @doc("Topic Resource.")
  @resource("topics")
  model Topic {
    @key
    @doc("Topic Name.")
    @visibility("read")
    topicName: string;
  }

  @doc("Event Subscription Resource.")
  @resource("eventsubscriptions")
  @parentResource(Topic)
  model EventSubscription {
    @key
    @doc("Event subscription name.")
    @visibility("read")
    eventSubscriptionName: string;
  }

  @doc("Publish operation Response")
  model PublishResponse {}


  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}:publish?api-version={apiVersion}}

  @doc("Publish Single Cloud Event to namespace topic.")
  @route("/", {shared: true})
  @action("publish")
  op PublishCloudEvent is Azure.Core.ResourceAction<
    Topic,
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/cloudevents+json; charset=utf-8";
    } & CloudEvent,
    PublishResponse
    >;

  @doc("Publish Batch of Cloud Events to namespace topic.")
  @route("/", {shared: true})
  @action("publish")
  op PublishCloudEvents is Azure.Core.ResourceAction<
    Topic,
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/cloudevents-batch+json; charset=utf-8";

      @doc("Array of Cloud Events being published.")
      @body
      events: CloudEvent[];
    },
    PublishResponse
    >;

  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:receive?api-Version={apiVersion}&timeout=60&maxEvents={maxEvents}
   
  @doc("Receive Batch of Cloud Events from the Event Subscription.")
  @action("receive")
  op ReceiveCloudEvents is Azure.Core.ResourceAction<
    EventSubscription,
    {
      @doc("Max Events count to be received.")
      @query
      maxEvents?: int32 = 1;

      @doc("Timeout value for receive operation in Seconds. Default is 60 seconds.")
      @query
      timeout?: int32 = 60;
    },
    ReceiveResult & CreatedResponse
  >;

  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:acknowledge&apiVersion={apiVersion}


  @doc("Acknowledge Cloud Events.")
  @action("acknowledge")
  op AcknowledgeCloudEvents is Azure.Core.ResourceAction<
    EventSubscription,
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/json; charset=utf-8";   

      @doc("AcknowledgeOptions.")
      @body
      lockTokens: AcknowledgeOptions;
    },
    AcknowledgeResult
  >;

  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:release?api-version={apiVersion}
  
  @doc("Release Cloud Events.")
  @action("release")
  op ReleaseCloudEvents is Azure.Core.ResourceAction<
    EventSubscription,
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/json; charset=utf-8";

    @doc("ReleaseOptions")
    @body    
    lockTokens : ReleaseOptions;
  }, ReleaseResult >;
}

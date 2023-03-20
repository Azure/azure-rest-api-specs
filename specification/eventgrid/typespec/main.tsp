import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

enum ServiceApiVersions {
    v2022_05_01: "2022-05-01", // TODO: should we use newer one like 2023-06-01-preview or 2023-06-01????
}

enum ProtocolType {
    https: "https://",
}

// TODO: will this be included in all operations? or should I explicitely add that?
// TODO: what is the story for SAS signature.

@useAuth(
    ApiKeyAuth<ApiKeyLocation.header, "aeg-sas-key"> | OAuth2Auth<[
        {
            type: OAuth2FlowType.implicit,
            authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
            scopes: ["https://eventgrid.azure.net/.default"],
        }
    ]>
)
@service({
    title: "EventGridClient", // TODO: Naming
    version: "2022-05-01",
})

//
// Supported operations as of 3/17/2023.
//
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}:publish?api-version={apiVersion}}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:receive?apiVersion={apiVersion}&timeout=60&maxEvents={maxEvents}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:acknowledge&apiVersion={apiVersion}
// POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:release?api-version={apiVersion}

// TODO: How to describe the query parameters or do we need it?
@server(
    "{ProtocolType}{NamespaceName}.{Region}.eventgrid.azure.net}",
    "The host name of the topic",
    {
        // @doc("""
        // The supported endpoints of the service. This includes either:
        //    1. Protocol and hostname of the topic. For example: https://namespace1.eastus-1.eventgrid.azure.net/topics/topic1 , or
        //    2. protocol and hostname of the event subscription. For example: https://namespace1.eastus-1.eventgrid.azure.net/topics/topic1/eventSubscriptions/eventSubscription1 .
        // """)
        // Endpoint: string,       // TODO: Alternative is to use url but in the future we will add other protocols here.

        @doc("Protocol type.")
        @path
        ProtocolType: ProtocolType,

        @doc("Namespace Name.")
        @path
        NamespaceName: string,

        @doc("Azure region where namespace and related nested resources are available.")
        @path
        Region: string,
    }
)

@doc("Azure EventGrid Client")
@versioned(ServiceApiVersions)
namespace AzureEventGrid {
    using TypeSpec.Http;
    using TypeSpec.Rest;
    using TypeSpec.Versioning;
    using Azure.Core;
    using Azure.Core.Foundations;

    @doc("Properties of an event published to an Azure EventGrid Namespace topic using the CloudEvent 1.0 Schema.")
    model CloudEventEvent {
        @doc("An identifier for the event. The combination of id and source must be unique for each distinct event.")
        id: string;

        @doc("Identifies the context in which an event happened. The combination of id and source must be unique for each distinct event.")
        source: string;

        @doc("Event data specific to the event type.")
        data?: object;

        @doc("Event data specific to the event type, encoded as a base64 string.")
        data_base64?: bytes; // TODO: maintain same format like event grid v1.. not using cameel dataBase64

        @doc("Type of event related to the originating occurrence.")
        type: string;

        @doc("The time (in UTC) the event was generated, in RFC3339 format.")
        time?: zonedDateTime;

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
        // TODO: is this correct description? is string right representation
        @doc("The token used to lock the event.")
        lockToken: string;
    }

    @doc("Properties of the Event Broker operation.")
    model BrokerProperties {
        // TODO: is this correct description? is string right representation
        @doc("The token used to lock the event.")
        lockToken: LockToken;

        // TODO: is this needed in this context?
        @doc("Delivery count.")
        deliveryCount: int32;
    }

    @doc("Receive operation details per Cloud Event.") 
    // TODO: is it OK to use ReceiveResponse? Other names: ReceiveReply, ReceiveResult, others?
    model ReceiveDetails {
        // TODO: is this correct description? is string right representation
        @doc("The Event Broker details.")
        brokerProperties: BrokerProperties;

        // TODO: is this needed in this context?
        @doc("Cloud Event details.")
        event: CloudEventEvent;
    }

     // TODO: is it OK to use ReceiveResponse? Other names: ReceiveReply, ReceiveResult, others?
   
     @doc("Details of the Receive operation response.")
     model ReceiveResponse {
        // TODO: is this correct description? is string right representation
        @doc("Array of resceiver responses, one per cloud event.")
        value: ReceiveDetails[];
    }
    
    @doc("Details of the LockTokens informaiton. This is used by both Acknowledge and Reslease operation response.")
    model LockTokensResponse {
       // TODO: is this correct description? is string right representation
       @doc("Array of LockToken values for failed cloud events.")
       failedLockTokens: string[];

       // TODO: is this correct description? is string right representation
       @doc("Array of LockToken values for succeeded cloud events.")
       succeededLockTokens: string[];
   }

    // TODO: PROBLEM.. show last one only
    // TODO: USE SHARED ROUTES in the future

    // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}:publish?api-version={apiVersion}}

    @doc("Publish Single Cloud Event to namespace topic.")
    @route("/topics/{topicName}:publish", { shared: true})
        @post op PublishCloudEvent is Azure.Core.RpcOperation<{
         @doc("content type")
         @header("content-type")
         contentType: "application/cloudevents+json; charset=utf-8";

         @doc("Topic Name.")
         @path
         topicName: string;

         @doc("Single Cloud Event being published.")
         @body
         event: CloudEventEvent;   // NOTE: What is the behavior in V1? is it events or event?
      }, {} >;


      @doc("Publish Batch of Cloud Events to namespace topic.")
      // @route("topics/{topicName}:publish?api-version={version}", {shared: true})
      @route("/topics/{topicName}:publish", { shared: true})
      @post op PublishBatchOfCloudEvents is Azure.Core.RpcOperation<{
        @doc("content type")
        @header("content-type")
        contentType: "application/cloudevents-batch+json; charset=utf-8";

        @doc("Topic Name.")
        @path
        topicName: string;

        @doc("Array of Cloud Events being published.")
        @body
        events: CloudEventEvent[];
      }, {} >;
      
      @doc("Receive Batch of Cloud Events from EventSubscription.")
      @route("/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:receive", { shared: true})
      @post op ReceiveBatchOfCloudEvents is Azure.Core.RpcOperation<{
        @doc("content type")
        @header("content-type")
        contentType: "application/json; charset=utf-8";

        @doc("Topic Name.")
        @path
        topicName: string;

        @doc("Event Subscription Name.")
        @path
        eventSubscriptionName: string;

        @doc("Max Events count to be received.")
        @query
        maxEvents: int32;

        // TODO: this does not seem to be implemented.
        @doc("Timeout in seconds.")
        @query
        timeout: int32;
    }, ReceiveResponse >;

    // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:acknowledge&apiVersion={apiVersion}

    @doc("Acknowledge Cloud Events.")
    @route("/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:acknowledge", { shared: true})
    @post op AcknowledgeBatchOfCloudEvents is Azure.Core.RpcOperation<{
      @doc("content type")
      @header("content-type")
      contentType: "application/json; charset=utf-8";

      @doc("Topic Name.")
      @path
      topicName: string;

      @doc("Event Subscription Name.")
      @path
      eventSubscriptionName: string;

      @doc("Array of LockTokens for the corresponding received Cloud Events to be acknowledged.")
      @body
      lockTokens: string[];
  }, LockTokensResponse >;

  // POST https://{namespaceName}.{region}.eventgrid.azure.net/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:release?api-version={apiVersion}
  
  @doc("Release Cloud Events.")
  @route("/topics/{topicName}/eventsubscriptions/{eventSubscriptionName}:release", { shared: true})
  @post op ReleaseBatchOfCloudEvents is Azure.Core.RpcOperation<{
    @doc("content type")
    @header("content-type")
    contentType: "application/json; charset=utf-8";

    @doc("Topic Name.")
    @path
    topicName: string;

    @doc("Event Subscription Name.")
    @path
    eventSubscriptionName: string;

    @doc("Array of LockTokens for the corresponding received Cloud Events to be acknowledged.")
    @body    
    // TODO: is it possible to have array of values without property name?
    tokens : LockToken[];
  }, LockTokensResponse >;
}

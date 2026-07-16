import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

enum ServiceApiVersions {
  v2018_01_01: "2018-01-01",
}

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
  title: "EventGridClient",
  version: "2018-01-01",
})
@server(
  "{endpoint}",
  "The host name of the topic",
  {
    @doc("The host name of the topic, e.g. topic1.westus2-1.eventgrid.azure.net")
    endpoint: url,
  }
)

@doc("Azure EventGrid Client")
@versioned(ServiceApiVersions)
namespace EventGrid {
  using TypeSpec.Http;
  using TypeSpec.Rest;
  using TypeSpec.Versioning;
  using Azure.Core;
  using Azure.Core.Foundations;

  @doc("Properties of an event published to an Event Grid topic using the EventGrid Schema.")
  model EventGridEvent {
    @doc("An unique identifier for the event.")
    id: string;

    @doc("The resource path of the event source.")
    topic?: string;

    @doc("A resource path relative to the topic path.")
    subject: string;

    @doc("Event data specific to the event type.")
    data: object;

    @doc("The type of the event that occurred.")
    eventType: string;

    @doc("The time (in UTC) the event was generated.")
    eventTime: zonedDateTime;

    @doc("The schema version of the event metadata.")
    @visibility("read")
    metadataVersion?: string;

    @doc("The schema version of the data object.")
    dataVersion: string;
  }

  @doc("Properties of an event published to an Event Grid topic using the CloudEvent 1.0 Schema")
  model CloudEventEvent {
    @doc("An identifier for the event. The combination of id and source must be unique for each distinct event.")
    id: string;

    @doc("Identifies the context in which an event happened. The combination of id and source must be unique for each distinct event.")
    source: string;

    @doc("Event data specific to the event type.")
    data?: object;

    @doc("Event data specific to the event type, encoded as a base64 string.")
    data_base64?: bytes;

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

  @doc("Properties of an event published to an Event Grid topic using a custom schema")
  model CustomEventEvent {}

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.EventGrid.SubscriptionValidationEvent event.")
  model SubscriptionValidationEventData {
    @doc("The validation code sent by Azure Event Grid to validate an event subscription. To complete the validation handshake, the subscriber must either respond with this validation code as part of the validation response, or perform a GET request on the validationUrl (available starting version 2018-05-01-preview).")
    @visibility("read")
    validationCode?: string;

    @doc("The validation URL sent by Azure Event Grid (available starting version 2018-05-01-preview). To complete the validation handshake, the subscriber must either respond with the validationCode as part of the validation response, or perform a GET request on the validationUrl (available starting version 2018-05-01-preview).")
    @visibility("read")
    validationUrl?: string;
  }

  @doc("To complete an event subscription validation handshake, a subscriber can use either the validationCode or the validationUrl received in a SubscriptionValidationEvent. When the validationCode is used, the SubscriptionValidationResponse can be used to build the response.")
  model SubscriptionValidationResponse {
    @doc("The validation response sent by the subscriber to Azure Event Grid to complete the validation of an event subscription.")
    validationResponse?: string;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.EventGrid.SubscriptionDeletedEvent event.")
  model SubscriptionDeletedEventData {
    @doc("The Azure resource ID of the deleted event subscription.")
    @visibility("read")
    eventSubscriptionId?: string;
  }

 // USE SHARED ROUTES

  alias EventType = EventGridEvent[] | CloudEventEvent[];

  @doc("Publish CloudEvents")
  @route("/send", { shared: true})
  op PublishCloudEvent is Azure.Core.RpcOperation<{
    
    @doc("content type")
    @header("content-type")
    contentType: "application/cloudevents-batch+json; charset=utf-8",

    @doc("Required only when publishing to partner namespaces with partner topic routing mode ChannelNameHeader.")
    @header("aeg-channel-name")
    channelName?: string,

    @doc("Events being published.")
    @body
    events: CloudEventEvent[],
  }, {} >;

  @doc("Publish EventGridEvents")
  @route("/send", { shared: true})
  op PublishEventGridEvent is Azure.Core.RpcOperation<{
    @doc("content type")
    @header("content-type")
    contentType: "application/json",

    @doc("Events being published.")
    @body
    events: EventGridEvent[],
  }, {} >;

}


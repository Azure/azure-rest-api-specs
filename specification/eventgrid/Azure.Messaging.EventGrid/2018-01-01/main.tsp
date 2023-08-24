import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

@useAuth({
  type: AuthType.http,
  scheme: "SharedAccessKey",
})
@service({
  title: "EventGridClient",
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
namespace EventGrid;
  using TypeSpec.Http;
  using TypeSpec.Rest;
  using TypeSpec.Versioning;
  using Azure.Core;
  using Azure.Core.Foundations;

  @doc("The API version of the EventGrid service.")
  enum ServiceApiVersions {
    @doc("2018-01-01")
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    v2018_01_01: "2018-01-01",
  }

  @doc("Properties of an event published to an Event Grid topic using the EventGrid Schema.")
  model EventGridEvent {
    @doc("An unique identifier for the event.")
    id: string;

    @doc("The resource path of the event source.")
    topic?: string;

    @doc("A resource path relative to the topic path.")
    subject: string;

    @doc("Event data specific to the event type.")
    data: unknown;

    @doc("The type of the event that occurred.")
    eventType: string;

    @doc("The time (in UTC) the event was generated.")
    eventTime: utcDateTime;

    @doc("The schema version of the event metadata.")
    @visibility("read")
    metadataVersion?: string;

    @doc("The schema version of the data object.")
    dataVersion: string;
  }

  @doc("Properties of an event published to an Azure Messaging EventGrid Namespace topic using the CloudEvent 1.0 Schema.")
  model CloudEventEvent {
    @doc("An identifier for the event. The combination of id and source must be unique for each distinct event.")
    id: string;

    @doc("Identifies the context in which an event happened. The combination of id and source must be unique for each distinct event.")
    source: string;

    #suppress "@azure-tools/typespec-azure-core/no-unknown" "Using 'unknown' for data is intentional. Following CloudEvent spec."
    @doc("Event data specific to the event type.")
    data?: unknown;

    #suppress "@azure-tools/typespec-azure-core/casing-style" "Using 'data_base64' is intentional. Following CloudEvent spec."
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

  @doc("Properties of an event published to an Event Grid topic using a custom schema")
  model CustomEventEvent {}

  // USE SHARED ROUTES

  @doc("Publish CloudEvents")
  @route("/send")
  @sharedRoute
  op publishCloudEvent is Azure.Core.RpcOperation<
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/cloudevents-batch+json; charset=utf-8";

      @doc("Required only when publishing to partner namespaces with partner topic routing mode ChannelNameHeader.")
      @header("aeg-channel-name")
      channelName?: string;

      #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Events is a valid request body."
      @doc("Events being published.")
      @body
      events: CloudEventEvent[];
    },
    {}
  >;

  @doc("Publish EventGridEvents")
  @route("/send")
  @sharedRoute
  op publishEventGridEvent is Azure.Core.RpcOperation<
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/json";

      #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Events is a valid request body."
      @doc("Events being published.")
      @body
      events: EventGridEvent[];
    },
    {}
  >;

  @doc("Publish custom events")
  @route("/send")
  @sharedRoute
  op publishCustomEvent is Azure.Core.RpcOperation<
    {
      @doc("content type")
      @header("content-type")
      contentType: "application/json";

      #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Events is a valid request body."
      @doc("Events being published.")
      @body
      events: CustomEventEvent[];
    },
    {}
  >;
  
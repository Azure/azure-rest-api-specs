import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace AzureCommunicationMessagesService;

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface TemplateOperations {
  @summary("List all templates for given ACS channel")
  @doc("List all templates for given ACS channel")
  @route("/messages/channels/{channelId}/templates")
  @tag("Template")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The registration ID of the channel.")
      @path 
      channelId: uuid;
      
      @doc("The max page size.")
      @query 
      maxPageSize?: int32;
    },
    ListTemplatesResponse
  >;
}

interface NotificationMessagesOperations {
  @summary("Sends a notification message from Business to User.")
  @doc("Sends a notification message from Business to User.")
  @route("/messages/notifications/:send")
  @tag("Notifications")
  @post
  sendMessage is Azure.Core.Foundations.Operation<
    {
      @doc("Details of the message to send.")
      @body 
      body: SendNotificationRequest;

      @header("Repeatability-Request-ID")
      @doc("An opaque, globally-unique, client-generated string identifier for the request.")
      repeatabilityRequestId?: string;
    
      @doc("Specifies the date and time at which the request was first created.")
      @header("Repeatability-First-Sent")
      repeatabilityFirstSent?: utcDateTime;
    },
    AcceptedResponse & SendMessageResult
  >;
}

interface StreamOperations {
  @summary("Download the Media payload from a User to Business message.")
  @doc("Download the Media payload from a User to Business message.")
  @route("/messages/streams/{id}")
  @tag("Stream")
  @get
  downloadMedia is Azure.Core.Foundations.Operation<
    {
      @doc("The Media Identifier contained in the User to Business message event.")
      @path
      id: string;
    },
    {
      @body 
      content: bytes;
      @header 
      contentType: "application/octet-stream";
    }
  >;
}


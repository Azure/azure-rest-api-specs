import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@versioned(AzureCommunicationMessagesService.Versions)
namespace AzureCommunicationMessagesService;

@access(Access.public, "csharp")
@doc("The type of message. Supports text, image, template.")
enum CommunicationMessageType {
  @doc("Text message type.")
  text,

  @doc("Image message type.")
  image,

  @doc("Template message type.")
  template,
}

@access(Access.public, "csharp")
@doc("The WhatsApp button sub type.")
enum WhatsAppMessageTemplateValueSubType {
  @doc("The WhatsApp button sub type is quick reply.")
  quickReply,

  @doc("The WhatsApp button sub type is url.")
  url,
}

@access(Access.public, "csharp")
@doc("The aggregated template status.")
enum MessageTemplateStatus {
  @doc("Message template is approved.")
  approved,

  @doc("Message template is rejected.")
  rejected,

  @doc("Message template is pending.")
  pending,

  @doc("Message template is paused.")
  paused,
}

@discriminator("kind")
@doc("Details of the message to send.")
model SendNotificationRequest {
  @doc("The Channel Registration ID for the Business Identifier.")
  channelRegistrationId: uuid;

  @doc("The native external platform user identifiers of the recipient.")
  to: string[];
}

@doc("A request to send a text notification.")
model SendTextNotificationRequest extends SendNotificationRequest {
  @doc("Message notification type is text.")
  kind: "text";

  @doc("Message content.")
  content: string;
}

@doc("A request to send a media notification.")
model SendMediaNotificationRequest extends SendNotificationRequest {
  @doc("Message notification type is image.")
  kind: "image";

  @doc("Message content.")
  content?: string;

  @doc("""
A media url for the file. Required if the type is one of the supported media
types, e.g. image
""")
  mediaUri: url;
}

@doc("A request to send a template notification.")
model SendTemplateNotificationRequest extends SendNotificationRequest {
  @doc("Message notification type is template.")
  kind: "template";

  @doc("The template object used to create templates.")
  template: MessageTemplate;
}

@access(Access.public, "csharp")
@doc("The template object used to create templates.")
model MessageTemplate {
  @doc("Name of the template.")
  name: string;

  @doc("The codes for the supported languages for templates.")
  language: string;

  @doc("The template values.")
  values?: MessageTemplateValue[];

  @doc("The binding object to link values to the template specific locations")
  bindings?: MessageTemplateBindings;
}

@access(Access.public, "csharp")
@discriminator("kind")
@doc("The class describes a parameter of a template.")
model MessageTemplateValue {
  @doc("Name of the Template value")
  name: string;
}

@access(Access.public, "csharp")
@doc("The message template's text value information.")
model MessageTemplateText extends MessageTemplateValue {
  @doc("Message parameter type is text.")
  kind: "text";

  @doc("The text value.")
  text: string;
}

@access(Access.public, "csharp")
@doc("""
The message template's media value information.
Could be an image, document or
video.
""")
model MessageTemplateMedia {
  @doc("The (public) URL of the media.")
  url: url;

  @doc("The [optional] caption of the media object.")
  caption?: string;

  @doc("The [optional] filename of the media file.")
  fileName?: string;
}

@doc("The message template's image value information.")
@access(Access.public, "csharp")
model MessageTemplateImage extends MessageTemplateValue {
  @doc("Message parameter type is image.")
  kind: "image",
  ...MessageTemplateMedia
}

@doc("The message template's document value information.")
@access(Access.public, "csharp")
model MessageTemplateDocument extends MessageTemplateValue {
  @doc("Message parameter type is document.")
  kind: "document",
  ...MessageTemplateMedia
}

@doc("The message template's video value information.")
@access(Access.public, "csharp")
model MessageTemplateVideo extends MessageTemplateValue {
  @doc("Message parameter type is video.")
  kind: "video",
  ...MessageTemplateMedia
}

@access(Access.public, "csharp")
@doc("The message template's location value information.")
model MessageTemplateLocation extends MessageTemplateValue {
  @doc("Message parameter type is location.")
  kind: "location";

  @doc("The [Optional] name of the location.")
  locationName?: string;

  @doc("The [Optional] address of the location.")
  address?: string;

  @doc("The latitude of the location.")
  latitude?: float64;

  @doc("The longitude of the location.")
  longitude?: float64;
}

@access(Access.public, "csharp")
@doc("The message template's quick action value information.")
model MessageTemplateQuickAction extends MessageTemplateValue {
  @doc("Message parameter type is quick action.")
  kind: "quickAction";

  @doc("The [Optional] quick action text")
  text?: string;

  @doc("The [Optional] quick action payload")
  payload?: string;
}

@access(Access.public, "csharp")
@discriminator("kind")
@doc("The binding object to link values to the template specific locations")
model MessageTemplateBindings {
}

@access(Access.public, "csharp")
@doc("The template bindings for WhatsApp")
model WhatsAppMessageTemplateBindings extends MessageTemplateBindings {
  @doc("MessageTemplateBindings is whatsApp")
  kind: "whatsApp";

  @doc("The header template bindings")
  header?: WhatsAppMessageTemplateBindingsComponent[];

  @doc("The body template bindings")
  body?: WhatsAppMessageTemplateBindingsComponent[];

  @doc("The footer template bindings")
  footer?: WhatsAppMessageTemplateBindingsComponent[];

  @doc("The button template bindings")
  button?: WhatsAppMessageTemplateBindingsButton[];
}

@access(Access.public, "csharp")
@doc("The template bindings component for WhatsApp")
model WhatsAppMessageTemplateBindingsComponent {
  @doc("""
The reference to the value in the
Microsoft.Azure.Communication.CrossPlatformMessages.Contract.Model.VNext.Notifications.Requests.MessageTemplate.Values
dictionary.
""")
  refValue: string;
}

@access(Access.public, "csharp")
@doc("The template bindings component button for WhatsApp")
model WhatsAppMessageTemplateBindingsButton {
  @doc("The WhatsApp button sub type")
  subType?: WhatsAppMessageTemplateValueSubType;

  @doc("""
The reference to the value in the
Microsoft.Azure.Communication.CrossPlatformMessages.Contract.Model.VNext.Notifications.Requests.MessageTemplate.Values
dictionary.
""")
  refValue: string;
}

@access(Access.public, "csharp")
@doc("Result of the send message operation.")
model SendMessageResult {
  @doc("Receipts of the send message operation.")
  receipts: MessageReceipt[];
}

@access(Access.public, "csharp")
@doc("Receipt of the sending one message.")
model MessageReceipt {
  @doc("The message id.")
  messageId: string;

  @doc("The native external platform user identifier of the recipient.")
  to: string;
}

@access(Access.public, "csharp")
@doc("The WhatsApp-specific template response contract")
model WhatsAppMessageTemplateResponse extends MessageTemplateResponse{
  @doc("""
WhatsApp platform's template content
This is the payload returned from WhatsApp
API.
""")
  content?: unknown;

  @doc("Message template response type is whatsApp.")
  kind: "whatsApp";
}

@resource("messages/notifications")
@doc("A notification.")
model Notifications {
  @key
  @visibility("read")
  @doc("The notification ID.")
  id: string;
}

@resource("messages/channels")
@doc("A communication channel.")
model CommunicationChannel {
  @key
  @visibility("read")
  @doc("The registration ID of the channel.")
  channelId: string;
}

@resource("messages/streams")
@doc("A data stream.")
model Stream {
  @key
  @visibility("read")
  @doc("The stream ID.")
  id: string;
  @body
  @doc("The stream body.")
  body: bytes;
  @header 
  @doc("The stream content type.")
  contentType: "application/octet-stream";
}

@access(Access.public, "csharp")
@resource("templates")
@parentResource(CommunicationChannel)
@discriminator("kind")
@doc("The Message Template Response.")
model MessageTemplateResponse {
  @key
  @visibility("read")
  @doc("Get the template's Name")
  name: string;

  @doc("Get the template's language")
  language: string;

  @doc("The aggregated template status.")
  status: MessageTemplateStatus;
}


@doc("Azure Communication Messages Versions")
enum Versions {
  @doc("Azure Communication Messages 2024-02-01 api version")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  c2024_02_01: "2024-02-01",
}
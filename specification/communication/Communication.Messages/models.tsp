import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Azure.Communication.MessagesService.Versions)
namespace Azure.Communication.MessagesService;

@doc("The type of message. Supports text, image, template.")
union CommunicationMessageKind {
  string,

  @doc("Text message type.")
  text: "text",

  @doc("Image message type.")
  image: "image",

  @doc("Template message type.")
  template: "template",
}

@doc("The WhatsApp button sub type.")
union WhatsAppMessageButtonSubType {
  string,

  @doc("The WhatsApp button sub type is quick reply.")
  quickReply: "quickReply",

  @doc("The WhatsApp button sub type is url.")
  url: "url",
}

@doc("The aggregated template status.")
union MessageTemplateStatus {
  string,

  @doc("Message template is approved.")
  approved: "approved",

  @doc("Message template is rejected.")
  rejected: "rejected",

  @doc("Message template is pending.")
  pending: "pending",

  @doc("Message template is paused.")
  paused: "paused",
}

@doc("The type of the template parameter.")
union MessageTemplateValueKind {
  string,

  @doc("The text template parameter type.")
  text: "text",

  @doc("The image template parameter type.")
  image: "image",

  @doc("The document template parameter type.")
  document: "document",

  @doc("The video template parameter type.")
  video: "video",

  @doc("The location template parameter type.")
  location: "location",

  @doc("The quick action template parameter type.")
  quickAction: "quickAction",
}

@doc("The type of the communication messages channel.")
union CommunicationMessagesChannel {
  string,

  @doc("The WhatsApp communication messages channel type.")
  whatsApp: "whatsApp",
}

@doc("The type of the message template.")
union MessageTemplateBindingsKind {
  string,

  @doc("The WhatsApp template type.")
  whatsApp: "whatsApp",
}

@discriminator("kind")
@doc("Details of the message to send.")
model NotificationContent {
  @doc("The Channel Registration ID for the Business Identifier.")
  channelRegistrationId: uuid;

  @doc("The native external platform user identifiers of the recipient.")
  to: string[];

  @doc("The type discriminator describing a notification type.")
  kind: CommunicationMessageKind;
}

@doc("A request to send a text notification.")
model TextNotificationContent extends NotificationContent {
  @doc("Message notification type is text.")
  kind: CommunicationMessageKind.text;

  @doc("Message content.")
  content: string;
}

@doc("A request to send a media notification.")
model MediaNotificationContent extends NotificationContent {
  @doc("Message notification type is image.")
  kind: CommunicationMessageKind.image;

  @doc("Optional text content.")
  content?: string;

  @clientName("mediaUrl", "java")
  @doc("A media url for the file. Required if the type is one of the supported media types, e.g. image")
  mediaUri: url;
}

@doc("A request to send a template notification.")
model TemplateNotificationContent extends NotificationContent {
  @doc("Message notification type is template.")
  kind: CommunicationMessageKind.template;

  @doc("The template object used to create templates.")
  template: MessageTemplate;
}

@doc("The template object used to create templates.")
model MessageTemplate {
  @doc("Name of the template.")
  name: string;

  @doc("The template's language, in the ISO 639 format, consist of a two-letter language code followed by an optional two-letter country code, e.g., 'en' or 'en_US'.")
  language: string;

  @doc("The template values.")
  values?: MessageTemplateValue[];

  @doc("The binding object to link values to the template specific locations")
  bindings?: MessageTemplateBindings;
}

@discriminator("kind")
@doc("The class describes a parameter of a template.")
model MessageTemplateValue {
  @doc("Template binding reference name")
  @clientName("refValue", "java")
  name: string;

  @doc("The type discriminator describing a template parameter type.")
  kind: MessageTemplateValueKind;
}

@doc("The message template's text value information.")
model MessageTemplateText extends MessageTemplateValue {
  @doc("Message parameter type is text.")
  kind: MessageTemplateValueKind.text;

  @doc("The text value.")
  text: string;
}

@doc("The message template's media value information. Could be an image, document or video.")
model MessageTemplateMedia {
  @clientName("uri", "csharp")
  @doc("The (public) URL of the media.")
  url: url;

  @doc("The [optional] caption of the media object.")
  caption?: string;

  @doc("The [optional] filename of the media file.")
  fileName?: string;
}

@doc("The message template's image value information.")
model MessageTemplateImage extends MessageTemplateValue {
  @doc("Message parameter type is image.")
  kind: MessageTemplateValueKind.image;

  ...MessageTemplateMedia;
}

@doc("The message template's document value information.")
model MessageTemplateDocument extends MessageTemplateValue {
  @doc("Message parameter type is document.")
  kind: MessageTemplateValueKind.document;

  ...MessageTemplateMedia;
}

@doc("The message template's video value information.")
model MessageTemplateVideo extends MessageTemplateValue {
  @doc("Message parameter type is video.")
  kind: MessageTemplateValueKind.video;

  ...MessageTemplateMedia;
}

@doc("The message template's location value information.")
model MessageTemplateLocation extends MessageTemplateValue {
  @doc("Message parameter type is location.")
  kind: MessageTemplateValueKind.location;

  @doc("The [Optional] name of the location.")
  locationName?: string;

  @doc("The [Optional] address of the location.")
  address?: string;

  @doc("The latitude of the location.")
  latitude: float64;

  @doc("The longitude of the location.")
  longitude: float64;
}

@doc("The message template's quick action value information.")
model MessageTemplateQuickAction extends MessageTemplateValue {
  @doc("Message parameter type is quick action.")
  kind: MessageTemplateValueKind.quickAction;

  @doc("The [Optional] quick action text")
  text?: string;

  @doc("The [Optional] quick action payload")
  payload?: string;
}

@discriminator("kind")
@doc("The binding object to link values to the template specific locations")
model MessageTemplateBindings {
  @doc("The type discriminator describing a template bindings type.")
  kind: MessageTemplateBindingsKind;
}

@doc("The template bindings for WhatsApp")
model WhatsAppMessageTemplateBindings extends MessageTemplateBindings {
  @doc("MessageTemplateBindings is whatsApp")
  kind: MessageTemplateBindingsKind.whatsApp;

  @doc("The header template bindings")
  header?: WhatsAppMessageTemplateBindingsComponent[];

  @doc("The body template bindings")
  body?: WhatsAppMessageTemplateBindingsComponent[];

  @doc("The footer template bindings")
  footer?: WhatsAppMessageTemplateBindingsComponent[];

  @doc("The button template bindings")
  buttons?: WhatsAppMessageTemplateBindingsButton[];
}

@doc("The template bindings component for WhatsApp")
model WhatsAppMessageTemplateBindingsComponent {
  @doc("The name of the referenced item in the template values.")
  refValue: string;
}

@doc("The template bindings component button for WhatsApp")
model WhatsAppMessageTemplateBindingsButton {
  @doc("The WhatsApp button sub type")
  subType: WhatsAppMessageButtonSubType;

  @doc("The name of the referenced item in the template values.")
  refValue: string;
}

@doc("Result of the send message operation.")
model SendMessageResult {
  @doc("Receipts of the send message operation.")
  receipts: MessageReceipt[];
}

@doc("Receipt of the sending one message.")
model MessageReceipt {
  @doc("The message id.")
  messageId: string;

  @doc("The native external platform user identifier of the recipient.")
  to: string;
}

@doc("The WhatsApp-specific template response contract")
model WhatsAppMessageTemplateItem extends MessageTemplateItem {
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Payload being returned from WhatsApp with no guaranteed object type."
  @doc("WhatsApp platform's template content. This is the payload returned from WhatsApp API.")
  content?: unknown;

  @doc("Message template response type is whatsApp.")
  kind: CommunicationMessagesChannel.whatsApp;
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
  channelId: uuid;
}

@resource("messages/streams")
@doc("A data stream.")
model MessageDataStream {
  @key
  @visibility("none") // this model is only used as a parameter
  @doc("The stream ID.")
  @clientName("mediaId", "java")
  id: string;

  @body
  @doc("The stream body.")
  body: bytes;

  @header
  @doc("The stream content type.")
  contentType: "application/octet-stream";
}

@resource("templates")
@parentResource(CommunicationChannel)
@discriminator("kind")
@doc("The message template as returned from the service.")
model MessageTemplateItem {
  @key
  @visibility("read")
  @doc("The template's name.")
  name: string;

  @doc("The template's language, in the ISO 639 format, consist of a two-letter language code followed by an optional two-letter country code, e.g., 'en' or 'en_US'.")
  language: string;

  @doc("The aggregated template status.")
  status: MessageTemplateStatus;

  @doc("The type discriminator describing a template type.")
  kind: CommunicationMessagesChannel;
}

alias ListTemplatesQueryParams = ListQueryParametersTrait<{
  @doc("Number of objects to return per page.")
  @query
  maxpagesize?: int32;
}>;

@doc("Azure Communication Messages Versions")
enum Versions {
  @doc("Azure Communication Messages 2024-02-01 api version")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  c2024_02_01: "2024-02-01",
}

@doc("Notification messages send request body.")
model NotificationMessagesSendRequestBody {
  @doc("Details of the message to send.")
  @bodyRoot
  body: NotificationContent;
}

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

@doc("The type of message.")
union CommunicationMessageKind {
  string,

  @doc("Text message type.")
  text: "text",

  @doc("Image message type.")
  image: "image",

  @added(Versions.c2024_08_30)
  @doc("Image message type. Legacy image type for `MediaNotificationContent` which is being deprecated")
  image_v0: "image_v0",

  @added(Versions.c2024_08_30)
  @doc("Document message type.")
  document: "document",

  @added(Versions.c2024_08_30)
  @doc("Video message type.")
  video: "video",

  @added(Versions.c2024_08_30)
  @doc("Audio message type.")
  audio: "audio",

  @doc("Template message type.")
  template: "template",

  @added(Versions.c2025_01_15_Preview)
  @doc("Sticker message type.")
  sticker: "sticker",

  @added(Versions.c2025_01_15_Preview)
  @doc("Reaction message type.")
  reaction: "reaction",

  @added(Versions.c2025_01_15_Preview)
  @doc("Interactive Actionable message type.")
  interactive: "interactive",
}

@added(Versions.c2025_01_15_Preview)
@doc("The Kind of interactive message channel action binding like WhatsAppListAction.")
union MessageActionBindingKind {
  string,

  @doc("The WhatsApp List action binding kind.")
  whatsAppListAction: "whatsAppListAction",

  @doc("The WhatsApp Button action binding kind.")
  whatsAppButtonAction: "whatsAppButtonAction",

  @doc("The WhatsApp Url action binding kind.")
  whatsAppUrlAction: "whatsAppUrlAction",
}

@added(Versions.c2025_01_15_Preview)
@doc("The kind of Interactive message content.")
union MessageContentKind {
  string,

  @doc("The text content type.")
  text: "text",

  @doc("The image content type.")
  image: "image",

  @doc("The video content type.")
  video: "video",

  @doc("The document content type.")
  document: "document",

  @doc("The ActionSet content type.")
  group: "group",

  @doc("The ButtonSet content type.")
  buttonSet: "buttonSet",

  @doc("The Url content type.")
  url: "url",
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

@added(Versions.c2024_08_30)
@doc("A request to send a media notification. Could be an image, document or video.")
model MediaNotificationContentBase {
  @clientName("mediaUrl", "java")
  @doc("A media url for the file. Required if the type is one of the supported media types, e.g. image")
  mediaUri: url;
}

#deprecated "`MediaNotificationContent` is being deprecated, we encourage you to use the new `ImageNotificationContent` for sending images instead."
@access(Access.internal, "python")
@added(Versions.c2024_08_30)
@doc("@deprecated A request to send an image notification.")
model MediaNotificationContent extends NotificationContent {
  @doc("Message notification type is image.")
  kind: CommunicationMessageKind.image_v0;

  @doc("Optional text content.")
  content?: string;

  ...MediaNotificationContentBase;
}

@renamedFrom(Versions.c2024_08_30, "MediaNotificationContent")
@doc("A request to send an image notification.")
model ImageNotificationContent extends NotificationContent {
  @doc("Message notification type is image.")
  kind: CommunicationMessageKind.image;

  @renamedFrom(Versions.c2024_08_30, "content")
  @clientName("content", "python")
  @doc("Optional text content.")
  caption?: string;

  ...MediaNotificationContentBase;
}

@added(Versions.c2024_08_30)
@doc("A request to send a document notification.")
model DocumentNotificationContent extends NotificationContent {
  @doc("Message notification type is image.")
  kind: CommunicationMessageKind.document;

  @doc("Optional text content.")
  caption?: string;

  @doc("Optional name for the file.")
  fileName?: string;

  ...MediaNotificationContentBase;
}

@added(Versions.c2024_08_30)
@doc("A request to send a video notification.")
model VideoNotificationContent extends NotificationContent {
  @doc("Message notification type is image.")
  kind: CommunicationMessageKind.video;

  @doc("Optional text content.")
  caption?: string;

  ...MediaNotificationContentBase;
}

@added(Versions.c2024_08_30)
@doc("A request to send an audio notification.")
model AudioNotificationContent extends NotificationContent {
  @doc("Message notification type is audio.")
  kind: CommunicationMessageKind.audio;

  ...MediaNotificationContentBase;
}

@added(Versions.c2025_01_15_Preview)
@doc("A request to send a Reaction notification.")
model ReactionNotificationContent extends NotificationContent {
  @doc("Message notification type is reaction.")
  kind: CommunicationMessageKind.reaction;

  @doc("emoji content like \\uD83D\\uDE00.")
  emoji: string;

  @doc("ID of the previous message you want to reply to.")
  messageId: string;
}

@added(Versions.c2025_01_15_Preview)
@doc("A request to send a Sticker notification.")
model StickerNotificationContent extends NotificationContent {
  @doc("Message notification type is sticker.")
  kind: CommunicationMessageKind.sticker;

  ...MediaNotificationContentBase;
}

@added(Versions.c2025_01_15_Preview)
@doc("A request to send an Interactive message notification.")
model InteractiveNotificationContent extends NotificationContent {
  @doc("Message notification type is Interactive.")
  kind: CommunicationMessageKind.interactive;

  @doc("The interactive message content.")
  interactiveMessage: InteractiveMessage;
}

@added(Versions.c2025_01_15_Preview)
@doc("The Interactive message content to which user can read and respond.")
model InteractiveMessage {
  @doc("Gets or Sets Header content. Supports the following types:text, images etc.")
  header?: MessageContent;

  @doc("Gets or Sets Message body content. Emojis, markdown, and links are supported.")
  body: TextMessageContent;

  @doc("Gets or Sets Message footer content. Emojis, markdown, and links are supported.")
  footer?: TextMessageContent;

  @doc("The binding object to get or set Action which describes options user have to respond to message.")
  action: ActionBindings;
}

@added(Versions.c2025_01_15_Preview)
@discriminator("kind")
@doc("The message content object used to create interactive messages components.")
model MessageContent {
  @doc("Kind of MessageContent.")
  kind: MessageContentKind;
}

@added(Versions.c2025_01_15_Preview)
@doc("The message content of type text information.")
model TextMessageContent extends MessageContent {
  @doc("Message content kind is text.")
  kind: MessageContentKind.text;

  @doc("The text value.")
  text: string;
}

@added(Versions.c2025_01_15_Preview)
@doc("The message content of type document information.")
model DocumentMessageContent extends MessageContent {
  @doc("Message content kind is document.")
  kind: MessageContentKind.document;

  ...MediaMessageContent;
}

@added(Versions.c2025_01_15_Preview)
@doc("The message content of type image information.")
model ImageMessageContent extends MessageContent {
  @doc("Message content kind is image.")
  kind: MessageContentKind.image;

  ...MediaMessageContent;
}

@added(Versions.c2025_01_15_Preview)
@doc("The message content of type video information.")
model VideoMessageContent extends MessageContent {
  @doc("Message content kind is video.")
  kind: MessageContentKind.video;

  ...MediaMessageContent;
}

@added(Versions.c2025_01_15_Preview)
@doc("The message content of type Button information.")
model ButtonContent {
  @doc("Unique Id of the button content.")
  id: string;

  @doc("Title of the button content.")
  title: string;
}

@added(Versions.c2025_01_15_Preview)
@doc("The message content of type ButtonSet/ List of buttons information.")
model ButtonSetContent extends MessageContent {
  @doc("Message content kind is Button.")
  kind: MessageContentKind.buttonSet;

  @doc("Unique Id of the button content.")
  buttons: ButtonContent[];
}

@added(Versions.c2025_01_15_Preview)
@doc("The message content of type Url information.")
model LinkContent extends MessageContent {
  @doc("Message content kind is url.")
  kind: MessageContentKind.url;

  @doc("Title of the url content.")
  title: string;

  @doc("The url in the content.")
  url: url;
}

@added(Versions.c2025_01_15_Preview)
@doc("The action content of type ActionGroup.")
model ActionGroupContent extends MessageContent {
  @doc("Message content kind is actionGroup.")
  kind: MessageContentKind.group;

  @doc("Title of the actionGroup content.")
  title: string;

  @doc("Set or group of actions.")
  groups: ActionGroup[];
}

@added(Versions.c2025_01_15_Preview)
@doc("The Action Group content.")
model ActionGroup {
  @doc("Title of the ActionGroup.")
  title: string;

  @doc("Array of items in ActionGroup.")
  items: ActionGroupItem[];
}

@added(Versions.c2025_01_15_Preview)
@doc("The Action group item in the content.")
model ActionGroupItem {
  @doc("Id of the Item.")
  id: string;

  @doc("Title of the Item.")
  title: string;

  @doc("Description of the Item.")
  description: string;
}

@added(Versions.c2025_01_15_Preview)
@doc("The media content.")
model MediaMessageContent {
  @doc("MediaUri of the media content.")
  mediaUri: url;
}

@added(Versions.c2025_01_15_Preview)
@discriminator("kind")
@doc("Binding actions to the interactive message.")
model ActionBindings {
  @doc("Kind of the MessageActionBinding.")
  kind: MessageActionBindingKind;
}

@added(Versions.c2025_01_15_Preview)
@doc("WhatsApp List Binding actions to the interactive message.")
model WhatsAppListActionBindings extends ActionBindings {
  @doc("Message action binding type is WhatsAppListAction.")
  kind: MessageActionBindingKind.whatsAppListAction;

  @doc("Action content of Interactive message.")
  content: ActionGroupContent;
}

@added(Versions.c2025_01_15_Preview)
@doc("WhatsApp Binding actions to the interactive message.")
model WhatsAppButtonActionBindings extends ActionBindings {
  @doc("Message action binding type is WhatsAppButtonAction.")
  kind: MessageActionBindingKind.whatsAppButtonAction;

  @doc("Action content of Interactive message.")
  content: ButtonSetContent;
}

@added(Versions.c2025_01_15_Preview)
@doc("WhatsApp Binding actions to the interactive message.")
model WhatsAppUrlActionBindings extends ActionBindings {
  @doc("Message action binding type is WhatsAppUrlAction.")
  kind: MessageActionBindingKind.whatsAppUrlAction;

  @doc("Action content of Interactive message.")
  content: LinkContent;
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
  @visibility(Lifecycle.Read)
  @doc("The notification ID.")
  id: string;
}

@resource("messages/channels")
@doc("A communication channel.")
model CommunicationChannel {
  @key
  @visibility(Lifecycle.Read)
  @doc("The registration ID of the channel.")
  channelId: uuid;
}

@resource("messages/streams")
@doc("A data stream.")
model MessageDataStream {
  @key
  @path
  @invisible(Lifecycle) // The stream ID is only used as a parameter.
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
  @visibility(Lifecycle.Read)
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

@doc("Notification messages send request body.")
model NotificationMessagesSendRequestBody {
  @doc("Details of the message to send.")
  @bodyRoot
  body: NotificationContent;
}

@doc("Azure Communication Messages Versions")
enum Versions {
  @doc("Azure Communication Messages 2024-02-01 api version")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  c2024_02_01: "2024-02-01",

  @doc("Azure Communication Messages 2024-08-30 api version")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  c2024_08_30: "2024-08-30",

  @doc("Azure Communication Messages 2025-01-15-preview api version")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  c2025_01_15_Preview: "2025-01-15-preview",
}

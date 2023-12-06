import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(AzureCommunicationMessagesService.Versions)
namespace AzureCommunicationMessagesService;

@doc("The type of message. Supports text, image, template.")
enum CommunicationMessageType {
  @doc("Text message type.")
  text,

  @doc("Image message type.")
  image,

  @doc("Template message type.")
  template,
}

@doc("The template value kind.")
enum MessageTemplateValueKind {
  @doc("Message parameter type is text.")
  text,

  @doc("Message parameter type is image.")
  image,

  @doc("Message parameter type is document.")
  document,

  @doc("Message parameter type is video.")
  video,

  @doc("Message parameter type is location.")
  location,

  @doc("Message parameter type is quick action.")
  quick_action,
}

@doc("The WhatsApp button sub type.")
enum WhatsAppMessageTemplateValueSubType {
  @doc("The WhatsApp button sub type is quick reply.")
  quickReply,

  @doc("The WhatsApp button sub type is url.")
  url,
}

@doc("The Communication Messages Channel.")
enum CommunicationMessagesChannel {
  @doc("The Communication Messages Channel is WhatsApp.")
  whatsApp,
}

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

@doc("Details of the message to send.")
model SendNotificationRequest {
  @doc("The Channel Registration ID for the Business Identifier.")
  channelRegistrationId: uuid;

  @doc("The native external platform user identifiers of the recipient.")
  to: string[];

  @doc("The type of message. Supports text, image, template.")
  type: CommunicationMessageType;

  @doc("Message content.")
  content?: string;

  @doc("""
A media url for the file. Required if the type is one of the supported media
types, e.g. image
""")
  mediaUri?: string;

  @doc("The template object used to create templates.")
  template?: MessageTemplate;
}

@doc("The template object used to create templates.")
model MessageTemplate {
  @doc("Name of the template.")
  name: string;

  @doc("The codes for the supported languages for templates.")
  language: string;

  @doc("The template values.")
  values?: Record<MessageTemplateValue>;

  @doc("The binding object to link values to the template specific locations")
  bindings?: MessageTemplateBindings;
}

@doc("The class describes a parameter of a template.")
model MessageTemplateValue {
  @doc("The template value kind.")
  kind: MessageTemplateValueKind;

  @doc("The message template's text value information.")
  text?: MessageTemplateValueText;

  @doc("""
The message template's media value information.
Could be an image, document or
video.
""")
  image?: MessageTemplateValueMedia;

  @doc("""
The message template's media value information.
Could be an image, document or
video.
""")
  document?: MessageTemplateValueMedia;

  @doc("""
The message template's media value information.
Could be an image, document or
video.
""")
  video?: MessageTemplateValueMedia;

  @doc("The message template's location value information.")
  location?: MessageTemplateParameterLocation;

  @doc("The message template's quick action value information.")
  quickAction?: MessageTemplateValueQuickAction;
}

@doc("The message template's text value information.")
model MessageTemplateValueText {
  @doc("The text value.")
  text: string;
}

@doc("""
The message template's media value information.
Could be an image, document or
video.
""")
model MessageTemplateValueMedia {
  @doc("The (public) URL of the media.")
  url?: url;

  @doc("The [optional] caption of the media object.")
  caption?: string;

  @doc("The [optional] filename of the media file.")
  fileName?: string;
}

@doc("The message template's location value information.")
model MessageTemplateParameterLocation {
  @doc("The [Optional] name of the location.")
  name?: string;

  @doc("The [Optional] address of the location.")
  address?: string;

  @doc("The latitude of the location.")
  latitude?: float64;

  @doc("The longitude of the location.")
  longitude?: float64;
}

@doc("The message template's quick action value information.")
model MessageTemplateValueQuickAction {
  @doc("The [Optional] quick action text")
  text?: string;

  @doc("The [Optional] quick action payload")
  payload?: string;
}

@doc("The binding object to link values to the template specific locations")
model MessageTemplateBindings {
  @doc("The template bindings for WhatsApp")
  whatsApp?: WhatsAppMessageTemplateBindings;
}

@doc("The template bindings for WhatsApp")
model WhatsAppMessageTemplateBindings {
  @doc("The header template bindings")
  header?: WhatsAppMessageTemplateBindingsComponent[];

  @doc("The body template bindings")
  body?: WhatsAppMessageTemplateBindingsComponent[];

  @doc("The footer template bindings")
  footer?: WhatsAppMessageTemplateBindingsComponent[];

  @doc("The button template bindings")
  button?: WhatsAppMessageTemplateBindingsButton[];
}

@doc("The template bindings component for WhatsApp")
model WhatsAppMessageTemplateBindingsComponent {
  @doc("""
The reference to the value in the
Microsoft.Azure.Communication.CrossPlatformMessages.Contract.Model.VNext.Notifications.Requests.MessageTemplate.Values
dictionary.
""")
  refValue: string;
}

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

@pagedResult
@doc("Paged collection of MessageTemplateResponse items")
model ListTemplatesResponse {
  @doc("The MessageTemplateResponse items on this page")
  @items
  value: MessageTemplateResponse[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: string;
}

@doc("The Message Template Response.")
model MessageTemplateResponse {
  @doc("Get the template's Name")
  name?: string;

  @doc("Get the template's language")
  language?: string;

  @doc("The Communication Messages Channel.")
  channelType?: CommunicationMessagesChannel;

  @doc("The aggregated template status.")
  status?: MessageTemplateStatus;

  @doc("The WhatsApp-specific template response contract")
  whatsApp?: WhatsAppMessageTemplateResponse;
}

@doc("The WhatsApp-specific template response contract")
model WhatsAppMessageTemplateResponse {
  @doc("""
WhatsApp platform's template content
This is the payload returned from WhatsApp
API.
""")
  content?: unknown;
}

@doc("Azure Communication Messages Versions")
enum Versions {
  @doc("Azure Communication Messages 2024-02-01 api version")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  c2024_02_01: "2024-02-01",
}
using Azure.Core;

namespace Azure.AI.Projects;

@doc("A page of Foundry resources. The service omits `nextLink` on the final page. When present, `nextLink` is an absolute, opaque URL that includes all parameters required to retrieve the next page.")
model FoundryPagedResult<T> {
  @doc("Resources returned on this page.")
  @pageItems
  value: T[];

  @doc("Absolute URL used to retrieve the next page. Clients must use this URL as returned without constructing or modifying it.")
  @nextLink
  nextLink?: url;
}

@doc("Type discriminator for a multimodal content part used in conversational APIs across Foundry.")
union FoundryMessageContentPartType {
  string,
  input_text: "input_text",
  output_text: "output_text",
  input_image: "input_image",
  output_image: "output_image",
  input_audio: "input_audio",
  output_audio: "output_audio",
}

@doc("Base model for a typed content part in a multimodal message.")
@discriminator("type")
model FoundryMessageContentPart {
  @doc("The content part type.")
  type: FoundryMessageContentPartType;
}

@doc("Text content part types for conversational messages.")
union FoundryTextContentPartType {
  input_text: "input_text",
  output_text: "output_text",
  string,
}

@doc("Text content part for a conversational message.")
model FoundryTextContentPart extends FoundryMessageContentPart {
  @doc("The content part type. Must be `input_text` or `output_text`.")
  type: FoundryTextContentPartType;

  @doc("The text payload for this content part.")
  text: string;
}

@doc("Generic conversational message shape that can be reused across Foundry APIs.")
model FoundryMessage {
  @doc("Role for the message in the conversation.")
  role: string;

  @doc("Multimodal content for the message. The content can contain one or more typed parts such as text, images, or audio.")
  content: FoundryMessageContentPart[];
}

@doc("Reference to a Foundry dataset. At least one of `id` or `name` must be supplied.")
model FoundryDatasetReference {
  @doc("Optional dataset identifier. At least one of `id` or `name` must be supplied.")
  id?: string;

  @doc("Optional dataset name. At least one of `id` or `name` must be supplied.")
  name?: string;

  @doc("Optional dataset version identifier.")
  version?: string;
}

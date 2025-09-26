import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace VoiceLive;

union ContentPartType {
  string,
  input_text: "input_text",
  input_audio: "input_audio",
  text: "text",
  audio: "audio",
}

@discriminator("type")
@doc("Base for any content part; discriminated by `type`.")
model ContentPart {
  type: ContentPartType;
}

@usage(RequestUsage)
@doc("A text content part for a request.")
model RequestTextContentPart extends ContentPart {
  type: ContentPartType.input_text;
  text?: string;
}

@usage(RequestUsage)
@doc("An audio content part for a request.")
model RequestAudioContentPart extends ContentPart {
  type: ContentPartType.input_audio;
  transcript?: string;
}

@usage(ResponseUsage)
@doc("A text content part for a response.")
model ResponseTextContentPart extends ContentPart {
  type: ContentPartType.text;
  text?: string;
}

@usage(ResponseUsage)
@doc("An audio content part for a response.")
model ResponseAudioContentPart extends ContentPart {
  type: ContentPartType.audio;
  transcript?: string;
}

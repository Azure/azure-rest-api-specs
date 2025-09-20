import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.OpenAPI;

namespace VoiceLive;

union ContentPartType {
  string,
  input_text: "input_text",
  input_audio: "input_audio",
  text: "text",
  audio: "audio",
}

@discriminator("type")
model ContentPart {
  type: ContentPartType;
}

@usage(RequestUsage)
model RequestTextContentPart extends ContentPart {
  type: ContentPartType.input_text;
  text?: string;
}

@usage(RequestUsage)
model RequestAudioContentPart extends ContentPart {
  type: ContentPartType.input_audio;
  transcript?: string;
}

@usage(ResponseUsage)
model ResponseTextContentPart extends ContentPart {
  type: ContentPartType.text;
  text?: string;
}

@usage(ResponseUsage)
model ResponseAudioContentPart extends ContentPart {
  type: ContentPartType.audio;
  transcript?: string;
}

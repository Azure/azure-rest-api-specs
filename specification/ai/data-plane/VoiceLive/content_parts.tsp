import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace VoiceLive;

union ContentPartType {
  string,
  input_text: "input_text",
  input_audio: "input_audio",
  input_image: "input_image",
  text: "text",
  audio: "audio",
}

/** Base for any content part; discriminated by `type`. */
@discriminator("type")
model ContentPart {
  type: ContentPartType;
}

/** A text content part for a request. */
@usage(RequestUsage)
model RequestTextContentPart extends ContentPart {
  type: ContentPartType.input_text;
  text?: string;
}

/** An audio content part for a request. */
@usage(RequestUsage)
model RequestAudioContentPart extends ContentPart {
  type: ContentPartType.input_audio;
  transcript?: string;
}

/** A text content part for a response. */
@usage(ResponseUsage)
model ResponseTextContentPart extends ContentPart {
  type: ContentPartType.text;
  text?: string;
}

/** An audio content part for a response. */
@usage(ResponseUsage)
model ResponseAudioContentPart extends ContentPart {
  type: ContentPartType.audio;
  transcript?: string;
}

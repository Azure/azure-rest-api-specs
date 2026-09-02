import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

namespace VoiceLive;

union ContentPartType {
  string,
  input_text: "input_text",
  input_audio: "input_audio",

  @added(Versions.v2026_01_01_preview)
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

/** An audio content part for a request. This is supported only by realtime models (e.g., gpt-realtime). For text-based models, use `input_text` instead. */
@usage(RequestUsage)
model RequestAudioContentPart extends ContentPart {
  type: ContentPartType.input_audio;

  /** Base64-encoded audio bytes, these will be parsed as the format specified in the session input audio type configuration. This defaults to PCM 16-bit 24kHz mono if not specified. */
  audio: string;

  /** Optional transcript of the audio content. This is not sent to the model, but will be attached to the message item for reference. */
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

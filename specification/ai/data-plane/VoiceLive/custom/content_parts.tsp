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

model RequestTextContentPart extends ContentPart {
  type: ContentPartType.input_text;
  text?: string;
}

model RequestAudioContentPart extends ContentPart {
  type: ContentPartType.input_audio;
  transcript?: string;
}

model ResponseTextContentPart extends ContentPart {
  type: ContentPartType.text;
  text?: string;
}

model ResponseAudioContentPart extends ContentPart {
  type: ContentPartType.audio;
  transcript?: string;
}

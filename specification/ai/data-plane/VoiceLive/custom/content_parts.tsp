using TypeSpec.OpenAPI;

namespace VoiceLive;

union VoiceLiveContentPartType {
  string,
  input_text: "input_text",
  input_audio: "input_audio",
  text: "text",
  audio: "audio",
}

@discriminator("type")
model VoiceLiveContentPart {
  type: VoiceLiveContentPartType;
}

model VoiceLiveRequestTextContentPart extends VoiceLiveContentPart {
  type: VoiceLiveContentPartType.input_text;
  text?: string;
}

model VoiceLiveRequestAudioContentPart extends VoiceLiveContentPart {
  type: VoiceLiveContentPartType.input_audio;
  transcript?: string;
}

model VoiceLiveResponseTextContentPart extends VoiceLiveContentPart {
  type: VoiceLiveContentPartType.text;
  text?: string;
}

model VoiceLiveResponseAudioContentPart extends VoiceLiveContentPart {
  type: VoiceLiveContentPartType.audio;
  transcript?: string;
}

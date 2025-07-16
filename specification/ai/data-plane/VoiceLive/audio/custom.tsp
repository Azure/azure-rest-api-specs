import "./models.tsp";

using TypeSpec.OpenAPI;

namespace VoiceLive;

union TranscriptionAudioResponseFormat {
  AudioResponseFormat,
}

union TranslationAudioResponseFormat {
  AudioResponseFormat,
}

union TranscriptTextUsageType {
  tokens: "tokens",
  duration: "duration",
}

@discriminator("type")
model TranscriptTextUsage {
  type: TranscriptTextUsageType;
}

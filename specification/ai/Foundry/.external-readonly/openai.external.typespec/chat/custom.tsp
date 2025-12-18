import "../common";

using TypeSpec.OpenAPI;

namespace OpenAI;

union ChatOutputPredictionType {
  string,
  static_content: "content",
}

/**
 * Base representation of predicted output from a model.
 */
@discriminator("type")
model ChatOutputPrediction {
  type: ChatOutputPredictionType;
}

model ChatCompletionFunctionChoice {}

model ChatCompletionToolChoice {}

union ChatCompletionRequestMessageContentPartType {
  text: "text",
  file: "file",
  input_audio: "input_audio",
  image_url: "image_url",
  refusal: "refusal",
}

@discriminator("type")
model ChatCompletionRequestMessageContentPart {
  type: ChatCompletionRequestMessageContentPartType;
}

model ChatCompletionMessageAudioChunk {
  id?: string;
  transcript?: string;

  @encode("base64")
  data?: bytes;

  @encode("unixTimestamp", int32)
  expires_at?: utcDateTime;
}

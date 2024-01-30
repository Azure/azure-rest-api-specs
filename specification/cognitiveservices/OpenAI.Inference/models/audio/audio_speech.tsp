import "@typespec/versioning";
import "@typespec/http";

using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Azure.OpenAI;

@doc("Represents a voice for speech synthesis.")
@added(ServiceApiVersions.v2024_02_15_Preview)
enum AudioSpeechVoice {
  @doc("The Alloy voice.")
  alloy: "alloy",

  @doc("The Echo voice.")
  echo: "echo",

  @doc("The Fable voice.")
  fable: "fable",

  @doc("The Onyx voice.")
  onyx: "onyx",

  @doc("The Nova voice.")
  nova: "nova",

  @doc("The Shimmer voice.")
  shimmer: "shimmer",
}

@doc("Represents the output format for speech synthesis.")
@added(ServiceApiVersions.v2024_02_15_Preview)
enum AudioSpeechOutputFormat {
  @doc("Use mp3 as output format.")
  mp3: "mp3",

  @doc("Use opus as output format.")
  opus: "opus",

  @doc("Use aac as output format.")
  aac: "aac",

  @doc("Use flac as output format.")
  flac: "flac",
}

@doc("Specifies the request for speech synthesis.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model AudioSpeechOptions {
  @doc("The text to synthesize audio for. The maximum length is 4096 characters.")
  @maxLength(4096)
  input: string;

  @doc("The voice to use for speech synthesis.")
  voice: AudioSpeechVoice;

  @doc("The format to synthesize the audio in.")
  @projectedName("json", "response_format")
  responseFormat?: AudioSpeechOutputFormat;

  @doc("The speed of the synthesize audio. Select a value from `0.25` to `4.0`. `1.0` is the default.")
  @minValue(0.25)
  @maxValue(4.0)
  speed?: float32;
}

@doc("Represents the response for speech synthesis.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model AudioSpeechResponse {
  @doc("The content type of the response.")
  @header
  contentType: "application/octet-stream";

  @doc("The synthesized audio.")
  @body
  audio: bytes;
}

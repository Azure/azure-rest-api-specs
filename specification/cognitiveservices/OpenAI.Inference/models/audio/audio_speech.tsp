import "@typespec/versioning";
import "@typespec/http";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Azure.OpenAI;

@doc("The available voices for text-to-speech.")
@added(ServiceApiVersions.v2024_02_15_Preview)
union SpeechVoice {
  string,

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

@doc("The supported audio output formats for text-to-speech.")
@added(ServiceApiVersions.v2024_02_15_Preview)
union SpeechGenerationResponseFormat {
  string,

  @doc("Use MP3 as the audio output format. MP3 is the default, general-purpose format.")
  mp3: "mp3",

  @doc("Use Opus as the audio output format. Opus is optimized for internet streaming and low latency.")
  opus: "opus",

  @doc("Use AAC as the audio output format. AAC is optimized for digital audio compression and is preferred by YouTube, Android, and iOS.")
  aac: "aac",

  @doc("Use FLAC as the audio output format. FLAC is a fully lossless format optimized for maximum quality at the expense of size.")
  flac: "flac",

  @doc("Use uncompressed WAV as the audio output format, suitable for low-latency applications to avoid decoding overhead.")
  @added(ServiceApiVersions.v2024_04_01_Preview)
  wav: "wav",

  @doc("Use uncompressed PCM as the audio output format, which is similar to WAV but contains raw samples in 24kHz (16-bit signed, low-endian), without the header.")
  @added(ServiceApiVersions.v2024_04_01_Preview)
  pcm: "pcm",
}

@doc("A representation of the request options that control the behavior of a text-to-speech operation.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model SpeechGenerationOptions {
  @doc("The text to generate audio for. The maximum length is 4096 characters.")
  @maxLength(4096)
  input: string;

  @doc("The voice to use for text-to-speech.")
  voice: SpeechVoice;

  @doc("The audio output format for the spoken text. By default, the MP3 format will be used.")
  @encodedName("application/json", "response_format")
  responseFormat?: SpeechGenerationResponseFormat = SpeechGenerationResponseFormat.mp3;

  @doc("The speed of speech for generated audio. Values are valid in the range from 0.25 to 4.0, with 1.0 the default and higher values corresponding to faster speech.")
  @minValue(0.25)
  @maxValue(4.0)
  speed?: float32 = 1.0;

  @doc("""
    The model to use for this text-to-speech request.
    """)
  // Implementation note: developer-facing specification of deployment or model by clients should be controlled either
  // via an operation parameter or by this request body field -- but only one of those. This field should be hidden by
  // clients if operation parameters are used and populated into the request body on an as-needed basis.
  @clientName("DeploymentName", "csharp")
  `model`?: string;
}

@doc("A representation of a response for a text-to-speech operation.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model SpeechGenerationResponse {
  @doc("The content type of the response. Always application/octet-stream for audio/speech responses.")
  @header
  contentType: "application/octet-stream";

  @doc("The generated audio, generated in the requested audio output format.")
  @bodyRoot
  audio: bytes;
}

/**
 * Get generate speech from text body.
 */
@added(ServiceApiVersions.v2024_02_15_Preview)
model GenerateSpeechFromTextBody {
  /**
   * A representation of the request options that control the behavior of a text-to-speech operation.
   */
  @bodyRoot
  body: SpeechGenerationOptions;
}

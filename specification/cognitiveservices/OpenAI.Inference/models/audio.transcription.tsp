import "@typespec/versioning";
import "./audio.common.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@doc("Defines available options for the underlying response format of output transcription information.")
@added(ServiceApiVersions.v2023_09_01_Preview)
enum AudioTranscriptionFormat {
  @doc("Use a response body that is a JSON object containing a single 'text' field for the transcription.")
  json: "json",

  @doc("""
    Use a response body that is a JSON object containing transcription text along with timing, segments, and other
    metadata.
    """)
  verbose_json: "verbose_json",

  @doc("Use a response body that is plain text containing the raw, unannotated transcription.")
  text: "text",

  @doc("Use a response body that is plain text in SubRip (SRT) format that also includes timing information.")
  srt: "srt",

  @doc("""
    Use a response body that is plain text in Web Video Text Tracks (VTT) format that also includes timing information.
    """)
  vtt: "vtt",
}

@doc("""
The configuration information for an audio transcription request.
""")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranscriptionOptions {
  @doc("""
  The audio data to transcribe. This must be the binary content of a file in one of the supported media formats:
  flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, webm.
  """)
  @projectedName("csharp", "AudioData")
  file: bytes;

  @doc("""
  The requested format of the transcription response data, which will influence the content and detail of the result.
  """)
  @projectedName("json", "response_format")
  responseFormat?: AudioTranscriptionFormat;

  @doc("""
  The primary spoken language of the audio data to be transcribed, supplied as a two-letter ISO-639-1 language code
  such as 'en' or 'fr'.
  Providing this known input language is optional but may improve the accuracy and/or latency of transcription.
  """)
  language?: string;

  @doc("""
  An optional hint to guide the model's style or continue from a prior audio segment. The written language of the
  prompt should match the primary spoken language of the audio data.
  """)
  prompt?: string;

  @doc("""
  The sampling temperature, between 0 and 1.
  Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
  If set to 0, the model will use log probability to automatically increase the temperature until certain thresholds are hit.
  """)
  temperature?: float32;

  @doc("""
  The model to use for this transcription request.
  """)
  // Implementation note: developer-facing specification of deployment or model by clients should be controlled either
  // via an operation parameter or by this request body field -- but only one of those. This field should be hidden by
  // clients if operation parameters are used and populated into the request body on an as-needed basis.
  @projectedName("csharp", "InternalNonAzureModelName")
  `model`?: string;
}

@doc("""
Extended information about a single segment of transcribed audio data.
Segments generally represent roughly 5-10 seconds of speech. Segment boundaries typically occur between words but not
necessarily sentences.
""")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranscriptionSegment {
  @doc("The 0-based index of this segment within a transcription.")
  id: int32;

  @doc("The time at which this segment started relative to the beginning of the transcribed audio.")
  @encode("seconds", float32)
  start: duration;

  @doc("The time at which this segment ended relative to the beginning of the transcribed audio.")
  @encode("seconds", float32)
  end: duration;

  @doc("The transcribed text that was part of this audio segment.")
  text: string;

  @doc("The temperature score associated with this audio segment.")
  temperature: float32;

  @doc("The average log probability associated with this audio segment.")
  @projectedName("json", "avg_logprob")
  @projectedName("csharp", "AverageLogProbability")
  avgLogprob: float32;

  @doc("The compression ratio of this audio segment.")
  @projectedName("json", "compression_ratio")
  compressionRatio: float32;

  @doc("The probability of no speech detection within this audio segment.")
  @projectedName("json", "no_speech_prob")
  @projectedName("csharp", "NoSpeechProbability")
  noSpeechProb: float32;

  @doc("The token IDs matching the transcribed text in this audio segment.")
  tokens: int32[];

  @doc("""
  The seek position associated with the processing of this audio segment.
  Seek positions are expressed as hundredths of seconds.
  The model may process several segments from a single seek position, so while the seek position will never represent
  a later time than the segment's start, the segment's start may represent a significantly later time than the
  segment's associated seek position.
  """)
  seek: int32;
}

@doc("Result information for an operation that transcribed spoken audio into written text.")
@added(ServiceApiVersions.v2023_09_01_Preview)
model AudioTranscription {
  @doc("The transcribed text for the provided audio data.")
  text: string;

  @doc("The label that describes which operation type generated the accompanying response data.")
  @projectedName("csharp", "InternalAudioTaskLabel")
  task?: AudioTaskLabel;

  @doc("""
  The spoken language that was detected in the transcribed audio data.
  This is expressed as a two-letter ISO-639-1 language code like 'en' or 'fr'.
  """)
  language?: string;

  @doc("The total duration of the audio processed to produce accompanying transcription information.")
  @encode("seconds", float32)
  duration?: duration;

  @doc("""
  A collection of information about the timing, probabilities, and other detail of each processed audio segment.
  """)
  segments?: AudioTranscriptionSegment[];
}

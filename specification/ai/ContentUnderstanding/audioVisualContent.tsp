import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";
import "./documentContent.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ContentUnderstanding;

@doc("Audio visual content.  Ex. audio/wav, video/mp4.")
model AudioVisualContent extends MediaContent {
  @doc("Content kind.")
  kind: MediaContentKind.audioVisual;

  @doc("Start time of the content in milliseconds.")
  startTimeMs: int64;

  @doc("End time of the content in milliseconds.")
  endTimeMs: int64;

  @doc("Width of each video frame in pixels, if applicable.")
  width?: int32;

  @doc("Height of each video frame in pixels, if applicable.")
  height?: int32;

  @doc("List of key frames in the video, represented by its timestamp in milliseconds.  Only if returnDetails is true.")
  keyFrameTimesMs?: int64[];

  @doc("List of transcript phrases.  Only if returnDetails is true.")
  transcriptPhrases?: TranscriptPhrase[];

  @doc("List of faces in the video.  Only if enableFace and returnDetails are true.")
  faces?: ImageFace[];
}

@doc("Transcript phrase.")
model TranscriptPhrase {
  @doc("Speaker index or name.")
  speaker?: string;

  @doc("Start time of the phrase in milliseconds.")
  startTimeMs: int64;

  @doc("End time of the phrase in milliseconds.")
  endTimeMs: int64;

  @doc("Detected locale of the phrase.  Ex. en-US.")
  locale?: string;

  @doc("Transcript text.")
  text: string;

  @doc("Confidence of predicting the phrase.")
  @minValue(0)
  @maxValue(1)
  confidence?: float32;

  @doc("Span of the phrase in the markdown content.")
  span?: ContentSpan;

  @doc("List of words in the phrase.")
  words: TranscriptWord[];
}

@doc("Transcript word.")
model TranscriptWord {
  @doc("Start time of the word in milliseconds.")
  startTimeMs: int64;

  @doc("End time of the word in milliseconds.")
  endTimeMs: int64;

  @doc("Transcript text.")
  text: string;

  @doc("Span of the word in the markdown content.")
  span?: ContentSpan;
}

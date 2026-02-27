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

  // @added(Versions.v2025_05_01_preview)
  @doc("List of camera shot changes in the video, represented by its timestamp in milliseconds.  Only if returnDetails is true.")
  cameraShotTimesMs?: int64[];

  @doc("List of key frames in the video, represented by its timestamp in milliseconds.  Only if returnDetails is true.")
  keyFrameTimesMs?: int64[];

  @doc("List of transcript phrases.  Only if returnDetails is true.")
  transcriptPhrases?: TranscriptPhrase[];

  // @removed(Versions.v2025_05_01_preview)
  // @doc("List of faces in the video.  Only if enableFace and returnDetails are true.")
  // faces?: ImageFace[];

  // @added(Versions.v2025_05_01_preview)
  // @removed(Versions.v2025_11_01)
  // @doc("List of detected persons in the video.  Only if enableFace and returnDetails are true.")
  // persons?: DetectedPerson[];

  @added(Versions.v2025_11_01)
  @doc("List of detected content segments.  Only if enableSegment is true.")
  segments?: AudioVisualContentSegment[];
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

// @added(Versions.v2025_05_01_preview)
// @removed(Versions.v2025_11_01)
// @doc("Audio visual segment, such as a scene, chapter, etc.")
// model AudioVisualSegment {
//   @doc("Segment ID.")
//   segmentId: string;

//   @doc("Start time of the segment in milliseconds.")
//   startTimeMs: int64;

//   @doc("End time of the segment in milliseconds.")
//   endTimeMs: int64;

//   @doc("Short description of the segment.")
//   description: string;

//   @doc("Span of the segment in the markdown content.")
//   span?: ContentSpan;
// }

// @added(Versions.v2025_05_01_preview)
// @removed(Versions.v2025_11_01)
// @doc("Detected person.")
// model DetectedPerson {
//   @doc("Person identifier in the optional person directory if found.  Otherwise, each unknown person is assigned a unique `Person-{Number}`.")
//   personId?: string;

//   @doc("Confidence of the person identification, if a person directory is provided.")
//   confidence?: float32;

//   @doc("Encoded source that identifies the position of the person in the input content.")
//   source?: SourceExpression;
// }

@added(Versions.v2025_11_01)
@doc("Detected audio/visual content segment.")
model AudioVisualContentSegment {
  @doc("Segment identifier.")
  segmentId: string;

  @doc("Classified content category.")
  category: string;

  @doc("Span of the segment in the markdown content.")
  span: ContentSpan;

  @doc("Start time of the segment in milliseconds.")
  startTimeMs: int64;

  @doc("End time of the segment in milliseconds.")
  endTimeMs: int64;
}

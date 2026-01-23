import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ClientGenerator.Core;

namespace Azure.Ai.Speech.Transcription;

@doc("Mode of profanity filtering.")
union ProfanityFilterMode {
  @doc("Disable profanity filtering.")
  None: "None",

  @doc("Remove profanity.")
  Removed: "Removed",

  @doc("Add \"profanity\" XML tags</Profanity>")
  Tags: "Tags",

  @doc("Mask the profanity with * except of the first letter, e.g., f***")
  Masked: "Masked",

  string,
}

@doc("Enhanced mode properties for transcription.")
model EnhancedModeProperties {
  @doc("Enable enhanced mode for transcription. This is automatically set to true when task, targetLanguage, or prompt are specified.")
  @visibility(Lifecycle.Read)
  enabled?: boolean;

  @doc("Task type for enhanced mode.")
  task?: string;

  @doc("Target language for enhanced mode.")
  targetLanguage?: string;

  @doc("A list of user prompts.")
  prompt?: string[];
}

@doc("Phrase list properties for transcription.")
model PhraseListProperties {
  @doc("List of phrases for recognition.")
  phrases?: string[];

  @doc("Biasing weight for phrase list (0.0-2.0).")
  biasingWeight?: float32;
}

#suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "Support streaming input files"
@doc("Metadata for a transcription request.")
model TranscriptionOptions {
  @doc("The URL of the audio to be transcribed. The audio must be shorter than 2 hours in audio duration and smaller than 250 MB in size. If both Audio and AudioUrl are provided, Audio is used.")
  @clientName("audioUri", "csharp")
  audioUrl?: url;

  @doc("A list of possible locales for the transcription. If not specified, the locale of the speech in the audio is detected automatically from all supported locales.")
  locales?: Array<string>;

  @doc("Maps some or all candidate locales to a model URI to be used for transcription. If no mapping is given, the default model for the locale is used.")
  models?: Record<url>;

  @doc("Mode of profanity filtering.")
  profanityFilterMode?: ProfanityFilterMode;

  @doc("Mode of diarization.")
  diarization?: TranscriptionDiarizationOptions;

  @doc("The 0-based indices of the channels to be transcribed separately. If not specified, multiple channels are merged and transcribed jointly. Only up to two channels are supported.")
  channels?: Array<int32>;

  @doc("Enhanced mode properties.")
  enhancedMode?: EnhancedModeProperties;

  @doc("Phrase list properties.")
  phraseList?: PhraseListProperties;
}

@doc("The Speaker Diarization settings. Diarization settings must be specified to enable speaker diarization.")
model TranscriptionDiarizationOptions {
  @doc("Enable speaker diarization. This is automatically set to true when maxSpeakers is specified.")
  @visibility(Lifecycle.Read)
  enabled?: boolean;

  @maxValue(35)
  @minValue(2)
  @doc("Gets or sets a hint for the maximum number of speakers for diarization. Must be greater than 1 and less than 36.")
  maxSpeakers?: int32;
}

@doc("The result of the transcribe operation.")
model TranscriptionResult {
  @doc("The duration of the audio in milliseconds.")
  durationMilliseconds: int32;

  @doc("The full transcript for each channel.")
  combinedPhrases: Array<ChannelCombinedPhrases>;

  @doc("The transcription results segmented into phrases.")
  phrases: Array<TranscribedPhrase>;
}

@doc("The full transcript per channel.")
model ChannelCombinedPhrases {
  @doc("The 0-based channel index. Only present if channel separation is enabled.")
  channel?: int32;

  @doc("The complete transcribed text for the channel.") text: string;
}

@doc("A transcribed phrase.")
model TranscribedPhrase {
  @doc("The 0-based channel index. Only present if channel separation is enabled.")
  channel?: int32;

  @doc("A unique integer number that is assigned to each speaker detected in the audio without particular order. Only present if speaker diarization is enabled.")
  speaker?: int32;

  @doc("The start offset of the phrase in milliseconds.")
  offsetMilliseconds: int32;

  @doc("The duration of the phrase in milliseconds.")
  durationMilliseconds: int32;

  @doc("The transcribed text of the phrase.") text: string;

  @doc("The words that make up the phrase. Only present if word-level timestamps are enabled.")
  words?: Array<TranscribedWord>;

  @doc("The locale of the phrase.") locale?: string;
  @doc("The confidence value for the phrase.") confidence: float32;
}

@doc("Time-stamped word in the display form.")
model TranscribedWord {
  @doc("The recognized word, including punctuation.") text: string;

  @doc("The start offset of the word in milliseconds.")
  offsetMilliseconds: int32;

  @doc("The duration of the word in milliseconds.")
  durationMilliseconds: int32;
}

#suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "Support streaming input files"
@doc("Request model for transcription operation.")
model TranscriptionContent {
  @doc("Metadata for a transcription request. This field contains a JSON-serialized object of type `TranscriptionOptions`.")
  definition: HttpPart<TranscriptionOptions>;

  @doc("The content of the audio file to be transcribed. The audio file must be shorter than 2 hours in audio duration and smaller than 250 MB in size. Optional if audioUrl is provided in the definition.")
  audio?: HttpPart<bytes>;
}

import "./common.tsp";

namespace SpeechToText.FastTranscriptionClient;

#suppress "@azure-tools/typespec-autorest/unsupported-multipart-type" "Support streaming input files"
@doc("Metadata for a fast transcription request.")
model TranscribeDefinition {
  @doc("A list of possible locales for the transcription. If not specified, the locale of the speech in the audio is detected automatically from all supported locales.")
  locales?: Array<string>;

  @doc("Maps some or all candidate locales to a model URI to be used for transcription. If no mapping is given, the default model for the locale is used.")
  models?: Record<url>;

  @doc("Mode of profanity filtering.")
  profanityFilterMode?: ProfanityFilterMode;

  @doc("Mode of diarization.")
  diarization?: TranscribeDiarizationProperties;

  @doc("The 0-based indices of the channels to be transcribed separately. If not specified, multiple channels are merged and transcribed jointly. Only up to two channels are supported.")
  channels?: Array<int32>;
}

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

@doc("The diarization settings. Diarization settings must be specified to enable diarization.")
model TranscribeDiarizationProperties {
  @doc("Gets or sets a value indicating whether speaker diarization is enabled.")
  enabled?: boolean;

  @maxValue(35)
  @minValue(2)
  @doc("Gets or sets a hint for the maximum number of speakers for diarization. Must be greater than 1 and less than 36.")
  maxSpeakers?: int32;
}

@doc("The result of the transcribe operation.")
model TranscribeResult {
  @doc("The duration of the audio in milliseconds.")
  durationMilliseconds: int32;

  @doc("The full transcript for each channel.")
  combinedPhrases: Array<ChannelCombinedPhrases>;

  @doc("The transcription results segmented into phrases.")
  phrases: Array<Phrase>;
}

@doc("The full transcript per channel.")
model ChannelCombinedPhrases {
  @doc("The 0-based channel index. Only present if channel separation is enabled.")
  channel?: int32;

  @doc("The complete transcribed text for the channel.") text: string;
}

@doc("A transcribed phrase.")
model Phrase {
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
  words?: Array<Word>;

  @doc("The locale of the phrase.") locale?: string;
  @doc("The confidence value for the phrase.") confidence: float32;
}

@doc("Time-stamped word in the display form.")
model Word {
  @doc("The recognized word, including punctuation.") text: string;

  @doc("The start offset of the word in milliseconds.")
  offsetMilliseconds: int32;

  @doc("The duration of the word in milliseconds.")
  durationMilliseconds: int32;
}

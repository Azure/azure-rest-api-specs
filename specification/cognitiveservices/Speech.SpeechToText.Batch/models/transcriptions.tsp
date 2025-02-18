import "@typespec/versioning";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace SpeechToText;

@doc("Transcription")
model Transcription {
  @doc("TranscriptionLinks")
  links?: TranscriptionLinks;

  @doc("TranscriptionProperties")
  properties: TranscriptionProperties;

  @visibility("read")
  @doc("The location of this entity.")
  self?: url;

  @doc("EntityReference")
  `model`?: EntityReference;

  @doc("EntityReference")
  dataset?: EntityReference;

  @doc("A list of content urls to get audio files to transcribe. Up to 1000 urls are allowed.\r\nThis property will not be returned in a response.")
  contentUrls?: Array<url>;

  @doc("A URL for an Azure blob container that contains the audio files. A container is allowed to have a maximum size of 5GB and a maximum number of 10000 blobs.\r\nThe maximum size for a blob is 2.5GB.\r\nContainer SAS should contain 'r' (read) and 'l' (list) permissions.\r\nThis property will not be returned in a response.")
  contentContainerUrl?: url;

  @minLength(1)
  @doc("The locale of the contained data. If Language Identification is used, this locale is used to transcribe speech for which no language could be detected.")
  locale: string;

  @minLength(1)
  @doc("The display name of the object.")
  displayName: string;

  @doc("The description of the object.")
  description?: string;

  @doc("The custom properties of this entity. The maximum allowed key length is 64 characters, the maximum\r\nallowed value length is 256 characters and the count of allowed entries is 10.")
  customProperties?: Record<string>;

  @doc("The project reference of the object")
  @removed(ServiceApiVersions.V20241115)
  project?: EntityReference;

  @visibility("read")
  @doc("The time-stamp when the current status was entered.\r\nThe time stamp is encoded as ISO 8601 date and time format\r\n(\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  lastActionDateTime?: utcDateTime;

  @doc("The status of the object")
  status?: Status;

  @visibility("read")
  @doc("The time-stamp when the object was created.\r\nThe time stamp is encoded as ISO 8601 date and time format\r\n(\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  createdDateTime?: utcDateTime;
}

@doc("TranscriptionUpdate")
model TranscriptionUpdate {
  @doc("The name of the object.")
  displayName?: string;

  @doc("The description of the object.")
  description?: string;

  @doc("The custom properties of this entity. The maximum allowed key length is 64 characters, the maximum\r\nallowed value length is 256 characters and the count of allowed entries is 10.")
  customProperties?: Record<string>;

  @doc("EntityReference")
  @removed(ServiceApiVersions.V20241115)
  project?: EntityReference;
}

@doc("TranscriptionLinks")
model TranscriptionLinks {
  @visibility("read")
  @doc("The location to get all files of this entity. See operation \"Transcriptions_ListFiles\" for more details.")
  files?: url;
}

@doc("TranscriptionProperties")
model TranscriptionProperties {
  @doc("A value indicating whether word level timestamps are requested. The default value is false.")
  wordLevelTimestampsEnabled?: boolean;

  @doc("A value indicating whether word level timestamps for the display form are requested. The default value is false.")
  displayFormWordLevelTimestampsEnabled?: boolean;

  @visibility("read")
  @doc("The duration of the transcription. The duration is encoded as ISO 8601 duration (\"PnYnMnDTnHnMnS\", see https://en.wikipedia.org/wiki/ISO_8601#Durations).")
  @removed(ServiceApiVersions.V20241115)
  duration?: string;

  @visibility("read")
  @doc("The duration in milliseconds of the transcription.\nDurations larger than 2^53-1 are not supported to ensure compatibility with JavaScript integers.")
  @added(ServiceApiVersions.V20241115)
  durationMilliseconds?: int32;

  @doc("A collection of the requested channel numbers. In the default case, the channels 0 and 1 are considered.")
  channels?: Array<int32>;

  @doc("The requested destination container.\n\nRemarks\n\nWhen a destination container is used in combination with a timeToLive, the metadata of a transcription will be deleted normally, but the data stored in the destination container, including transcription results, will remain untouched, because no delete permissions are required for this container.\n\nTo support automatic cleanup, either configure blob lifetimes on the container, or use \"Bring your own Storage (BYOS)\" instead of destinationContainerUrl, where blobs can be cleaned up.")
  destinationContainerUrl?: url;

  @doc("The mode used for punctuation.")
  punctuationMode?: PunctuationMode;

  @doc("Mode of profanity filtering.")
  profanityFilterMode?: ProfanityFilterMode;

  @doc("How long the transcription will be kept in the system after it has completed. Once the transcription reaches the time to live after completion (successful or failed) it will be automatically deleted.\n\nNote: When using BYOS (bring your own storage), the result files on the customer owned storage account will also be deleted. Use either destinationContainerUrl to specify a separate container for result files which will not be deleted when the timeToLive expires, or retrieve the result files through the API and store them as needed.\n\nThe shortest supported duration is 6h, the longest supported duration is 31 days. 2 days (\"P2D\") is the recommended default value when data is consumed directly. The duration is encoded as ISO 8601 duration (\"PnYnMnDTnHnMnS\", see https://en.wikipedia.org/wiki/ISO_8601#Durations).")
  @removed(ServiceApiVersions.V20241115)
  timeToLive: string;

  @doc("How long the transcription will be kept in the system after it has completed. Once the transcription reaches the time to live after completion(successful or failed) it will be automatically deleted.\n\nNote: When using BYOS (bring your own storage), the result files on the customer owned storage account will also be deleted.Use either destinationContainerUrl to specify a separate container for result files which will not be deleted when the timeToLive expires, or retrieve the result files through the API and store them as needed.\n\nThe shortest supported duration is 6 hours, the longest supported duration is 31 days. 2 days (48 hours) is the recommended default value when data is consumed directly.")
  @added(ServiceApiVersions.V20241115)
  timeToLiveHours: int32;

  @doc("EntityError")
  error?: EntityError;

  @doc("A value indicating whether diarization (speaker identification) is requested. The default value\r\nis `false`.\r\nIf this field is set to true and the improved diarization system is configured by specifying\r\n`DiarizationProperties`, the improved diarization system will provide diarization for a configurable\r\nrange of speakers.\r\nIf this field is set to true and the improved diarization system is not enabled (not specifying\r\n`DiarizationProperties`), the basic diarization system will distinguish between up to two speakers.\r\nNo extra charges are applied for the basic diarization.\r\n            \r\nThe basic diarization system is deprecated and will be removed in the next major version of the API.\r\nThis `diarizationEnabled` setting will also be removed.")
  @removed(ServiceApiVersions.V20241115)
  diarizationEnabled?: boolean;

  @doc("DiarizationProperties")
  diarization?: DiarizationProperties;

  @doc("LanguageIdentificationProperties")
  languageIdentification?: LanguageIdentificationProperties;
}

@doc("Describe the current state of the API.")
union Status {
  @doc("The long running operation has not yet started.")
  NotStarted: "NotStarted",

  @doc("The long running operation is currently processing.")
  Running: "Running",

  @doc("The long running operation has successfully completed.")
  Succeeded: "Succeeded",

  @doc("The long running operation has failed.")
  Failed: "Failed",

  string,
}

@doc("The mode used for punctuation.")
union PunctuationMode {
  @doc("No punctuation.")
  None: "None",

  @doc("Dictated punctuation marks only, i.e., explicit punctuation.")
  Dictated: "Dictated",

  @doc("Automatic punctuation.")
  Automatic: "Automatic",

  @doc("Dictated punctuation marks or automatic punctuation.")
  DictatedAndAutomatic: "DictatedAndAutomatic",

  string,
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

@doc("EntityError")
model EntityError {
  @visibility("read")
  @doc("The code of this error.")
  code?: string;

  @visibility("read")
  @doc("The message for this error.")
  message?: string;
}

@doc("DiarizationProperties")
model DiarizationProperties {
  @removed(ServiceApiVersions.V20241115)
  @doc("DiarizationSpeakersProperties")
  speakers: DiarizationSpeakersProperties;

  @added(ServiceApiVersions.V20241115)
  @doc("A value indicating whether speaker diarization is enabled.")
  enabled: boolean;

  @added(ServiceApiVersions.V20241115)
  @minValue(2)
  @maxValue(35)
  @doc("A hint for the maximum number of speakers for diarization. Must be greater than 1 and less than 36.")
  maxSpeakers: int32;
}

@removed(ServiceApiVersions.V20241115)
@doc("DiarizationSpeakersProperties")
model DiarizationSpeakersProperties {
  @minValue(1)
  @doc("A hint for the minimum number of speakers for diarization. Must be smaller than or equal to the maxSpeakers property.")
  minCount: int32;

  @minValue(1)
  @doc("The maximum number of speakers for diarization. Must be less than 36 and larger than or equal to the minSpeakers property.")
  maxCount: int32;
}

@doc("LanguageIdentificationProperties")
model LanguageIdentificationProperties {
  @doc("The mode used for language identification.")
  mode?: LanguageIdentificationMode;

  @doc("The candidate locales for language identification (example [\"en-US\", \"de-DE\", \"es-ES\"]). A minimum of 2 and a maximum of 10 candidate locales, including the main locale for the transcription, is supported for continuous mode. For single language identification, the maximum number of candidate locales is unbounded.")
  candidateLocales: Array<string>;

  @doc("An optional mapping of locales to speech model entities. If no model is given for a locale, the default base model is used.\r\nKeys must be locales contained in the candidate locales, values are entities for models of the respective locales.")
  speechModelMapping?: Record<EntityReference>;
}

@doc("The mode used for language identification.")
union LanguageIdentificationMode {
  @doc("Continuous language identification (Default).")
  Continuous: "Continuous",

  @doc("Single language identification. If no language can be identified, the error code NoLanguageIdentified is returned to the user. If there is ambiguity between multiple languages, the error code MultipleLanguagesIdentified is returned to the user.")
  Single: "Single",

  string,
}

@doc("EntityReference")
model EntityReference {
  @doc("The location of the referenced entity.")
  self: url;
}

@doc("File")
model File {
  @doc("The creation time of this file. The time stamp is encoded as ISO 8601 date and time format (see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  createdDateTime: utcDateTime;

  @doc("FileKind")
  kind: FileKind;

  @doc("FileLinks")
  links: FileLinks;

  @doc("The name of this file.")
  name: string;

  @doc("FileProperties")
  properties: FileProperties;

  @doc("The location of this entity.")
  self: url;
}

@doc("FileLinks")
model FileLinks {
  @doc("The url to retrieve the content of this file.")
  contentUrl: url;
}

@doc("FileProperties")
model FileProperties {
  @doc("The total duration in milliseconds of the file in case this file is an audio file.")
  durationMilliseconds: int32;

  @doc("The size of the data in bytes.")
  size: int32;
}

@doc("FileKind")
union FileKind {
  @doc("Type of data is acoustic data archive.")
  AcousticDataArchive: "AcousticDataArchive",

  @doc("Type of data is acoustic data transcription v2.")
  AcousticDataTranscriptionV2: "AcousticDataTranscriptionV2",

  @doc("Type of data is audio.")
  Audio: "Audio",

  @doc("Type of data is dataset report.")
  DatasetReport: "DatasetReport",

  @doc("Type of data is evaluation details.")
  EvaluationDetails: "EvaluationDetails",

  @doc("Type of data is language data.")
  LanguageData: "LanguageData",

  @doc("Type of data is model report.")
  ModelReport: "ModelReport",

  @doc("Type of data is output formatting input file.")
  OutputFormattingData: "OutputFormattingData",

  @doc("Type of data is pronunciation data.")
  PronunciationData: "PronunciationData",

  @doc("Type of data is transcription.")
  Transcription: "Transcription",

  @doc("Type of data is transcription report.")
  TranscriptionReport: "TranscriptionReport",

  string,
}

import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.Core.Foundations;
using Azure.Core.Traits;
using Azure.Core.Traits.Private;
using TypeSpec.Rest;

namespace Azure.Ai.Speech.BatchTranscription;

@doc("EntityReference")
model EntityReference {
  @doc("The location of the referenced entity.")
  self: url;
}

@doc("EntityError")
model EntityError {
  @visibility(Lifecycle.Read)
  @doc("The code of this error.")
  code?: string;

  @visibility(Lifecycle.Read)
  @doc("The message for this error.")
  message?: string;
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

@doc("Transcription")
@resource("transcriptions")
model TranscriptionJob {
  @doc("TranscriptionLinks")
  @visibility(Lifecycle.Read)
  links?: TranscriptionLinks;

  @doc("TranscriptionProperties")
  properties: TranscriptionProperties;

  @doc("The id of this entity.")
  @key("id")
  @visibility(Lifecycle.Read)
  id: string;

  @visibility(Lifecycle.Read)
  @doc("The location of this entity.")
  self: url;

  @doc("EntityReference")
  `model`?: EntityReference;

  @doc("EntityReference")
  dataset?: EntityReference;

  @doc("A list of content urls to get audio files to transcribe. Up to 1000 urls are allowed.\r\nThis property will not be returned in a response.")
  @visibility(Lifecycle.Create)
  contentUrls?: Array<url>;

  @doc("A URL for an Azure blob container that contains the audio files. A container is allowed to have a maximum size of 5GB and a maximum number of 10000 blobs.\r\nThe maximum size for a blob is 2.5GB.\r\nContainer SAS should contain 'r' (read) and 'l' (list) permissions.\r\nThis property will not be returned in a response.")
  @visibility(Lifecycle.Create)
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

  @visibility(Lifecycle.Read)
  @doc("The time-stamp when the current status was entered.\r\nThe time stamp is encoded as ISO 8601 date and time format\r\n(\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  lastActionDateTime?: utcDateTime;

  @doc("The status of the object")
  @visibility(Lifecycle.Read)
  status: TranscriptionStatus;

  @visibility(Lifecycle.Read)
  @doc("The time-stamp when the object was created.\r\nThe time stamp is encoded as ISO 8601 date and time format\r\n(\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  createdDateTime?: utcDateTime;
}

@doc("TranscriptionProperties")
model TranscriptionProperties {
  @doc("A value indicating whether word level timestamps are requested. The default value is false.")
  wordLevelTimestampsEnabled?: boolean;

  @doc("A value indicating whether word level timestamps for the display form are requested. The default value is false.")
  displayFormWordLevelTimestampsEnabled?: boolean;

  @visibility(Lifecycle.Read)
  @doc("The duration in milliseconds of the transcription.\nDurations larger than 2^53-1 are not supported to ensure compatibility with JavaScript integers.")
  durationMilliseconds?: int32;

  @doc("A collection of the requested channel numbers. In the default case, the channels 0 and 1 are considered.")
  channels?: Array<int32>;

  @doc("The requested destination container.\n\nRemarks\n\nWhen a destination container is used in combination with a timeToLive, the metadata of a transcription will be deleted normally, but the data stored in the destination container, including transcription results, will remain untouched, because no delete permissions are required for this container.\n\nTo support automatic cleanup, either configure blob lifetimes on the container, or use \"Bring your own Storage (BYOS)\" instead of destinationContainerUrl, where blobs can be cleaned up.")
  destinationContainerUrl?: url;

  @doc("The mode used for punctuation.")
  punctuationMode?: PunctuationMode;

  @doc("Mode of profanity filtering.")
  profanityFilterMode?: ProfanityFilterMode;

  @doc("How long the transcription will be kept in the system after it has completed. Once the transcription reaches the time to live after completion(successful or failed) it will be automatically deleted.\n\nNote: When using BYOS (bring your own storage), the result files on the customer owned storage account will also be deleted.Use either destinationContainerUrl to specify a separate container for result files which will not be deleted when the timeToLive expires, or retrieve the result files through the API and store them as needed.\n\nThe shortest supported duration is 6 hours, the longest supported duration is 31 days. 2 days (48 hours) is the recommended default value when data is consumed directly.")
  timeToLiveHours: int32;

  @doc("EntityError")
  error?: EntityError;

  @doc("Speaker Diarization")
  diarization?: DiarizationProperties;

  @doc("LanguageIdentificationProperties")
  languageIdentification?: LanguageIdentificationProperties;
}

@doc("Describe the current state of the API.")
@lroStatus
union TranscriptionStatus {
  @doc("The long running operation has not yet started.")
  NotStarted: "NotStarted",

  @doc("The long running operation is currently processing.")
  Running: "Running",

  @lroSucceeded
  @doc("The long running operation has successfully completed.")
  Succeeded: "Succeeded",

  @lroFailed
  @doc("The long running operation has failed.")
  Failed: "Failed",

  string,
}

@doc("TranscriptionLinks")
model TranscriptionLinks {
  @visibility(Lifecycle.Read)
  @doc("The location to get all files of this entity. See operation \"Transcriptions_ListFiles\" for more details.")
  files?: url;
}

@doc("Speaker Diarization Properties")
model DiarizationProperties {
  @doc("A value indicating whether speaker diarization is enabled.")
  enabled: boolean;

  @minValue(2)
  @maxValue(35)
  @doc("A hint for the maximum number of speakers for diarization. Must be greater than 1 and less than 36.")
  maxSpeakers: int32;
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

@doc("TranscriptionFile")
@parentResource(TranscriptionJob)
@resource("files")
model TranscriptionFile {
  @doc("The creation time of this file. The time stamp is encoded as ISO 8601 date and time format (see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  createdDateTime: utcDateTime;

  @doc("FileKind")
  kind: FileKind;

  @doc("FileLinks")
  links: FileLinks;

  @doc("The name of this file.")
  displayName: string;

  @doc("FileProperties")
  properties: FileProperties;

  @doc("The location of this entity.")
  @visibility(Lifecycle.Read)
  @key
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

// Overwriting Azure.Core.Foundations.CustomPage for our own page response layout
@doc("Page of entities.")
model SpeechToTextCustomPage<
  Resource extends TypeSpec.Reflection.Model,
  Traits extends TypeSpec.Reflection.Model = {}
> {
  @doc("A list of entities limited by either the passed query parameters 'skip' and 'top' or their default values.\r\n            \r\nWhen iterating through a list using pagination and deleting entities in parallel, some entities will be skipped in the results.\r\nIt's recommended to build a list on the client and delete after the fetching of the complete list.")
  @visibility(Lifecycle.Read)
  @pageItems
  values?: Array<Resource>;

  @doc("A link to the next set of paginated results if there are more entities available; otherwise null.")
  @visibility(Lifecycle.Read)
  @nextLink
  `@nextLink`?: ResourceLocation<Resource>;
}

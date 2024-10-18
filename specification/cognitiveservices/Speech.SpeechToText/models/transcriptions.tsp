import "@typespec/versioning";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Azure.Speech;

model Transcription {
  links?: TranscriptionLinks;
  properties: TranscriptionProperties;

  @visibility("read")
  self?: url;

  `model`?: EntityReference;
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

  project?: EntityReference;

  @visibility("read")
  @doc("The time-stamp when the current status was entered.\r\nThe time stamp is encoded as ISO 8601 date and time format\r\n(\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  lastActionDateTime?: utcDateTime;

  status?: Status;

  @visibility("read")
  @doc("The time-stamp when the object was created.\r\nThe time stamp is encoded as ISO 8601 date and time format\r\n(\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  createdDateTime?: utcDateTime;
}

model TranscriptionUpdate {
  @doc("The name of the object.")
  displayName?: string;

  @doc("The description of the object.")
  description?: string;

  @doc("The custom properties of this entity. The maximum allowed key length is 64 characters, the maximum\r\nallowed value length is 256 characters and the count of allowed entries is 10.")
  customProperties?: Record<string>;

  project?: EntityReference;
}

model TranscriptionLinks {
  @visibility("read")
  files?: url;
}

model TranscriptionProperties {
  wordLevelTimestampsEnabled?: boolean;
  displayFormWordLevelTimestampsEnabled?: boolean;

  @visibility("read")
  duration?: string;

  channels?: Array<int32>;
  destinationContainerUrl?: url;
  punctuationMode?: PunctuationMode;
  profanityFilterMode?: ProfanityFilterMode;
  timeToLive: string;
  error?: EntityError;

  @doc("A value indicating whether diarization (speaker identification) is requested. The default value\r\nis `false`.\r\nIf this field is set to true and the improved diarization system is configured by specifying\r\n`DiarizationProperties`, the improved diarization system will provide diarization for a configurable\r\nrange of speakers.\r\nIf this field is set to true and the improved diarization system is not enabled (not specifying\r\n`DiarizationProperties`), the basic diarization system will distinguish between up to two speakers.\r\nNo extra charges are applied for the basic diarization.\r\n            \r\nThe basic diarization system is deprecated and will be removed in the next major version of the API.\r\nThis `diarizationEnabled` setting will also be removed.")
  @removed(ServiceApiVersions.V20241115)
  diarizationEnabled?: boolean;

  diarization?: DiarizationProperties;
  languageIdentification?: LanguageIdentificationProperties;
}

@doc("Describe the current state of the API.")
union Status {
  NotStarted: "NotStarted",
  Running: "Running",
  Succeeded: "Succeeded",
  Failed: "Failed",
}

@doc("The mode used for punctuation.")
union PunctuationMode {
  None: "None",
  Dictated: "Dictated",
  Automatic: "Automatic",
  DictatedAndAutomatic: "DictatedAndAutomatic",
}

@doc("Mode of profanity filtering.")
union ProfanityFilterMode {
  None: "None",
  Removed: "Removed",
  Tags: "Tags",
  Masked: "Masked",
}

model EntityError {
  @visibility("read")
  @doc("The code of this error.")
  code?: string;

  @visibility("read")
  @doc("The message for this error.")
  message?: string;
}

model DiarizationProperties {
  @removed(ServiceApiVersions.V20241115)
  speakers?: DiarizationSpeakersProperties;

  @added(ServiceApiVersions.V20241115)
  @doc("A value indicating whether speaker diarization is enabled.")
  enabled?: boolean;

  @added(ServiceApiVersions.V20241115)
  @minValue(2)
  @maxValue(35)
  @doc("A hint for the maximum number of speakers for diarization. Must be greater than 1 and less than 36.")
  maxSpeakers?: int32;
}

@removed(ServiceApiVersions.V20241115)
model DiarizationSpeakersProperties {
  @minValue(1)
  @doc("A hint for the minimum number of speakers for diarization. Must be smaller than or equal to the maxSpeakers property.")
  minCount?: int32;

  @minValue(1)
  @doc("The maximum number of speakers for diarization. Must be less than 36 and larger than or equal to the minSpeakers property.")
  maxCount?: int32;
}

model LanguageIdentificationProperties {
  mode?: LanguageIdentificationMode;

  @doc("The candidate locales for language identification (example [\"en-US\", \"de-DE\", \"es-ES\"]). A minimum of 2 and a maximum of 10 candidate locales, including the main locale for the transcription, is supported for continuous mode. For single language identification, the maximum number of candidate locales is unbounded.")
  candidateLocales: Array<string>;

  @doc("An optional mapping of locales to speech model entities. If no model is given for a locale, the default base model is used.\r\nKeys must be locales contained in the candidate locales, values are entities for models of the respective locales.")
  speechModelMapping?: Record<EntityReference>;
}

@doc("The mode used for language identification.")
union LanguageIdentificationMode {
  Continuous: "Continuous",
  Single: "Single",
}

model EntityReference {
  self: url;
}

@doc("The result of the transcribe operation.")
model TranscribeResult {
  @doc("The duration of the audio in milliseconds.")
  @renamedFrom(ServiceApiVersions.V20241115, "duration")
  @typeChangedFrom(ServiceApiVersions.V20241115, "int64")
  durationMilliseconds: int32;

  @doc("The combined transcription results for each channel.")
  combinedPhrases: Array<CombinedPhrases>;

  @doc("The transcription results segmented into phrases.")
  phrases: Array<Phrase>;
}

model CombinedPhrases {
  @doc("The 0-based channel index. Only present if channel separation is enabled.")
  channel?: int32;

  @doc("The complete transcribed text for the channel.") text: string;
}

model Phrase {
  @doc("The 0-based channel index. Only present if channel separation is enabled.")
  channel?: int32;

  @doc("The speaker number. Only present if speaker diarization is enabled.")
  speaker?: int32;

  @renamedFrom(ServiceApiVersions.V20241115, "offset")
  @typeChangedFrom(ServiceApiVersions.V20241115, "int64")
  @doc("The start offset of the phrase in milliseconds.")
  offsetMilliseconds: int32;

  @renamedFrom(ServiceApiVersions.V20241115, "duration")
  @typeChangedFrom(ServiceApiVersions.V20241115, "int64")
  @doc("The duration of the phrase in milliseconds.")
  durationMilliseconds: int32;

  @doc("The transcribed text of the phrase.") text: string;

  @doc("The words that make up the phrase. Only present if word-level timestamps are enabled.")
  words?: Array<Word>;

  @doc("The locale of the phrase.") locale?: string;
  @doc("The confidence value for the phrase.") confidence: float;
}

model Word {
  @doc("The recognized word, including punctuation.") text: string;

  @doc("The start offset of the word in milliseconds.")
  @renamedFrom(ServiceApiVersions.V20241115, "offset")
  @typeChangedFrom(ServiceApiVersions.V20241115, "int64")
  offsetMilliseconds: int32;

  @renamedFrom(ServiceApiVersions.V20241115, "duration")
  @typeChangedFrom(ServiceApiVersions.V20241115, "int64")
  @doc("The duration of the word in milliseconds.")
  durationMilliseconds: int32;
}

@doc("New format which conforms to the new Cognitive Services API guidelines which is available at https://microsoft.sharepoint.com/%3Aw%3A/t/CognitiveServicesPMO/EUoytcrjuJdKpeOKIK_QRC8BPtUYQpKBi8JsWyeDMRsWlQ?e=CPq8ow.\r\nThis contains an outer error with error code, message, details, target and an inner error with more descriptive details.")
@defaultResponse
@error
model Error {
  code?: ErrorCode;

  @doc("Additional supportive details regarding the error and/or expected policies.")
  details?: Array<Error>;

  @doc("High level error message.")
  message?: string;

  @doc("The source of the error.\r\nFor example it would be \"documents\" or \"document id\" in case of invalid document.")
  target?: string;

  innerError?: InnerError;
}

@doc("Metadata for a fast transcription request.")
model TranscribeDefinition {
  @doc("A list of possible locales for the transcription. If not specified, the locale of the speech in the audio is detected automatically from all supported locales.")
  locales?: Array<string>;

  @doc("Maps some or all candidate locales to a model URI to be used for transcription. If no mapping is given, the default model for the locale is used.")
  models?: Record<url>;

  profanityFilterMode?: ProfanityFilterMode;

  @added(ServiceApiVersions.V20241115)
  diarization?: TranscribeDiarizationProperties;

  @doc("The 0-based indices of the channels to be transcribed separately. If not specified, multiple channels are merged and transcribed jointly. Only up to two channels are supported.")
  channels?: Array<int32>;
}

@doc("The diarization settings. Diarization settings must be specified to enable diarization.")
@added(ServiceApiVersions.V20241115)
model TranscribeDiarizationProperties {
  @doc("Gets or sets a value indicating whether speaker diarization is enabled.")
  enabled?: boolean;

  @maxValue(35)
  @minValue(2)
  @doc("Gets or sets a hint for the maximum number of speakers for diarization. Must be greater than 1 and less than 36.")
  maxSpeakers?: int32;
}

@doc("High level error codes.")
union ErrorCode {
  InvalidRequest: "InvalidRequest",
  InvalidArgument: "InvalidArgument",
  InternalServerError: "InternalServerError",
  ServiceUnavailable: "ServiceUnavailable",
  NotFound: "NotFound",
  PipelineError: "PipelineError",
  Conflict: "Conflict",
  InternalCommunicationFailed: "InternalCommunicationFailed",
  Forbidden: "Forbidden",
  NotAllowed: "NotAllowed",
  Unauthorized: "Unauthorized",
  UnsupportedMediaType: "UnsupportedMediaType",
  TooManyRequests: "TooManyRequests",
  UnprocessableEntity: "UnprocessableEntity",
}

model InnerError {
  code?: DetailedErrorCode;

  @doc("Additional supportive details regarding the error and/or expected policies.")
  details?: Record<string>;

  @doc("High level error message.")
  message?: string;

  @doc("The source of the error.\r\nFor example it would be \"documents\" or \"document id\" in case of invalid document.")
  target?: string;

  innerError?: InnerError;
}

@doc("Detailed error code enum.")
union DetailedErrorCode {
  InvalidParameterValue: "InvalidParameterValue",
  InvalidRequestBodyFormat: "InvalidRequestBodyFormat",
  EmptyRequest: "EmptyRequest",
  MissingInputRecords: "MissingInputRecords",
  InvalidDocument: "InvalidDocument",
  ModelVersionIncorrect: "ModelVersionIncorrect",
  InvalidDocumentBatch: "InvalidDocumentBatch",
  UnsupportedLanguageCode: "UnsupportedLanguageCode",
  DataImportFailed: "DataImportFailed",
  InUseViolation: "InUseViolation",
  InvalidLocale: "InvalidLocale",
  InvalidBaseModel: "InvalidBaseModel",
  InvalidAdaptationMapping: "InvalidAdaptationMapping",
  InvalidDataset: "InvalidDataset",
  InvalidTest: "InvalidTest",
  FailedDataset: "FailedDataset",
  InvalidModel: "InvalidModel",
  InvalidTranscription: "InvalidTranscription",
  InvalidPayload: "InvalidPayload",
  InvalidParameter: "InvalidParameter",
  EndpointWithoutLogging: "EndpointWithoutLogging",
  InvalidPermissions: "InvalidPermissions",
  InvalidPrerequisite: "InvalidPrerequisite",
  InvalidProductId: "InvalidProductId",
  InvalidSubscription: "InvalidSubscription",
  InvalidProject: "InvalidProject",
  InvalidProjectKind: "InvalidProjectKind",
  InvalidRecordingsUri: "InvalidRecordingsUri",
  OnlyOneOfUrlsOrContainerOrDataset: "OnlyOneOfUrlsOrContainerOrDataset",
  ExceededNumberOfRecordingsUris: "ExceededNumberOfRecordingsUris",
  InvalidChannels: "InvalidChannels",
  ModelMismatch: "ModelMismatch",
  ProjectGenderMismatch: "ProjectGenderMismatch",
  ModelDeprecated: "ModelDeprecated",
  ModelExists: "ModelExists",
  ModelNotDeployable: "ModelNotDeployable",
  EndpointNotUpdatable: "EndpointNotUpdatable",
  SingleDefaultEndpoint: "SingleDefaultEndpoint",
  EndpointCannotBeDefault: "EndpointCannotBeDefault",
  InvalidModelUri: "InvalidModelUri",
  SubscriptionNotFound: "SubscriptionNotFound",
  QuotaViolation: "QuotaViolation",
  UnsupportedDelta: "UnsupportedDelta",
  UnsupportedFilter: "UnsupportedFilter",
  UnsupportedPagination: "UnsupportedPagination",
  UnsupportedDynamicConfiguration: "UnsupportedDynamicConfiguration",
  UnsupportedOrderBy: "UnsupportedOrderBy",
  NoUtf8WithBom: "NoUtf8WithBom",
  ModelDeploymentNotCompleteState: "ModelDeploymentNotCompleteState",
  SkuLimitsExist: "SkuLimitsExist",
  DeployingFailedModel: "DeployingFailedModel",
  UnsupportedTimeRange: "UnsupportedTimeRange",
  InvalidLogDate: "InvalidLogDate",
  InvalidLogId: "InvalidLogId",
  InvalidLogStartTime: "InvalidLogStartTime",
  InvalidLogEndTime: "InvalidLogEndTime",
  InvalidTopForLogs: "InvalidTopForLogs",
  InvalidSkipTokenForLogs: "InvalidSkipTokenForLogs",
  DeleteNotAllowed: "DeleteNotAllowed",
  Forbidden: "Forbidden",
  DeployNotAllowed: "DeployNotAllowed",
  UnexpectedError: "UnexpectedError",
  InvalidCollection: "InvalidCollection",
  InvalidCallbackUri: "InvalidCallbackUri",
  InvalidSasValidityDuration: "InvalidSasValidityDuration",
  InaccessibleCustomerStorage: "InaccessibleCustomerStorage",
  UnsupportedClassBasedAdaptation: "UnsupportedClassBasedAdaptation",
  InvalidWebHookEventKind: "InvalidWebHookEventKind",
  InvalidTimeToLive: "InvalidTimeToLive",
  InvalidSourceAzureResourceId: "InvalidSourceAzureResourceId",
  ModelCopyAuthorizationExpired: "ModelCopyAuthorizationExpired",
}

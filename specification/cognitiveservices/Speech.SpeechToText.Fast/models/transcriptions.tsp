import "@typespec/versioning";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

namespace Azure.Speech.SpeechToText;

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

  @doc("The project refernce of the object")
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
  project?: EntityReference;
}

@doc("TranscriptionUpdate")
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
  duration?: string;

  @doc("A collection of the requested channel numbers. In the default case, the channels 0 and 1 are considered.")
  channels?: Array<int32>;

  @doc("The requested destination container.\n\nRemarks\n\nWhen a destination container is used in combination with a timeToLive, the metadata of a transcription will be deleted normally, but the data stored in the destination container, including transcription results, will remain untouched, because no delete permissions are required for this container.\n\nTo support automatic cleanup, either configure blob lifetimes on the container, or use \"Bring your own Storage (BYOS)\" instead of destinationContainerUrl, where blobs can be cleaned up.")
  destinationContainerUrl?: url;

  @doc("The mode used for punctuation.")
  punctuationMode?: PunctuationMode;

  @doc("Mode of profanity filtering.")
  profanityFilterMode?: ProfanityFilterMode;

  @doc("How long the transcription will be kept in the system after it has completed. Once the transcription reaches the time to live after completion (successful or failed) it will be automatically deleted.\n\nNote: When using BYOS (bring your own storage), the result files on the customer owned storage account will also be deleted. Use either destinationContainerUrl to specify a separate container for result files which will not be deleted when the timeToLive expires, or retrieve the result files through the API and store them as needed.\n\nThe shortest supported duration is 6h, the longest supported duration is 31 days. 2 days (\"P2D\") is the recommended default value when data is consumed directly. The duration is encoded as ISO 8601 duration (\"PnYnMnDTnHnMnS\", see https://en.wikipedia.org/wiki/ISO_8601#Durations).")
  timeToLive: string;

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
@doc("DiarizationSpeakersProperties")
model DiarizationSpeakersProperties {
  @minValue(1)
  @doc("A hint for the minimum number of speakers for diarization. Must be smaller than or equal to the maxSpeakers property.")
  minCount?: int32;

  @minValue(1)
  @doc("The maximum number of speakers for diarization. Must be less than 36 and larger than or equal to the minSpeakers property.")
  maxCount?: int32;
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

@doc("The result of the transcribe operation.")
model TranscribeResult {
  @doc("The duration of the audio in milliseconds.")
  @renamedFrom(ServiceApiVersions.V20241115, "duration")
  @typeChangedFrom(ServiceApiVersions.V20241115, "int64")
  durationMilliseconds: int32;

  @doc("The full transcript for each channel.")
  combinedPhrases: Array<ChannelCombinedPhrases>;

  @doc("The transcription results segmented into phrases.")
  phrases: Array<Phrase>;
}

@doc("The full transcript per channel.")
@renamedFrom(ServiceApiVersions.V20241115, "CombinedPhrases")
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
  @doc("The confidence value for the phrase.") confidence: float32;
}

@doc("Time-stamped word in the display form.")
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
@error
model Error {
  @doc("High level error code.")
  code?: ErrorCode;

  @doc("Additional supportive details regarding the error and/or expected policies.")
  details?: Array<Error>;

  @doc("High level error message.")
  message?: string;

  @doc("The source of the error.\r\nFor example it would be \"documents\" or \"document id\" in case of invalid document.")
  target?: string;

  @doc("New Inner Error format which conforms to Cognitive Services API Guidelines which is available at https://microsoft.sharepoint.com/%3Aw%3A/t/CognitiveServicesPMO/EUoytcrjuJdKpeOKIK_QRC8BPtUYQpKBi8JsWyeDMRsWlQ?e=CPq8ow. This contains required properties ErrorCode, message and optional properties target, details(key value pair), inner error(this can be nested).")
  innerError?: InnerError;
}

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
  @doc("Representing the invalid request error code.")
  InvalidRequest: "InvalidRequest",

  @doc("Representing the invalid argument error code.")
  InvalidArgument: "InvalidArgument",

  @doc("Representing the internal server error error code.")
  InternalServerError: "InternalServerError",

  @doc("Representing the service unavailable error code.")
  ServiceUnavailable: "ServiceUnavailable",

  @doc("Representing the not found error code.")
  NotFound: "NotFound",

  @doc("Representing the pipeline error error code.")
  PipelineError: "PipelineError",

  @doc("Representing the conflict error code.")
  Conflict: "Conflict",

  @doc("Representing the internal communication failed error code.")
  InternalCommunicationFailed: "InternalCommunicationFailed",

  @doc("Representing the forbidden error code.")
  Forbidden: "Forbidden",

  @doc("Representing the not allowed error code.")
  NotAllowed: "NotAllowed",

  @doc("Representing the unauthorized error code.")
  Unauthorized: "Unauthorized",

  @doc("Representing the unsupported media type error code.")
  UnsupportedMediaType: "UnsupportedMediaType",

  @doc("Representing the too many requests error code.")
  TooManyRequests: "TooManyRequests",

  @doc("Representing the unprocessable entity error code.")
  UnprocessableEntity: "UnprocessableEntity",

  string,
}

@doc("InnerError")
model InnerError {
  @doc("Detailed error code enum.")
  code?: DetailedErrorCode;

  @doc("Additional supportive details regarding the error and/or expected policies.")
  details?: Record<string>;

  @doc("High level error message.")
  message?: string;

  @doc("The source of the error.\r\nFor example it would be \"documents\" or \"document id\" in case of invalid document.")
  target?: string;

  #suppress "@azure-tools/typespec-azure-core/property-name-conflict" "This can be nested."
  @doc("New Inner Error format which conforms to Cognitive Services API Guidelines which is available at https://microsoft.sharepoint.com/%3Aw%3A/t/CognitiveServicesPMO/EUoytcrjuJdKpeOKIK_QRC8BPtUYQpKBi8JsWyeDMRsWlQ?e=CPq8ow. This contains required properties ErrorCode, message and optional properties target, details(key value pair), inner error(this can be nested).")
  innerError?: InnerError;
}

@doc("Detailed error code enum.")
union DetailedErrorCode {
  @doc("Invalid parameter value.")
  InvalidParameterValue: "InvalidParameterValue",

  @doc("Invalid request body format.")
  InvalidRequestBodyFormat: "InvalidRequestBodyFormat",

  @doc("Empty Request.")
  EmptyRequest: "EmptyRequest",

  @doc("Missing Input Records.")
  MissingInputRecords: "MissingInputRecords",

  @doc("Invalid Document.")
  InvalidDocument: "InvalidDocument",

  @doc("Model Version Incorrect.")
  ModelVersionIncorrect: "ModelVersionIncorrect",

  @doc("Invalid Document Batch.")
  InvalidDocumentBatch: "InvalidDocumentBatch",

  @doc("Unsupported language code.")
  UnsupportedLanguageCode: "UnsupportedLanguageCode",

  @doc("Data import failed.")
  DataImportFailed: "DataImportFailed",

  @doc("In use violation.")
  InUseViolation: "InUseViolation",

  @doc("Invalid locale.")
  InvalidLocale: "InvalidLocale",

  @doc("Invalid base model.")
  InvalidBaseModel: "InvalidBaseModel",

  @doc("Invalid adaptation mapping.")
  InvalidAdaptationMapping: "InvalidAdaptationMapping",

  @doc("Invalid dataset.")
  InvalidDataset: "InvalidDataset",

  @doc("Invalid test.")
  InvalidTest: "InvalidTest",

  @doc("Failed dataset.")
  FailedDataset: "FailedDataset",

  @doc("Invalid model.")
  InvalidModel: "InvalidModel",

  @doc("Invalid transcription.")
  InvalidTranscription: "InvalidTranscription",

  @doc("Invalid payload.")
  InvalidPayload: "InvalidPayload",

  @doc("Invalid parameter.")
  InvalidParameter: "InvalidParameter",

  @doc("Endpoint without logging.")
  EndpointWithoutLogging: "EndpointWithoutLogging",

  @doc("Invalid permissions.")
  InvalidPermissions: "InvalidPermissions",

  @doc("Invalid prerequisite.")
  InvalidPrerequisite: "InvalidPrerequisite",

  @doc("Invalid product id.")
  InvalidProductId: "InvalidProductId",

  @doc("Invalid subscription.")
  InvalidSubscription: "InvalidSubscription",

  @doc("Invalid project.")
  InvalidProject: "InvalidProject",

  @doc("Invalid project kind.")
  InvalidProjectKind: "InvalidProjectKind",

  @doc("Invalid recordings uri.")
  InvalidRecordingsUri: "InvalidRecordingsUri",

  @doc("Only one of urls or container or dataset.")
  OnlyOneOfUrlsOrContainerOrDataset: "OnlyOneOfUrlsOrContainerOrDataset",

  @doc("Exceeded number of recordings uris.")
  ExceededNumberOfRecordingsUris: "ExceededNumberOfRecordingsUris",

  @doc("Invalid channels.")
  InvalidChannels: "InvalidChannels",

  @doc("Model mismatch.")
  ModelMismatch: "ModelMismatch",

  @doc("Project gender mismatch.")
  ProjectGenderMismatch: "ProjectGenderMismatch",

  @doc("Model deprecated.")
  ModelDeprecated: "ModelDeprecated",

  @doc("Model exists.")
  ModelExists: "ModelExists",

  @doc("Model not deployable.")
  ModelNotDeployable: "ModelNotDeployable",

  @doc("Endpoint not updatable.")
  EndpointNotUpdatable: "EndpointNotUpdatable",

  @doc("Single default endpoint.")
  SingleDefaultEndpoint: "SingleDefaultEndpoint",

  @doc("Endpoint cannot be default.")
  EndpointCannotBeDefault: "EndpointCannotBeDefault",

  @doc("Invalid model uri.")
  InvalidModelUri: "InvalidModelUri",

  @doc("Subscription not found.")
  SubscriptionNotFound: "SubscriptionNotFound",

  @doc("Quota violation.")
  QuotaViolation: "QuotaViolation",

  @doc("Unsupported delta.")
  UnsupportedDelta: "UnsupportedDelta",

  @doc("Unsupported filter.")
  UnsupportedFilter: "UnsupportedFilter",

  @doc("Unsupported pagination.")
  UnsupportedPagination: "UnsupportedPagination",

  @doc("Unsupported dynamic configuration.")
  UnsupportedDynamicConfiguration: "UnsupportedDynamicConfiguration",

  @doc("Unsupported order by.")
  UnsupportedOrderBy: "UnsupportedOrderBy",

  @doc("No utf8 with bom.")
  NoUtf8WithBom: "NoUtf8WithBom",

  @doc("Model deployment not complete state.")
  ModelDeploymentNotCompleteState: "ModelDeploymentNotCompleteState",

  @doc("Sku limits exist.")
  SkuLimitsExist: "SkuLimitsExist",

  @doc("Deploying failed model.")
  DeployingFailedModel: "DeployingFailedModel",

  @doc("Unsupported time range.")
  UnsupportedTimeRange: "UnsupportedTimeRange",

  @doc("Invalid log date.")
  InvalidLogDate: "InvalidLogDate",

  @doc("Invalid log id.")
  InvalidLogId: "InvalidLogId",

  @doc("Invalid log start time.")
  InvalidLogStartTime: "InvalidLogStartTime",

  @doc("Invalid log end time.")
  InvalidLogEndTime: "InvalidLogEndTime",

  @doc("Invalid top for logs.")
  InvalidTopForLogs: "InvalidTopForLogs",

  @doc("Invalid skip token for logs.")
  InvalidSkipTokenForLogs: "InvalidSkipTokenForLogs",

  @doc("Delete not allowed.")
  DeleteNotAllowed: "DeleteNotAllowed",

  @doc("Forbidden")
  Forbidden: "Forbidden",

  @doc("Deploy not allowed.")
  DeployNotAllowed: "DeployNotAllowed",

  @doc("Unexpected error.")
  UnexpectedError: "UnexpectedError",

  @doc("Invalid collection.")
  InvalidCollection: "InvalidCollection",

  @doc("Invalid callback uri.")
  InvalidCallbackUri: "InvalidCallbackUri",

  @doc("Invalid sas validity duration.")
  InvalidSasValidityDuration: "InvalidSasValidityDuration",

  @doc("Inaccessible customer storage.")
  InaccessibleCustomerStorage: "InaccessibleCustomerStorage",

  @doc("Unsupported class based adaptation.")
  UnsupportedClassBasedAdaptation: "UnsupportedClassBasedAdaptation",

  @doc("Invalid web hook event kind.")
  InvalidWebHookEventKind: "InvalidWebHookEventKind",

  @doc("Invalid time to live.")
  InvalidTimeToLive: "InvalidTimeToLive",

  @doc("Invalid source Azure resource ID.")
  InvalidSourceAzureResourceId: "InvalidSourceAzureResourceId",

  @doc("Expired ModelCopyAuthorization.")
  ModelCopyAuthorizationExpired: "ModelCopyAuthorizationExpired",

  @doc("Language Identification did not recognize any language.")
  NoLanguageIdentified: "NoLanguageIdentified",

  @doc("Language Identification recognized multiple languages. No dominant language could be determined.")
  MultipleLanguagesIdentified: "MultipleLanguagesIdentified",

  @doc("The format of input audio is not supported.")
  InvalidAudioFormat: "InvalidAudioFormat",

  @doc("There is a mismatch between audio channels in the data, in the configuration, or the requirements of the application.")
  BadChannelConfiguration: "BadChannelConfiguration",

  @doc("The selection of channels in the transcription request is not supported (e.g., neither 0 nor 1 have been selected.)")
  InvalidChannelSpecification: "InvalidChannelSpecification",

  @doc("The audio file is longer than the maximum allowed duration.")
  AudioLengthLimitExceeded: "AudioLengthLimitExceeded",

  @doc("The audio file is empty.")
  EmptyAudioFile: "EmptyAudioFile",

  string,
}

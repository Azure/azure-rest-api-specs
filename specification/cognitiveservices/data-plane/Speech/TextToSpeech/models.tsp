import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace CustomvoiceAPI;

/** Project kind */
union ProjectKind {
  string,

  /** ProfessionalVoice */
  ProfessionalVoice: "ProfessionalVoice",

  /** PersonalVoice */
  PersonalVoice: "PersonalVoice",
}

/** Top-level error code */
union ErrorCode {
  string,

  /** BadRequest */
  BadRequest: "BadRequest",

  /** BadArgument */
  BadArgument: "BadArgument",

  /** Unauthorized */
  Unauthorized: "Unauthorized",

  /** Forbidden */
  Forbidden: "Forbidden",

  /** NotFound */
  NotFound: "NotFound",

  /** UnsupportedMediaType */
  UnsupportedMediaType: "UnsupportedMediaType",

  /** TooManyRequests */
  TooManyRequests: "TooManyRequests",

  /** InternalServerError */
  InternalServerError: "InternalServerError",

  /** ServiceUnavailable */
  ServiceUnavailable: "ServiceUnavailable",
}

/** Consent creation failure reason */
union ConsentFailureReason {
  string,

  /**
   * The consent audio mismatch with verbal statement. Please check
   * [verbal-statement](https://github.com/Azure-Samples/Cognitive-Speech-TTS/blob/master/CustomVoice/script/verbal-statement-all-locales.txt).
   */
  AudioAndScriptNotMatch: "AudioAndScriptNotMatch",

  /** Custom Voice Service error. */
  Internal: "Internal",
}

/** Status of a resource. */
union Status {
  string,

  /** NotStarted */
  NotStarted: "NotStarted",

  /** Running */
  Running: "Running",

  /** Succeeded */
  Succeeded: "Succeeded",

  /** Failed */
  Failed: "Failed",

  /** Disabling */
  Disabling: "Disabling",

  /** Disabled */
  Disabled: "Disabled",
}

/** Voice kind */
union VoiceKind {
  string,

  /** Male */
  Male: "Male",

  /** Female */
  Female: "Female",
}

/** Dataset kind */
union DatasetKind {
  string,

  /** AudioAndScript */
  AudioAndScript: "AudioAndScript",

  /** LongAudio */
  LongAudio: "LongAudio",

  /** AudioOnly */
  AudioOnly: "AudioOnly",
}

/**
 * Dataset processing method. If not specified, the default processing method will
 * be used.
 */
union DatasetProcessAs {
  string,

  /** The default processing mode that works with all supported languages. */
  Segmented: "Segmented",

  /**
   * An enhanced mode that retains the audio as a whole to keep the contextual
   * information for more natural intonations.
   */
  Contextual: "Contextual",
}

/** Model training failure reason */
union ModelFailureReason {
  string,

  /**
   * The customer uses Bring Your Own Storage in Speech Account. But the storage is
   * not accessible now. Please check
   * [doc](https://learn.microsoft.com/azure/ai-services/speech-service/bring-your-own-storage-speech-resource?tabs=portal#configure-byos-associated-storage-account).
   */
  InaccessibleCustomerStorage: "InaccessibleCustomerStorage",

  /** The consent and training audio are not from the same speaker. */
  SpeakerVerificationFailed: "SpeakerVerificationFailed",

  /** The customer canceled model training. */
  TerminateByUser: "TerminateByUser",

  /** Custom Voice Service error. */
  Internal: "Internal",

  /** Training data is not ready for model training. */
  DataNotReady: "DataNotReady",

  /** Training data is not enough for model training. */
  DataNotEnough: "DataNotEnough",
}

/** Endpoint kind */
union EndpointKind {
  string,

  /** HighPerformance */
  HighPerformance: "HighPerformance",

  /** FastResume */
  FastResume: "FastResume",
}

/** Model capability */
union ModelCapability {
  string,

  /** PersonalVoice */
  PersonalVoice: "PersonalVoice",
}

/** Status of an operation. */
union OperationStatus {
  string,

  /** NotStarted */
  NotStarted: "NotStarted",

  /** Running */
  Running: "Running",

  /** Succeeded */
  Succeeded: "Succeeded",

  /** Failed */
  Failed: "Failed",
}

/** Paginated project list */
model PaginatedProjects is Azure.Core.Page<Project>;

/**
 * Project object. Consents, training sets, models, and endpoints are organized in
 * a project.
 */
model Project {
  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  id?: string;

  /** Project name */
  @minLength(1)
  displayName?: string;

  /** Project description */
  description?: string;

  /** Project kind */
  kind: ProjectKind;

  /**
   * The locale of this project. Locale code follows BCP-47. You can find the text
   * to speech locale list here
   * https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts.
   */
  locale?: string;

  /**
   * The timestamp when the object was created. The timestamp is encoded as ISO 8601
   * date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;
}

/**
 * Error response follows Microsoft Azure REST API Guidelines which is available
 * at
 * https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#handling-errors.
 */
@error
model ErrorResponse {
  /**
   * Top-level error follows Microsoft Azure REST API Guidelines which is available
   * at
   * https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#handling-errors.
   * This contains an top-level error with error code, message, details, target and
   * an inner error with more descriptive details.
   */
  error: Error;
}

/**
 * Top-level error follows Microsoft Azure REST API Guidelines which is available
 * at
 * https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#handling-errors.
 * This contains an top-level error with error code, message, details, target and
 * an inner error with more descriptive details.
 */
model Error {
  /** Top-level error code */
  code: ErrorCode;

  /**
   * The source of the error. For example it would be "model" or "model id" in case
   * of invalid model.
   */
  target?: string;

  /** Top-level error message. */
  message: string;

  /** Additional supportive details regarding the error and/or expected policies. */
  details?: Error[];

  /**
   * Inner error follows Microsoft Azure REST API Guidelines which is available at
   * https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#handling-errors.
   * This contains required properties error code, message and optional properties
   * target, inner error(this can be nested).
   */
  innererror?: InnerError;
}

/**
 * Inner error follows Microsoft Azure REST API Guidelines which is available at
 * https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#handling-errors.
 * This contains required properties error code, message and optional properties
 * target, inner error(this can be nested).
 */
model InnerError {
  /** Detailed error code to help diagnostic. */
  code?: string;

  /**
   * The source of the error. For example it would be "model" or "model id" in case
   * of invalid model.
   */
  target?: string;

  /** Detailed error message. */
  message?: string;

  /**
   * Inner error follows Microsoft Azure REST API Guidelines which is available at
   * https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#handling-errors.
   * This contains required properties error code, message and optional properties
   * target, inner error(this can be nested).
   */
  innererror?: InnerError;
}

/** Paginated consent list */
model PaginatedConsents is Azure.Core.Page<Consent>;

/** Consent object */
model Consent {
  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  id?: string;

  /** Name of consent. */
  @minLength(1)
  displayName?: string;

  /** Description of consent. */
  description?: string;

  /** Voice talent name. Must match the voice talent name in the consent audio file. */
  @minLength(1)
  voiceTalentName: string;

  /** Company name. Must match the company name in the consent audio file. */
  @minLength(1)
  companyName: string;

  /**
   * The public accessible URL of the consent audio file. It's recommended to be an
   * Azure blob URL with
   * [SAS](https://learn.microsoft.com/azure/storage/common/storage-sas-overview).
   * This property is only available in request.
   */
  audioUrl?: url;

  /**
   * The locale of this consent. Locale code follows BCP-47. You can find the text
   * to speech locale list here
   * https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts.
   */
  locale: string;

  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  projectId: string;

  /** Consent properties */
  properties?: ConsentProperties;

  /** Status of a resource. */
  status?: Status;

  /**
   * The timestamp when the object was created. The timestamp is encoded as ISO 8601
   * date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations)
   */
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;

  /**
   * The timestamp when the current status was entered. The timestamp is encoded as
   * ISO 8601 date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  @visibility(Lifecycle.Read)
  lastActionDateTime?: utcDateTime;
}

/** Consent properties */
model ConsentProperties {
  /** Consent creation failure reason */
  failureReason?: ConsentFailureReason;
}

/** Paginated training set list */
model PaginatedTrainingSets is Azure.Core.Page<TrainingSet>;

/** Training set */
model TrainingSet {
  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  id?: string;

  /** Training set name */
  @minLength(1)
  displayName?: string;

  /** Training set description */
  description?: string;

  /**
   * The locale of the training dataset. Locale code follows BCP-47. You can find
   * the text to speech locale list here
   * https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts.
   */
  locale: string;

  /** Voice kind */
  voiceKind?: VoiceKind;

  /** Training set properties */
  properties?: TrainingSetProperties;

  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  projectId: string;

  /** Status of a resource. */
  status?: Status;

  /**
   * The timestamp when the object was created. The timestamp is encoded as ISO 8601
   * date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;

  /**
   * The timestamp when the current status was entered. The timestamp is encoded as
   * ISO 8601 date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  @visibility(Lifecycle.Read)
  lastActionDateTime?: utcDateTime;
}

/** Training set properties */
model TrainingSetProperties {
  /** Utterance count in this training set */
  utteranceCount?: int32;

  /** Total duration of audio in seconds in this training set */
  durationInSeconds?: float64;

  /** Indicates whether the training set is composed of contextual data */
  isContextual?: boolean;
}

/** Dataset object */
model Dataset {
  /** The name of this dataset. */
  displayName?: string;

  /** Optional description of this dataset. */
  description?: string;

  /** Dataset kind */
  kind: DatasetKind;

  /**
   * Dataset processing method. If not specified, the default processing method will
   * be used.
   */
  processAs?: DatasetProcessAs;

  /**
   * Azure Blob Storage content. With the examples below, it represents files
   * https://contoso.blob.core.windows.net/voicecontainer/jessica/*.wav
   */
  audios: AzureBlobContentSource;

  /**
   * Azure Blob Storage content. With the examples below, it represents files
   * https://contoso.blob.core.windows.net/voicecontainer/jessica/*.wav
   */
  scripts?: AzureBlobContentSource;
}

/**
 * Azure Blob Storage content. With the examples below, it represents files
 * https://contoso.blob.core.windows.net/voicecontainer/jessica/*.wav
 */
model AzureBlobContentSource {
  /**
   * Azure Blob Storage container URL with
   * [SAS](https://learn.microsoft.com/azure/storage/common/storage-sas-overview).
   * Need both read and list permissions.
   */
  containerUrl: url;

  /** Blob name prefix. */
  prefix?: string;

  /** File name extensions. */
  extensions: string[];
}

/** Paginated recipe list */
model PaginatedRecipes is Azure.Core.Page<Recipe>;

/** Recipe for model building. Different recipes have different capability. */
model Recipe {
  /** Recipe kind */
  kind?: string;

  /** Recipe version */
  version?: string;

  /** Recipe description */
  @visibility(Lifecycle.Read)
  description?: string;

  /** Minimum utterance count required to train a voice model with this recipe. */
  @visibility(Lifecycle.Read)
  minUtteranceCount?: int32;

  /** Minimum utterance count required to train each customized style. */
  @visibility(Lifecycle.Read)
  minStyleUtteranceCount?: int32;

  /** Maximum customized style number supported in one voice model. */
  @visibility(Lifecycle.Read)
  maxCustomStyleNum?: int32;

  /**
   * The locale of the training dataset. Locale code follows BCP-47. You can find
   * the text to speech locale list here
   * https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts.
   */
  @visibility(Lifecycle.Read)
  datasetLocales?: string[];

  /**
   * The locale that a voice model can speak with this recipe. Locale code follows
   * BCP-47. You can find the text to speech locale list here
   * https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts.
   */
  @visibility(Lifecycle.Read)
  modelLocales?: string[];

  /**
   * Preset styles supported by this recipe per locale. You can get these styles
   * without any style training set.
   */
  @visibility(Lifecycle.Read)
  presetStyles?: Record<PresetStyleItem>;

  /**
   * Minimum audio duration in seconds required to train a voice model with this
   * recipe.
   */
  @visibility(Lifecycle.Read)
  minDurationInSeconds?: float64;
}

/**
 * Preset styles supported by the recipe. The voice model can support these styles
 * without any style training set.
 */
model PresetStyleItem {
  /** Preset styles supported on male voice model. */
  male?: string[];

  /** Preset styles supported on female voice model. */
  female?: string[];
}

/** Paginated model list */
model PaginatedModels is Azure.Core.Page<Model>;

/** Model object */
model Model {
  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  id?: string;

  /** Voice name */
  @minLength(1)
  voiceName?: string;

  /** Model description */
  description?: string;

  /** Recipe for model building. Different recipes have different capability. */
  recipe: Recipe;

  /**
   * The locale of this model. Locale code follows BCP-47. You can find the text to
   * speech locale list here
   * https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts.
   */
  locale?: string;

  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  projectId: string;

  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  consentId: string;

  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  trainingSetId: string;

  /** Engine version. Update this version can get the latest pronunciation bug fixing. */
  @visibility(Lifecycle.Read)
  engineVersion?: string;

  /** Model properties */
  properties?: ModelProperties;

  /** Status of a resource. */
  status?: Status;

  /**
   * The timestamp when the object was created. The timestamp is encoded as ISO 8601
   * date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;

  /**
   * The timestamp when the current status was entered. The timestamp is encoded as
   * ISO 8601 date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  @visibility(Lifecycle.Read)
  lastActionDateTime?: utcDateTime;
}

/** Model properties */
model ModelProperties {
  /** Preset styles of this model. */
  presetStyles?: string[];

  /** Customized styles and associated training sets. */
  styleTrainingSetIds?: Record<string>;

  /** All styles supported by this model. */
  @visibility(Lifecycle.Read)
  voiceStyles?: string[];

  /** Model training failure reason */
  failureReason?: ModelFailureReason;

  /** IDs of failed training sets. */
  @visibility(Lifecycle.Read)
  failedTrainingsets?: string[];

  /** Secondary locales that this model can speak. Locale code follows BCP-47. */
  @visibility(Lifecycle.Read)
  secondaryLocales?: string[];
}

/** Paginated endpoint list */
model PaginatedEndpoints is Azure.Core.Page<Endpoint>;

/** Endpoint object */
model Endpoint {
  /** Endpoint Id */
  @format("uuid")
  id?: string;

  /** Endpoint name */
  @minLength(1)
  displayName?: string;

  /** Endpoint description */
  description?: string;

  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  projectId: string;

  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  modelId: string;

  /** Endpoint properties */
  properties?: EndpointProperties;

  /** Status of a resource. */
  status?: Status;

  /**
   * The timestamp when the object was created. The timestamp is encoded as ISO 8601
   * date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;

  /**
   * The timestamp when the current status was entered. The timestamp is encoded as
   * ISO 8601 date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  @visibility(Lifecycle.Read)
  lastActionDateTime?: utcDateTime;
}

/** Endpoint properties */
model EndpointProperties {
  /** Endpoint kind */
  kind?: EndpointKind;
}

/** Paginated base model list */
model PaginatedBaseModels is Azure.Core.Page<BaseModel>;

/** Base model */
model BaseModel {
  /** Base model name */
  @minLength(1)
  name: string;

  /** Base model description */
  description?: string;

  /**
   * The stamp when the base model was released. The timestamp is encoded as ISO
   * 8601 date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  releaseDateTime: utcDateTime;

  /**
   * The timestamp when TTS service will stop serving this base model. The timestamp
   * is encoded as ISO 8601 date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  expirationDateTime?: utcDateTime;

  /** Capabilities of base model */
  capabilities?: ModelCapability[];
}

/** Paginated personal voice list */
model PaginatedPersonalVoices is Azure.Core.Page<PersonalVoice>;

/** Personal voice object */
model PersonalVoice {
  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  id?: string;

  /** Personal voice speaker profile id. Fill this property in SSML. */
  @visibility(Lifecycle.Read)
  @format("uuid")
  speakerProfileId?: string;

  /** Display name of personal voice */
  @minLength(1)
  displayName?: string;

  /** Personal voice description */
  description?: string;

  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  projectId: string;

  /** Resource id */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  consentId: string;

  /**
   * Azure Blob Storage content. With the examples below, it represents files
   * https://contoso.blob.core.windows.net/voicecontainer/jessica/*.wav
   */
  audios?: AzureBlobContentSource;

  /** Personal voice properties */
  properties?: PersonalVoiceProperties;

  /** Status of a resource. */
  status?: Status;

  /**
   * The timestamp when the object was created. The timestamp is encoded as ISO 8601
   * date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;

  /**
   * The timestamp when the current status was entered. The timestamp is encoded as
   * ISO 8601 date and time format ("YYYY-MM-DDThh:mm:ssZ", see
   * https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).
   */
  @visibility(Lifecycle.Read)
  lastActionDateTime?: utcDateTime;
}

/** Personal voice properties */
model PersonalVoiceProperties {
  /** Model training failure reason */
  failureReason?: ModelFailureReason;
}

/** Status of a long running operation. */
model Operation {
  /** Unique operation ID. */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
  id?: string;

  /** Status of an operation. */
  status?: OperationStatus;
}

/** Form data for creating a consent with an audio file. */
model ConsentPostFormData {
  /** The project ID. */
  projectId: HttpPart<string>;

  /** The display name of this consent. */
  displayName?: HttpPart<string>;

  /** Optional description of this consent. */
  description?: HttpPart<string>;

  /** The name of voice talent. */
  voiceTalentName: HttpPart<string>;

  /** The name of company. */
  companyName: HttpPart<string>;

  /** An audio file containing the audio data. */
  audiodata: HttpPart<bytes>;

  /**
   * The locale of this consent. Locale code follows BCP-47. You can find the text
   * to speech locale list here
   * https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts.
   */
  locale: HttpPart<string>;

  /** properties. */
  properties?: HttpPart<string>;
}

/** Form data for creating a personal voice with audio files. */
model PersonalVoicePostFormData {
  /** The display name of this model. */
  displayName?: HttpPart<string>;

  /** Optional description of this model. */
  description?: HttpPart<string>;

  /** The project ID. */
  projectId: HttpPart<string>;

  /** Audio files. Maximum file size is 30MB. */
  audioData?: HttpPart<bytes>;

  /** properties. */
  properties?: HttpPart<string>;
}

import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace CustomVoiceApi;

/** Resource ID */
@pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
@minLength(3)
@maxLength(64)
scalar resourceId extends string;

/** Project kind */
union ProjectKind {
  string,

  /** A project for creating a professional custom neural voice. */
  ProfessionalVoice: "ProfessionalVoice",

  /** A project for creating a personal voice from a short audio sample. */
  PersonalVoice: "PersonalVoice",
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

  /** The resource has not started processing yet. */
  NotStarted: "NotStarted",

  /** The resource is currently being processed. */
  Running: "Running",

  /** The resource was processed successfully. */
  Succeeded: "Succeeded",

  /** The resource processing failed. Check the failure reason for details. */
  Failed: "Failed",

  /** The resource is being disabled. */
  Disabling: "Disabling",

  /** The resource is disabled and not serving requests. */
  Disabled: "Disabled",
}

/** Voice kind */
union VoiceKind {
  string,

  /** The voice talent is male. */
  Male: "Male",

  /** The voice talent is female. */
  Female: "Female",
}

/** Dataset kind */
union DatasetKind {
  string,

  /** Training dataset containing both audio files and corresponding script files. */
  AudioAndScript: "AudioAndScript",

  /** Training dataset containing long audio files without script. */
  LongAudio: "LongAudio",

  /** Training dataset containing audio files only without corresponding scripts. */
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

  /** High performance endpoint with maximum throughput capacity. */
  HighPerformance: "HighPerformance",

  /** Fast resume endpoint optimized for quick startup after suspension. */
  FastResume: "FastResume",
}

/** Model capability */
union ModelCapability {
  string,

  /** The model supports personal voice synthesis. */
  PersonalVoice: "PersonalVoice",
}

/** Status of an operation. */
union OperationStatus {
  string,

  /** The operation has not started yet. */
  NotStarted: "NotStarted",

  /** The operation is currently in progress. */
  Running: "Running",

  /** The operation completed successfully. */
  Succeeded: "Succeeded",

  /** The operation failed. Check the error details for more information. */
  Failed: "Failed",

  /** The operation was canceled by the user. */
  Canceled: "Canceled",
}

/**
 * Project object. Consents, training sets, models, and endpoints are organized in
 * a project.
 */
@resource("projects")
model Project {
  /** Resource id */
  @key
  @visibility(Lifecycle.Read)
  id: resourceId;

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

/** Consent object */
@resource("consents")
model Consent {
  /** Resource id */
  @key
  @visibility(Lifecycle.Read)
  id: resourceId;

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
  projectId: resourceId;

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

/** Training set */
@resource("trainingsets")
model TrainingSet {
  /** Resource id */
  @key
  @visibility(Lifecycle.Read)
  id: resourceId;

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
  projectId: resourceId;

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

/** Model object */
@resource("models")
model Model {
  /** Resource id */
  @key
  @visibility(Lifecycle.Read)
  id: resourceId;

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
  projectId: resourceId;

  /** Resource id */
  consentId: resourceId;

  /** Resource id */
  trainingSetId: resourceId;

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

/** Endpoint object */
@resource("endpoints")
model Endpoint {
  /** Endpoint Id */
  @key
  @visibility(Lifecycle.Read)
  id: uuid;

  /** Endpoint name */
  @minLength(1)
  displayName?: string;

  /** Endpoint description */
  description?: string;

  /** Resource id */
  projectId: resourceId;

  /** Resource id */
  modelId: resourceId;

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

/** Base model */
@resource("basemodels")
model BaseModel {
  /** Base model name */
  @key
  @visibility(Lifecycle.Read)
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

/** Personal voice object */
@resource("personalvoices")
model PersonalVoice {
  /** Resource id */
  @key
  @visibility(Lifecycle.Read)
  id: resourceId;

  /** Personal voice speaker profile id. Fill this property in SSML. */
  @visibility(Lifecycle.Read)
  speakerProfileId?: uuid;

  /** Display name of personal voice */
  @minLength(1)
  displayName?: string;

  /** Personal voice description */
  description?: string;

  /** Resource id */
  projectId: resourceId;

  /** Resource id */
  consentId: resourceId;

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
@resource("operations")
model Operation {
  /** Unique operation ID. */
  @key
  @visibility(Lifecycle.Read)
  id: resourceId;

  /** Status of an operation. */
  status?: OperationStatus;
}

/** Operation-Id header for long-running operations. */
model OperationIdHeader {
  /**
   * ID of the status monitor for the operation. If the Operation-Id header matches
   * an existing operation and the request is not identical to the prior request, it
   * will fail with a 400 Bad Request.
   */
  @header("Operation-Id")
  operationId?: resourceId;
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

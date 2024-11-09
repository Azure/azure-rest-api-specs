import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.AnalyzeDocuments;

/** These are the [Azure Active Directory OAuth2](https://docs.microsoft.com/azure/active-directory/develop/v1-overview) Flows. When paired with [Azure role-based access](https://docs.microsoft.com/azure/role-based-access-control/overview) control it can be used to control access to Azure Maps REST APIs. Azure role-based access controls are used to designate access to one or more Azure Maps resource account or sub-resources. Any user, group, or service principal can be granted access via a  built-in role or a custom role composed of one or more permissions to Azure Maps REST APIs.\n\nTo implement scenarios, we recommend viewing [authentication concepts](https://aka.ms/amauth). In summary, this security definition provides a solution for modeling application(s) via objects capable of access control on specific APIs and scopes.\n\n#### Notes\n* This security definition **requires** the use of the `x-ms-client-id` header to indicate which Azure Maps resource the application is requesting access to. This can be acquired from the [Maps management API](https://aka.ms/amauthdetails).\n* \nThe `Authorization URL` is specific to the Azure public cloud instance. Sovereign clouds have unique Authorization URLs and Azure Active directory configurations. \n* \nThe Azure role-based access control is configured from the [Azure management plane](https://aka.ms/amrbac) via Azure portal, PowerShell, CLI, Azure SDKs, or REST APIs.\n* \nUsage of the [Azure Maps Web SDK](https://aka.ms/amaadmc) allows for configuration based setup of an application for multiple use cases.\n* Currently, Azure Active Directory [v1.0 or v2.0](https://docs.microsoft.com/azure/active-directory/develop/azure-ad-endpoint-comparison) supports Work, School, and Guests but does not support Personal accounts. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      scopes: ["https://cognitiveservices.azure.com/.default"];
    }
  ]>;

/** The kind of the long running analyze documents tasks supported. */
union AnalyzeDocumentsLROTaskKind {
  string,

  /** PII entity recognition task */
  PiiEntityRecognition: "PiiEntityRecognition",

  /** Extractive summarization task */
  ExtractiveSummarization: "ExtractiveSummarization",

  /** Abstractive summarization task */
  AbstractiveSummarization: "AbstractiveSummarization",
}

/** The kind of the response object returned by the analyze-documents long running task. */
union AnalyzeDocumentsLROResultsKind {
  string,

  /** PII entity recognition LRO results */
  PiiEntityRecognitionLROResults: "PiiEntityRecognitionLROResults",

  /** Extractive summarization LRO results */
  ExtractiveSummarizationLROResults: "ExtractiveSummarizationLROResults",

  /** Abstractive summarization LRO results */
  AbstractiveSummarizationLROResults: "AbstractiveSummarizationLROResults",
}

/** Collection of input documents to be analyzed by the service. */
model MultiLanguageAnalysisInput {
  /** The input documents to be analyzed. */
  documents?: Array<MultiLanguageInput>;
}

/** The long running task to be performed by the service on the input documents. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@discriminator("kind")
model AnalyzeDocumentsLROTask is TaskIdentifier {
  /** The kind of task to perform. */
  kind: AnalyzeDocumentsLROTaskKind;
}

/** The input object for the analyze documents LRO. */
model AnalyzeDocumentJobsInput {
  /** Name for the task. */
  displayName?: string;

  /** Contains the input to be analyzed. */
  analysisInput: MultiLanguageAnalysisInput;

  /** List of tasks to be performed as part of the LRO. */
  tasks: Array<AnalyzeDocumentsLROTask>;

  /** Default language to use for records. */
  defaultLanguage?: string;
}

/** The input object for the prebuilt/default result. */
model AnalyzeDocumentsPreBuiltResult {
  /** Errors by document id. */
  errors: Array<AnalyzeDocumentsDocumentError>;

  /** if showStats=true was specified in the request this field will contain information about the request payload. */
  statistics?: RequestStatistics;

  /** This field indicates which model is used for analysis. */
  modelVersion: string;
}

/** Defines the detected language for the document. */
model DocumentDetectedLanguage {
  /** If 'language' is set to 'auto' for the document in the request this field will contain a 2 letter ISO 639-1 representation of the language detected for this document. */
  detectedLanguage?: DetectedLanguage;
}

/** Contains the details of the detected language for the text. */
model DetectedLanguage {
  /** Long name of a detected language (e.g. English, French). */
  name: string;

  /** A two letter representation of the detected language according to the ISO 639-1 standard (e.g. en, fr). */
  iso6391Name: string;

  /** A confidence score between 0 and 1. Scores close to 1 indicate 100% certainty that the identified language is true. */
  confidenceScore: float64;

  /** Identifies the script of the input document. */
  script?: ScriptKind;

  /** Identifies the script of the input document. */
  scriptCode?: ScriptCode;
}

/** The script of the text. */
@added(Versions.v2023_11_15_preview)
union ScriptKind {
  string,

  /** Script name for the Arabic script. */
  Arabic: "Arabic",

  /** Script name for the Armenian script. */
  Armenian: "Armenian",

  /** Script name for the Bangla script. */
  Bangla: "Bangla",

  /** Script name for the UnifiedCanadianAboriginalSyllabics script. */
  UnifiedCanadianAboriginalSyllabics: "UnifiedCanadianAboriginalSyllabics",

  /** Script name for the Cyrillic script. */
  Cyrillic: "Cyrillic",

  /** Script name for the Devanagari script. */
  Devanagari: "Devanagari",

  /** Script name for the Ethiopic script. */
  Ethiopic: "Ethiopic",

  /** Script name for the Georgian script. */
  Georgian: "Georgian",

  /** Script name for the Greek script. */
  Greek: "Greek",

  /** Script name for the Gujarati script. */
  Gujarati: "Gujarati",

  /** Script name for the Gurmukhi script. */
  Gurmukhi: "Gurmukhi",

  /** Script name for the Hangul script. */
  Hangul: "Hangul",

  /** Script name for the HanSimplified script. */
  HanSimplified: "HanSimplified",

  /** Script name for the HanTraditional script. */
  HanTraditional: "HanTraditional",

  /** Script name for the Hebrew script. */
  Hebrew: "Hebrew",

  /** Script name for the Japanese script. */
  Japanese: "Japanese",

  /** Script name for the Khmer script. */
  Khmer: "Khmer",

  /** Script name for the Kannada script. */
  Kannada: "Kannada",

  /** Script name for the Lao script. */
  Lao: "Lao",

  /** Script name for the Latin script. */
  Latin: "Latin",

  /** Script name for the Malayalam script. */
  Malayalam: "Malayalam",

  /** Script name for the Myanmar script. */
  Myanmar: "Myanmar",

  /** Script name for the Odia script. */
  Odia: "Odia",

  /** Script name for the Sinhala script. */
  Sinhala: "Sinhala",

  /** Script name for the Tamil script. */
  Tamil: "Tamil",

  /** Script name for the Telugu script. */
  Telugu: "Telugu",

  /** Script name for the Thaana script. */
  Thaana: "Thaana",

  /** Script name for the Thai script. */
  Thai: "Thai",

  /** Script name for the Tibetan script. */
  Tibetan: "Tibetan",
}

/** Identifies the script of the input document. Maps to the ISO 15924 standard script code. */
@added(Versions.v2023_11_15_preview)
union ScriptCode {
  string,

  /** Script code for the Arabic script. */
  Arab: "Arab",

  /** Script code for the Armenian script. */
  Armn: "Armn",

  /** Script code for the Bangla script. */
  Beng: "Beng",

  /** Script code for the UnifiedCanadianAboriginalSyllabics script. */
  Cans: "Cans",

  /** Script code for the Cyrillic script. */
  Cyrl: "Cyrl",

  /** Script code for the Devanagari script. */
  Deva: "Deva",

  /** Script code for the Ethiopic script. */
  Ethi: "Ethi",

  /** Script code for the Georgian script. */
  Geor: "Geor",

  /** Script code for the Greek script. */
  Grek: "Grek",

  /** Script code for the Gujarati script. */
  Gujr: "Gujr",

  /** Script code for the Gurmukhi script. */
  Guru: "Guru",

  /** Script code for the Hangul script. */
  Hang: "Hang",

  /** Script code for the HanSimplified script. */
  Hans: "Hans",

  /** Script code for the HanTraditional script. */
  Hant: "Hant",

  /** Script code for the Hebrew script. */
  Hebr: "Hebr",

  /** Script code for the Japanese script. */
  Jpan: "Jpan",

  /** Script code for the Khmer script. */
  Khmr: "Khmr",

  /** Script code for the Kannada script. */
  Knda: "Knda",

  /** Script code for the Lao script. */
  Laoo: "Laoo",

  /** Script code for the Latin script. */
  Latn: "Latn",

  /** Script code for the Malayalam script. */
  Mlym: "Mlym",

  /** Script code for the Myanmar script. */
  Mymr: "Mymr",

  /** Script code for the Odia script. */
  Orya: "Orya",

  /** Script code for the Sinhala script. */
  Sinh: "Sinh",

  /** Script code for the Tamil script. */
  Taml: "Taml",

  /** Script code for the Telugu script. */
  Telu: "Telu",

  /** Script code for the Thaana script. */
  Thaa: "Thaa",

  /** Script code for the Thai script. */
  Thai: "Thai",

  /** Script code for the Tibetan script. */
  Tibt: "Tibt",
}

/** The object containing the analyze job LRO job state. */
@resource("analyze-documents/jobs")
model AnalyzeDocumentsJobState {
  ...JobState;
  ...TasksState;
  ...AnalyzeDocumentsJobStatistics;
}

/** Contains the pagination information. */
model Pagination {
  /** The nextLink for getting the next paginated response. */
  nextLink?: string;
}

/** Contains the analyze documents LRO errors */
model AnalyzeDocumentsJobErrors {
  /** Collection of errors encountered during processing. */
  errors: Array<Error>;
}

/** Contains the analyze documents job statistics returned only when showStats=true. */
model AnalyzeDocumentsJobStatistics {
  /** if showStats=true was specified in the request this field will contain information about the request payload. */
  statistics?: RequestStatistics;
}

/** Contains the analyze documents job tasks. */
model TasksState {
  /** List of tasks. */
  tasks: Tasks;
}

/** Container for the tasks status for the LRO job. */
model Tasks {
  /** Count of completed tasks. */
  completed: int32;

  /** Count of failed tasks. */
  failed: int32;

  /** Count of inprogress tasks. */
  inProgress: int32;

  /** Count of total tasks. */
  total: int32;

  /** Enumerable of Analyze documents job results. */
  items?: Array<AnalyzeDocumentsLROResult>;
}

/** Contains the result object for the processed document. */
model AnalyzeDocumentsResult is AnalyzeDocumentsPreBuiltResult {
  /** Response by document */
  documents: Array<DocumentAnalysisDocumentResult>;
}

/** List of job statuses. */
union Status {
  string,

  /** Not started status */
  notStarted: "notStarted",

  /** Running status */
  running: "running",

  /** Succeeded status */
  succeeded: "succeeded",

  /** Failed status */
  failed: "failed",

  /** Cancelled status */
  cancelled: "cancelled",

  /** Cancelling status */
  cancelling: "cancelling",
}

/** Contains the AnalyzeDocuments long running operation result object. */
#suppress "@azure-tools/typespec-azure-core/casing-style"
@discriminator("kind")
model AnalyzeDocumentsLROResult {
  ...TaskState;
  ...TaskIdentifier;

  /** Kind of the task. */
  kind: AnalyzeDocumentsLROResultsKind;
}

/** Contains the result object for the processed document. */
model DocumentResult {
  /** Unique, non-empty document identifier. */
  id: string;

  /** Warnings encountered while processing document. */
  warnings: Array<DocumentWarning>;

  /** if showStats=true was specified in the request this field will contain information about the document payload. */
  statistics?: DocumentStatistics;
}

model DocumentAnalysisDocumentResult is DocumentResult {
  /** Location of the input document. */
  source: DocumentLocation;

  /** Array of document results generated after the analysis. */
  target: Array<DocumentLocation>;
}

/** Contains the error object with errors encountered for the processed document. */
model AnalyzeDocumentsDocumentError {
  /** Document Id. */
  id: string;

  /** Document Error. */
  error: Error;
}

/** Contains the warnings object with warnings encountered for the processed document. */
model DocumentWarning {
  /** Warning code. */
  code: WarningCodeValue;

  /** Warning message. */
  message: string;

  /** A JSON pointer reference indicating the target object. */
  targetRef?: string;
}

/** Defines the list of the warning codes. */
union WarningCodeValue {
  string,

  /** Long words in document warning */
  LongWordsInDocument: "LongWordsInDocument",

  /** Document truncated warning */
  DocumentTruncated: "DocumentTruncated",
}

/** if showStats=true was specified in the request this field will contain information about the document payload. */
model DocumentStatistics {
  /** Number of documents elements recognized in the document. */
  charactersCount: int32;

  /** Number of transactions for the document. */
  transactionsCount: int32;
}

/** Contains an input document to be analyzed by the service. */
model MultiLanguageInput {
  /** A unique, non-empty document identifier. */
  id: string;

  /** The location of the input document to process. */
  source: DocumentLocation;

  /** The location where the processed document will be stored. */
  target: DocumentLocation;

  /** (Optional) This is the 2 letter ISO 639-1 representation of a language. For example, use \"en\" for English; \"es\" for Spanish etc. If not set, use \"en\" for English as default. */
  language?: string;
}

/** Contains the location of the document. */
@discriminator("kind")
model DocumentLocation {
  /** The kind of the document location. */
  kind: DocumentLocationKind;
}

/** Enumeration of supported document locations. */
union DocumentLocationKind {
  string,

  /** The document is a URL. */
  AzureBlob: "AzureBlob",
}

/** Document location for azure blobs. */
model AzureBlobDocumentLocation extends DocumentLocation {
  /** The kind of the document location. */
  kind: DocumentLocationKind.AzureBlob;

  /** The location of the document. */
  location: string;

  /** The user managed identity client Id to use to authenticate with the storage account */
  managedIdentityClientId?: string;
}

/** Error response. */
@error
model ErrorResponse is Azure.Core.Foundations.ErrorResponseBase<Error>;

/** An object containing more specific information about the error. As per Microsoft One API guidelines - https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#7102-error-condition-responses. */
model InnerErrorModel {
  /** One of a server-defined set of error codes. */
  code: InnerErrorCode;

  /** Error message. */
  message: string;

  /** Error details. */
  details?: Record<string>;

  /** Error target. */
  target?: string;

  /** An object containing more specific information than the current object about the error. */
  innererror?: InnerErrorModel;
}

/** Specifies the method used to interpret string offsets.  Defaults to documents Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/documents-analytics-offsets. */
union StringIndexType {
  string,

  /** Returned offset and length values will correspond to textElements (Graphemes and Grapheme clusters) confirming to the Unicode 8.0.0 standard. Use this option if your application is written in .Net Framework or .Net Core and you will be using StringInfo. */
  TextElements_v8: "TextElements_v8",

  /** Returned offset and length values will correspond to Unicode code points. Use this option if your application is written in a language that support Unicode, for example Python. */
  UnicodeCodePoint: "UnicodeCodePoint",

  /** Returned offset and length values will correspond to UTF-16 code units. Use this option if your application is written in a language that support Unicode, for example Java, JavaScript. */
  Utf16CodeUnit: "Utf16CodeUnit",
}

/** Returns the current state of the task. */
model TaskState {
  /** The last updated time in UTC for the task. */
  lastUpdateDateTime: utcDateTime;

  /** The status of the task at the mentioned last update time. */
  status: State;
}

/** The status of the task at the mentioned last update time. */
@lroStatus
union State {
  string,

  /** Not started status */
  notStarted: "notStarted",

  /** Running status */
  running: "running",

  /** Succeeded status */
  @lroSucceeded
  succeeded: "succeeded",

  /** Partially completed status */
  partiallyCompleted: "partiallyCompleted",

  /** Failed status */
  @lroFailed
  failed: "failed",

  /** Cancelled status */
  @lroCanceled
  cancelled: "cancelled",

  /** Cancelling status */
  cancelling: "cancelling",
}

/** Base task object. */
model TaskIdentifier {
  /** task name */
  taskName?: string;
}

/** Base parameters object for a documents analysis task. */
model TaskParameters {
  /** logging opt out */
  loggingOptOut?: boolean = false;
}

/** Parameters object for a documents analysis task using pre-built models. */
model PreBuiltTaskParameters is TaskParameters {
  /** model version */
  modelVersion?: string = "latest";
}

alias ShowStatsQueryParameter = QueryParametersTrait<{
  /** (Optional) if set to true, response will contain request and document level statistics. */
  @query
  showStats?: boolean;
}>;

alias AnalyzeDocumentsJobQueryParameters = QueryParametersTrait<{
  /** (Optional) if set to true, response will contain request and document level statistics. */
  @query
  showStats?: boolean;

  /** The maximum number of resources to return from the collection. */
  @query
  top?: int32;

  /** An offset into the collection of the first resource to be returned. */
  @query
  skip?: int32;
}>;

alias AnalyzeDocumentsQueryParameters = {
  /** (Optional) if set to true, response will contain request and document level statistics. */
  @query
  showStats?: boolean;
};

/** job state */
model JobState {
  /** display name */
  displayName?: string;

  /** Date and time job created */
  createdDateTime: utcDateTime;

  /** Date and time job expires */
  expirationDateTime?: utcDateTime;

  /** job ID */
  @key
  @visibility("read")
  jobId: uuid;

  /** last updated date and time */
  lastUpdatedDateTime: utcDateTime;

  /** status */
  status: State;

  /** errors */
  errors?: Array<Error>;

  /** next link */
  nextLink?: string;
}

/** job errors */
model JobErrors {
  /** errors */
  errors?: Array<Error>;
}

/** Contains details of errors encountered during a job execution. */
model DocumentError {
  /** The ID of the input document. */
  id: string;

  /** Error encountered. */
  error: Error;
}

/** Contains details of warnings encountered during a job execution. */
model InputWarning {
  /** Warning code. */
  code: string;

  /** Warning message. */
  message: string;

  /** A JSON pointer reference indicating the target object. */
  targetRef?: string;
}

/** if showStats=true was specified in the request this field will contain information about the request payload. */
model RequestStatistics {
  /** Number of documents submitted in the request. */
  documentsCount: int32;

  /** Number of valid documents. This excludes empty, over-size limit or non-supported languages documents. */
  validDocumentsCount: int32;

  /** Number of invalid documents. This includes empty, over-size limit or non-supported languages documents. */
  erroneousDocumentsCount: int32;

  /** Number of transactions for the request. */
  transactionsCount: int64;
}

/** Pre built result */
model PreBuiltResult {
  /** Errors by document id. */
  errors: Array<DocumentError>;

  /** if showStats=true was specified in the request this field will contain information about the request payload. */
  statistics?: RequestStatistics;

  /** This field indicates which model is used for scoring. */
  modelVersion: string;
}

/** Human-readable error code. */
union InnerErrorCode {
  string,

  /** Invalid request error */
  InvalidRequest: "InvalidRequest",

  /** Invalid parameter value error */
  InvalidParameterValue: "InvalidParameterValue",

  /** Knowledge base not found error */
  KnowledgeBaseNotFound: "KnowledgeBaseNotFound",

  /** Azure Cognitive Search not found error */
  AzureCognitiveSearchNotFound: "AzureCognitiveSearchNotFound",

  /** Azure Cognitive Search throttling error */
  AzureCognitiveSearchThrottling: "AzureCognitiveSearchThrottling",

  /** Extraction failure error */
  ExtractionFailure: "ExtractionFailure",

  /** Invalid request body format error */
  InvalidRequestBodyFormat: "InvalidRequestBodyFormat",

  /** Empty request error */
  EmptyRequest: "EmptyRequest",

  /** Missing input documents error */
  MissingInputDocuments: "MissingInputDocuments",

  /** Invalid document error */
  InvalidDocument: "InvalidDocument",

  /** Model version incorrect error */
  ModelVersionIncorrect: "ModelVersionIncorrect",

  /** Invalid document batch error */
  InvalidDocumentBatch: "InvalidDocumentBatch",

  /** Unsupported language code error */
  UnsupportedLanguageCode: "UnsupportedLanguageCode",

  /** Invalid country hint error */
  InvalidCountryHint: "InvalidCountryHint",
}

/** Human-readable error code. */
union ErrorCode {
  string,

  /** Invalid request error */
  InvalidRequest: "InvalidRequest",

  /** Invalid argument error */
  InvalidArgument: "InvalidArgument",

  /** Unauthorized access error */
  Unauthorized: "Unauthorized",

  /** Forbidden access error */
  Forbidden: "Forbidden",

  /** Not found error */
  NotFound: "NotFound",

  /** Project not found error */
  ProjectNotFound: "ProjectNotFound",

  /** Operation not found error */
  OperationNotFound: "OperationNotFound",

  /** Azure Cognitive Search not found error */
  AzureCognitiveSearchNotFound: "AzureCognitiveSearchNotFound",

  /** Azure Cognitive Search index not found error */
  AzureCognitiveSearchIndexNotFound: "AzureCognitiveSearchIndexNotFound",

  /** Too many requests error */
  TooManyRequests: "TooManyRequests",

  /** Azure Cognitive Search throttling error */
  AzureCognitiveSearchThrottling: "AzureCognitiveSearchThrottling",

  /** Azure Cognitive Search index limit reached error */
  AzureCognitiveSearchIndexLimitReached: "AzureCognitiveSearchIndexLimitReached",

  /** Internal server error */
  InternalServerError: "InternalServerError",

  /** Service unavailable error */
  ServiceUnavailable: "ServiceUnavailable",

  /** Timeout error */
  Timeout: "Timeout",

  /** Quota exceeded error */
  QuotaExceeded: "QuotaExceeded",

  /** Conflict error */
  Conflict: "Conflict",

  /** Warning error */
  Warning: "Warning",
}

/** Enum that defines the length of the output summaries. */
union SummaryLengthBucket {
  string,

  /** Instructs model to generate shorter length summaries. */
  short: "short",

  /** Instructs model to generate medium length summaries. */
  medium: "medium",

  /** Instructs model to generate longer length summaries. */
  long: "long",
}

/** Supported parameters for an Abstractive Summarization task. */
model AbstractiveSummarizationTaskParametersBase {
  /** Controls the approximate number of sentences in the output summaries. */
  sentenceCount?: int32;

  /** String index type */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;

  /** (NOTE: Recommended to use summaryLength over sentenceCount) Controls the approximate length of the output summaries. */
  summaryLength?: SummaryLengthBucket;
}

/** The context of the summary. */
model SummaryContext {
  /** Start position for the context. Use of different 'stringIndexType' values can affect the offset returned. */
  offset: int32;

  /** The length of the context. Use of different 'stringIndexType' values can affect the length returned. */
  length: int32;
}

/** Optional parameter to use a Custom Character to be used for redaction in PII responses. Default character will be * as before. We allow specific ascii characters for redaction. */
union redactionCharacter {
  string,

  /** Exclamation point character */
  exclamationPoint: "!",

  /** Number sign character */
  numberSign: "#",

  /** Dollar sign character */
  dollar: "$",

  /** Percent sign character */
  perCent: "%",

  /** Ampersand character */
  ampersand: "&",

  /** Asterisk character */
  asterisk: "*",

  /** Plus sign character */
  plus: "+",

  /** Minus sign character */
  minus: "-",

  /** Equals sign character */
  equals: "=",

  /** Question mark character */
  questionMark: "?",

  /** At sign character */
  atSign: "@",

  /** Caret character */
  caret: "^",

  /** Underscore character */
  underscore: "_",

  /** Tilde character */
  tilde: "~",
}

/** The error response object returned when the service encounters some errors during processing the request. */
model Error {
  /** One of a server-defined set of error codes. */
  code: ErrorCode;

  /** A human-readable representation of the error. */
  message: string;

  /** The target of the error. */
  target?: string;

  /** An array of details about specific errors that led to this reported error. */
  details?: Array<Error>;

  /** An object containing more specific information than the current object about the error. */
  innererror?: InnerErrorModel;
}

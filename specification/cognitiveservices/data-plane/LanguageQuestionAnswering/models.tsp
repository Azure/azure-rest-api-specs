import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";

using TypeSpec.Versioning;
using TypeSpec.Http;

@versioned(Language.QuestionAnswering.Versions)
namespace Language.QuestionAnswering;

/** The secret key for your Azure AI Language resource. */
alias AzureKey = ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">;

/**
 * These are the [Azure Active Directory OAuth2](https://learn.microsoft.com/azure/active-directory/develop/v1-overview) Flows.
 * When paired with [Azure role-based access](https://learn.microsoft.com/azure/role-based-access-control/overview) control it can be used to control access to Azure Maps REST APIs.
 * Azure role-based access controls are used to designate access to one or more Azure Language resource account or sub-resources. Any user, group, or service principal can be granted access
 * via a  built-in role or a custom role composed of one or more permissions to Azure Language REST APIs.
 *
 * To implement scenarios, we recommend viewing [authentication concepts](https://aka.ms/amauth).
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Model types must use PascalCase"
alias AADToken = OAuth2Auth<[
  {
    type: OAuth2FlowType.implicit;
    authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
    scopes: ["https://cognitiveservices.azure.com/.default"];
  }
]>;

/**
 * Type of ranker to be used.
 */
union RankerKind {
  string,

  /**
   * Question only ranker.
   */
  QuestionOnly: "QuestionOnly",

  /**
   * Default ranker.
   */
  Default: "Default",
}

/**
 * Set to 'OR' or 'AND' for using corresponding logical operation.
 */
union LogicalOperationKind {
  string,

  /**
   * 'AND' for using corresponding logical operation.
   */
  AND: "AND",

  /**
   * Set 'OR' for using corresponding logical operation.
   */
  OR: "OR",
}

/**
 * Type of scorer to be used
 */
@added(Versions.v2025_05_15_preview)
union Scorer {
  string,

  /**
   * Set this value for scoring based on classic algorithms like wordnet, tfidf, ngram etc.
   */
  Classic: "Classic",

  /**
   * Set this value for scoring based on transformer based models.
   */
  Transformer: "Transformer",

  /**
   * Set this scorer to use AI search semantic based ranking. Semantic ranking should be configured for this to be used.
   */
  Semantic: "Semantic",
}

/**
 * Kind of matching policy to be used
 */
@added(Versions.v2025_05_15_preview)
union MatchingPolicyKind {
  string,

  /**
   * Prebuilt weights will be used for giving preference to question and answer columns when quering AI search
   */
  Prebuilt: "Prebuilt",
}

/**
 * Fields to be considred for matching policy
 */
@added(Versions.v2025_05_15_preview)
union MatchingPolicyFieldsType {
  string,

  /**
   * Include 'Questions' field
   */
  Questions: "Questions",

  /**
   * Include 'Answer' field
   */
  Answer: "Answer",
}

/**
 * Human-readable error code.
 */
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

/**
 * Human-readable error code.
 */
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

/**
 * Specifies the method used to interpret string offsets.  Defaults to Text
 * Elements (Graphemes) according to Unicode v8.0.0. For additional information
 * see https://aka.ms/text-analytics-offsets.
 */
union StringIndexType {
  string,

  /**
   * Returned offset and length values will correspond to TextElements (Graphemes
   * and Grapheme clusters) confirming to the Unicode 8.0.0 standard. Use this
   * option if your application is written in .Net Framework or .Net Core and you
   * will be using StringInfo.
   */
  TextElements_v8: "TextElements_v8",

  /**
   * Returned offset and length values will correspond to Unicode code points. Use
   * this option if your application is written in a language that support Unicode,
   * for example Python.
   */
  UnicodeCodePoint: "UnicodeCodePoint",

  /**
   * Returned offset and length values will correspond to UTF-16 code units. Use
   * this option if your application is written in a language that support Unicode,
   * for example Java, JavaScript.
   */
  Utf16CodeUnit: "Utf16CodeUnit",
}

/**
 * Parameters to query a knowledge base.
 */
model AnswersOptions {
  /**
   * Exact QnA ID to fetch from the knowledge base, this field takes priority over
   * question.
   */
  qnaId?: int32;

  /**
   * User question to query against the knowledge base.
   */
  question?: string;

  /**
   * Max number of answers to be returned for the question.
   */
  top?: int32;

  /**
   * Unique identifier for the user.
   */
  userId?: string;

  /**
   * Minimum threshold score for answers, value ranges from 0 to 1.
   */
  @maxValue(1)
  @minValue(0)
  confidenceScoreThreshold?: float64;

  /**
   * Context object with previous QnA's information.
   */
  context?: KnowledgeBaseAnswerContext;

  /**
   * Type of ranker to be used.
   */
  rankerType?: RankerKind;

  /**
   * Filter QnAs based on given metadata list and knowledge base sources.
   */
  filters?: QueryFilters;

  /**
   * To configure Answer span prediction feature.
   */
  answerSpanRequest?: ShortAnswerOptions;

  /**
   * (Optional) Flag to enable Query over Unstructured Sources.
   */
  includeUnstructuredSources?: boolean;

  /**
   * To fine tune query results
   */
  @added(Versions.v2025_05_15_preview)
  queryPreferences?: QueryPreferences;
}

/**
 * Context object with previous QnA's information.
 */
model KnowledgeBaseAnswerContext {
  /**
   * Previous turn top answer result QnA ID.
   */
  previousQnaId: int32;

  /**
   * Previous user query.
   */
  previousUserQuery?: string;
}

/**
 * filters over knowledge base.
 */
model QueryFilters {
  /**
   * Find QnAs that are associated with the given list of metadata.
   */
  metadataFilter?: MetadataFilter;

  /**
   * Find QnAs that are associated with any of the given list of sources in
   * knowledge base.
   */
  sourceFilter?: string[];

  /**
   * Logical operation used to join metadata filter with source filter.
   */
  logicalOperation?: LogicalOperationKind;
}

/**
 * Find QnAs that are associated with the given list of metadata.
 */
model MetadataFilter {
  /** Dictionary of string */
  metadata?: MetadataRecord[];

  /**
   * Operation used to join metadata filters.
   */
  logicalOperation?: LogicalOperationKind;
}

/**
 * Object to provide the key value pair for each metadata.
 */
model MetadataRecord {
  /**
   * Metadata Key from Metadata dictionary used in the QnA.
   */
  key: string;

  /**
   * Metadata Value from Metadata dictionary used in the QnA.
   */
  value: string;
}

/**
 * To configure Answer span prediction feature.
 */
model ShortAnswerOptions {
  /**
   * Enable or disable Answer Span prediction.
   */
  enable: boolean;

  /**
   * Minimum threshold score required to include an answer span, value ranges from 0
   * to 1.
   */
  @maxValue(1)
  @minValue(0)
  confidenceScoreThreshold?: float64;

  /**
   * Number of Top answers to be considered for span prediction from 1 to 10.
   */
  @maxValue(10)
  @minValue(1)
  topAnswersWithSpan?: int32;
}

/**
 * Additional properties to fine tune query results
 */
@added(Versions.v2025_05_15_preview)
model QueryPreferences {
  /**
   * To specify what scoring algorithm is preferred
   */
  scorer?: Scorer;

  /**
   * Policy for controling exact query match behavior
   */
  matchingPolicy?: MatchingPolicy;
}

/**
 * Specify parameters for query matching
 */
@added(Versions.v2025_05_15_preview)
@discriminator("kind")
model MatchingPolicy {
  /**
   * Kind of matching policy to be applied
   */
  kind: MatchingPolicyKind;
}

/**
 * Represents fields for Prebuilt query matching. Prebuilt weights will be used for giving preference to question and answer columns when quering AI search
 */
@added(Versions.v2025_05_15_preview)
model PrebuiltQueryMatchingPolicy extends MatchingPolicy {
  /**
   * Matching policy kind
   */
  kind: MatchingPolicyKind.Prebuilt;

  /**
   * List of fields to filter during query. For ex if only "questions" is used then query will be filtered on that column
   */
  fields?: MatchingPolicyFieldsType[];

  /**
   * Disabling full match on query. Enabling this will give preference to qna pairs that have exact match.
   */
  disableFullMatch?: boolean;
}

/**
 * Represents List of Question Answers.
 */
model AnswersResult {
  /**
   * Represents Answer Result list.
   */
  answers?: KnowledgeBaseAnswer[];
}

/**
 * Represents knowledge base answer.
 */
model KnowledgeBaseAnswer {
  /**
   * List of questions associated with the answer.
   */
  questions?: string[];

  /**
   * Answer text.
   */
  answer?: string;

  /**
   * Answer confidence score, value ranges from 0 to 1.
   */
  @maxValue(1)
  @minValue(0)
  confidenceScore?: float64;

  /**
   * ID of the QnA result.
   */
  id?: int32;

  /**
   * Source of QnA result.
   */
  source?: string;

  /**
   * Metadata associated with the answer, useful to categorize or filter question
   * answers.
   */
  metadata?: Record<string>;

  /**
   * Dialog associated with Answer.
   */
  dialog?: KnowledgeBaseAnswerDialog;

  /**
   * Answer span object of QnA with respect to user's question.
   */
  answerSpan?: AnswerSpan;
}

/**
 * Dialog associated with Answer.
 */
model KnowledgeBaseAnswerDialog {
  /**
   * To mark if a prompt is relevant only with a previous question or not. If true,
   * do not include this QnA as search result for queries without context;
   * otherwise, if false, ignores context and includes this QnA in search result.
   */
  isContextOnly?: boolean;

  /**
   * List of prompts associated with the answer.
   */
  @maxItems(20)
  prompts?: KnowledgeBaseAnswerPrompt[];
}

/**
 * Prompt for an answer.
 */
model KnowledgeBaseAnswerPrompt {
  /**
   * Index of the prompt - used in ordering of the prompts.
   */
  displayOrder?: int32;

  /**
   * QnA ID corresponding to the prompt.
   */
  qnaId?: int32;

  /**
   * Text displayed to represent a follow up question prompt.
   */
  @maxLength(200)
  displayText?: string;
}

/**
 * Answer span object of QnA.
 */
model AnswerSpan {
  /**
   * Predicted text of answer span.
   */
  text?: string;

  /**
   * Predicted score of answer span, value ranges from 0 to 1.
   */
  @maxValue(1)
  @minValue(0)
  confidenceScore?: float64;

  /**
   * The answer span offset from the start of answer.
   */
  offset?: int32;

  /**
   * The length of the answer span.
   */
  length?: int32;
}

/**
 * Error response.
 */
@error
model ErrorResponse is Azure.Core.Foundations.ErrorResponseBase<Error>;

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

/**
 * An object containing more specific information about the error. As per
 * Microsoft One API guidelines -
 * https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#7102-error-condition-responses.
 */
model InnerErrorModel {
  /**
   * One of a server-defined set of error codes.
   */
  code: InnerErrorCode;

  /**
   * Error message.
   */
  message: string;

  /**
   * Error details.
   */
  details?: Record<string>;

  /**
   * Error target.
   */
  target?: string;

  /**
   * An object containing more specific information than the current object about
   * the error.
   */
  innererror?: InnerErrorModel;
}

/**
 * The question and text record parameters to answer.
 */
model AnswersFromTextOptions {
  /**
   * User question to query against the given text records.
   */
  question: string;

  /**
   * Text records to be searched for given question.
   */
  records: TextDocument[];

  /**
   * Language of the text records. This is BCP-47 representation of a language. For
   * example, use "en" for English; "es" for Spanish etc. If not set, use "en" for
   * English as default.
   */
  language?: string;

  /**
   * Specifies the method used to interpret string offsets.  Defaults to Text
   * Elements (Graphemes) according to Unicode v8.0.0. For additional information
   * see https://aka.ms/text-analytics-offsets.
   */
  stringIndexType?: StringIndexType = StringIndexType.TextElements_v8;
}

/**
 * Represent input text record to be queried.
 */
model TextDocument {
  /**
   * Unique identifier for the text record.
   */
  id: string;

  /**
   * Text contents of the record.
   */
  text: string;
}

/**
 * Represents the answer results.
 */
model AnswersFromTextResult {
  /**
   * Represents the answer results.
   */
  answers?: TextAnswer[];
}

/**
 * Represents answer result.
 */
model TextAnswer {
  /**
   * Answer.
   */
  answer?: string;

  /**
   * answer confidence score, value ranges from 0 to 1.
   */
  @maxValue(1)
  @minValue(0)
  confidenceScore?: float64;

  /**
   * record ID.
   */
  id?: string;

  /**
   * Answer span object with respect to user's question.
   */
  answerSpan?: AnswerSpan;

  /**
   * The sentence offset from the start of the document.
   */
  offset?: int32;

  /**
   * The length of the sentence.
   */
  length?: int32;
}

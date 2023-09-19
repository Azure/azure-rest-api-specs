import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.Conversations;

@doc("Error response.")
model ErrorResponse is Azure.Core.Foundations.ErrorResponse;

#suppress "@azure-tools/typespec-azure-core/bad-record-type" "InnerErrorModel should not use 'extends Record<unknown>'. Use 'extends Record<string>' instead."
@doc("An object containing more specific information about the error. As per Microsoft One API guidelines - https://github.com/Microsoft/api-guidelines/blob/vNext/Guidelines.md#7102-error-condition-responses.")
model InnerErrorModel extends Record<unknown> {
    @doc("One of a server-defined set of error codes.")
    code: InnerErrorCode;

    @doc("Error message.")
    message: string;

    @doc("Error details.")
    details?: Record<string>;

    @doc("Error target.")
    target?: string;

    @doc("An object containing more specific information than the current object about the error.")
    innererror?: InnerErrorModel;
}

@doc("Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets.")
enum StringIndexType {
    @doc("Returned offset and length values will correspond to TextElements (Graphemes and Grapheme clusters) confirming to the Unicode 8.0.0 standard. Use this option if your application is written in .Net Framework or .Net Core and you will be using StringInfo.")
    TextElements_v8,

    @doc("Returned offset and length values will correspond to Unicode code points. Use this option if your application is written in a language that support Unicode, for example Python.")
    UnicodeCodePoint,

    @doc("Returned offset and length values will correspond to UTF-16 code units. Use this option if your application is written in a language that support Unicode, for example Java, JavaScript.")
    Utf16CodeUnit,
}

@doc("Returns the current state of the task.")
@added(Versions.v2023_04_01)
model TaskState {
    @doc("The last updated time in UTC for the task.")
    lastUpdateDateTime: utcDateTime;

    @doc("The status of the task at the mentioned last update time.")
    status: State;
}

@doc("The status of the task at the mentioned last update time.")
@added(Versions.v2023_04_01)
enum State {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'notStarted' should have a documentation or description, please use decorator @doc to add it."
    notStarted,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'running' should have a documentation or description, please use decorator @doc to add it."
    running,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'succeeded' should have a documentation or description, please use decorator @doc to add it."
    succeeded,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'partiallyCompleted' should have a documentation or description, please use decorator @doc to add it."
    partiallyCompleted,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'failed' should have a documentation or description, please use decorator @doc to add it."
    failed,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'cancelled' should have a documentation or description, please use decorator @doc to add it."
    cancelled,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'cancelling' should have a documentation or description, please use decorator @doc to add it."
    cancelling,
}

@doc("Base task object.")
@added(Versions.v2023_04_01)
model TaskIdentifier {
    @doc("task name")
    taskName: string;
}

@doc("Base parameters object for a text analysis task.")
@added(Versions.v2023_04_01)
model TaskParameters {
    @doc("logging opt out")
    loggingOptOut: boolean = false;
}

@doc("Parameters object for a text analysis task using pre-built models.")
@added(Versions.v2023_04_01)
model PreBuiltTaskParameters extends TaskParameters {
    @doc("model version")
    modelVersion: string = "latest";
}

alias ShowStatsQueryParameter = QueryParametersTrait<{
    @doc("(Optional) if set to true, response will contain request and document level statistics.")
    @query showStats?: boolean
}>;

@doc("job state")
@added(Versions.v2023_04_01)
model JobState {
    @doc("display name")
    displayName?: string;

    @doc("Date and time job created")
    createdDateTime: utcDateTime;

    @doc("Date and time job expires")
    expirationDateTime?: utcDateTime;

    @doc("job ID")
    @key
    @visibility("read")
    jobId: string;

    @doc("last updated date and time")
    lastUpdateDateTime: utcDateTime;

    @doc("status")
    // @lroStatus commented because State throws error because enums not capatalized
    status: State;

    @doc("errors")
    errors?: Array<ErrorResponse>;

    @doc("next link")
    nextlink?: string;
}

@doc("job errors")
model JobErrors {
    @doc("errors")
    errors: Array<ErrorResponse>;
}

@doc("Contains details of errors encountered during a job execution.")
model DocumentError {
    @doc("The ID of the input document.")
    id: string;

    @doc("Error encountered.")
    error: ErrorResponse;
}

@doc("Contains details of warnings encountered during a job execution.")
model InputWarning {
    @doc("Warning code.")
    code: string;

    @doc("Warning message.")
    message: string;

    @doc("A JSON pointer reference indicating the target object.")
    targetRef?: string;
}

@doc("if showStats=true was specified in the request this field will contain information about the request payload.")
model RequestStatistics {
    @doc("Number of documents submitted in the request.")
    documentsCount: int32;

    @doc("Number of valid documents. This excludes empty, over-size limit or non-supported languages documents.")
    validDocumentCount: int32;

    @doc("Number of invalid documents. This includes empty, over-size limit or non-supported languages documents.")
    erroneousDocumentCount: int32;

    @doc("Number of transactions for the request.")
    transactionsCount: int64;
}

@doc("Pre built result")
model PreBuiltResult {
    @doc("Errors by document id.")
    errors: Array<DocumentError>;

    @doc("statistics")
    statistics?: RequestStatistics;

    @doc("This field indicates which model is used for scoring.")
    modelVersion: string;
}

@doc("Represents List of Question Answers.")
model AnswersResult {
    @doc("Represents Answer Result list.")
    answers?: Array<KnowledgeBaseAnswer>;
}

@doc("Represents knowledge base answer.")
model KnowledgeBaseAnswer {
    @doc("List of questions associated with the answer.")
    questions?: Array<string>;

    @doc("Answer text.")
    answer?: string;

    @doc("Answer confidence score, value ranges from 0 to 1.")
    @minValue(0)
    @maxValue(1)
    @projectedName("client", "confidence")
    confidenceScore?: float64;

    @doc("ID of the QnA result.")
    @projectedName("client", "qnaId")
    id?: int32;

    @doc("Source of QnA result.")
    source?: string;

    #suppress "deprecated" " Deprecated: object is deprecated. Please use {} for an empty model, `Record<unknown>` for a record with unknown property types, `unknown[]` for an array."
    @doc("Metadata associated with the answer, useful to categorize or filter question answers.")
    metadata?: Record<unknown>;

    @doc("Dialog associated with Answer.")
    dialog?: KnowledgeBaseAnswerDialog;

    @doc("Answer span object of QnA with respect to user's question.")
    @projectedName("client", "shortAnswer")
    answerSpan?: AnswerSpan;
}

@doc("Dialog associated with Answer.")
model KnowledgeBaseAnswerDialog {
    @doc("To mark if a prompt is relevant only with a previous question or not. If true, do not include this QnA as search result for queries without context; otherwise, if false, ignores context and includes this QnA in search result.")
    isContextOnly?: boolean;

    @doc("List of prompts associated with the answer.")
    @maxItems(20)
    prompts?: Array<KnowledgeBaseAnswerPrompt>;
}

@doc("Prompt for an answer.")
model KnowledgeBaseAnswerPrompt {
    @doc("Index of the prompt - used in ordering of the prompts.")
    displayOrder: int32;

    @doc("QnA ID corresponding to the prompt.")
    qnaId: int32;

    @doc("Text displayed to represent a follow up question prompt.")
    @maxLength(200)
    displayText: string;
}

@doc("Answer span object of QnA.")
model AnswerSpan {
    @doc("Predicted text of answer span.")
    text?: string;

    @doc("Predicted score of answer span, value ranges from 0 to 1.")
    @minValue(0)
    @maxValue(1)
    confidenceScore?: float64;

    @doc("The answer span offset from the start of answer.")
    offset?: int32;

    @doc("The length of the answer span.")
    length?: int32;
}

@doc("Parameters to query a knowledge base.")
model AnswersOptions {
    @doc("Exact QnA ID to fetch from the knowledge base, this field takes priority over question.")
    qnaId?: int32;

    @doc("User question to query against the knowledge base.")
    question?: string;

    @doc("Max number of answers to be returned for the question.")
    top?: int32;

    @doc("Unique identifier for the user.")
    userId?: string;

    @doc("Minimum threshold score for answers, value ranges from 0 to 1.")
    @maxValue(1)
    @minValue(0)
    @projectedName("client", "confidenceThreshold")
    confidenceScoreThreshold?: float64;

    @doc("Context object with previous QnA's information.")
    @projectedName("client", "answerContext")
    context?: KnowledgeBaseAnswerContext;

    @doc("Type of ranker to be used.")
    @projectedName("client", "rankerKind")
    rankerType?: RankerKind;

    @doc("Filter QnAs based on given metadata list and knowledge base sources.")
    filters?: QueryFilters;

    @doc("To configure Answer span prediction feature.")
    @projectedName("client", "shortAnswerOptions")
    answerSpanRequest?: ShortAnswerOptions;

    @doc("(Optional) Flag to enable Query over Unstructured Sources.")
    includeUnstructuredSources?: boolean;
}

@doc("Type of ranker to be used")
enum RankerKind {
    @doc("Default ranker.")
    Default: "Default ranker",

    @doc("Question only ranker.")
    Question: "Question only ranker",
}

@doc("Context object with previous QnA's information.")
model KnowledgeBaseAnswerContext {
    @doc("Previous turn top answer result QnA ID.")
    previousQnaId: int32;

    @doc("Previous user query.")
    @projectedName("client", "previousQuestion")
    previousUserQuery?: string;
}

@doc("filters over knowledge base.")
model QueryFilters {
    @doc("filters over knowledge base.")
    metadataFilter?: MetadataFilter;

    @doc("filters over knowledge base.")
    sourceFilter?: SourceFilter;

    @doc("Logical operation used to join metadata filter with source filter.")
    logicalOperation?: LogicalOperationKind = LogicalOperationKind.AND;
}

@doc("Find QnAs that are associated with the given list of metadata.")
model MetadataFilter {
    @doc("List of metadata.")
    metadata?: Array<MetadataRecord>;

    @doc("Operation used to join metadata filters.")
    logicalOperation?: LogicalOperationKind = LogicalOperationKind.AND;
}

@doc("Object to provide the key value pair for each metadata.")
model MetadataRecord {
    @doc("Metadata Key from Metadata dictionary used in the QnA.")
    key: string;

    @doc("Metadata Value from Metadata dictionary used in the QnA.")
    value: string;
}

@doc("Find QnAs that are associated with any of the given list of sources in knowledge base.")
model SourceFilter is Array<string>;

//todo: add enum member descriptions
@doc("Set to 'OR' or 'AND' for using corresponding logical operation.")
enum LogicalOperationKind {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AND' should have a documentation or description, please use decorator @doc to add it."
    AND,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'OR' should have a documentation or description, please use decorator @doc to add it."
    OR,
}

@doc("To configure Answer span prediction feature.")
model ShortAnswerOptions {
    @doc("Enable or disable Answer Span prediction.")
    enable: boolean;

    @doc("Minimum threshold score required to include an answer span, value ranges from 0 to 1.")
    @maxValue(1)
    @minValue(0)
    @projectedName("client", "confidenceThreshold")
    confidenceScoreThreshold?: float64;

    @doc("Number of Top answers to be considered for span prediction from 1 to 10.")
    @maxValue(10)
    @minValue(1)
    @projectedName("client", "top")
    topAnswersWithSpan?: int32;
}

//todo: add enum member descriptions
@doc("Human-readable error code.")
enum InnerErrorCode {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidRequest' should have a documentation or description, please use decorator @doc to add it."
    InvalidRequest,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidParameterValue' should have a documentation or description, please use decorator @doc to add it."
    InvalidParameterValue,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'KnowledgeBaseNotFound' should have a documentation or description, please use decorator @doc to add it."
    KnowledgeBaseNotFound,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchNotFound' should have a documentation or description, please use decorator @doc to add it."
    AzureCognitiveSearchNotFound,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchThrottling' should have a documentation or description, please use decorator @doc to add it."
    AzureCognitiveSearchThrottling,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ExtractionFailure' should have a documentation or description, please use decorator @doc to add it."
    ExtractionFailure,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidRequestBodyFormat' should have a documentation or description, please use decorator @doc to add it."
    InvalidRequestBodyFormat,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'EmptyRequest' should have a documentation or description, please use decorator @doc to add it."
    EmptyRequest,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'MissingInputDocuments' should have a documentation or description, please use decorator @doc to add it."
    MissingInputDocuments,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidDocument' should have a documentation or description, please use decorator @doc to add it."
    InvalidDocument,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ModelVersionIncorrect' should have a documentation or description, please use decorator @doc to add it."
    ModelVersionIncorrect,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidDocumentBatch' should have a documentation or description, please use decorator @doc to add it."
    InvalidDocumentBatch,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'UnsupportedLanguageCode' should have a documentation or description, please use decorator @doc to add it."
    UnsupportedLanguageCode,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidCountryHint' should have a documentation or description, please use decorator @doc to add it."
    InvalidCountryHint,
}

//todo: add enum member descriptions
@doc("Human-readable error code.")
enum ErrorCode {
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidRequest' should have a documentation or description, please use decorator @doc to add it."
    InvalidRequest,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InvalidArgument' should have a documentation or description, please use decorator @doc to add it."
    InvalidArgument,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Unauthorized' should have a documentation or description, please use decorator @doc to add it."
    Unauthorized,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Forbidden' should have a documentation or description, please use decorator @doc to add it."
    Forbidden,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'NotFound' should have a documentation or description, please use decorator @doc to add it."
    NotFound,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ProjectNotFound' should have a documentation or description, please use decorator @doc to add it."
    ProjectNotFound,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'OperationNotFound' should have a documentation or description, please use decorator @doc to add it."
    OperationNotFound,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchNotFound' should have a documentation or description, please use decorator @doc to add it."
    AzureCognitiveSearchNotFound,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchIndexNotFound' should have a documentation or description, please use decorator @doc to add it."
    AzureCognitiveSearchIndexNotFound,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'TooManyRequests' should have a documentation or description, please use decorator @doc to add it."
    TooManyRequests,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchThrottling' should have a documentation or description, please use decorator @doc to add it."
    AzureCognitiveSearchThrottling,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'AzureCognitiveSearchIndexLimitReached' should have a documentation or description, please use decorator @doc to add it."
    AzureCognitiveSearchIndexLimitReached,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'InternalServerError' should have a documentation or description, please use decorator @doc to add it."
    InternalServerError,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'ServiceUnavailable' should have a documentation or description, please use decorator @doc to add it."
    ServiceUnavailable,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Timeout' should have a documentation or description, please use decorator @doc to add it."
    Timeout,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'QuotaExceeded' should have a documentation or description, please use decorator @doc to add it."
    QuotaExceeded,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Conflict' should have a documentation or description, please use decorator @doc to add it."
    Conflict,
    #suppress "@azure-tools/typespec-azure-core/documentation-required" "The EnumMember named 'Warning' should have a documentation or description, please use decorator @doc to add it."
    Warning,
}

@doc("Predicted sentiment")
@added(Versions.v2023_04_01)
enum Sentiment {
    @doc("Positive statement")
    positive,

    @doc("Neutral statement")
    neutral,

    @doc("Negative statement")
    negative,

    @doc("Mixed statement")
    mixed,
}

@doc("Represents the confidence scores between 0 and 1 across all sentiment classes: positive, neutral, negative.")
@added(Versions.v2023_04_01)
model SentimentConfidenceScores {
    @doc("Confidence score for positive sentiment")
    positive: float64;

    @doc("Confidence score for neutral sentiment")
    neutral: float64;

    @doc("Confidence score for negative sentiment")
    negative: float64;
}

@doc("Supported parameters for an Abstractive Summarization task.")
@added(Versions.v2023_04_01)
model AbstractiveSummarizationTaskParametersBase {
    @doc("It controls the approximate number of sentences in the output summaries.")
    sentenceCount: int32;

    @doc("String index type")
    stringIndexType: StringIndexType;
}

@doc("The context of the summary.")
@added(Versions.v2023_04_01)
model SummaryContext {
    @doc("Start position for the context. Use of different 'stringIndexType' values can affect the offset returned.")
    offset: int32;

    @doc("The length of the context. Use of different 'stringIndexType' values can affect the length returned.")
    length: int32;
}

@doc("Parameters object for a text analysis task using custom models.")
model CustomTaskParameters {
    ...TaskParameters;

    @doc("This field indicates the project name for the model.")
    projectName: string,

    @doc("This field indicates the deployment name for the model.")
    deploymentName: string
}

@doc("Custom Task Results")
model CustomResult {
    @doc("Errors by document id.")
    errors: Array<DocumentError>,

    @doc("if showStats=true was specified in the request this field will contain information about the request payload.")
    statistics?: RequestStatistics,

    @doc("This field indicates the project name for the model.")
    projectName: string,

    @doc("This field indicates the deployment name for the model.")
    deploymentName: string,
}

@doc("Optional parameter to use a Custom Character to be used for redaction in PII responses. Default character will be * as before. We allow specific ascii characters for redaction.")
enum RedactionCharacter{
    #suppress "@azure-tools/typespec-azure-core/documentation-required"
    redactionCharacter,
    #suppress "@azure-tools/typespec-azure-core/documentation-required"
    redactChar,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `!`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `#`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `$`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `%`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `&`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `*`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `+`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `-`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `=`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `?`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `@`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `^`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `_`,
    // #suppress "@azure-tools/typespec-azure-core/documentation-required"
    // `~`,
}
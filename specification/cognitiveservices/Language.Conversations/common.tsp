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

alias Language = string;

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
model TaskState{
    @doc("The last updated time in UTC for the task.")
    lastUpdateDateTime: utcDateTime;

    @doc("The status of the task at the mentioned last update time.")
    status: State;
}

@doc("The status of the task at the mentioned last update time.")
@added(Versions.v2023_04_01)
enum State{
    @doc("The status of the task at the mentioned last update time.")
    notStarted,
    @doc("The status of the task at the mentioned last update time.")
    running,
    @doc("The status of the task at the mentioned last update time.")
    succeeded,
    @doc("The status of the task at the mentioned last update time.")
    partiallyCompleted,
    @doc("The status of the task at the mentioned last update time.")
    failed,
    @doc("The status of the task at the mentioned last update time.")
    cancelled,
    @doc("The status of the task at the mentioned last update time.")
    cancelling,
}

@doc("Base task object.")
@added(Versions.v2023_04_01)
model TaskIdentifier{
    @doc("task name")
    taskName: string;
}

@doc("Base parameters object for a text analysis task.")
@added(Versions.v2023_04_01)
model TaskParameters{
    @doc("logging opt out")
    loggingOptOut: boolean=false;
}

@doc("Parameters object for a text analysis task using pre-built models.")
@added(Versions.v2023_04_01)
model PreBuiltTaskParameters extends TaskParameters{
    @doc("model version")
    modelVersion: string="latest"
}

@doc("job state")
@added(Versions.v2023_04_01)
model JobState{
    @doc("display name")
    displayName?: string;

    @doc("Date and time job created")
    createdDateTime: utcDateTime;

    @doc("Date and time job expires")
    expirationDateTime?: utcDateTime;

    @doc("job ID")
    jobId: string;

    @doc("last updated date and time")
    lastUpdateDateTime: utcDateTime;

    @doc("status")
    status: State;

    @doc("errors")
    errors?: Array<ErrorResponse>;

    @doc("next link")
    nextlink?:string;
}

@doc("job errors")
@added(Versions.v2023_04_01)
model JobErrors{
    @doc("errors")
    errors: Array<ErrorResponse>;
}

@doc("Contains details of errors encountered during a job execution.")
@added(Versions.v2023_04_01)
model DocumentError{
    @doc("The ID of the input document.")
    id: string;

    @doc("Error encountered.")
    error: ErrorResponse;
}

@doc("Contains details of warnings encountered during a job execution.")
@added(Versions.v2023_04_01)
model InputWarning{
    @doc("Warning code.")
    code: string;

    @doc("Warning message.")
    message: string;

    @doc("A JSON pointer reference indicating the target object.")
    targetRef?: string;
}

@doc("if showStats=true was specified in the request this field will contain information about the request payload.")
@added(Versions.v2023_04_01)
model RequestStatistics{
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
@added(Versions.v2023_04_01)
model PreBuiltResult{
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
    confidenceScore?: float;

    @doc("ID of the QnA result.")
    id?: int32;

    @doc("Source of QnA result.")
    source?: string;

    @doc("Metadata associated with the answer, useful to categorize or filter question answers.")
    metadata?: object;

    @doc("Dialog associated with Answer.")
    dialog?: KnowledgeBaseAnswerDialog;

    @doc("Answer span object of QnA with respect to user's question.")
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
    confidenceScoreThreshold?: float64;

    @doc("Context object with previous QnA's information.")
    context?: KnowledgeBaseAnswerContext;

    @doc("Type of ranker to be used.")
    rankerType?: RankerKind;

    @doc("Filter QnAs based on given metadata list and knowledge base sources.")
    filters?: QueryFilters;

    @doc("To configure Answer span prediction feature.")
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
model SourceFilter {
    @doc("List of sources in knowledge base.")
    type?: Array<string>;
}

@doc("Set to 'OR' or 'AND' for using corresponding logical operation.")
enum LogicalOperationKind {
    @doc("Set to AND.")
    AND,
    @doc("Set to OR.")
    OR,
}

@doc("To configure Answer span prediction feature.")
model ShortAnswerOptions {
    @doc("Enable or disable Answer Span prediction.")
    enable: boolean;

    @doc("Minimum threshold score required to include an answer span, value ranges from 0 to 1.")
    @maxValue(1)
    @minValue(0)
    confidenceScoreThreshold?: float64;

    @doc("Number of Top answers to be considered for span prediction from 1 to 10.")
    @maxValue(10)
    @minValue(1)
    @projectedName("client", "top")
    topAnswersWithSpan?: int32;
}

@doc("Human-readable error code.")
enum InnerErrorCode {
    @doc("Human-readable error code.")
    InvalidRequest,
    @doc("Human-readable error code.")
    InvalidParameterValue,
    @doc("Human-readable error code.")
    KnowledgeBaseNotFound,
    @doc("Human-readable error code.")
    AzureCognitiveSearchNotFound,
    @doc("Human-readable error code.")
    AzureCognitiveSearchThrottling,
    @doc("Human-readable error code.")
    ExtractionFailure,
    @doc("Human-readable error code.")
    InvalidRequestBodyFormat,
    @doc("Human-readable error code.")
    EmptyRequest,
    @doc("Human-readable error code.")
    MissingInputDocuments,
    @doc("Human-readable error code.")
    InvalidDocument,
    @doc("Human-readable error code.")
    ModelVersionIncorrect,
    @doc("Human-readable error code.")
    InvalidDocumentBatch,
    @doc("Human-readable error code.")
    UnsupportedLanguageCode,
    @doc("Human-readable error code.")
    InvalidCountryHint,
}

@doc("Human-readable error code.")
enum ErrorCode {
    @doc("Human-readable error code.")
    InvalidRequest,
    @doc("Human-readable error code.")
    InvalidArgument,
    @doc("Human-readable error code.")
    Unauthorized,
    @doc("Human-readable error code.")
    Forbidden,
    @doc("Human-readable error code.")
    NotFound,
    @doc("Human-readable error code.")
    ProjectNotFound,
    @doc("Human-readable error code.")
    OperationNotFound,
    @doc("Human-readable error code.")
    AzureCognitiveSearchNotFound,
    @doc("Human-readable error code.")
    AzureCognitiveSearchIndexNotFound,
    @doc("Human-readable error code.")
    TooManyRequests,
    @doc("Human-readable error code.")
    AzureCognitiveSearchThrottling,
    @doc("Human-readable error code.")
    AzureCognitiveSearchIndexLimitReached,
    @doc("Human-readable error code.")
    InternalServerError,
    @doc("Human-readable error code.")
    ServiceUnavailable,
    @doc("Human-readable error code.")
    Timeout,
    @doc("Human-readable error code.")
    QuotaExceeded,
    @doc("Human-readable error code.")
    Conflict,
    @doc("Human-readable error code.")
    Warning,
}

@doc("Predicted sentiment")
@added(Versions.v2023_04_01)
enum Sentiment{
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
model SentimentConfidenceScores{
    @doc("Confidence score for positive sentiment")
    postive: float64;

    @doc("Confidence score for neutral sentiment")
    neutral: float64;

    @doc("Confidence score for negative sentiment")
    negative: float64;
}


@doc("Supported parameters for an Abstractive Summarization task.")
@added(Versions.v2023_04_01)
model AbstractiveSummarizationTaskParameterBase{
    @doc("It controls the approximate number of sentences in the output summaries.")
    sentenceCount: int32;

    @doc("String index type")
    stringIndexType: StringIndexType;
}

@doc("The context of the summary.")
@added(Versions.v2023_04_01)
model SummaryContext{
    @doc("Start position for the context. Use of different 'stringIndexType' values can affect the offset returned.")
    offset: int32;

    @doc("The length of the context. Use of different 'stringIndexType' values can affect the length returned.")
    length: int32;
}
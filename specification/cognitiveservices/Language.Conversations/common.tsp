import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@doc("The language service API is a suite of natural language processing (NLP) skills built with best-in-class Microsoft machine learning algorithms.  The API can be used to analyze unstructured text for tasks such as sentiment analysis, key phrase extraction, language detection and question answering. Further documentation can be found in <a href=\"https://docs.microsoft.com/en-us/azure/cognitive-services/text-analytics/overview\">https://docs.microsoft.com/en-us/azure/cognitive-services/text-analytics/overview</a>.")
@service({
    title: "Microsoft Cognitive Language Service",
    version: "2022-05-01",
})
namespace Azure.AI.Language.Conversations;

@doc("Error Response")
model ErrorResponse {
    @doc("The error object.")
    error: Error;
}

@doc("The error object.")
model Error extends Record<unknown> {
    @doc("One of a server-defined set of error codes.")
    code: ErrorCode;

    @doc("A human-readable representation of the error.")
    message: string;

    @doc("The target of the error.")
    target?: string;

    @doc("An array of details about specific errors that led to this reported error.")
    details?: Array<Error>;

    @doc("An object containing more specific information than the current object about the error.")
    innererror?: InnerErrorModel;
}

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

@doc("Language of the text records. This is BCP-47 representation of a language. For example, use \"en\" for English; \"es\" for Spanish etc. If not set, use \"en\" for English as default.")
model Language {}

@doc("Specifies the method used to interpret string offsets.  Defaults to Text Elements (Graphemes) according to Unicode v8.0.0. For additional information see https://aka.ms/text-analytics-offsets.")
enum StringIndexType {
    @doc("Returned offset and length values will correspond to TextElements (Graphemes and Grapheme clusters) confirming to the Unicode 8.0.0 standard. Use this option if your application is written in .Net Framework or .Net Core and you will be using StringInfo.")
    TextElements_v8,

    @doc("Returned offset and length values will correspond to Unicode code points. Use this option if your application is written in a language that support Unicode, for example Python.")
    UnicodeCodePoint,

    @doc("Returned offset and length values will correspond to UTF-16 code units. Use this option if your application is written in a language that support Unicode, for example Java, JavaScript.")
    Utf16CodeUnit,
}

@doc("Represents List of Question Answers.")
model AnswersResult {
    @doc("Represents Answer Result list.")
    answers: Array<KnowledgeBaseAnswer>;
}

@doc("Represents knowledge base answer.")
model KnowledgeBaseAnswer {
    @doc("List of questions associated with the answer.")
    questions: Array<string>;

    @doc("Answer text.")
    answer: string;

    @doc("Answer confidence score, value ranges from 0 to 1.")
    @minValue(0)
    @maxValue(1)
    confidenceScore: float;

    @doc("ID of the QnA result.")
    id: int32;

    @doc("Source of QnA result.")
    source: string;

    @doc("Metadata associated with the answer, useful to categorize or filter question answers.")
    metadeta: object;

    @doc("Dialog associated with Answer.")
    dialog: KnowledgeBaseAnswerDialog;

    @doc("Answer span object of QnA with respect to user's question.")
    answerSpan: AnswerSpan;
}

@doc("Dialog associated with Answer.")
model KnowledgeBaseAnswerDialog {
    @doc("To mark if a prompt is relevant only with a previous question or not. If true, do not include this QnA as search result for queries without context; otherwise, if false, ignores context and includes this QnA in search result.")
    isContextOnly: boolean;

    @doc("List of prompts associated with the answer.")
    @maxItems(20)
    prompts: Array<KnowledgeBaseAnswerPrompt>;
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
    text: string;

    @doc("Predicted score of answer span, value ranges from 0 to 1.")
    @minValue(0)
    @maxValue(1)
    confidenceScore: float64;

    @doc("The answer span offset from the start of answer.")
    offset: int32;

    @doc("The length of the answer span.")
    length: int32;
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

enum RankerKind {
    Default: "Default ranker",
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
    metadataFilter: MetadataFilter;
    sourceFilter: SourceFilter;

    @doc("Logical operation used to join metadata filter with source filter.")
    logicalOperation: LogicalOperationKind = LogicalOperationKind.AND;
}

@doc("Find QnAs that are associated with the given list of metadata.")
model MetadataFilter {
    metadata: Array<MetadataRecord>;

    @doc("Operation used to join metadata filters.")
    logicalOperation: LogicalOperationKind = LogicalOperationKind.AND;
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
    type: Array<string>;
}

@doc("Set to 'OR' or 'AND' for using corresponding logical operation.")
enum LogicalOperationKind {
    AND,
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
    topAnswersWithSpan: int32;
}

@doc("Human-readable error code.")
enum InnerErrorCode {
    InvalidRequest,
    InvalidParameterValue,
    KnowledgeBaseNotFound,
    AzureCognitiveSearchNotFound,
    AzureCognitiveSearchThrottling,
    ExtractionFailure,
    InvalidRequestBodyFormat,
    EmptyRequest,
    MissingInputDocuments,
    InvalidDocument,
    ModelVersionIncorrect,
    InvalidDocumentBatch,
    UnsupportedLanguageCode,
    InvalidCountryHint,
}

@doc("Human-readable error code.")
enum ErrorCode {
    InvalidRequest,
    InvalidArgument,
    Unauthorized,
    Forbidden,
    NotFound,
    ProjectNotFound,
    OperationNotFound,
    AzureCognitiveSearchNotFound,
    AzureCognitiveSearchIndexNotFound,
    TooManyRequests,
    AzureCognitiveSearchThrottling,
    AzureCognitiveSearchIndexLimitReached,
    InternalServerError,
    ServiceUnavailable,
    Timeout,
    QuotaExceeded,
    Conflict,
    Warning,
}

import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;

namespace Azure.Data.AI;

/** The format of a document submitted for semantic reranking. */
union DocumentType {
  string,

  /** A plain-text document. */
  Text: "text",

  /** A JSON document. */
  Json: "json",
}

/** The input for a semantic reranking operation. */
model SemanticRerankingInferenceContent {
  /** The query used to rank the documents. */
  @maxLength(2147483647)
  @minLength(1)
  query: string;

  /** The documents to rank against the query. */
  @minItems(1)
  documents: string[];

  /** Whether the response should include the submitted documents. */
  returnDocuments?: boolean;

  /** The maximum number of ranked documents to return. */
  @maxValue(2147483647)
  @minValue(1)
  topK?: int32;

  /** The number of documents processed in each batch. */
  @maxValue(2147483647)
  @minValue(1)
  batchSize?: int32;

  /** Whether to return documents sorted by relevance score. */
  sort?: boolean;

  /** The format of the submitted documents. */
  documentType?: DocumentType;

  /**
   * The property containing text to rank when the document type is JSON.
   * This property is required for JSON documents. Use dot notation for a nested property, for example `meta.content`.
   * You can specify multiple property paths separated by commas, for example `meta.content,id`.
   */
  @maxLength(2147483647)
  targetPaths?: string;

  /** The name of the model used for the semantic reranking operation. */
  @maxLength(2147483647)
  `model`?: string;

  /** Whether to return sentence-level scores in the response. */
  returnSentenceScore?: boolean;
}

/** The result of a semantic reranking operation. */
model SemanticRerankingInferenceResult {
  /** The relevance scores for the submitted documents. */
  scores?: SemanticRerankingScore[];

  /** Additional metadata about the semantic reranking operation. */
  meta?: MetaResult;
}

/** A relevance score assigned to a submitted document. */
model SemanticRerankingScore {
  /** The zero-based position of the document in the request. */
  index?: int32;

  /** The submitted document when requested in the response. */
  document?: string;

  /** The relevance score assigned to the document. */
  score?: float32;

  /** The sentence-level relevance scores for the submitted document. */
  sentenceScores?: SentenceScore[];
}

/** A sentence-level relevance score for a submitted document. */
model SentenceScore {
  /** The zero-based position of the sentence in the document. */
  @minValue(0)
  index: int32;

  /** The relevance score assigned to the sentence. */
  @minValue(0)
  @maxValue(1)
  score: float32;
}

/** Additional metadata about the semantic reranking operation. */
model MetaResult {
  /** The number of tokens processed in the request. */
  tokenUsage?: TokenUsageResult;

  /** The latency of the semantic reranking operation. */
  latency?: LatencyResult;

  /** The name of the model used for the semantic reranking operation. */
  modelName?: string;

  /** The version of the model used for the semantic reranking operation. */
  modelVersion?: string;
}

/** The result of the token usage in the semantic reranking operation. */
model TokenUsageResult {
  /** The total number of tokens processed in the semantic reranking operation. */
  totalTokens?: int32;
}

#suppress "@azure-tools/typespec-azure-core/known-encoding" "We use milliseconds as our unit of measurement"
@encode(DurationKnownEncoding.milliseconds, float32)
scalar Milliseconds extends duration;

/** The result of the latency in the semantic reranking operation. */
model LatencyResult {
  /** The time spent on data preprocessing in the semantic reranking operation, in milliseconds. */
  dataPreprocessTime?: Milliseconds;

  /** The time spent on inference in the semantic reranking operation, in milliseconds. */
  inferenceTime?: Milliseconds;

  /** The time spent on post-processing in the semantic reranking operation, in milliseconds. */
  postProcessTime?: Milliseconds;
}

/** Headers returned by every inference response. */
model CorrelatedResponseHeaders {
  /** An identifier used to correlate the response with service diagnostics. */
  @header("X-Correlation-ID")
  correlationId: string;
}

/** A successful semantic reranking response. */
model SemanticRerankingResult {
  ...CorrelatedResponseHeaders;

  /** The HTTP status code. */
  @statusCode
  statusCode: 200;

  /** The semantic reranking result. */
  @bodyRoot
  result: SemanticRerankingInferenceResult;
}

/** Details about an HTTP API error. */
#suppress "@azure-tools/typespec-azure-core/bad-record-type" "The existing ProblemDetails contract permits arbitrary additional JSON properties."
model ProblemDetails is Azure.Core.Foundations.Error {
  ...Record<unknown>;

  /** A URI reference identifying the problem type. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing ProblemDetails contract permits null for this property."
  type?: string | null;

  /** A short, human-readable summary of the problem. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing ProblemDetails contract permits null for this property."
  title?: string | null;

  /** The HTTP status code associated with the problem. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing ProblemDetails contract permits null for this property."
  status?: int32 | null;

  /** A human-readable explanation specific to this occurrence. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing ProblemDetails contract permits null for this property."
  detail?: string | null;

  /** A URI reference identifying this occurrence of the problem. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing ProblemDetails contract permits null for this property."
  instance?: string | null;

  /** Additional service-defined details about the problem. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The existing extensions property permits arbitrary JSON values."
  extensions?: Record<unknown>;
}

/** The request was rejected because the service is receiving too many requests. */
@error
model TooManyRequestsResult
  is Azure.Core.Foundations.ErrorResponseBase<ProblemDetails> {
  ...CorrelatedResponseHeaders;

  /** The HTTP status code. */
  @statusCode
  statusCode: 429;

  /** The number of seconds the client should wait before retrying the request. */
  @header("Retry-After")
  retryAfter: int32;
}

/** An unexpected error response. */
@error
model InferenceErrorResult
  is Azure.Core.Foundations.ErrorResponseBase<ProblemDetails> {
  ...CorrelatedResponseHeaders;
}

/** Errors returned by an inference operation. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "The union defines distinct HTTP error responses and is not emitted as a response body schema."
union InferenceOperationError {
  /** The request was rate limited. */
  tooManyRequests: TooManyRequestsResult,

  /** An unexpected error occurred. */
  unexpected: InferenceErrorResult,
}

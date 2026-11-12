import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using TypeSpec.Http;
using TypeSpec.Versioning;

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
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "The service contract takes the paths as one comma-separated string; commaDelimited encoding lets SDKs expose a string collection while sending that string."
  #suppress "@azure-tools/typespec-autorest/unknown-format" "AutoRest cannot express array delimiter encoding, so the OpenAPI keeps the existing string definition, which matches the wire contract."
  @encode(ArrayEncoding.commaDelimited)
  @maxItems(100)
  targetPaths?: string[];

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
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Pre-existing API contract; preserve the union of distinct HTTP error responses rather than introduce a response body model hierarchy."
union InferenceOperationError {
  /** The request was rate limited. */
  tooManyRequests: TooManyRequestsResult,

  /** An unexpected error occurred. */
  unexpected: InferenceErrorResult,
}

// ---------------------------------------------------------------------------
// Multimodal embedding
// ---------------------------------------------------------------------------

/** The kind of an item to embed. */
@added(Versions.v2026_11_01_preview)
union EmbeddingContentKind {
  string,

  /** A document to index. */
  Text: "text",

  /** A search query. Queries are embedded for retrieval against documents and must be sent inline. */
  Query: "query",

  /** A document image, such as a scanned page. */
  Image: "image",
}

/** The kind of vectors to return. */
@added(Versions.v2026_11_01_preview)
union EmbeddingVectorKind {
  string,

  /** One vector per item. */
  Dense: "dense",

  /** One vector per token, for late-interaction (MaxSim) scoring. */
  Multi: "multi",

  /**
   * Both, from one model run: one dense vector (`dimensions` wide) and one vector per token (`multiDimensions` wide)
   * for each item.
   */
  DenseAndMulti: "dense_multi",
}

/** The numeric type of the returned vector values. */
@added(Versions.v2026_11_01_preview)
union EmbeddingOutputDataKind {
  string,

  /** 32-bit floating point. The default for dense vectors. */
  Float32: "float32",

  /** 16-bit floating point. The default for `multi` and `dense_multi`. */
  Float16: "float16",
}

/** How vectors are encoded in the response. */
@added(Versions.v2026_11_01_preview)
union EmbeddingEncodingFormat {
  string,

  /** JSON arrays of numbers. */
  Float: "float",

  /** A base64 string of little-endian values; row-major for multi-vectors. */
  Base64: "base64",
}

/** The format of an embedded image. */
@added(Versions.v2026_11_01_preview)
union EmbeddingImageFormat {
  string,

  /** JPEG. */
  Jpeg: "jpeg",

  /** PNG. */
  Png: "png",

  /** GIF. */
  Gif: "gif",

  /** WebP. */
  Webp: "webp",
}

/** One item to embed, defaulting to text: an optional `id` and exactly one source, `content` or `url` with `sasToken`. */
@added(Versions.v2026_11_01_preview)
model EmbeddingContentItem {
  /** A caller-chosen identifier, up to 256 characters, echoed on the matching result. */
  @maxLength(256)
  id?: string;

  /** What the item is: a document (`text`, the default), a search query (`query`) or a document image (`image`). */
  kind?: EmbeddingContentKind = "text";

  /**
   * The item, inline. For `text` and `query`: the text, up to 100,000 characters; text over the model's token limit
   * (currently 8,192 tokens) isn't rejected: only its start is embedded, and the result is flagged with `truncated` and
   * an `EMBEDDING_INPUT_TRUNCATED` warning. For `image`, only where the endpoint accepts inline images (off by
   * default): a `data:image/...;base64,` URI or raw base64. The service never fetches URLs in `content`.
   */
  content?: string;

  /**
   * For `text` and `image` items, from Microsoft Entra callers, where enabled: the Azure Blob Storage URL of the blob
   * to embed, `https://{account}.blob.core.windows.net/{container}/{blob}`, with no query string. This is how images
   * are sent by default. Text blobs are read as UTF-8, currently up to 1 MiB. Queries must be sent inline.
   */
  url?: url;

  /**
   * Required with `url`: a user delegation SAS for that one blob (its query string, with or without a leading `?`):
   * read-only (`sp=r`), for the blob (`sr=b`), https-only (`spr=https`), and signed by the identity that calls this
   * API. A SAS valid for more than 15 minutes is accepted with warning `EMBEDDING_SAS_LONG_LIVED`. The service uses
   * it for one read and never stores, logs or returns it.
   */
  @secret
  sasToken?: string;
}

/** How the results of a multimodal embedding operation are returned. */
@added(Versions.v2026_11_01_preview)
union EmbeddingDelivery {
  string,

  /** The vectors are in the response's `data`. */
  Inline: "inline",

  /**
   * The service stores the response as a JSON file and returns `output`, a read-only link valid for up to 15
   * minutes, with an empty `data`. Not available on every endpoint (`EMBEDDING_DELIVERY_NOT_SUPPORTED`).
   */
  Link: "link",
}

/** The input for an embedding operation. */
@added(Versions.v2026_11_01_preview)
model EmbeddingContent {
  /**
   * The items to embed, in order: 1 to 32 items. Currently a request can have at most one `text` or `query` item and
   * at most 8 images. Images can be up to 20 MiB and 50 megapixels each (JPEG, PNG, GIF or WebP), with at most 20 MiB
   * of images per request. The request body can be up to 30,000,000 bytes.
   */
  @minItems(1)
  @maxItems(32)
  inputs: EmbeddingContentItem[];

  /** The model to use. Defaults to `microsoft-embedding-1-large` (Microsoft Embedding 1-large). */
  `model`?: string;

  /** The model version. Defaults to the latest; the response always names the version used. */
  modelVersion?: string;

  /** The kind of vectors to return. Defaults to `dense`. */
  vectorKind?: EmbeddingVectorKind;

  /**
   * The number of dimensions per vector; with `dense_multi`, of the dense vector. Must be a value the model supports for the
   * requested vector kind; the model's native width is the default.
   */
  @minValue(1)
  dimensions?: int32;

  /**
   * For `dense_multi` only: the number of dimensions per multi-vector. Must be a value the model supports for multi-vectors;
   * the model's native multi-vector width is the default.
   */
  @minValue(1)
  multiDimensions?: int32;

  /** For `multi` and `dense_multi` only: the most multi-vectors to return per item. */
  @minValue(1)
  maxVectorCount?: int32;

  /**
   * The numeric type of the returned values, for every vector in the response. Defaults to `float32` for `dense` and
   * `float16` for `multi` and `dense_multi`.
   */
  outputDataKind?: EmbeddingOutputDataKind;

  /** How vectors are encoded in the response. Defaults to `float`. */
  encodingFormat?: EmbeddingEncodingFormat;

  /**
   * How to return the results. An explicit value wins. Without it, a request with images gets `link` where the
   * endpoint has a result store, and every other request gets `inline`.
   */
  delivery?: EmbeddingDelivery;
}

/** The implementation of an embedding result item. */
@added(Versions.v2026_11_01_preview)
union EmbeddingDataKind {
  string,

  /** One dense vector from a multimodal model. */
  MultimodalDense: "multimodal_dense",

  /** One vector per token from a multimodal model. */
  MultimodalMultiVector: "multimodal_multi",

  /** A dense vector and one vector per token from a multimodal model. */
  MultimodalDenseAndMultiVector: "multimodal_dense_multi",
}

/** Common metadata for one embedding result item, in request order. */
@added(Versions.v2026_11_01_preview)
@discriminator("kind")
model EmbeddingData {
  /** The embedding implementation that produced this item. */
  kind: EmbeddingDataKind;

  /** The zero-based position of the item in the request. */
  index: int32;

  /** The item's `id` from the request, if it had one. */
  id?: string;
}

/** Shared metadata for the results from a multimodal embedding model. */
@added(Versions.v2026_11_01_preview)
model MultimodalEmbeddingData {
  /** The item's content kind, as supplied in the request's `kind`. */
  contentKind: EmbeddingContentKind;

  /** For images: the width in pixels. */
  width?: int32;

  /** For images: the height in pixels. */
  height?: int32;

  /** For images: the detected image format. */
  format?: EmbeddingImageFormat;

  /**
   * The tokens the model read for this item, including any text the service adds to queries and, for images, the
   * image prompt and image tokens. For a truncated item, the tokens embedded. Omitted when the model doesn't report it.
   */
  tokens?: int64;

  /** For images: how many of `tokens` were image tokens. */
  visualTokens?: int64;

  /**
   * `true` when the item was over the model's token limit and only its start was embedded; `warnings` then has an
   * `EMBEDDING_INPUT_TRUNCATED` entry for it. Omitted otherwise.
   */
  truncated?: boolean;

  /** For truncated items only: the item's tokens before truncation. */
  inputTokens?: int64;
}

/** The result for one item when `vectorKind` is `dense`: one vector. */
@added(Versions.v2026_11_01_preview)
model MultimodalDenseEmbedding extends EmbeddingData {
  /** The embedding implementation. */
  kind: EmbeddingDataKind.MultimodalDense;

  ...MultimodalEmbeddingData;

  /** The kind of vectors returned. */
  vectorKind: EmbeddingVectorKind.Dense;

  /**
   * The vector: an array of numbers, or, when `encodingFormat` is `base64`, a base64 string of its little-endian
   * `outputDataKind` values.
   */
  embedding: EmbeddingVector;
}

/** The result for one item when `vectorKind` is `multi`: one vector per token, for late-interaction (MaxSim) scoring. */
@added(Versions.v2026_11_01_preview)
model MultimodalMultiVectorEmbedding extends EmbeddingData {
  /** The embedding implementation. */
  kind: EmbeddingDataKind.MultimodalMultiVector;

  ...MultimodalEmbeddingData;

  /** The kind of vectors returned. */
  vectorKind: EmbeddingVectorKind.Multi;

  /** The number of vectors and the number of dimensions: `[vectors, dimensions]`. */
  shape: int32[];

  /**
   * The vectors: an array of arrays of numbers, or, when `encodingFormat` is `base64`, one base64 string of all their
   * little-endian `outputDataKind` values in row-major order. Decode it and reshape it to `shape`.
   */
  multiEmbedding: MultiEmbeddingVector;
}

/**
 * The result for one item when `vectorKind` is `dense_multi`: a dense vector and one vector per token, from one model run.
 */
@added(Versions.v2026_11_01_preview)
model MultimodalDenseAndMultiVectorEmbedding extends EmbeddingData {
  /** The embedding implementation. */
  kind: EmbeddingDataKind.MultimodalDenseAndMultiVector;

  ...MultimodalEmbeddingData;

  /** The kind of vectors returned. */
  vectorKind: EmbeddingVectorKind.DenseAndMulti;

  /** The number of multi-vectors and their number of dimensions: `[vectors, multiDimensions]`. */
  shape: int32[];

  /**
   * The dense vector: an array of numbers, or, when `encodingFormat` is `base64`, a base64 string of its little-endian
   * `outputDataKind` values.
   */
  embedding: EmbeddingVector;

  /**
   * The multi-vectors: an array of arrays of numbers, or, when `encodingFormat` is `base64`, one base64 string of all
   * their little-endian `outputDataKind` values in row-major order. Decode it and reshape it to `shape`.
   */
  multiEmbedding: MultiEmbeddingVector;
}

/** A dense vector: numbers, or a base64 string of little-endian values. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "The vector is returned as numbers or as a base64 string, depending on the requested encoding format."
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "A vector is either numbers or a base64 string; there is no common base type."
@added(Versions.v2026_11_01_preview)
union EmbeddingVector {
  /** The values as numbers. */
  float32[],

  /** The values as a base64 string of little-endian values. */
  string,
}

/**
 * Multi-vectors: arrays of numbers, or one base64 string of all values (little-endian `outputDataKind`, row-major) to
 * decode and reshape to the item's `shape`.
 */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "The vectors are returned as numbers or as a base64 string, depending on the requested encoding format."
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "Multi-vectors are either arrays of numbers or a base64 string; there is no common base type."
@added(Versions.v2026_11_01_preview)
union MultiEmbeddingVector {
  /** The vectors as arrays of numbers. */
  float32[][],

  /**
   * All vectors as one base64 string: the little-endian `outputDataKind` values in row-major order, `shape[0]` vectors of
   * `shape[1]` values each. For example, in Python: `numpy.frombuffer(base64.b64decode(value), datatype).reshape(shape)`.
   */
  string,
}

/** The implementation that reported embedding usage. */
@added(Versions.v2026_11_01_preview)
union EmbeddingUsageKind {
  string,

  /** Usage from a multimodal embedding model. */
  Multimodal: "multimodal",
}

/** Common usage for an embedding operation. Token counts are omitted when the model doesn't report them. */
@added(Versions.v2026_11_01_preview)
@discriminator("kind")
model EmbeddingUsage {
  /** The embedding implementation that reported this usage. */
  kind: EmbeddingUsageKind;

  /** The number of input tokens. */
  promptTokens?: int64;

  /** The total number of tokens. */
  totalTokens?: int64;
}

/** Usage for a multimodal embedding operation. */
@added(Versions.v2026_11_01_preview)
model MultimodalEmbeddingUsage extends EmbeddingUsage {
  /** The embedding implementation, always `multimodal`. */
  kind: EmbeddingUsageKind.Multimodal;

  /**
   * Tokens that aren't image tokens: the query and text items (including the query instruction) and the short prompt
   * the model adds around each image. Equal to `promptTokens` minus `visualTokens`, so text and image tokens can be
   * priced separately. Omitted when the split isn't known: `promptTokens` isn't reported, or the request has images
   * and `visualTokens` isn't reported.
   */
  textTokens?: int64;

  /** The number of images embedded. */
  imageCount: int32;

  /** The number of tokens the images produced. */
  visualTokens?: int64;
}

/** The result of an embedding operation. */
@added(Versions.v2026_11_01_preview)
model EmbeddingResult {
  /** The object type, always `list`. */
  object: "list";

  /** The name of the model that produced the vectors. */
  `model`: string;

  /** The model version that produced the vectors. Pin it to keep an index stable. */
  modelVersion: string;

  /** The numeric type of the returned values. */
  outputDataKind: EmbeddingOutputDataKind;

  /** One entry per item in `inputs`, in request order. Empty when `output` is present. */
  data: EmbeddingData[];

  /** Usage for the operation. */
  usage: EmbeddingUsage;

  /** Things to know about a successful response, such as truncated items. Omitted when there are none. */
  warnings?: MultimodalEmbeddingWarning[];

  /** With `delivery: link`: where to read the results. */
  output?: MultimodalEmbeddingOutput;
}

/**
 * A `delivery: link` result: a JSON file with the complete response (the same body as an inline response, including
 * `data`), readable with `sasToken` until `expiresAt`.
 */
@added(Versions.v2026_11_01_preview)
model MultimodalEmbeddingOutput {
  /** The result's identifier, for support requests. */
  @pattern("^[0-9a-f]{32}$")
  id: string;

  /** The result file's URL, without a query string. Read it with `sasToken`. */
  url: url;

  /**
   * A read-only SAS for the result file only, valid until `expiresAt` (at most 15 minutes). Read the file with
   * `GET {url}?{sasToken}`.
   */
  @secret
  sasToken: string;

  /** When `sasToken` stops working. After that, send the request again, or use `delivery: inline`. */
  expiresAt: utcDateTime;

  /** The number of `data` items in the file. */
  recordCount: int32;

  /** The size of the file in bytes. */
  sizeInBytes: int64;

  /** The lowercase hexadecimal SHA-256 hash of the file. */
  sha256: string;

  /** The media type of the file: `application/json`. */
  contentType: string;
}

/** A machine-readable embedding warning code. */
@added(Versions.v2026_11_01_preview)
union EmbeddingWarningCode {
  string,

  /**
   * A `text` or `query` item was over the model's token limit, and only its start was embedded. Numeric alias
   * `1001`.
   */
  InputTruncated: "EMBEDDING_INPUT_TRUNCATED",

  /**
   * An item's `sasToken` stays valid for more than 15 minutes (plus 5 minutes of clock skew). The blob was read and
   * embedded; a shorter SAS is recommended. Numeric alias `1002`.
   */
  SasLongLived: "EMBEDDING_SAS_LONG_LIVED",
}

/** Something about a successful multimodal embedding response the caller should know. */
@added(Versions.v2026_11_01_preview)
model MultimodalEmbeddingWarning {
  /** A machine-readable warning code. */
  code: EmbeddingWarningCode;

  /** A stable numeric alias of `code`: `1001` for `EMBEDDING_INPUT_TRUNCATED`, `1002` for `EMBEDDING_SAS_LONG_LIVED`. */
  codeNumber?: int32;

  /** The zero-based position of the item the warning is about, in `inputs` and `data`. */
  index: int32;

  /** For `EMBEDDING_INPUT_TRUNCATED`: the item's tokens before truncation. */
  inputTokens?: int64;

  /** For `EMBEDDING_INPUT_TRUNCATED`: the tokens embedded. */
  tokens?: int64;

  /** A human-readable description that names the item, for example `inputs[1]`. */
  message: string;
}

/** A successful embedding response. */
@added(Versions.v2026_11_01_preview)
model EmbeddingOperationResult {
  ...CorrelatedResponseHeaders;

  /** The HTTP status code. */
  @statusCode
  statusCode: 200;

  /** The embedding result. */
  @bodyRoot
  result: EmbeddingResult;
}

/**
 * The embedding request was not valid. The `error.code` identifies the problem:
 * - `InvalidRequest`: the request isn't supported on this endpoint, for example `inputs` isn't enabled.
 * - `InvalidRequestBody`: malformed JSON, a wrong type, an unknown or snake_case field, or a value outside its allowed
 *   set. `error.details` describes each problem.
 * - `EMBEDDING_INPUT_INVALID`: an item's kind, source, size, format or count, or a model or version isn't valid.
 *   Text over the model's token limit isn't an error; see `EMBEDDING_INPUT_TRUNCATED`.
 * - `EMBEDDING_URL_NOT_ALLOWED`: `input_images`, a link in an image's `content`, a `url` where blob inputs are off or
 *   from an API-key caller, or a `sasToken` that isn't a read-only, https-only user delegation SAS for one blob signed
 *   by the caller. Nothing is read.
 * - `EMBEDDING_BLOB_READ_FAILED`: Storage refused the blob, for example because of an expired SAS or a missing blob.
 * - `EMBEDDING_DELIVERY_NOT_SUPPORTED`: `delivery: link` isn't enabled on this endpoint. Use `inline`.
 */
@added(Versions.v2026_11_01_preview)
@error
model EmbeddingBadRequestResult
  is Azure.Core.Foundations.ErrorResponseBase<ProblemDetails> {
  ...CorrelatedResponseHeaders;

  /** The HTTP status code. */
  @statusCode
  statusCode: 400;
}

/** The caller isn't allowed to perform the operation. */
@added(Versions.v2026_11_01_preview)
@error
model EmbeddingForbiddenResult
  is Azure.Core.Foundations.ErrorResponseBase<ProblemDetails> {
  ...CorrelatedResponseHeaders;

  /** The HTTP status code. */
  @statusCode
  statusCode: 403;
}

/** The request or a blob it names is too large. `error.code` is `EMBEDDING_BLOB_READ_FAILED` when a blob exceeds its size limit. */
@added(Versions.v2026_11_01_preview)
@error
model EmbeddingPayloadTooLargeResult
  is Azure.Core.Foundations.ErrorResponseBase<ProblemDetails> {
  ...CorrelatedResponseHeaders;

  /** The HTTP status code. */
  @statusCode
  statusCode: 413;
}

/** Azure Blob Storage failed while the service was reading a blob. `error.code` is `EMBEDDING_BLOB_READ_FAILED`. */
@added(Versions.v2026_11_01_preview)
@error
model EmbeddingBadGatewayResult
  is Azure.Core.Foundations.ErrorResponseBase<ProblemDetails> {
  ...CorrelatedResponseHeaders;

  /** The HTTP status code. */
  @statusCode
  statusCode: 502;
}

/**
 * The service couldn't complete the request. `error.code` is `EMBEDDING_OUTPUT_WRITE_FAILED` when a `delivery: link`
 * result couldn't be stored. Try again, or use `delivery: inline`.
 */
@added(Versions.v2026_11_01_preview)
@error
model EmbeddingServiceUnavailableResult
  is Azure.Core.Foundations.ErrorResponseBase<ProblemDetails> {
  ...CorrelatedResponseHeaders;

  /** The HTTP status code. */
  @statusCode
  statusCode: 503;
}

/** Azure Blob Storage didn't return a blob in time. `error.code` is `EMBEDDING_BLOB_READ_FAILED`. */
@added(Versions.v2026_11_01_preview)
@error
model EmbeddingGatewayTimeoutResult
  is Azure.Core.Foundations.ErrorResponseBase<ProblemDetails> {
  ...CorrelatedResponseHeaders;

  /** The HTTP status code. */
  @statusCode
  statusCode: 504;
}

/** Errors returned by a multimodal embedding operation. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" "The union defines distinct HTTP error responses and is not emitted as a response body schema."
#suppress "@azure-tools/typespec-client-generator-core/use-union-hierarchy" "The union defines distinct HTTP error responses, matching InferenceOperationError."
@added(Versions.v2026_11_01_preview)
union EmbeddingOperationError {
  /** The request was not valid. */
  badRequest: EmbeddingBadRequestResult,

  /** The caller isn't allowed to perform the operation. */
  forbidden: EmbeddingForbiddenResult,

  /** The request or a blob it names is too large. */
  payloadTooLarge: EmbeddingPayloadTooLargeResult,

  /** The request was rate limited. */
  tooManyRequests: TooManyRequestsResult,

  /** Azure Blob Storage failed while the service was reading a blob. */
  badGateway: EmbeddingBadGatewayResult,

  /** The service couldn't complete the request. */
  serviceUnavailable: EmbeddingServiceUnavailableResult,

  /** Azure Blob Storage didn't return a blob in time. */
  gatewayTimeout: EmbeddingGatewayTimeoutResult,

  /** An unexpected error occurred. */
  unexpected: InferenceErrorResult,
}

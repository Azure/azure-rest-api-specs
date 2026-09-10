import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";

using Azure.Core;
using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace ContentUnderstanding;

@doc("Analyzer that extracts content and fields from multimodal documents.")
@resource("analyzers")
model ContentAnalyzer {
  @doc("The unique identifier of the analyzer.")
  @key
  @visibility(Lifecycle.Read)
  @pattern("^[a-zA-Z0-9._-]{1,64}$")
  @minLength(1)
  @maxLength(64)
  analyzerId: string;

  @doc("A description of the analyzer.")
  description?: string;

  @doc("Tags associated with the analyzer.")
  tags?: Record<string>;

  @doc("The status of the analyzer.")
  @visibility(Lifecycle.Read)
  status: ContentAnalyzerStatus;

  @doc("The date and time when the analyzer was created.")
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  @doc("The date and time when the analyzer was last modified.")
  @visibility(Lifecycle.Read)
  lastModifiedAt: utcDateTime;

  @doc("Warnings encountered while creating the analyzer.")
  @visibility(Lifecycle.Read)
  warnings?: Azure.Core.Foundations.Error[];

  @doc("The analyzer to incrementally train from.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @pattern("^[a-zA-Z0-9._-]{1,64}$")
  @minLength(1)
  @maxLength(64)
  baseAnalyzerId?: string;

  // @removed(Versions.v2025_05_01_preview)
  // @doc("The scenario for which the analyzer is optimized.")
  // @visibility(Lifecycle.Create, Lifecycle.Read)
  // scenario?: string;

  @doc("Analyzer configuration settings.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  config?: ContentAnalyzerConfig;

  @doc("The schema of fields to extracted.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  fieldSchema?: FieldSchema;

  @added(Versions.v2025_11_01)
  @doc("Indicates whether the result may contain additional fields outside of the defined schema.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  dynamicFieldSchema?: boolean = false;

  // @removed(Versions.v2025_11_01)
  // @doc("The data source containing training data for the analyzer.")
  // @visibility(Lifecycle.Create, Lifecycle.Read)
  // trainingData?: DataSource;

  // @added(Versions.v2025_05_01_preview)
  @doc("The location where the data may be processed.  Defaults to global.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  processingLocation?: ProcessingLocation = ProcessingLocation.global;

  // @added(Versions.v2025_05_01_preview)
  // @removed(Versions.v2025_11_01)
  // @doc("The analysis mode: standard, pro.  Default is standard.")
  // @visibility(Lifecycle.Create, Lifecycle.Read)
  // mode?: AnalysisMode = AnalysisMode.standard;

  // @added(Versions.v2025_05_01_preview)
  @doc("Additional knowledge sources used to enhance the analyzer.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  knowledgeSources?: KnowledgeSource[];

  @added(Versions.v2025_11_01)
  @doc("""
    Mapping of model roles to specific model names.
    Ex. { "completion": "gpt-4.1", "embedding": "text-embedding-3-large" }.
    """)
  @visibility(Lifecycle.Create, Lifecycle.Read)
  models?: Record<string>;

  @added(Versions.v2025_11_01)
  @doc("Chat completion and embedding models supported by the analyzer.")
  @visibility(Lifecycle.Read)
  supportedModels?: SupportedModels;
}

@added(Versions.v2025_11_01)
@doc("Chat completion and embedding models supported by the analyzer.")
model SupportedModels {
  @doc("Chat completion models supported by the analyzer.")
  completion?: string[];

  @doc("Embedding models supported by the analyzer.")
  embedding?: string[];
}

@doc("Status of a resource.")
union ContentAnalyzerStatus {
  string,

  @doc("The resource is being created.")
  creating: "creating",

  @doc("The resource is ready.")
  ready: "ready",

  @doc("The resource is being deleted.")
  deleting: "deleting",

  @doc("The resource failed during creation.")
  failed: "failed",
}

@doc("The location where the data may be processed.")
union ProcessingLocation {
  string,

  @doc("Data may be processed in the same geography as the resource.")
  geography: "geography",

  @doc("Data may be processed in the same data zone as the resource.")
  dataZone: "dataZone",

  @doc("Data may be processed in any Azure data center globally.")
  global: "global",
}

@doc("Knowledge source kind.")
union KnowledgeSourceKind {
  string,

  @added(Versions.v2025_11_01)
  @doc("A labeled data knowledge source.")
  labeledData: "labeledData",
}

@doc("Knowledge source.")
@discriminator("kind")
model KnowledgeSource {
  @doc("The kind of knowledge source.")
  kind: KnowledgeSourceKind;
}

@added(Versions.v2025_11_01)
@doc("Labeled data knowledge source.")
model LabeledDataKnowledgeSource extends KnowledgeSource {
  @doc("A blob container containing labeled data.")
  kind: KnowledgeSourceKind.labeledData;

  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("The URL of the blob container containing labeled data.")
  containerUrl: url;

  @doc("An optional prefix to filter blobs within the container.")
  prefix?: string;

  @doc("An optional path to a file listing specific blobs to include.")
  fileListPath: string;
}

@doc("Schema of fields to be extracted from documents.")
@clientName("ContentFieldSchema")
model FieldSchema {
  @doc("The name of the field schema.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name?: string;

  @doc("A description of the field schema.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  description?: string;

  @doc("The fields defined in the schema.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  fields: Record<ContentFieldDefinition>;

  @doc("Additional definitions referenced by the fields in the schema.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  definitions?: Record<ContentFieldDefinition>;
}

@doc("Configuration settings for an analyzer.")
model ContentAnalyzerConfig {
  @doc("Return all content details.")
  returnDetails?: boolean;

  @doc("List of locale hints for speech transcription.")
  locales?: string[];

  @doc("Enable optical character recognition (OCR).")
  enableOcr?: boolean;

  @doc("Enable layout analysis.")
  enableLayout?: boolean;

  @added(Versions.v2025_11_01)
  @doc("Enable generation of figure description.")
  enableFigureDescription?: boolean;

  @added(Versions.v2025_11_01)
  @doc("Enable analysis of figures, such as charts and diagrams.")
  enableFigureAnalysis?: boolean;

  @doc("Enable mathematical formula detection.")
  enableFormula?: boolean;

  @doc("Representation format of tables in analyze result markdown.")
  tableFormat?: TableFormat = TableFormat.html;

  @added(Versions.v2025_11_01)
  @doc("Representation format of charts in analyze result markdown.")
  chartFormat?: ChartFormat = ChartFormat.chartJs;

  @added(Versions.v2025_11_01)
  @doc("Representation format of annotations in analyze result markdown.")
  annotationFormat?: AnnotationFormat = AnnotationFormat.markdown;

  @doc("Disable the default blurring of faces for privacy while processing the content.")
  disableFaceBlurring?: boolean;

  @doc("Return field grounding source and confidence.")
  estimateFieldSourceAndConfidence?: boolean;

  @added(Versions.v2025_11_01)
  @doc("Map of categories to classify the input content(s) against.")
  contentCategories?: Record<ContentCategoryDefinition>;

  @added(Versions.v2025_11_01)
  @doc("Enable segmentation of the input by contentCategories.")
  enableSegment?: boolean;

  @added(Versions.v2025_11_01)
  @doc("Force segmentation of document content by page.")
  segmentPerPage?: boolean;

  @added(Versions.v2025_11_01)
  @doc("""
    Omit the content for this analyzer from analyze result.
    Only return content(s) from additional analyzers specified in contentCategories, if any.
    """)
  omitContent?: boolean;

  @added(Versions.v2026_06_01_preview)
  @doc("Workflow used for content analysis.")
  workflow?: ContentAnalyzerWorkflow;

  @added(Versions.v2026_06_01_preview)
  @doc("""
    When true, input that exceeds the service's processable-unit limit is truncated to the limit and returned as a
    partial result with a warning, instead of failing. Field extraction and segmentation, where configured, run over
    the processed content and may be inaccurate. Defaults to false. Overridable per request by the allowInputTruncation
    query parameter.
    """)
  allowInputTruncation?: boolean;

  @added(Versions.v2026_06_01_preview)
  @doc("Enable sub-page segmentation. When true, segments may cover a portion of a page instead of full pages.")
  allowInPageSegments?: boolean;

  @added(Versions.v2026_06_01_preview)
  @doc("Strategy for chunking document content into smaller units for RAG scenarios. When omitted, chunking is disabled.")
  chunkingStrategy?: ChunkingStrategy;
}

@added(Versions.v2026_06_01_preview)
@doc("The kind of chunking strategy.")
union ChunkingStrategyKind {
  string,

  @doc("Semantic chunking strategy.")
  semantic: "semantic",
}

@added(Versions.v2026_06_01_preview)
@doc("Strategy for chunking document content. The `kind` property serves as the discriminator.")
@discriminator("kind")
model ChunkingStrategy {
  @doc("The chunking strategy kind.")
  kind: ChunkingStrategyKind;
}

@added(Versions.v2026_06_01_preview)
@doc("Semantic chunking strategy that splits content into semantically meaningful, size-controlled chunks.")
model SemanticChunkingStrategy extends ChunkingStrategy {
  @doc("The chunking strategy kind.")
  kind: ChunkingStrategyKind.semantic;

  @doc("Target chunk size expressed in tokens. Interpreted as a soft limit; the chunking process may slightly exceed this value to respect semantic or structural boundaries.")
  maxTokens?: int32;
}

@doc("Representation format of tables in analyze result markdown.")
union TableFormat {
  string,

  @doc("Represent tables using HTML table elements: \\<table>, \\<th>, \\<tr>, \\<td>.")
  html: "html",

  @added(Versions.v2025_11_01)
  @doc("Represent tables using GitHub Flavored Markdown table syntax, which does not support merged cells or rich headers.")
  markdown: "markdown",
}

@added(Versions.v2025_11_01)
@doc("Representation format of charts in analyze result markdown.")
union ChartFormat {
  string,

  @doc("Represent charts as Chart.js code blocks.")
  chartJs: "chartJs",

  @doc("Represent charts as markdown tables.")
  markdown: "markdown",
}

@added(Versions.v2025_11_01)
@doc("Representation format of annotations in analyze result markdown.")
union AnnotationFormat {
  string,

  @doc("Do not represent annotations.")
  none: "none",

  @doc("Represent basic annotation information using markdown formatting.")
  markdown: "markdown",
}

@added(Versions.v2026_06_01_preview)
@doc("Workflow used for document analysis.")
union ContentAnalyzerWorkflow {
  string,

  @doc("Default analysis workflow. The service selects standard or advanced contextualization as appropriate for the analyzer.")
  default: "default",

  @doc("Agentic analysis workflow using iterative reasoning with integrated tool calling for enhanced accuracy on complex documents.")
  agentic: "agentic",
}

@doc("Definition of the field using a JSON Schema like syntax.")
model ContentFieldDefinition {
  @doc("Generation method.")
  method?: GenerationMethod;

  @doc("Semantic data type of the field value.")
  type?: ContentFieldType;

  @doc("Field description.")
  description?: string;

  @doc("Field type schema of each array element, if type is array.")
  items?: ContentFieldDefinition;

  @doc("Named sub-fields, if type is object.")
  properties?: Record<ContentFieldDefinition>;

  @doc("Examples of field values.")
  examples?: string[];

  @doc("Enumeration of possible field values.")
  `enum`?: string[];

  @doc("Descriptions for each enumeration value.")
  enumDescriptions?: Record<string>;

  @doc("Reference to another field definition.")
  $ref?: string;

  @added(Versions.v2025_11_01)
  @doc("Return grounding source and confidence.")
  estimateSourceAndConfidence?: boolean;
}

@doc("Generation method.")
union GenerationMethod {
  string,

  @doc("Values are generated freely based on the content.")
  generate: "generate",

  @doc("Values are extracted as they appear in the content.")
  extract: "extract",

  @doc("Values are classified against a predefined set of categories.")
  classify: "classify",
}

@doc("Semantic data type of the field value.")
union ContentFieldType {
  string,

  @doc("Plain text.")
  string: "string",

  @doc("Date, normalized to ISO 8601 (YYYY-MM-DD) format.")
  date: "date",

  @doc("Time, normalized to ISO 8601 (hh:mm:ss) format.")
  time: "time",

  @doc("Number as double precision floating point.")
  number: "number",

  @doc("Integer as 64-bit signed integer.")
  integer: "integer",

  @doc("Boolean value.")
  boolean: "boolean",

  @doc("List of subfields of the same type.")
  array: "array",

  @doc("Named list of subfields.")
  object: "object",

  @added(Versions.v2025_11_01)
  @doc("JSON object.")
  json: "json",
}

@added(Versions.v2025_11_01)
@doc("Content category definition.")
model ContentCategoryDefinition {
  @doc("The description of the category.")
  description?: string;

  @doc("Optional analyzer used to process the content.")
  analyzerId?: string;

  @doc("Optional inline definition of analyzer used to process the content.")
  analyzer?: ContentAnalyzer;
}

@doc("Analyze operation parameters.")
model AnalyzeParameters {
  @doc("""
      The string encoding format for content spans in the response.
      Possible values are 'codePoint', 'utf16', and `utf8`.  Default is `codePoint`.")
    """)
  @query
  stringEncoding?: string = "codePoint";

  @doc("The location where the data may be processed.  Defaults to global.")
  @query
  processingLocation?: ProcessingLocation = ProcessingLocation.global;

  @added(Versions.v2026_06_01_preview)
  @doc("Overrides the analyzer's allowInputTruncation setting for this request. When omitted, the analyzer's configured value applies.")
  @query
  allowInputTruncation?: boolean;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Analyze operation request.")
model AnalyzeRequest {
  ...AnalyzeParameters;

  @doc("Inputs to analyze.  Currently, only pro mode supports multiple inputs.")
  inputs: AnalysisInput[];

  @added(Versions.v2025_11_01)
  @doc("Specify the default mapping of model names to LLM/embedding deployments in Microsoft Foundry. For details and current semantics, see https://aka.ms/cudoc-quickstart-rest.")
  modelDeployments?: Record<string>;
}

@added(Versions.v2025_11_01)
@doc("""
    Range expression for specifying parts of the input to analyze (ex. `1-3,5,9-`).
    Document content uses 1-based page numbers, while audio visual content uses integer milliseconds.
  """)
scalar RangeExpression extends string;

@doc("Additional input to analyze.")
model AnalysisInput {
  @doc("The URL of the input to analyze.  Only one of url or data should be specified.")
  url?: url;

  @doc("Base64-encoded binary content of the input to analyze.  Only one of url or data should be specified.")
  data?: bytes;

  @doc("Name of the input.")
  name?: string;

  @added(Versions.v2025_11_01)
  @doc("The MIME type of the input content.  Ex. application/pdf, image/jpeg, etc.")
  mimeType?: string;

  @added(Versions.v2025_11_01)
  @doc("Range of the input to analyze (ex. `1-3,5,9-`).  Document content uses 1-based page numbers, while audio visual content uses integer milliseconds.")
  range?: RangeExpression;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Analyze operation request directly from binary content.")
model AnalyzeBinaryRequest {
  ...AnalyzeParameters;

  @doc("Request content type.")
  @header
  contentType: string = "application/octet-stream";

  @doc("The binary content of the document to analyze.")
  @bodyRoot
  input: bytes;

  @added(Versions.v2025_11_01)
  @doc("Range of the input to analyze (ex. `1-3,5,9-`).  Document content uses 1-based page numbers, while audio visual content uses integer milliseconds.")
  @query
  range?: RangeExpression;
}

@doc("Get result operation parameters.")
model GetResultParameters {}

@doc("Analyze operation result.")
model AnalysisResult {
  @doc("The unique identifier of the analyzer.")
  @pattern("^[a-zA-Z0-9._-]{1,64}$")
  @minLength(1)
  @maxLength(64)
  analyzerId?: string;

  @doc("The version of the API used to analyze the document.")
  apiVersion?: string;

  @doc("The date and time when the result was created.")
  createdAt?: utcDateTime;

  @doc("Warnings encountered while analyzing the document.")
  warnings?: Azure.Core.Foundations.Error[];

  @added(Versions.v2026_06_01_preview)
  @doc("Additional diagnostic information about the analysis.")
  infos?: Azure.Core.Foundations.Error[];

  // @added(Versions.v2025_05_01_preview)
  @doc("""
      The string encoding format for content spans in the response.
      Possible values are 'codePoint', 'utf16', and `utf8`.  Default is `codePoint`.")
    """)
  stringEncoding?: string = "codePoint";

  @doc("The extracted content.")
  contents: AnalysisContent[];
}

@doc("Kind of media content.")
union AnalysisContentKind {
  string,

  @doc("Document content, such as pdf, image, txt, etc.")
  document: "document",

  @doc("Audio visual content, such as mp3, mp4, etc.")
  audioVisual: "audioVisual",
}

@doc("Media content base class.")
@discriminator("kind")
model AnalysisContent {
  @doc("Content kind.")
  kind: AnalysisContentKind;

  // @added(Versions.v2025_05_01_preview)
  @doc("Detected MIME type of the content.  Ex. application/pdf, image/jpeg, etc.")
  mimeType: string;

  @added(Versions.v2025_11_01)
  @doc("The analyzer that generated this content.")
  @pattern("^[a-zA-Z0-9._-]{1,64}$")
  @minLength(1)
  @maxLength(64)
  analyzerId?: string;

  // @added(Versions.v2025_05_01_preview)
  @doc("Classified content category.")
  category?: string;

  // @added(Versions.v2025_05_01_preview)
  @doc("The path of the content in the input.")
  path?: string;

  @doc("Markdown representation of the content.")
  markdown?: string;

  @doc("Extracted fields from the content.")
  fields?: Record<ContentField>;

  @added(Versions.v2026_06_01_preview)
  @doc("Metadata extracted from the input as string key/value pairs, such as author, title, creation date, or media properties. Keys and values are strings. Only keys with extracted values are present.")
  metadata?: Record<string>;
}

@doc("Position of the element in markdown, specified as a character offset and length.")
model ContentSpan {
  @doc("Starting position (0-indexed) of the element in markdown, specified in characters.")
  offset: int32;

  @doc("Length of the element in markdown, specified in characters.")
  length: int32;
}

@doc("Encoded string expression that describes positions in the content.")
scalar SourceExpression extends string;

@doc("Field extracted from the content.")
@discriminator("type")
model ContentField {
  @doc("Semantic data type of the field value.")
  type: ContentFieldType;

  @doc("Span(s) associated with the field value in the markdown content.")
  spans?: ContentSpan[];

  @doc("Confidence of predicting the field value.")
  @minValue(0)
  @maxValue(1)
  confidence?: float32;

  @doc("Encoded source that identifies the position of the field value in the content.")
  source?: SourceExpression;
}

@doc("String field extracted from the content.")
model StringField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: ContentFieldType.string;

  @doc("String field value.")
  valueString?: string;
}

@doc("Date field extracted from the content.")
model DateField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: ContentFieldType.date;

  @doc("Date field value, in ISO 8601 (YYYY-MM-DD) format.")
  valueDate?: plainDate;
}

@doc("Time field extracted from the content.")
model TimeField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: ContentFieldType.time;

  @doc("Time field value, in ISO 8601 (hh:mm:ss) format.")
  valueTime?: plainTime;
}

@doc("Number field extracted from the content.")
model NumberField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: ContentFieldType.number;

  @doc("Number field value.")
  valueNumber?: float64;
}

@doc("Integer field extracted from the content.")
model IntegerField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: ContentFieldType.integer;

  @doc("Integer field value.")
  valueInteger?: int64;
}

@doc("Boolean field extracted from the content.")
model BooleanField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: ContentFieldType.boolean;

  @doc("Boolean field value.")
  valueBoolean?: boolean;
}

@doc("Array field extracted from the content.")
model ArrayField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: ContentFieldType.array;

  @doc("Array field value.")
  valueArray?: ContentField[];
}

@doc("Object field extracted from the content.")
model ObjectField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: ContentFieldType.object;

  @doc("Object field value.")
  valueObject?: Record<ContentField>;
}

@added(Versions.v2025_11_01)
@doc("JSON field extracted from the content.")
model JsonField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: ContentFieldType.json;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "Property value is dynamic and can be any JSON object."
  @doc("JSON field value.")
  valueJson?: unknown;
}

@added(Versions.v2025_11_01)
@doc("Usage details.")
model UsageDetails {
  @doc("""
    The number of document pages processed at the minimal level.
    For documents without explicit pages (ex. txt, html), every 3000 UTF-16 characters is counted as one page.
    """)
  documentPagesMinimal?: int32;

  @doc("""
    The number of document pages processed at the basic level.
    For documents without explicit pages (ex. txt, html), every 3000 UTF-16 characters is counted as one page.
    """)
  documentPagesBasic?: int32;

  @doc("""
    The number of document pages processed at the standard level.
    For documents without explicit pages (ex. txt, html), every 3000 UTF-16 characters is counted as one page.
    """)
  documentPagesStandard?: int32;

  @added(Versions.v2026_06_01_preview)
  @doc("""
    The number of document pages processed at the minimal level by an inline analyze operation.
    For documents without explicit pages (ex. txt, html), every 3000 UTF-16 characters is counted as one page.
    """)
  documentPagesMinimalInline?: int32;

  @added(Versions.v2026_06_01_preview)
  @doc("""
    The number of document pages processed at the basic level by an inline analyze operation.
    For documents without explicit pages (ex. txt, html), every 3000 UTF-16 characters is counted as one page.
    """)
  documentPagesBasicInline?: int32;

  @added(Versions.v2026_06_01_preview)
  @doc("""
    The number of document pages processed at the standard level by an inline analyze operation.
    For documents without explicit pages (ex. txt, html), every 3000 UTF-16 characters is counted as one page.
    """)
  documentPagesStandardInline?: int32;

  @doc("The hours of audio processed.")
  audioHours?: float32;

  @doc("The hours of video processed.")
  videoHours?: float32;

  @doc("The number of contextualization tokens consumed for preparing context, generating confidence scores, source grounding, and output formatting.")
  contextualizationTokens?: int32;

  @added(Versions.v2026_06_01_preview)
  @doc("The number of advanced contextualization tokens consumed for preparing context, generating confidence scores, source grounding, and output formatting.")
  advancedContextualizationTokens?: int32;

  @doc("The number of LLM and embedding tokens consumed, grouped by model (ex. GTP 4.1) and type (ex. input, cached input, output).")
  tokens?: Record<int32>;
}

@added(Versions.v2025_11_01)
@doc("Copy authorization details for cross-resource copy.")
model CopyAuthorization {
  @doc("Full path of the source analyzer.")
  source: string;

  @doc("Azure resource ID of the target location to copy to.")
  targetAzureResourceId: string;

  @doc("Date/time when the copy authorization expires.")
  expiresAt: utcDateTime;
}

@doc("Provides status details for analyzer creation operations.")
model ContentAnalyzerOperationStatus {
  ...Azure.Core.Foundations.OperationStatus<ContentAnalyzer>;

  @added(Versions.v2025_11_01)
  @doc("Usage details of the analyzer creation operation.")
  usage?: UsageDetails;
}

@doc("Provides status details for analyze operations.")
model ContentAnalyzerAnalyzeOperationStatus {
  ...Azure.Core.Foundations.OperationStatus<AnalysisResult>;

  @added(Versions.v2025_11_01)
  @doc("Usage details of the analyze operation.")
  usage?: UsageDetails;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Preserve existing C# model name for backward compatibility."
@added(Versions.v2026_06_01_preview)
@doc("Provides inline response details for analyze operations.")
model ContentAnalyzerInlineResponse {
  @doc("The status of the inline analyze request.")
  status: Azure.Core.Foundations.OperationState;

  @doc("The result of the inline analyze request.")
  result: AnalysisResult;

  @doc("Usage details of the inline analyze request.")
  usage?: UsageDetails;
}

@added(Versions.v2025_11_01)
@doc("Default settings for this Content Understanding resource.")
model ContentUnderstandingDefaults {
  @doc("Specify the default mapping of model names to LLM/embedding deployments in Microsoft Foundry. For details and current semantics, see https://aka.ms/cudoc-quickstart-rest.")
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  modelDeployments: Record<string>;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.v2025_11_01)
@doc("Copy operation request.")
model CopyRequest {
  @doc("Azure resource ID of the source analyzer location.  Defaults to the current resource.")
  sourceAzureResourceId?: string;

  @doc("Azure region of the source analyzer location.  Defaults to current region.")
  sourceRegion?: string;

  @doc("Source analyzer ID.")
  sourceAnalyzerId: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@added(Versions.v2025_11_01)
@doc("Grant copy authorization request.")
model GrantCopyAuthorizationRequest {
  @doc("Azure resource ID of the target analyzer location.")
  targetAzureResourceId: string;

  @doc("Azure region of the target analyzer location.  Defaults to current region.")
  targetRegion?: string;
}

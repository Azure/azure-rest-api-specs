import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";

using Azure.Core;
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
  analyzerId: string;

  @doc("A description of the analyzer.")
  description?: string;

  @doc("Tags associated with the analyzer.")
  tags?: Record<string>;

  @doc("The status of the analyzer.")
  @visibility(Lifecycle.Read)
  status: ResourceStatus;

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
  baseAnalyzerId?: string;

  @removed(Versions.v2025_05_01_preview)
  @doc("The scenario for which the analyzer is optimized.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  scenario?: string;

  @doc("Analyzer configuration settings.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  config?: ContentAnalyzerConfig;

  @doc("The schema of fields to extracted.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  fieldSchema?: FieldSchema;

  @doc("The data source containing training data for the analyzer.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  trainingData?: DataSource;

  @added(Versions.v2025_05_01_preview)
  @doc("The location where the data may be processed.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  processingLocation?: ProcessingLocation = ProcessingLocation.geography;

  @added(Versions.v2025_05_01_preview)
  @doc("The analysis mode: standard, pro.  Default is standard.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  mode?: AnalysisMode = AnalysisMode.standard;

  // @added(Versions.v2025_05_01_preview)
  // @doc("The processing priority: normal, low.  Default is normal.")
  // @visibility(Lifecycle.Create, Lifecycle.Read)
  // priority?: ProcessingPriority = ProcessingPriority.normal;

  @added(Versions.v2025_05_01_preview)
  @doc("Additional knowledge sources used to enhance the analyzer.")
  knowledgeSources?: KnowledgeSource[];
}

@doc("Status of a resource.")
union ResourceStatus {
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

@added(Versions.v2025_05_01_preview)
@doc("Analysis mode.")
union AnalysisMode {
  string,

  // @doc("Lite analysis mode.")
  // lite: "lite",

  @doc("Standard analysis mode.")
  standard: "standard",

  @doc("Pro analysis mode.")
  pro: "pro",
}

// @added(Versions.v2025_05_01_preview)
// @doc("Processing priority.")
// union ProcessingPriority {
//   string,

//   @doc("Normal processing priority.")
//   normal: "normal",

//   @doc("Low processing priority.  Allow processing of larger inputs.")
//   low: "low",
// }

@added(Versions.v2025_05_01_preview)
@doc("Knowledge source kind.")
union KnowledgeSourceKind {
  string,

  @doc("A reference knowledge source.")
  reference: "reference",
}

@added(Versions.v2025_05_01_preview)
@doc("Knowledge source.")
@discriminator("kind")
model KnowledgeSource {
  @doc("The kind of knowledge source.")
  kind: KnowledgeSourceKind;
}

@added(Versions.v2025_05_01_preview)
@doc("File knowledge source.")
model ReferenceKnowledgeSource extends KnowledgeSource {
  @doc("Indicates that the knowledge source is a reference knowledge source.")
  kind: KnowledgeSourceKind.reference;

  @doc("The URL of the blob container.")
  containerUrl: url;

  @doc("An optional prefix to filter blobs within the container.")
  prefix?: string;

  @doc("Path to a file listing specific blobs to include.")
  fileListPath: string;
}

@doc("Schema of fields to be extracted from documents.")
model FieldSchema {
  @doc("The name of the field schema.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name?: string;

  @doc("A description of the field schema.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  description?: string;

  @doc("The fields defined in the schema.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  fields: Record<FieldDefinition>;

  @doc("Additional definitions referenced by the fields in the schema.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  definitions?: Record<FieldDefinition>;
}

@doc("Configuration settings for an analyzer.")
model ContentAnalyzerConfig {
  @doc("Return all content details.")
  returnDetails?: boolean;

  @doc("List of locale hints for speech transcription.")
  locales?: string[];

  @doc("Enable face detection.")
  enableFace?: boolean;

  @added(Versions.v2025_05_01_preview)
  @doc("Specify the person directory used for identifying detected faces.")
  personDirectoryId?: string;

  @doc("Enable optical character recognition (OCR).")
  enableOcr?: boolean;

  @doc("Enable layout analysis.")
  enableLayout?: boolean;

  @added(Versions.v2025_05_01_preview)
  @doc("Representation format of tables in analyze result markdown.")
  tableFormat?: TableFormat = TableFormat.html;

  @removed(Versions.v2025_05_01_preview)
  @doc("Enable barcode detection.")
  enableBarcode?: boolean;

  @doc("Enable mathematical formula detection.")
  enableFormula?: boolean;

  @added(Versions.v2025_05_01_preview)
  @doc("Disable the default blurring of faces for privacy while processing the content.")
  disableFaceBlurring?: boolean;

  @added(Versions.v2025_05_01_preview)
  @doc("Disable content filtering that detects and prevents the output of harmful content.")
  disableContentFiltering?: boolean;

  @added(Versions.v2025_05_01_preview)
  @doc("Return grounding source and confidence for extracted fields.")
  estimateFieldSourceAndConfidence?: boolean;

  @added(Versions.v2025_05_01_preview)
  @doc("Segmentation mode used to split audio/visual content.")
  segmentationMode?: SegmentationMode = SegmentationMode.noSegmentation;

  @added(Versions.v2025_05_01_preview)
  @doc("Segmentation definition for use with custom segmentation mode.")
  segmentationDefinition?: string;
}

@added(Versions.v2025_05_01_preview)
@doc("Representation format of tables in analyze result markdown.")
union TableFormat {
  string,

  @doc("Represent tables using HTML table elements: \\<table>, \\<th>, \\<tr>, \\<td>.")
  html: "html",

  // @doc("Represent tables using GitHub Flavored Markdown table syntax, which does not support merged cells or rich headers.")
  // markdown: "markdown",
}

@added(Versions.v2025_05_01_preview)
@doc("Segmentation mode used to split audio/visual content.")
union SegmentationMode {
  string,

  @doc("No segmentation.")
  noSegmentation: "noSegmentation",

  @doc("Automatic segmentation.")
  auto: "auto",

  @doc("Segment according to custom segmentation definition.")
  custom: "custom",
}

@doc("Data source kind.")
union DataSourceKind {
  string,

  @doc("A blob storage data source.")
  blob: "blob",
}

@doc("Data source specifying a set of documents.")
@discriminator("kind")
model DataSource {
  @doc("The kind of data source.")
  kind: DataSourceKind;
}

@doc("Blob storage data source.")
model BlobDataSource extends DataSource {
  @doc("Indicates that the data source is a blob.")
  kind: "blob";

  @doc("The URL of the blob container.")
  containerUrl: url;

  @doc("An optional prefix to filter blobs within the container.")
  prefix?: string;

  @doc("An optional path to a file listing specific blobs to include.")
  fileListPath?: string;
}

@doc("Definition of the field using a JSON Schema like syntax.")
model FieldDefinition {
  @doc("Generation method.")
  method?: GenerationMethod = GenerationMethod.generate;

  @doc("Semantic data type of the field value.")
  type?: FieldType;

  @doc("Field description.")
  description?: string;

  @doc("Field type schema of each array element, if type is array.")
  items?: FieldDefinition;

  @doc("Named sub-fields, if type is object.")
  properties?: Record<FieldDefinition>;

  @doc("Examples of field values.")
  examples?: string[];

  @doc("Enumeration of possible field values.")
  `enum`?: string[];

  @doc("Descriptions for each enumeration value.")
  enumDescriptions?: Record<string>;

  @doc("Reference to another field definition.")
  $ref?: string;
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
union FieldType {
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
}

@added(Versions.v2025_05_01_preview)
@doc("String encoding format.")
union StringEncoding {
  string,

  @doc("Unicode code point (UTF-32) encoding, used by languages such as Python, etc.")
  codePoint: "codePoint",

  @doc("UTF-16 encoding, used by languages such as C#, JavaScript, Java, etc.")
  utf16: "utf16",

  @doc("UTF-8 encoding, used by languages such as Go, Rust, Ruby, PHP, etc.")
  utf8: "utf8",
}

@doc("Analyze operation parameters.")
model AnalyzeParameters {
  // @added(Versions.v2025_05_01_preview)
  // @doc("Range of the input to analyze (ex. `1-3;5;9-`).  Document content uses 1-based page numbers, while audio visual content uses integer milliseconds.")
  // @query
  // range?: RangeExpression;

  @added(Versions.v2025_05_01_preview)
  @doc("The encoding format for content spans in the response.")
  @query
  stringEncoding?: StringEncoding = StringEncoding.codePoint;

  @added(Versions.v2025_05_01_preview)
  @doc("The location where the data may be processed.")
  @query
  processingLocation?: ProcessingLocation;

  // @added(Versions.v2025_05_01_preview)
  // @doc("The processing priority: normal, low.  Default is normal.")
  // @query
  // priority?: ProcessingPriority = ProcessingPriority.normal;
}

@doc("Analyze operation request.")
model AnalyzeRequest {
  ...AnalyzeParameters;

  @doc("The URL of the primary input to analyze.  Only one of url or data should be specified.")
  url?: url;

  @added(Versions.v2025_05_01_preview)
  @doc("Base64-encoded binary content of the primary input to analyze.  Only one of url or data should be specified.")
  data?: bytes;

  @added(Versions.v2025_05_01_preview)
  @doc("Additional inputs to analyze.  Only supported in analyzers with mode=pro.")
  inputs?: AnalyzeInput[];
}

@added(Versions.v2025_05_01_preview)
@doc("Additional input to analyze.")
model AnalyzeInput {
  @doc("The URL of the input to analyze.  Only one of url or data should be specified.")
  url: url;

  @doc("Base64-encoded binary content of the input to analyze.  Only one of url or data should be specified.")
  data?: bytes;

  @doc("Name of the input.")
  name?: string;
}

@doc("Analyze operation request directly from binary content.")
model AnalyzeBinaryRequest {
  ...AnalyzeParameters;

  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Conflicts with @typespec/http/content-type-string"
  @doc("Request content type.")
  @header
  contentType: string = "application/octet-stream";

  @doc("The binary content of the document to analyze.")
  @bodyRoot
  input: bytes;
}

@doc("Get result operation parameters.")
model GetResultParameters {
  // @doc("Embed images as base64 data URIs in Markdown.")
  // @query
  // embedImages?: boolean;
}

@doc("Analyze operation result.")
model AnalyzeResult {
  @doc("The unique identifier of the analyzer.")
  @pattern("^[a-zA-Z0-9._-]{1,64}$")
  analyzerId?: string;

  @doc("The version of the API used to analyze the document.")
  apiVersion?: string;

  @doc("The date and time when the result was created.")
  createdAt?: utcDateTime;

  @doc("Warnings encountered while analyzing the document.")
  warnings?: Azure.Core.Foundations.Error[];

  @added(Versions.v2025_05_01_preview)
  @doc("The string encoding used for content spans.")
  stringEncoding?: StringEncoding = StringEncoding.codePoint;

  @doc("The extracted content.")
  contents: MediaContent[];
}

@doc("Kind of media content.")
union MediaContentKind {
  string,

  @doc("Document content, such as pdf, image, txt, etc.")
  document: "document",

  @doc("Audio visual content, such as mp3, mp4, etc.")
  audioVisual: "audioVisual",
}

@doc("Media content base class.")
@discriminator("kind")
model MediaContent {
  @doc("Content kind.")
  kind: MediaContentKind;

  // TODO: Should be required.
  @added(Versions.v2025_05_01_preview)
  @doc("Detected MIME type of the content.  Ex. application/pdf, image/jpeg, etc.")
  mimeType?: string;

  @added(Versions.v2025_05_01_preview)
  @doc("Classified content category.")
  category?: string;

  @added(Versions.v2025_05_01_preview)
  @doc("The path of the content in the input.")
  path?: url;

  @doc("Markdown representation of the content.")
  markdown?: string;

  @doc("Extracted fields from the content.")
  fields?: Record<ContentField>;
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
  type: FieldType;

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
  type: FieldType.string;

  @doc("String field value.")
  valueString?: string;
}

@doc("Date field extracted from the content.")
model DateField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: FieldType.date;

  @doc("Date field value, in ISO 8601 (YYYY-MM-DD) format.")
  valueDate?: plainDate;
}

@doc("Time field extracted from the content.")
model TimeField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: FieldType.time;

  @doc("Time field value, in ISO 8601 (hh:mm:ss) format.")
  valueTime?: plainTime;
}

@doc("Number field extracted from the content.")
model NumberField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: FieldType.number;

  @doc("Number field value.")
  valueNumber?: float64;
}

@doc("Integer field extracted from the content.")
model IntegerField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: FieldType.integer;

  @doc("Integer field value.")
  valueInteger?: int64;
}

@doc("Boolean field extracted from the content.")
model BooleanField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: FieldType.boolean;

  @doc("Boolean field value.")
  valueBoolean?: boolean;
}

@doc("Array field extracted from the content.")
model ArrayField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: FieldType.array;

  @doc("Array field value.")
  valueArray?: ContentField[];
}

@doc("Object field extracted from the content.")
model ObjectField extends ContentField {
  @doc("Semantic data type of the field value.")
  type: FieldType.object;

  @doc("Object field value.")
  valueObject?: Record<ContentField>;
}

import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace ContentSafety;

@doc("The harm category supported in Text content analysis.")
union TextCategory {
  string,

  @doc("The harm category for Text - Hate.")
  "Hate",

  @doc("The harm category for Text - SelfHarm.")
  "SelfHarm",

  @doc("The harm category for Text - Sexual.")
  "Sexual",

  @doc("The harm category for Text - Violence.")
  "Violence",

  @added(ContentSafety.Versions.v2024_12_15_Preview)
  @doc("The harm category for Text - Drugs.")
  "Drugs",
}

@doc("The harm category supported in Image content analysis.")
union ImageCategory {
  string,

  @doc("The harm category for Image - Hate.")
  "Hate",

  @doc("The harm category for Image - SelfHarm.")
  "SelfHarm",

  @doc("The harm category for Image - Sexual.")
  "Sexual",

  @doc("The harm category for Image - Violence.")
  "Violence",

  @added(ContentSafety.Versions.v2024_12_15_Preview)
  @doc("The harm category for Text - Drugs.")
  "Drugs",
}

@doc("The type of text analysis output.")
union AnalyzeTextOutputType {
  string,

  @doc("Output severities in four levels, the value could be 0,2,4,6.")
  FourSeverityLevels: "FourSeverityLevels",

  @doc("Output severities in eight levels, the value could be 0,1,2,3,4,5,6,7.")
  EightSeverityLevels: "EightSeverityLevels",
}

@doc("The type of image analysis output.")
union AnalyzeImageOutputType {
  string,

  @doc("Output severities in four levels, the value could be 0,2,4,6.")
  FourSeverityLevels: "FourSeverityLevels",
}

@doc("The text analysis request.")
model AnalyzeTextOptions {
  @doc("The text to be analyzed. We support a maximum of 10k Unicode characters (Unicode code points) in the text of one request.")
  @maxLength(10000)
  text: string;

  @doc("The categories will be analyzed. If they are not assigned, a default set of analysis results for the categories will be returned.")
  categories?: TextCategory[];

  @doc("The names of blocklists.")
  blocklistNames?: string[];

  @doc("When set to true, further analyses of harmful content will not be performed in cases where blocklists are hit. When set to false, all analyses of harmful content will be performed, whether or not blocklists are hit.")
  haltOnBlocklistHit?: boolean;

  @doc("This refers to the type of text analysis output. If no value is assigned, the default value will be \"FourSeverityLevels\".")
  outputType?: AnalyzeTextOutputType = AnalyzeTextOutputType.FourSeverityLevels;
}

@doc("The text analysis response.")
model AnalyzeTextResult {
  @doc("The blocklist match details.")
  blocklistsMatch?: TextBlocklistMatch[];

  @doc("Analysis result for categories.")
  categoriesAnalysis: TextCategoriesAnalysis[];
}

@doc("The result of blocklist match.")
model TextBlocklistMatch {
  @doc("The name of the matched blocklist.")
  @maxLength(64)
  blocklistName: string;

  @doc("The ID of the matched item.")
  @maxLength(64)
  blocklistItemId: string;

  @doc("The content of the matched item.")
  @maxLength(128)
  blocklistItemText: string;
}

@doc("Text analysis result.")
model TextCategoriesAnalysis {
  @doc("The text analysis category.")
  category: TextCategory;

  @doc("The value increases with the severity of the input content. The value of this field is determined by the output type specified in the request. The output type could be ‘FourSeverityLevels’ or ‘EightSeverity Levels’, and the output value can be 0, 2, 4, 6 or 0, 1, 2, 3, 4, 5, 6, or 7.")
  severity?: int32;
}

@doc("The image analysis request.")
model AnalyzeImageOptions {
  @doc("The image to be analyzed.")
  image: ImageData;

  @doc("The categories will be analyzed. If they are not assigned, a default set of analysis results for the categories will be returned.")
  categories?: ImageCategory[];

  @doc("This refers to the type of image analysis output. If no value is assigned, the default value will be \"FourSeverityLevels\".")
  outputType?: AnalyzeImageOutputType = AnalyzeImageOutputType.FourSeverityLevels;
}

@doc("The image can be either base64 encoded bytes or a blob URL. You can choose only one of these options. If both are provided, the request will be refused. The maximum image size is 2048 x 2048 pixels and should not exceed 4 MB, while the minimum image size is 50 x 50 pixels.")
@clientName("ContentSafetyImageData", "csharp")
@clientName("ContentSafetyImageData", "java")
model ImageData {
  @doc("The Base64 encoding of the image.")
  content?: bytes;

  @doc("The blob url of the image.")
  @clientName("BlobUri", "csharp")
  blobUrl?: url;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request of detecting potential protected material present in the given text.")
model DetectImageProtectedMaterialOptions {
  @doc("The image to be analyzed, which may contain protected material.")
  image: ImageData;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The combined detection results of potential protected material.")
model DetectImageProtectedMaterialResult {
  @doc("Analysis result for the given image.")
  protectedMaterialAnalysis: ImageProtectedMaterialAnalysisResult;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The individual detection result of potential protected material.")
model ImageProtectedMaterialAnalysisResult {
  @doc("Whether potential protected material is detected or not.")
  detected: boolean;
}

@doc("The image analysis response.")
model AnalyzeImageResult {
  @doc("Analysis result for categories.")
  categoriesAnalysis: ImageCategoriesAnalysis[];
}

@doc("Image analysis result.")
model ImageCategoriesAnalysis {
  @doc("The image analysis category.")
  category: ImageCategory;

  @doc("The value increases with the severity of the input content. The value of this field is determined by the output type specified in the request. The output type could be ‘FourSeverityLevels’, and the output value can be 0, 2, 4, 6.")
  severity?: int32;
}

@doc("Text Blocklist.")
@resource("text/blocklists")
model TextBlocklist {
  @doc("Text blocklist name.")
  @pattern("^[0-9A-Za-z._~-]+$")
  @key("blocklistName")
  @visibility("read", "create", "query")
  @maxLength(64)
  @clientName("Name", "csharp")
  @clientName("name", "java")
  blocklistName: string;

  @doc("Text blocklist description.")
  @maxLength(1024)
  description?: string;
}

@doc("Item in a TextBlocklist.")
@resource("blocklistItems")
@parentResource(TextBlocklist)
model TextBlocklistItem {
  @doc("The service will generate a BlocklistItemId, which will be a UUID.")
  @key("blocklistItemId")
  @visibility("read")
  @maxLength(64)
  blocklistItemId: string;

  @doc("BlocklistItem description.")
  @maxLength(1024)
  description?: string;

  @doc("BlocklistItem content. The length is counted using Unicode code point.")
  @maxLength(128)
  text: string;

  @added(ContentSafety.Versions.v2024_09_01)
  @doc("An optional properties indicating whether this item is to be matched as a regular expression.")
  isRegex?: boolean;
}

@doc("The request to add blocklistItems to a text blocklist.")
model AddOrUpdateTextBlocklistItemsOptions {
  @doc("Array of blocklistItems to add.")
  blocklistItems: TextBlocklistItem[];
}

@doc("The response of adding blocklistItems to the text blocklist.")
model AddOrUpdateTextBlocklistItemsResult {
  @doc("Array of blocklistItems have been added.")
  blocklistItems: TextBlocklistItem[];
}

@doc("The request to remove blocklistItems from a text blocklist.")
model RemoveTextBlocklistItemsOptions {
  @doc("Array of blocklistItemIds to remove.")
  blocklistItemIds: string[];
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The request of analyzing potential direct or indirect injection attacks.")
model ShieldPromptOptions {
  @doc("The user prompt to be analyzed, which may contain direct injection attacks.")
  userPrompt?: string;

  @doc("The documents to be analyzed, which may contain direct or indirect injection attacks.")
  documents?: string[];
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The combined analysis results of potential direct or indirect injection attacks.")
model ShieldPromptResult {
  @doc("Direct injection attacks analysis result for the given user prompt.")
  userPromptAnalysis?: UserPromptInjectionAnalysisResult;

  @doc("Direct and indirect injection attacks analysis result for the given documents.")
  documentsAnalysis?: DocumentInjectionAnalysisResult[];
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The individual analysis result of potential injection attacks in the given user prompt.")
model UserPromptInjectionAnalysisResult {
  @doc("Whether a potential injection attack is detected or not.")
  attackDetected: boolean;
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The individual analysis result of potential injection attacks in the given documents.")
model DocumentInjectionAnalysisResult {
  @doc("Whether a potential injection attack is detected or not.")
  attackDetected: boolean;
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The request of detecting potential protected material present in the given text.")
model DetectTextProtectedMaterialOptions {
  @doc("The text to be analyzed, which may contain protected material. The characters will be counted in Unicode code points.")
  text: string;
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The combined detection results of potential protected material.")
model DetectTextProtectedMaterialResult {
  @doc("Analysis result for the given text.")
  protectedMaterialAnalysis: TextProtectedMaterialAnalysisResult;
}

@added(ContentSafety.Versions.v2024_09_01)
@doc("The individual detection result of potential protected material.")
model TextProtectedMaterialAnalysisResult {
  @doc("Whether potential protected material is detected or not.")
  detected: boolean;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request of detecting potential protected material present in the given code.")
model DetectCodeProtectedMaterialOptions {
  @doc("The code to be analyzed, which may contain protected material. The characters will be counted in Unicode code points.")
  code: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The combined detection results of potential protected material for code.")
model DetectCodeProtectedMaterialResult {
  @doc("Analysis result for the given text.")
  protectedMaterialAnalysis: CodeProtectedMaterialAnalysisResult;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The code citation of potential protected material for code.")
model CodeCitation {
  @doc("The license type fetched from source repository.")
  license: string;

  @doc("The repository URLs of the source code detected.")
  sourceUrls: string[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The individual detection result of potential protected material for code.")
model CodeProtectedMaterialAnalysisResult {
  @doc("Whether potential protected material is detected or not.")
  detected: boolean;

  @doc("The code citation of potential protected material for code.")
  codeCitations: CodeCitation[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The domain supported in Text Groundedness analysis.")
union GroundednessDomain {
  string,

  @doc("The domain for Groundedness analysis - Generic.")
  Generic: "Generic",

  @doc("The domain for Groundedness analysis - Medical.")
  Medical: "Medical",
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The task type supported in Text Groundedness analysis.")
union GroundednessTask {
  string,

  @doc("The task type for Groundedness analysis - Summarization.")
  Summarization: "Summarization",

  @doc("The task type for Groundedness analysis - QnA.")
  QnA: "QnA",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use PascalCase"
@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The options for QnA task.")
model QnAOptions {
  @doc("The user's question input in a QnA task.")
  query: string;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use PascalCase"
@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The LLM resource type supported in Text Groundedness analysis.")
union LLMResourceType {
  string,

  @doc("The LLM resource type for Groundedness analysis - Azure OpenAI.")
  AzureOpenAI: "AzureOpenAI",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use PascalCase"
@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Details of the given LLM resource.")
model LLMResource {
  @doc("LLM resource type.")
  resourceType?: LLMResourceType = LLMResourceType.AzureOpenAI;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
  @doc("Endpoint for Azure OpenAI resource.")
  azureOpenAIEndpoint: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
  @doc("Deployment name.")
  azureOpenAIDeploymentName: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request of text groundedness analysis.")
model AnalyzeTextGroundednessOptions {
  @doc("""
    The domain of the text for analysis. Allowed values: Medical, Generic.
    This field is optional, with a default value of Generic.
    """)
  domain?: GroundednessDomain = GroundednessDomain.Generic;

  @doc("""
    The task type for the text analysis. Type of task: QnA, Summarization.
    This field is optional, with a default value of Summarization.
    """)
  task?: GroundednessTask = GroundednessTask.Summarization;

  @doc("""
    The user's question input in a QnA scenario.
    This field is optional, but cannot be omitted when task type is QnA.
    """)
  qna?: QnAOptions;

  @doc("The text to be analyzed. Usually, it's the LLM output and may contain ungrounded content.")
  text: string;

  @doc("""
    The grounding sources to be used for validating the groundedness.
    Limit: Restrictions on the total amount of grounding sources that can be analyzed in a single request are 55K characters (in Unicode code point).
    """)
  groundingSources: string[];

  @doc("""
    A value indicating if to generate mitigated content for the ungrounded content and included in the response.
    This field is optional, with a default value of false.
    """)
  correction?: boolean;

  @doc("""
    A value indicating if to generate an explanation for the groundedness analysis result and included in the response.
    This field is optional, with a default value of false.
    """)
  reasoning?: boolean;

  @doc("""
    Connection details for the LLM resource. 
    This field will be used only when the 'reasoning' field is set to true; otherwise, it will be ignored.
    """)
  llmResource?: LLMResource;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("To describe the string index in different representations.")
model IndexDetails {
  @doc("Indicate the index when encoding is UTF-8.")
  utf8: int64;

  @doc("Indicate the index when encoding is UTF-16.")
  utf16: int64;

  @doc("Indicate the index with code point format.")
  codePoint: int64;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Details of the content that identified as ungroundedness.")
model UngroundednessDetails {
  @doc("The original text which is considered as ungrounded.")
  text: string;

  @doc("The offset that the ungrounded content starts in the original text.")
  offset: IndexDetails;

  @doc("The length of the ungrounded content.")
  length: IndexDetails;

  @doc("""
    The explanation for detected ungroundedness.
    It's available only when the 'reasoning' field in the input is set to true.
    """)
  reason?: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The response of text groundedness analysis.")
model AnalyzeTextGroundednessResult {
  @doc("Indicates whether ungrounded content is detected.")
  ungroundedDetected: boolean;

  @doc("""
    Specifies the proportion of the text identified as ungrounded, 
    expressed as a decimal between 0 and 1,
    where 0 indicates no ungrounded content and 1 indicates the entire given text is considered ungrounded.
    """)
  ungroundedPercentage: float32;

  @doc("Provides insights into ungrounded content with specific examples and percentages.")
  ungroundedDetails: UngroundednessDetails[];

  @doc("""
    The correction for detected ungroundedness.
    It's available only when the 'correction' field in the input is set to true.
    """)
  correctedText?: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The possible status of a content safety incident operation.")
union IncidentOperationStatus {
  string,

  @doc("Content Safety Incident operation status - NotStarted")
  "NotStarted",

  @doc("Content Safety Incident operation status - Running")
  "Running",

  @doc("Content Safety Incident operation status - Succeeded")
  "Succeeded",

  @doc("Content Safety Incident operation status - Failed")
  "Failed",

  @doc("Content Safety Incident operation status - Canceled")
  "Canceled",
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Definition of a content safety Text Incident.")
@resource("text/incidents")
model TextIncident {
  @doc("The name of the incident.")
  @visibility("read", "create", "query")
  @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @maxLength(64)
  @key("incidentName")
  incidentName: string;

  @doc("The guideline to define this incident.")
  incidentDefinition?: string;

  @doc("The created time of this incident.")
  @visibility("read", "query")
  created: utcDateTime;

  @doc("The latest updated time of this incident.")
  @visibility("read", "query")
  lastUpdated: utcDateTime;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Definition of a sample in a Text Incident.")
@resource("incidentSamples")
@parentResource(TextIncident)
model TextIncidentSample {
  @doc("The name of this incident sample.")
  @visibility("read")
  @maxLength(64)
  @key("incidentSampleId")
  incidentSampleId: string;

  @doc("The text content of this incident sample.")
  text?: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request to add incident samples to a Text Incident.")
model AddTextIncidentSamplesOptions {
  @doc("Incident samples to be added.")
  incidentSamples: TextIncidentSample[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The response of adding incident samples to a Text Incident.")
model AddTextIncidentSamplesResult {
  @doc("Incident samples have been added.")
  incidentSamples: TextIncidentSample[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request to remove incident samples from a Text Incident.")
model RemoveTextIncidentSamplesOptions {
  @doc("Incident samples to be removed.")
  incidentSampleIds: string[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request to analyze given text content with content safety Text Incidents defined.")
model AnalyzeTextDetectIncidentsOptions {
  @doc("The text to be analyzed.")
  text: string;

  @doc("The incidents defined.")
  incidentNames: string[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The definition of a matched content safety incident.")
model IncidentMatch {
  @doc("The name of the matched incident.")
  incidentName: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The response of analyzing given content with content safety incidents defined.")
model DetectIncidentsResult {
  @doc("The details of matched incidents.")
  incidentMatches: IncidentMatch[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Definition of a content safety Image Incident.")
@resource("image/incidents")
model ImageIncident {
  @doc("The name of the incident.")
  @visibility("read", "create", "query")
  @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @maxLength(64)
  @key("incidentName")
  incidentName: string;

  @doc("The created time of this incident.")
  @visibility("read", "query")
  created: utcDateTime;

  @doc("The latest updated time of this incident.")
  @visibility("read", "query")
  lastUpdated: utcDateTime;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Definition of an Image Incident sample in a request.")
@resource("incidentSamples")
@parentResource(ImageIncident)
model ImageIncidentSample {
  @doc("The name of this incident sample.")
  @visibility("read")
  @maxLength(64)
  @key("incidentSampleId")
  incidentSampleId: string;

  @doc("The image content of this incident sample.")
  image?: ImageData;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request to add incident samples to an Image Incident.")
model AddImageIncidentSamplesOptions {
  @doc("Incident samples to be added.")
  incidentSamples: ImageIncidentSample[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("A single sample in an Image Incident sample list.")
@resource("incidentSamples")
@parentResource(ImageIncident)
model ListImageIncidentSampleResult {
  @doc("The name of this incident sample.")
  @key("incidentSampleId")
  @visibility("read")
  incidentSampleId: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The response of adding incident samples to an Image Incident.")
model AddImageIncidentSamplesResult {
  @doc("Array of incidentSamples have been added.")
  incidentSamples: ListImageIncidentSampleResult[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Definition of an image in a response.")
model ImageDataResult {
  @doc("Base64-encoded image.")
  content?: bytes;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Definition of an Image Incident sample in a response.")
@resource("incidentSamples")
@parentResource(ImageIncident)
model ImageIncidentSampleResult {
  @doc("The name of this incident sample.")
  @key("incidentSampleId")
  @visibility("read")
  incidentSampleId: string;

  @doc("The image content of this incident sample.")
  image?: ImageDataResult;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request to remove incident samples from an Image Incident.")
model RemoveImageIncidentSamplesOptions {
  @doc("Incident samples to be removed.")
  incidentSampleIds: string[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request to analyze given image with content safety Image Incidents defined.")
model AnalyzeImageDetectIncidentsOptions {
  @doc("The image to be analyzed.")
  image: ImageData;

  @doc("The incidents defined.")
  incidentNames: string[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The details of a long running operation of Text Incident.")
@resource("text/incidents/operations")
model TextIncidentOperationResult {
  @doc("The id of this operation.")
  @key("operationId")
  @visibility("read", "create", "query")
  id: string;

  @doc("The status of this operation.")
  @visibility("read")
  status: IncidentOperationStatus;

  @doc("The error details when this operation failed.")
  errorMessage?: Azure.Core.Foundations.Error;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The details of a long running operation of Image Incident.")
@resource("image/incidents/operations")
model ImageIncidentOperationResult {
  @doc("The id of this operation.")
  @key("operationId")
  @visibility("read", "create", "query")
  id: string;

  @doc("The status of this operation.")
  @visibility("read")
  status: IncidentOperationStatus;

  @doc("The error details when this operation failed.")
  error?: Azure.Core.Foundations.Error;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Incident long running operation parameters.")
model IncidentLongRunningOperationParameters {
  @doc("The operation id passed by the user, if not provided, will be automatically generated as a UUID.")
  @header("Operation-Id")
  @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @maxLength(64)
  operationId?: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Incident long running operation status result.")
model IncidentLongRunningOperationStatusResult {
  @doc("The operation id passed by the user in the request or a random UUID generated by server side.")
  @header("Operation-Id")
  @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @maxLength(64)
  operationId: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@resource("text/categories")
@doc("Definition of a Customer Category version.")
model TextCustomCategoryVersion {
  @doc("The name of this Custom Category")
  @visibility("read", "create", "update")
  @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @maxLength(64)
  @key
  categoryName: string;

  @doc("The definition or description of this Custom Category version.")
  @visibility("read", "create", "update")
  definition: string;

  @doc("The blob URL which should be a jsonl that contains the samples. Read & write access to the upper layer virtual directory is required.")
  @visibility("create", "read", "update")
  sampleBlobUrl: string;

  @doc("The blob URL that contains a snapshot of sampleBlobUrl.")
  @visibility("read")
  sampleBlobSnapshotUrl: string;

  @doc("The version of Custom Category.")
  @visibility("read")
  version: int32;

  @doc("The creation time of this Custom Category version. The time is in UTC.")
  @visibility("read")
  createdTime: utcDateTime;

  @doc("The status of this Custom Category version")
  @visibility("read")
  status: CustomCategoryStatus;

  @doc("The error details of this Custom Category version.")
  @visibility("read")
  errorMessage?: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The possible status of building a Custom Category.")
union CustomCategoryStatus {
  string,

  @doc("Custom Category building status - NotStarted")
  "NotStarted",

  @doc("Custom Category building status - Running")
  "Running",

  @doc("Custom Category building status - Succeeded")
  "Succeeded",

  @doc("Custom Category building status - Failed")
  "Failed",
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("All versions of a Custom Category.")
model TextCustomCategoryVersionList {
  @doc("List of custom category versions.")
  value: TextCustomCategoryVersion[];
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The possible status of a Custom Category operation.")
union CustomCategoryOperationStatus {
  string,

  @doc("Custom Category operation status - NotStarted")
  "NotStarted",

  @doc("Custom Category operation status - Running")
  "Running",

  @doc("Custom Category operation status - Succeeded")
  "Succeeded",

  @doc("Custom Category operation status - Failed")
  "Failed",
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The details of a long running operation of Custom Category.")
@resource("text/categories/operations")
model CustomCategoryOperationDetail {
  @doc("The id of this operation.")
  @visibility("read", "create", "query")
  @maxLength(64)
  @key("operationId")
  id: string;

  @doc("The status of this operation.")
  @visibility("read")
  status: CustomCategoryOperationStatus;

  @doc("The error details when this operation failed.")
  error?: Azure.Core.Foundations.Error;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Custom Category long running operation parameters.")
model CustomCategoryLongRunningOperationParameters {
  @doc("The build will target on the given version.")
  @query
  version: int32;

  @doc("The operation id passed by the user, if not provided, will be automatically generated as a UUID.")
  @header("Operation-Id")
  @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @maxLength(64)
  operationId?: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("Custom Category long running operation status result.")
model CustomCategoryLongRunningOperationStatusResult {
  @doc("The operation id passed by the user in the request or a random UUID generated by server side.")
  @header("Operation-Id")
  @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @maxLength(64)
  operationId: string;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request to analyze given text content with the Custom Category version defined.")
model AnalyzeTextCustomCategoryOption {
  @doc("The text needs to be analyzed.")
  text: string;

  @doc("Custom category name.")
  categoryName: string;

  @doc("Custom category version, if not assigned use the latest version.")
  version?: int32;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The analysis result of Custom Category.")
model TextCustomCategoryAnalysis {
  @doc("Whether the Custom Category is detected.")
  detected: boolean;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The response of analyzing text with Custom Category.")
model AnalyzeTextCustomCategoryResult {
  @doc("The analysis result with Custom Category.")
  customCategoryAnalysis: TextCustomCategoryAnalysis;
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The harm category supported in Image-with-Text content analysis.")
union ImageWithTextCategory {
  string,

  @doc("The harm category for Image-with-Text - Hate.")
  "Hate",

  @doc("The harm category for Image-with-Text - SelfHarm.")
  "SelfHarm",

  @doc("The harm category for Image-with-Text - Sexual.")
  "Sexual",

  @doc("The harm category for Image-with-Text - Violence.")
  "Violence",
}

@added(ContentSafety.Versions.v2024_12_15_Preview)
@doc("The request to analyze an image with embedded or custom text.")
model AnalyzeImageWithTextOptions {
  @doc("The image content to be analyzed.")
  image: ImageData;

  @doc("The text related to the given image.")
  text?: string;

  @doc("The harm categories to be detected. A default set of harm categories will be applied if omitted.")
  categories?: ImageWithTextCategory[];

  @doc("When set to true, the embedded text in given image will be recognized and concatenated with the given text for analysis.")
  enableOcr: boolean;
}

@added(Versions.v2024_12_15_Preview)
@doc("The definition of individual result for analyzing an image with embedded or custom text.")
model ImageWithTextCategoriesAnalysis {
  @doc("The harm category detected.")
  category: ImageWithTextCategory;

  @doc("It indicates the severity of the harm. 0 means the content is considered as safe in this harm category.")
  severity?: int32;
}

@added(Versions.v2024_12_15_Preview)
@doc("The response of analyzing an image with embedded or custom text.")
model AnalyzeImageWithTextResult {
  @doc("The individual analysis result for each harm category.")
  categoriesAnalysis: ImageWithTextCategoriesAnalysis[];
}

@doc("The modality of the content.")
union Modality {
  string,

  @doc("The modality for content - Text.")
  "Text",

  @doc("The modality for content - Image.")
  "Image",
}

@doc("The source type of the message.")
union SourceType {
  string,

  @doc("The source type for message - message to AI.")
  "MESSAGE_TO_AI",

  @doc("The source type for message - message from AI.")
  "MESSAGE_FROM_AI",
}

@doc("The type of the role.")
union RoleType {
  string,

  @doc("All roles.")
  "All",

  @doc("User role.")
  "User",

  @doc("System role.")
  "System",

  @doc("Assistant role.")
  "Assistant",

  @doc("Tool role.")
  "Tool",
}

@doc("The harm category.")
union HarmCategory {
  string,

  @doc("Unspecified harm category.")
  "Unspecified",

  @doc("Celebrity harm category.")
  "Celebrity",

  @doc("Drug harm category.")
  "Drug",

  @doc("Hate harm category.")
  "Hate",

  @doc("Prompt injection harm category.")
  "PromptInjection",

  @doc("Protected material harm category.")
  "ProtectedMaterial",

  @doc("Sexual harm category.")
  "Sexual",

  @doc("Self-harm category.")
  "SelfHarm",

  @doc("Violence harm category.")
  "Violence",
}

@doc("The risk level.")
union RiskLevel {
  string,

  @doc("Safe risk level.")
  "Safe",

  @doc("Low risk level.")
  "Low",

  @doc("Medium risk level.")
  "Medium",

  @doc("High risk level.")
  "High",
}

@doc("The task type.")
union TaskType {
  string,

  @doc("Harm category task type.")
  "HarmCategory",

  @doc("Blocklist task type.")
  "Blocklist",

  @doc("Safety incident task type.")
  "SafetyIncident",

  @doc("Custom harm category task type.")
  "CustomHarmCategory",
}

@doc("Unify content model.")
model UnifyContent {
  @doc("The modality of the content.")
  modality: Modality;

  @doc("The text content.")
  text?: string;

  @doc("The base64 encoded image content.")
  imageBase64?: string;

  @doc("The blob URL of the image content.")
  imageBlob?: string;
}

@doc("Unify message model.")
model UnifyMessage {
  @doc("The source type of the message.")
  source: SourceType;

  @doc("The role of the message.")
  role: RoleType;

  @doc("The contents of the message.")
  contents: UnifyContent[];
}

@doc("Applied for model.")
model AppliedFor {
  @doc("The role applied for.")
  role: RoleType;

  @doc("The source type applied for.")
  sourceType: SourceType;
}

@doc("Harm category task setting model.")
model HarmCategoryTaskSetting {
  @doc("The harm category.")
  harmCategory: HarmCategory;

  @doc("The harm configuration ID.")
  harmConfigId: string;
}

@doc("Blocklist task setting model.")
model BlocklistTaskSetting {
  @doc("The name of the blocklist.")
  name: string;
}

@doc("Safety incident task setting model.")
model SafetyIncidentTaskSetting {
  @doc("The name of the safety incident.")
  name: string;
}

@doc("Custom harm category task setting model.")
model CustomHarmCategoryTaskSetting {
  @doc("The name of the custom harm category.")
  name: string;
}

@doc("Blocking criteria model.")
model BlockingCriteria {
  @doc("The allowed severity level.")
  allowedSeverity: int32;

  @doc("Indicates if it is detected.")
  isDetected: boolean;

  @doc("The risk level.")
  riskLevel: RiskLevel;
}

@doc("Task setting model.")
model TaskSetting {
  @doc("The setting ID.")
  settingId: string;

  @doc("Indicates if the setting is enabled.")
  settingEnabled: boolean;

  @doc("The applied for settings.")
  appliedFor: AppliedFor[];

  @doc("The task type.")
  type: TaskType;

  @doc("The harm category task setting.")
  harmCategoryTaskSetting?: HarmCategoryTaskSetting;

  @doc("The blocklist task setting.")
  blocklistTaskSetting?: BlocklistTaskSetting;

  @doc("The safety incident task setting.")
  safetyIncidentTaskSetting?: SafetyIncidentTaskSetting;

  @doc("The custom harm category task setting.")
  customHarmCategoryTaskSetting?: CustomHarmCategoryTaskSetting;

  @doc("Indicates if blocking criteria is enabled.")
  blockingCriteriaEnabled: boolean;

  @doc("The blocking criteria.")
  blockingCriteria: BlockingCriteria;
}

@resource("safetyPolicies")
@doc("Safety policy model.")
model SafetyPolicy {
  @doc("The safety policy name.")
  @pattern("^[0-9A-Za-z._~-]+$")
  @key("safetyPolicyName")
  @visibility("read", "create", "query")
  @maxLength(64)
  name: string;

  @doc("The task settings.")
  taskSettings: TaskSetting[];
}

@doc("Defines the options for analyzing content with a safety policy.")
model SafetyPolicyAnalyzeOption {
  @doc("The messages to be analyzed.")
  messages: UnifyMessage[];

  @doc("The inline safety policy to be applied during analysis. One of `safetyPolicyName` or `safetyPolicyInline` must be provided.")
  safetyPolicyInline?: SafetyPolicy;

  @doc("The name of a predefined safety policy to be applied during analysis. One of `safetyPolicyName` or `safetyPolicyInline` must be provided.")
  safetyPolicyName?: string;
}

@doc("The result code.")
union ResultCode {
  string,

  @doc("OK result code.")
  "OK",

  @doc("No valid input result code.")
  "NoValidInput",

  @doc("Internal timeout result code.")
  "InternalTimeout",

  @doc("Internal error result code.")
  "InternalError",
}

@doc("Details the output of an analysis, including detection status, severity, and additional information.")
model PromptInjectionDetail {
  @doc("Indicates whether prompt injection was detected.")
  promptInjection?: boolean;

  @doc("Indicates whether cross-domain issues were detected.")
  crossDomain?: boolean;
}

@doc("Harm category task result model.")
model HarmCategoryTaskResult {
  @doc("The harm category.")
  harmCategory: HarmCategory;

  @doc("The harm configuration ID.")
  harmConfigId: string;

  @doc("Indicates if it is detected.")
  isDetected: boolean;

  @doc("The severity level.")
  severity: int32;

  @doc("The risk level.")
  riskLevel: RiskLevel;

  @doc("Advanced results.")
  advanced?: PromptInjectionDetail;
}

@doc("Blocklist task result model.")
model BlocklistTaskResult {
  @doc("The name of the blocklist.")
  name: string;

  @doc("Indicates if it is detected.")
  isDetected: boolean;
}

@doc("Safety incident task result model.")
model SafetyIncidentTaskResult {
  @doc("The name of the safety incident.")
  name: string;

  @doc("Indicates if it is detected.")
  isDetected: boolean;
}

@doc("Custom category task result model.")
model CustomCategoryTaskResult {
  @doc("The name of the custom category.")
  name: string;

  @doc("Indicates if it is detected.")
  isDetected: boolean;
}

@doc("Task result model.")
model TaskResult {
  @doc("The setting ID.")
  settingId: string;

  @doc("The result code.")
  resultCode: ResultCode;

  @doc("The result code detail.")
  resultCodeDetail: string;

  @doc("Indicates if blocking criteria is met.")
  isBlockingCriteriaMet: boolean;

  @doc("The task type.")
  taskType: TaskType;

  @doc("The harm category task result.")
  harmCategoryTaskResult?: HarmCategoryTaskResult;

  @doc("The blocklist task result.")
  blocklistTaskResult?: BlocklistTaskResult;

  @doc("The safety incident task result.")
  safetyIncidentTaskResult?: SafetyIncidentTaskResult;

  @doc("The custom category task result.")
  customCategoryTaskResult?: CustomCategoryTaskResult;
}

@doc("The result.")
union Result {
  string,

  @doc("Unspecified result.")
  "Unspecified",

  @doc("No criteria met result.")
  "NoCriteriaMet",

  @doc("Blocking criteria met result.")
  "BlockingCriteriaMet",
}

@doc("The state.")
union State {
  string,

  @doc("Unspecified state.")
  "Unspecified",

  @doc("All analysis succeeded state.")
  "AnalysisAllSucceed",

  @doc("Not all analysis succeeded state.")
  "AnalysisNotAllSucceed",
}

@doc("Represents the analysis response obtained by applying a safety policy.")
model SafetyPolicyAnalyzeResponse {
  @doc("The state of the analysis.")
  state: State;

  @doc("The result of the analysis.")
  result: Result;

  @doc("The task results of the analysis.")
  taskResults: TaskResult[];
}

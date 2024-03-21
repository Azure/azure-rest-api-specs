import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace ContentSafety;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Text analyze category.")
union TextCategory {
  string,
  "Hate",
  "SelfHarm",
  "Sexual",
  "Violence",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Image analyze category.")
union ImageCategory {
  string,
  "Hate",
  "SelfHarm",
  "Sexual",
  "Violence",
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
  @doc("The text needs to be analyzed. We support a maximum of 10k Unicode characters (Unicode code points) in the text of one request.")
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

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The result of text incident match.")
model IncidentMatch {
  @doc("The name of the matched incident.")
  @maxLength(64)
  incidentName: string;
}

@doc("The image analysis request.")
model AnalyzeImageOptions {
  @doc("The image needs to be analyzed.")
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

  @doc("BlocklistItem content.")
  @maxLength(128)
  text: string;

  @added(ContentSafety.Versions.v2024_04_15_Preview)
  @doc("Optional setting. true means this item is a regex matched term, false means this item is an exact matched term. Default value is false.")
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

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("Text Incident.")
@resource("text/incidents")
model TextIncident {
  @doc("incident name.")
  @pattern("^[0-9A-Za-z._~-]+$")
  @key("incidentName")
  @visibility("read", "create", "query")
  @maxLength(64)
  incidentName: string;

  @doc("Incident definition.")
  @maxLength(1024)
  incidentDefinition?: string;

  @doc("Incident status.")
  @visibility("read")
  status: IncidentStatus;

  @doc("Incident created time.")
  @visibility("read", "query")
  created: utcDateTime;

  @doc("Incident updated time.")
  @visibility("read", "query")
  lastUpdated: utcDateTime;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("Incident status.")
enum IncidentStatus {
  InProgress,
  Completed,
  Failed,
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("Sample in a Text Incident.")
@resource("incidentSamples")
@parentResource(TextIncident)
model TextIncidentSample {
  @doc("incident name.")
  @key("incidentSampleId")
  @visibility("read")
  @maxLength(64)
  incidentSampleId: string;

  @doc("IncidentSample text content.")
  @maxLength(1024)
  text?: string;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The request to add incidentSamples to a incident.")
model AddTextIncidentSamplesOptions {
  @doc("Array of incidentSamples to add.")
  incidentSamples: TextIncidentSample[];
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The response of adding incidentSamples to the incident.")
model AddTextIncidentSamplesResult {
  @doc("Array of incidentSamples have been added.")
  incidentSamples: TextIncidentSample[];
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The request to remove incidentSamples from a incident.")
model RemoveTextIncidentSamplesOptions {
  @doc("Array of incidentSamples to remove.")
  incidentSampleIds: string[];
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("Image Incident.")
@resource("image/incidents")
model ImageIncident {
  @doc("incident name.")
  @pattern("^[0-9A-Za-z._~-]+$")
  @key("incidentName")
  @visibility("read", "create", "query")
  @maxLength(64)
  incidentName: string;

  @doc("Incident status.")
  @visibility("read")
  status: IncidentStatus;

  @doc("Incident created time.")
  @visibility("read", "query")
  created: utcDateTime;

  @doc("Incident updated time.")
  @visibility("read", "query")
  lastUpdated: utcDateTime;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("Sample in an Image Incident.")
@resource("incidentSamples")
@parentResource(ImageIncident)
model ImageIncidentSample {
  @doc("incident name.")
  @key("incidentSampleId")
  @visibility("read")
  @maxLength(64)
  incidentSampleId: string;

  @doc("IncidentSample image content.")
  image?: ImageData;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("Sample Result in an Image Incident.")
@resource("incidentSamples")
@parentResource(ImageIncident)
model ImageIncidentSampleResult {
  @doc("incident name.")
  @key("incidentSampleId")
  @visibility("read")
  @maxLength(64)
  incidentSampleId: string;

  @doc("IncidentSample image content.")
  image?: ImageDataResult;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The image result is base64 encoded bytes")
@projectedName("csharp", "ContentSafetyImageDataResult")
model ImageDataResult {
  @doc("The Base64 encoding of the image.")
  content?: bytes;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The request to add incidentSamples to a incident.")
model AddImageIncidentSamplesOptions {
  @doc("Array of incidentSamples to add.")
  incidentSamples: ImageIncidentSample[];
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The request to remove incidentSamples from a incident.")
model RemoveImageIncidentSamplesOptions {
  @doc("Array of incidentSamples to remove.")
  incidentSampleIds: string[];
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("Sample in a Image Incident.")
@resource("incidentSamples")
@parentResource(ImageIncident)
model ListImageIncidentSampleResult {
  @doc("incident name.")
  @key("incidentSampleId")
  @visibility("read")
  @maxLength(64)
  incidentSampleId: string;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The response of adding incidentSamples to the incident.")
model AddImageIncidentSamplesResult {
  @doc("Array of incidentSamples have been added.")
  incidentSamples: ListImageIncidentSampleResult[];
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("The protected material analysis request.")
model AnalyzeTextProtectedMaterialOptions {
  @doc("The text needs to be analyzed. We support a maximum of 1k Unicode characters (Unicode code points) in the text of one request.")
  @maxLength(1000)
  text: string;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("The protected material analysis response.")
model AnalyzeTextProtectedMaterialResult {
  @doc("Analysis result for protected material.")
  protectedMaterialAnalysis: ProtectedMaterialAnalysisResult;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("The text protected material analysis response.")
model ProtectedMaterialAnalysisResult {
  @doc("Analysis result for protected material..")
  detected: boolean;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("The text jailbreak analysis request.")
model AnalyzeTextJailbreakOptions {
  @doc("The text needs to be analyzed if it attempt to jailbreak. We support a maximum of 1k Unicode characters (Unicode code points) in the text of one request.")
  @maxLength(1000)
  text: string;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("The text jailbreak analysis request.")
model AnalyzeTextJailbreakResult {
  @doc("Analysis result for jailbreak.")
  jailbreakAnalysis: JailbreakAnalysisResult;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("The text jailbreak analysis response.")
model JailbreakAnalysisResult {
  @doc("Analysis result for jailbreak.")
  detected: boolean;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@added(ContentSafety.Versions.v2024_02_15_Preview)
@doc("Groundedness Domain.")
union GroundednessDomain {
  string,
  Generic: "Generic",
  Medical: "Medical",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@added(ContentSafety.Versions.v2024_02_15_Preview)
@doc("Groundedness Task type.")
union GroundednessTask {
  string,
  Summarization: "Summarization",
  QnA: "QnA",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use PascalCase"
@added(ContentSafety.Versions.v2024_02_15_Preview)
@doc("The request of QnA options.")
model QnAOptions {
  @doc("The user's question input in a QnA scenario.")
  @maxLength(7500)
  query: string;
}

@added(ContentSafety.Versions.v2024_02_15_Preview)
@doc("LLM resource type.")
union LLMResourceType {
  string,

  @doc("Azure OpenAI resource type.")
  AzureOpenAI: "AzureOpenAI",
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use PascalCase"
@added(Versions.v2024_02_15_Preview)
@doc("Connection details for the LLM resource.")
model LLMResource {
  @doc("LLM resource type. The default value is AzureOpenAI.")
  resourceType?: LLMResourceType = LLMResourceType.AzureOpenAI;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
  @doc("Endpoint for Azure OpenAI resource.")
  azureOpenAIEndpoint: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Property types must use camelCase"
  @doc("Deployment model name.")
  azureOpenAIDeploymentName: string;
}

@added(Versions.v2024_02_15_Preview)
@doc("The request of groundedness detection.")
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
  This field is optional, but if the task type is set to QnA, it becomes required.
  """)
  qna?: QnAOptions;

  @doc("The specific text that needs to be checked.")
  @maxLength(7500)
  text: string;

  @doc("""
  Leverages a vast array of grounding sources to validate AI-generated text.
  Limit: Restrictions on the total amount of grounding sources that can be analyzed in a single request are 55K characters.
  """)
  groundingSources: string[];

  @doc("""
  A value indicating if the output includes an explanation for the identified groundedness.
  This field is optional, with a default value of false.
  """)
  reasoning?: boolean;

  @doc("""
  Connection details for the LLM resource. 
  This field will be used only when the 'reasoning' field is set to true; otherwise, it will be ignored.
  """)
  llmResource?: LLMResource;
}

@added(Versions.v2024_02_15_Preview)
@doc("The index details.")
model IndexDetails {
  @doc("Indicate the index when encoding is UTF-8.")
  utf8: int64;

  @doc("Indicate the index when encoding is UTF-16.")
  utf16: int64;

  @doc("Indicate the index with code point format.")
  codePoint: int64;
}

@added(Versions.v2024_02_15_Preview)
@doc("The detailed information about a text identified as ungroundedness.")
model UngroundednessDetails {
  @doc("The grounded text.")
  text: string;

  @doc("The offset when grounded text starts.")
  offset: IndexDetails;

  @doc("The length of the grounded text.")
  length: IndexDetails;

  @doc("""
  The explanation for detected ungroundedness, enhancing understanding.
  Only when the 'reasoning' field in the input is set to true 'reason' field will be returned.
  """)
  reason?: string;
}

@added(Versions.v2024_02_15_Preview)
@doc("The response of groundedness detection.")
model AnalyzeTextGroundednessResult {
  @doc("Indicates whether the text exhibits ungroundedness.")
  ungroundedDetected: boolean;

  @doc("""
  Specifies the proportion of the text identified as ungrounded, 
  expressed as a decimal between 0 and 1,
  where 0 indicates no grounded content and 1 indicates entirely grounded content..
  """)
  ungroundedPercentage: float32;

  @doc("Provides insights into ungrounded content with specific examples and percentages.")
  ungroundedDetails: UngroundednessDetails[];
}

@added(ContentSafety.Versions.v2024_02_15_Preview)
@doc("The text prompt injection attacks analysis request.")
model AnalyzeTextPromptInjectionOptions {
  @doc("The user prompt needs to be analyzed if it attempts to do direct injection attacks.")
  userPrompt?: string;

  @doc("The documents needs to be analyzed if they attempt to do direct or indirect injection attacks.")
  documents?: string[];
}

@added(ContentSafety.Versions.v2024_02_15_Preview)
@doc("The text injection attacks analysis response.")
model AnalyzeTextPromptInjectionResult {
  @doc("Direct injection analysis result for user prompt input.")
  userPromptAnalysis?: TextPromptInjectionResult;

  @doc("Direct and indirect injection attacks analysis result for documents input.")
  documentsAnalysis?: TextPromptInjectionResult[];
}

@added(ContentSafety.Versions.v2024_02_15_Preview)
@doc("The text injection attacks analysis response.")
model TextPromptInjectionResult {
  @doc("Analysis result for whether the prompt is classified as an injection attack.")
  attackDetected: boolean;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The text detect incidents analysis request.")
model AnalyzeTextDetectIncidentsOptions {
  @doc("The text needs to be analyzed if it attempts to detect incidents. We support a maximum of 10 thousands Unicode characters (Unicode code points) in the text of one request.")
  @maxLength(10000)
  text: string;

  @added(ContentSafety.Versions.v2024_04_15_Preview)
  @doc("The incidents to detect.")
  incidentNames: string[];
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The detect incidents analysis request.")
model DetectIncidentsResult {
  @doc("The detect incidents match details.")
  incidentMatches: IncidentMatch[];
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The image detect incidents analysis request.")
model AnalyzeImageDetectIncidentsOptions {
  @doc("The image needs to be analyzed.")
  image: ImageData;

  @added(ContentSafety.Versions.v2024_04_15_Preview)
  @doc("The incidents to detect.")
  incidentNames: string[];
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@resource("text/autoReviewers")
model AutoReviewerVersion {
  @key
  @visibility("read", "create", "update")
  @pattern("^[0-9A-Za-z._~-]+$")
  @maxLength(64)
  @doc("The name of the auto reviewer.")
  autoReviewerName: string;

  @doc("The labels defined in the auto reviewer.")
  labels: AutoReviewerLabelDetails[];

  @doc("Whether let system add an otherwise label to the auto reviewer. Default value is true.")
  enableOtherwiseLabel?: boolean;

  @doc("URL of example jsonl blob. Read & write access to the last layer virtual directory is required.")
  @visibility("create", "read", "update")
  exampleBlobUrl?: string;

  @doc("Delimiter of blob url. If not provided, '/' will be used as the delimiter to parse the exampleBlobUrl.")
  @visibility("created", "update", "read")
  blobDelimiter?: string;

  @doc("URL of copied example jsonl blob. If exampleBlobUrl is not provided in the request, this field will not be shown in the response.")
  @visibility("read")
  exampleBlobCopyUrl?: string;

  @doc("Version number of the auto reviewer.")
  @visibility("read")
  version: int32;

  @doc("Creation time of the auto reviewer.")
  @visibility("read")
  createdTime: utcDateTime;

  @doc("Build status of the auto reviewer.")
  @visibility("read")
  status: AutoReviewerStatus;

  @doc("Error when building the auto reviewer.")
  error?: Azure.Core.Foundations.ErrorResponse;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
model AutoReviewerLabelDetails {
  @doc("The name of the label.")
  labelName: string;

  @doc("The description of the label.")
  description: string;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
enum AutoReviewerStatus {
  Building,
  Succeeded,
  Failed,
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("List of auto reviewer versions.")
model AutoReviewerVersionList {
  @doc("List of auto reviewer versions.")
  value: AutoReviewerVersion[];
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The text auto reviewing request.")
model AutoReviewTextOptions {
  @doc("The text needs to be auto reviewed.")
  text: string;

  @doc("The name of the auto reviewer.")
  autoReviewerName: string;

  @doc("The version of the auto reviewer. If not assigned we will use the latest version.")
  autoReviewerVersion?: int32;
}

@added(ContentSafety.Versions.v2024_04_15_Preview)
@doc("The text auto reviewing result.")
model AutoReviewTextResult {
  @doc("The output label name.")
  labelName: string;

  @doc("The reasoning of output label.")
  reasoning: string;
}

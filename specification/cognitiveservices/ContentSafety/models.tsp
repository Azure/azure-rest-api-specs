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

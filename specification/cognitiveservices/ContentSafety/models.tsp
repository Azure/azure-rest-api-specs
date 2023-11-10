import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace ContentSafety;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Text analyze category.")
enum TextCategory {
  Hate,
  SelfHarm,
  Sexual,
  Violence,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Image analyze category.")
enum ImageCategory {
  Hate,
  SelfHarm,
  Sexual,
  Violence,
}

@doc("The type of text analysis output.")
enum AnalyzeTextOutputType {
  @doc("Output severities in four levels, the value could be 0,2,4,6.")
  FourSeverityLevels,

  @doc("Output severities in eight levels, the value could be 0,1,2,3,4,5,6,7.")
  EightSeverityLevels,
}

@doc("The type of image analysis output.")
enum AnalyzeImageOutputType {
  @doc("Output severities in four levels, the value could be 0,2,4,6.")
  FourSeverityLevels,
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

  @added(ContentSafety.Versions.v2023_10_30_Preview)
  @doc("The incidents to detect.")
  incidents?: IncidentOptions;
}

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("The text analysis request.")
model IncidentOptions {
  @doc("The accept decision made by service.")
  incidentNames?: string[];

  @doc("When set to true, further analyses of harmful content will not be performed in cases where incidents are hit. When set to false, all analyses of harmful content will be performed, whether or not incidents are hit.")
  haltOnIncidentHit?: boolean;
}

@doc("The text analysis response.")
model AnalyzeTextResult {
  @doc("The blocklist match details.")
  blocklistsMatch?: TextBlocklistMatch[];

  @doc("Analysis result for categories.")
  categoriesAnalysis: TextCategoriesAnalysis[];

  @added(ContentSafety.Versions.v2023_10_30_Preview)
  @doc("The incident match details.")
  incidentMatches?: IncidentMatch[];
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

@added(ContentSafety.Versions.v2023_10_30_Preview)
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

  @added(ContentSafety.Versions.v2023_10_30_Preview)
  @doc("The incidents to detect.")
  incidents?: IncidentOptions;
}

@doc("The image can be either base64 encoded bytes or a blob URL. You can choose only one of these options. If both are provided, the request will be refused. The maximum image size is 2048 x 2048 pixels and should not exceed 4 MB, while the minimum image size is 50 x 50 pixels.")
@projectedName("csharp", "ContentSafetyImageData")
model ImageData {
  @doc("The Base64 encoding of the image.")
  content?: bytes;

  @doc("The blob url of the image.")
  blobUrl?: url;
}

@doc("The image analysis response.")
model AnalyzeImageResult {
  @doc("Analysis result for categories.")
  categoriesAnalysis: ImageCategoriesAnalysis[];

  @added(ContentSafety.Versions.v2023_10_30_Preview)
  @doc("The incident match details.")
  incidentMatches?: IncidentMatch[];
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

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("Text Incident.")
@resource("text/incidents")
model TextIncident {
  @doc("incident name.")
  @pattern("^[0-9A-Za-z._~-]+$")
  @key("incidentName")
  @visibility("read", "create", "query")
  @maxLength(64)
  incidentName: string;

  @doc("Incident description.")
  @maxLength(1024)
  description?: string;

  @doc("Incident created time.")
  @visibility("read", "query")
  created: utcDateTime;

  @doc("Incident updated time.")
  @visibility("read", "query")
  lastUpdated: utcDateTime;
}

@added(ContentSafety.Versions.v2023_10_30_Preview)
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

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("The request to add incidentSamples to a incident.")
model AddTextIncidentSamplesOptions {
  @doc("Array of incidentSamples to add.")
  incidentSamples: TextIncidentSample[];
}

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("The response of adding incidentSamples to the incident.")
model AddTextIncidentSamplesResult {
  @doc("Array of incidentSamples have been added.")
  incidentSamples: TextIncidentSample[];
}

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("The request to remove incidentSamples from a incident.")
model RemoveTextIncidentSamplesOptions {
  @doc("Array of incidentSamples to remove.")
  incidentSampleIds: string[];
}

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("Image Incident.")
@resource("image/incidents")
model ImageIncident {
  @doc("incident name.")
  @pattern("^[0-9A-Za-z._~-]+$")
  @key("incidentName")
  @visibility("read", "create", "query")
  @maxLength(64)
  incidentName: string;

  @doc("Incident description.")
  @maxLength(1024)
  description?: string;

  @doc("Incident created time.")
  @visibility("read", "query")
  created: utcDateTime;

  @doc("Incident updated time.")
  @visibility("read", "query")
  lastUpdated: utcDateTime;
}

@added(ContentSafety.Versions.v2023_10_30_Preview)
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

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("The image result is base64 encoded bytes")
@projectedName("csharp", "ContentSafetyImageDataResult")
model ImageDataResult {
  @doc("The Base64 encoding of the image.")
  content?: bytes;
}

@added(ContentSafety.Versions.v2023_10_30_Preview)
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

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("The request to add incidentSamples to a incident.")
model AddImageIncidentSamplesOptions {
  @doc("Array of incidentSamples to add.")
  incidentSamples: ImageIncidentSample[];
}

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("The request to remove incidentSamples from a incident.")
model RemoveImageIncidentSamplesOptions {
  @doc("Array of incidentSamples to remove.")
  incidentSampleIds: string[];
}

@added(ContentSafety.Versions.v2023_10_30_Preview)
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

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("The response of adding incidentSamples to the incident.")
model AddImageIncidentSamplesResult {
  @doc("Array of incidentSamples have been added.")
  incidentSamples: ListImageIncidentSampleResult[];
}

@doc("Annotate text options")
@added(Versions.v2023_10_30_Preview)
model AnnotateTextOptions {
  @doc("The text needs to be analyzed. We support a maximum of 10k Unicode characters (Unicode code points) in the text of one request.")
  @maxLength(10000)
  text: string;

  @doc("The category will be analyzed, you can set your customized category or one of built-in categories in 'Hate','Selfharm', 'Sexual' and 'Violence'.")
  category: string;
}

@doc("The text annotation response.")
@added(Versions.v2023_10_30_Preview)
model AnnotateTextResult {
  @doc("The label.")
  label: int32;

  @doc("The reasoning.")
  reasoning?: string;
}

@added(Versions.v2023_10_30_Preview)
@doc("Pre-defined concept.")
model PreDefinedConcept {
  concept: string;
  description: string;
}

@added(Versions.v2023_10_30_Preview)
@doc("Label definition.")
model LabelDefinition {
  label: int32;
  enumerations: string[];
}

@added(Versions.v2023_10_30_Preview)
@doc("Text Customized categories.")
@resource("text/categories")
model TextCustomizedCategory {
  @doc("Text customizedCategories name.")
  @pattern("^Customized_[0-9A-Za-z._~-]+$")
  @key("categoryName")
  @visibility("read", "create", "query")
  @maxLength(64)
  categoryName: string;

  preDefinedConcepts?: PreDefinedConcept[];
  labelDefinitions: LabelDefinition[];
  emphases?: string[];
  exampleBlobUrl?: url;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("ImageWithText analyze category.")
enum ImageWithTextCategory {
  Hate,
  SelfHarm,
  Sexual,
  Violence,
}

@added(ContentSafety.Versions.v2023_10_30_Preview)
@doc("The analysis request of the image with text.")
model AnalyzeImageWithTextOptions {
  @doc("The image needs to be analyzed.")
  image: ImageData;

  @doc("The text attached to the image. We support at most 1k characters (unicode code points) in one text request.")
  @maxLength(1000)
  text?: string;

  @doc("The categories will be analyzed. If they are not assigned, a default set of analysis results for the categories will be returned.")
  categories?: ImageWithTextCategory[];

  @doc("When set to true, our service will perform OCR and concatenate the recognized text with input text before analyzing. We will recognize at most 256 characters (unicode code points) from input image. The others will be truncated.")
  enableOcr: boolean;
}

@added(Versions.v2023_10_30_Preview)
@doc("ImageWithText analysis result.")
model ImageWithTextCategoriesAnalysis {
  @doc("The imageWithtext analysis category.")
  category: ImageWithTextCategory;

  @doc("The higher the severity of input content, the larger this value is. The values could be: 0,2,4,6.")
  severity?: int32;
}

@added(Versions.v2023_10_30_Preview)
@doc("The analysis response of the image with text.")
model AnalyzeImageWithTextResult {
  @doc("Analysis result for categories.")
  categoriesAnalysis: ImageWithTextCategoriesAnalysis[];
}

@added(Versions.v2023_11_30_Preview)
@doc("The text to detect ungroundedness.")
model DetectUngroundednessInputContent {
  @doc("Identity of the text.")
  id: string;

  @doc("Text for analysis.")
  text: string;
}

@added(Versions.v2023_11_30_Preview)
@doc("User input for ungroudedness detection.")
model DetectUngroundednessInput {
  @doc("This is optional and only used for QnA or chat task.")
  query?: string;

  @doc("Content for analysis.")
  contents: DetectUngroundednessInputContent[];

  @doc("Source information that serves as grounding source.")
  groundingSource: string[];
}

@added(Versions.v2023_11_30_Preview)
@doc("Connection information for GPT resource.")
model DetectUngroundednessGptxOptions {
  @doc("Endpoint of GPT resource.")
  azureOpenAIEndpoint: string;

  @doc("Deployment id of GPT resource.")
  deploymentId: string;
}

@added(Versions.v2023_11_30_Preview)
@doc("The request of ungroudedness detection.")
model DetectUngroundednessOptions {
  @doc("Domain that the current request belongs to.")
  domain: string;

  @doc("Type of work that the customer want the API to execute.")
  task: string;

  @doc("The input to be examined for detection.")
  input: DetectUngroundednessInput;

  @doc("Options to set GPT resources for BYO scenario.")
  gptxOptions?: DetectUngroundednessGptxOptions;
}

@added(Versions.v2023_11_30_Preview)
@doc("The detection result of ungroudedness.")
model TextUngroundednessDetection {
  @doc("Identity of content.")
  id: string;

  @doc("Detection result for ungroudedness.")
  isUngrounded: boolean;

  @doc("The confidence store of the model in the analysis results.")
  score: float64;

  @doc("Ungroundedness rate of content.")
  ungroundednessRate: float64;

  @doc("The detailed information about a text identified as ungroundness.")
  textSpan: UngroundednessTextSpan[];
}

@added(Versions.v2023_11_30_Preview)
@doc("The detailed information about a text identified as ungroundness.")
model UngroundednessTextSpan {
  @doc("The starting character where ungroundness information occurs.")
  startCharIdx: int32;

  @doc("The length of the ungroundness information.")
  charLen: int32;

  @doc("The text identified as ungroundness.")
  ungroundednessText: string;

  @doc("The reason for text being identified as ungroundness.")
  reason: string;
}

@added(Versions.v2023_11_30_Preview)
@doc("The response of ungroudedness detection.")
model DetectUngroundednessResult {
  @doc("Ungroudedness detection result.")
  detectionResult: TextUngroundednessDetection[];
}
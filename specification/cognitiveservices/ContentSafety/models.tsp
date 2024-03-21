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

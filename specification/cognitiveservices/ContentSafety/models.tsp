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

  @doc("Customized categories will be analyzed if they are assigned. If no customized categories are assigned, no analysis on them will be returned.")
  @added(ContentSafety.Versions.v2024_03_30_Preview)
  customizedCategories?: CustomizedCategoryOption[];
}

@added(ContentSafety.Versions.v2024_03_30_Preview)
@doc("The customized category option for text.")
model CustomizedCategoryOption {
  @doc("Name")
  categoryName: string;

  @doc("Customized category version for inference")
  version: int32;
}

@doc("The text analysis response.")
model AnalyzeTextResult {
  @doc("The blocklist match details.")
  blocklistsMatch?: TextBlocklistMatch[];

  @doc("Analysis result for categories.")
  categoriesAnalysis: TextCategoriesAnalysis[];

  @added(ContentSafety.Versions.v2024_03_30_Preview)
  @doc("Analysis result for text customized categories")
  textCustomizedCategoriesAnalysis?: TextCustomizedCategoriesAnalysis[];
}

@added(ContentSafety.Versions.v2024_03_30_Preview)
@doc("Analysis result for text customized categories.")
model TextCustomizedCategoriesAnalysis {
  @doc("Name of the custom category.")
  categoryName: string;

  @doc("Whether the customized category is detected.")
  detected: boolean;
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
@projectedName("csharp", "ContentSafetyImageData")
@projectedName("java", "ContentSafetyImageData")
model ImageData {
  @doc("The Base64 encoding of the image.")
  content?: bytes;

  @doc("The blob url of the image.")
  @projectedName("csharp", "BlobUri")
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
  @projectedName("csharp", "Name")
  @projectedName("java", "name")
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

@added(ContentSafety.Versions.v2024_03_30_Preview)
@resource("text/categories")
@doc("Text customized category")
model TextCustomizedCategoryVersion {
  @key
  @visibility("read", "create", "update")
  @doc("Name of the customized category")
  categoryName: string;

  @doc("Definition or description of the customized category.")
  @visibility("read", "create", "update")
  definition: string;

  @doc("URL of sample jsonl blob. Read & write access to the last layer virtual directory is required.")
  @visibility("create", "read", "update")
  sampleBlobUrl: string;

  @doc("Delimiter of blob url. If not provided, '/' will be used as the delimiter to parse the sampleBlobUrl.")
  @visibility("created", "update")
  blobDelimiter?: string;

  @doc("URL of copied sample jsonl blob. If sampleBlobUrl is not provided in the request, this field will not be shown in the response.")
  @visibility("read")
  sampleBlobCopyUrl: string;

  @doc("Version number of the customized category.")
  @visibility("read")
  version: int32;

  @doc("Creation time of the customized category.")
  @visibility("read")
  createdTime: utcDateTime;

  @doc("Build status of the customized category")
  @visibility("read")
  status: CategoryStatus;

  @doc("Build information for the customized category.")
  @visibility("read")
  buildInfo?: TextCustomizedCategoryBuildInfo;

  @doc("Build information for the customized category.")
  @visibility("read")
  deleteInfo?: TextCustomizedCategoryDeleteInfo;
}

@doc("Detailed information of the customized category build.")
model TextCustomizedCategoryBuildInfo {
  @doc("Last build trigger time.")
  lastBuildTriggeredTime: utcDateTime;

  @doc("Error when building the category.")
  buildError?: Azure.Core.Foundations.ErrorResponse;
}

@doc("Detailed information of the customized category build.")
model TextCustomizedCategoryDeleteInfo {
  @doc("Last build trigger time.")
  deleteTriggeredTime: utcDateTime;

  @doc("Error when building the category.")
  deleteError?: Azure.Core.Foundations.ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Status of the customized category build.")
enum CategoryStatus {
  BuildNotStarted,
  Building,
  BuildSucceeded,
  BuildFailed,
  Deleting,
  DeleteFailed,
}

// @doc("Alias of TextCustomizedCategory")
// model TextCustomizedCategoryVersion {
//   ...TextCustomizedCategory;
// }

@added(ContentSafety.Versions.v2024_03_30_Preview)
@doc("List of customized category versions.")
model TextCustomizedCategoryVersionList {
  @doc("List of customized category versions.")
  value: TextCustomizedCategoryVersion[];
}

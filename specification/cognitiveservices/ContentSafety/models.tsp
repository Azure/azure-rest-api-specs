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
  @doc("Output severities in four levels, the value could be 0, 2, 4, 6.")
  FourSeverityLevels,
}

@doc("The type of image analysis output.")
enum AnalyzeImageOutputType {
  @doc("Output severities in four levels, the value could be 0, 2, 4, 6.")
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

  @added(ContentSafety.Versions.v2023_10_15_Preview)
  @doc("Name of the project. When this field is provided, it means service will analyze the text with specified policy based on the given project name. If project name occurs with other configuration like categories, a bad request error will be returned.")
  projectName?: string;
}

@doc("The text analysis response.")
model AnalyzeTextResult {
  @doc("The blocklist match details.")
  blocklistsMatch?: TextBlocklistMatch[];

  @doc("Analysis result for categories.")
  categoriesAnalysis: TextCategoriesAnalysis[];

  @added(ContentSafety.Versions.v2023_10_15_Preview)
  @doc("The accept decision made by service.")
  accepted?: boolean;
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

  @doc("The value of this field is determined by the outputType specified in the request. If 'FourSeverityLevels' is chosen, this field will be included in the output. The value can be 0, 2, 4, or 6, and it increases with the severity of the input content.")
  severity?: int32;

  @added(ContentSafety.Versions.v2023_10_15_Preview)
  @doc("The decision made by service.")
  accepted?: boolean;
}

@doc("The image analysis request.")
model AnalyzeImageOptions {
  @doc("The image needs to be analyzed.")
  image: ImageData;

  @doc("The categories will be analyzed. If they are not assigned, a default set of analysis results for the categories will be returned.")
  categories?: ImageCategory[];

  @doc("This refers to the type of image analysis output. If no value is assigned, the default value will be \"FourSeverityLevels\".")
  outputType?: AnalyzeImageOutputType = AnalyzeImageOutputType.FourSeverityLevels;

  @added(ContentSafety.Versions.v2023_10_15_Preview)
  @doc("Name of the project. When this field is provided, it means service will analyze the text with specified policy based on the given project name. If project name occurs with other configuration like categories, a bad request error will be returned.")
  projectName?: string;
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

  @added(ContentSafety.Versions.v2023_10_15_Preview)
  @doc("The decision made by service.")
  accepted?: boolean;
}

@doc("Image analysis result.")
model ImageCategoriesAnalysis {
  @doc("The image analysis category.")
  category: ImageCategory;

  @doc("The value of this field is determined by the outputType specified in the request. If 'FourSeverityLevels' is chosen, this field will be included in the output. The value can be 0, 2, 4, or 6, and it increases with the severity of the input content.")
  severity?: int32;

  @added(ContentSafety.Versions.v2023_10_15_Preview)
  @doc("The decision made by service.")
  accepted?: boolean;
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
  blocklistItems?: TextBlocklistItem[];
}

@doc("The request to remove blocklistItems from a text blocklist.")
model RemoveTextBlocklistItemsOptions {
  @doc("Array of blocklistItemIds to remove.")
  blocklistItemIds: string[];
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("Project is an entity to manage deployment with specified policy.")
@resource("projects")
model Project {
  @doc("Project name.")
  @pattern("^[a-zA-Z][0-9A-Za-z-]*[0-9a-zA-Z]$")
  @key("projectName")
  @visibility("read", "query")
  @maxLength(255)
  @minLength(3)
  projectName: string;

  @doc("Project description.")
  @maxLength(1024)
  description?: string;

  @doc("Project modality.")
  @visibility("read", "query", "create")
  modality: ContentModality;

  @doc("Project display name.")
  @maxLength(255)
  @minLength(3)
  displayName?: string;

  @doc("Project created time.")
  @visibility("read", "query")
  createdAt?: utcDateTime;

  @doc("Project last modified time.")
  @visibility("read", "query")
  lastModifiedAt?: utcDateTime;

  @doc("Deployed text policy.")
  textPolicy?: TextPolicy;

  @doc("Deployed image policy.")
  imagePolicy?: ImagePolicy;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("Modality type.")
enum ContentModality {
  @doc("Text modality.")
  Text,
  @doc("Image modality.")
  Image,
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("TextCategoryPolicy. Content which severity less than the acceptLessThan will be accepted.")
model TextCategoryPolicy {
  @doc("Text category.")
  category: TextCategory;

  @doc("Severity less than the threshold will be treated as accepted for the category. The value can only be 2, 4, 6 for FourLevelSeverities.")
  severityThreshold?: int32;

  @doc("The judgement kind to help server make judgement.")
  judgementKind: JudgmentKind;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("ImageCategoryPolicy. Content which severity less than the acceptLessThan will be accepted.")
model ImageCategoryPolicy {
  @doc("Image category.")
  category: ImageCategory;
  
  @doc("Severity less than the threshold will be treated as accepted for the category. The value can only be 2, 4, 6 for FourLevelSeverities.")
  severityThreshold?: int32;
  
  @doc("The judgement kind to help server make judgement.")
  judgementKind: JudgmentKind;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("Policy for the text.")
model TextPolicy {
  @doc("The category policy. The length must be larger than 0.")
  @minItems(1)
  categoryPolicies: TextCategoryPolicy[];

  @doc("The policy of blocklist.")
  blocklistPolicy?: BlocklistPolicy;

  @doc("The type of text analysis output. If not assigned, the default value is \"FourSeverityLevels\".")
  outputType?: AnalyzeTextOutputType = AnalyzeTextOutputType.FourSeverityLevels;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("Policy for the image.")
model ImagePolicy {
  @doc("The category policy. The length must be larger than 0.")
  @minItems(1)
  categoryPolicies: ImageCategoryPolicy[];
  
  @doc("The type of text analysis output. If not assigned, the default value is \"FourSeverityLevels\".")
  outputType?: AnalyzeTextOutputType = AnalyzeTextOutputType.FourSeverityLevels;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("Policy for blocklist.")
model BlocklistPolicy {
  @doc("The names of blocklists.")
  blocklistNames?: string[];

  @doc("When set to true, further analyses of harmful content will not be performed in cases where blocklists are hit. When set to false, all analyses of harmful content will be performed, whether or not blocklists are hit.")
  haltOnBlocklistHit?: boolean;
}

@added(ContentSafety.Versions.v2023_10_15_Preview)
@doc("Judgement kind.")
enum JudgmentKind {
  @doc("Treat all content as accepted no matter what the predicted value is.")
  AcceptAll,
  @doc("Accept only when the predicted severity is less than the severity threshold.")
  AcceptLessThan,
}


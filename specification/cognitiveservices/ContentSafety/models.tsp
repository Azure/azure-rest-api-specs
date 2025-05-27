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
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Query)
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
  @visibility(Lifecycle.Read)
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

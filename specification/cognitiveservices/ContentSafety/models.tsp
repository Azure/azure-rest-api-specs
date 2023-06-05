import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace ContentSafety;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Text analyze category")
enum TextCategory {
  Hate,
  SelfHarm,
  Sexual,
  Violence,
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Image analyze category")
enum ImageCategory {
  Hate,
  SelfHarm,
  Sexual,
  Violence,
}

@doc("The analysis request of the text.")
model AnalyzeTextOptions {
  @doc("The text needs to be scanned. We support at most 1000 characters (unicode code points) in text of one request.")
  @maxLength(1000)
  text: string;

  @doc("The categories will be analyzed. If not assigned, a default set of the categories' analysis results will be returned.")
  categories?: TextCategory[];

  @doc("The names of blocklists.")
  blocklistNames?: string[];

  @doc("When set to true, further analyses of harmful content will not be performed in cases where blocklists are hit. When set to false, all analyses of harmful content will be performed, whether or not blocklists are hit.")
  breakByBlocklists?: boolean;
}

@doc("The analysis response of the text")
model AnalyzeTextResult {
  @doc("The details of blocklist match.")
  blocklistsMatchResults?: TextBlocklistMatchResult[];

  @doc("Analysis result for Hate category.")
  hateResult?: TextAnalyzeSeverityResult;

  @doc("Analysis result for SelfHarm category.")
  selfHarmResult?: TextAnalyzeSeverityResult;

  @doc("Analysis result for Sexual category.")
  sexualResult?: TextAnalyzeSeverityResult;

  @doc("Analysis result for Violence category.")
  violenceResult?: TextAnalyzeSeverityResult;
}

@doc("The result of blocklist match.")
model TextBlocklistMatchResult {
  @doc("The name of matched blocklist.")
  @maxLength(64)
  blocklistName: string;

  @doc("The id of matched item.")
  @maxLength(64)
  blockItemId: string;

  @doc("The content of matched item.")
  @maxLength(128)
  blockItemText: string;

  @doc("The character offset of matched text in original input.")
  offset: int32;

  @doc("The length of matched text in original input.")
  length: int32;
}

@doc("Text analysis result.")
model TextAnalyzeSeverityResult {
  @doc("The text category.")
  category: TextCategory;

  @doc("The higher the severity of input content, the larger this value is. The values could be: 0,2,4,6.")
  severity: int32;
}

@doc("The analysis request of the image.")
model AnalyzeImageOptions {
  @doc("The image needs to be analyzed.")
  image: ImageData;

  @doc("The categories will be analyzed. If not assigned, a default set of the categories' analysis results will be returned.")
  categories?: ImageCategory[];
}

@doc("The content or blob url of image, could be base64 encoding bytes or blob url. If both are given, the request will be refused. The maximum size of image is 2048 pixels * 2048 pixels, no larger than 4MB at the same time. The minimum size of image is 50 pixels * 50 pixels.")
@projectedName("csharp", "ContentSafetyImageData")
model ImageData {
  @doc("Base64 encoding of image.")
  content?: bytes;

  @doc("The blob url of image.")
  blobUrl?: url;
}

@doc("The analysis response of the image.")
model AnalyzeImageResult {
  @doc("Analysis result for Hate category.")
  hateResult?: ImageAnalyzeSeverityResult;

  @doc("Analysis result for SelfHarm category.")
  selfHarmResult?: ImageAnalyzeSeverityResult;

  @doc("Analysis result for Sexual category.")
  sexualResult?: ImageAnalyzeSeverityResult;

  @doc("Analysis result for Violence category.")
  violenceResult?: ImageAnalyzeSeverityResult;
}

@doc("Image analysis result.")
model ImageAnalyzeSeverityResult {
  @doc("The image category.")
  category: ImageCategory;

  @doc("The higher the severity of input content, the larger this value, currently its value could be: 0,2,4,6.")
  severity: int32;
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

@doc("Item in TextBlocklist.")
@resource("blockItems")
@parentResource(TextBlocklist)
model TextBlockItem {
  @doc("Block Item Id. It will be uuid.")
  @key("blockItemId")
  @visibility("read", "create", "query")
  @maxLength(64)
  blockItemId: string;

  @doc("Block item description.")
  @maxLength(1024)
  description?: string;

  @doc("Block item content.")
  @maxLength(128)
  text: string;
}

@doc("Block item info in text blocklist.")
model TextBlockItemInfo {
  @doc("Block item description.")
  @maxLength(1024)
  description?: string;

  @doc("Block item content.")
  @maxLength(128)
  text: string;
}

@doc("The request of adding blockItems to text blocklist.")
model AddBlockItemsOptions {
  @doc("Array of blockItemInfo to add.")
  blockItems: TextBlockItemInfo[];
}

@doc("The response of adding blockItems to text blocklist.")
model AddBlockItemsResult {
  @doc("Array of blockItems added.")
  value?: TextBlockItem[];
}

@doc("The request of removing blockItems from text blocklist.")
model RemoveBlockItemsOptions {
  @doc("Array of blockItemIds to remove.")
  blockItemIds: string[];
}

import "@typespec/http";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace ContentSafety;

enum TextCategory {
  Hate,
  SelfHarm,
  Sexual,
  Violence,
}

enum ImageCategory {
  Hate,
  SelfHarm,
  Sexual,
  Violence,
}

@doc("The analysis request of the text.")
model TextDetectRequest {
  @doc("The text needs to be scanned.")
  @maxLength(1000)
  text: string;

  @doc("The categories will be analyzed, if not assigned, a default set of categories' analysis results will be returned.")
  categories?: TextCategory[];

  @doc("The names of blocklists.")
  blocklistNames?: string[];

  @doc("When set to true, other analysis will be skipped once any of configured blocklists was hit. When set to false, all the analysis will be done even when blocklists were hit.")
  breakByBlocklists?: boolean;
}

@doc("The analysis response of the text")
model TextDetectResponse {
  @doc("The details of blocklist match.")
  blocklistsMatchResults?: TextListMatchResult[];

  @doc("Analysis result for Hate category.")
  hateResult?: TextDetectMultiSeverityResult;

  @doc("Analysis result for SelfHarm category.")
  selfHarmResult?: TextDetectMultiSeverityResult;

  @doc("Analysis result for Sexual category.")
  sexualResult?: TextDetectMultiSeverityResult;

  @doc("Analysis result for Violence category.")
  violenceResult?: TextDetectMultiSeverityResult;
}

@doc("The result of blocklist match.")
model TextListMatchResult {
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
model TextDetectMultiSeverityResult {
  @doc("The text category.")
  category: TextCategory;

  @doc("The higher the risk level of input content, the larger this value, currently its value could be: 0,2,4,6.")
  riskLevel: int32;
}

@doc("The analysis request of the image.")
model ImageDetectRequest {
  @doc("The image needs to be analyzed.")
  image: ImageData;

  @doc("The categories will be analyzed, if not assigned, a default set of categories' analysis results will be returned.")
  categories?: ImageCategory[];
}

@doc("The content or url of image, could be base64 encoding bytes or blob url, if both given, the content field will be used. The maxinum size of image is 2048 pixel * 2048 pixel, no larger than 4MB at the same time.")
model ImageData {
  @doc("Base64 encoding of image.")
  content?: bytes;

  @doc("The blob url of image.")
  url?: url;
}

@doc("The analysis response of the image.")
model ImageDetectResponse {
  @doc("Analysis result for Hate category.")
  hateResult?: ImageDetectMultiSeverityResult;

  @doc("Analysis result for SelfHarm category.")
  selfHarmResult?: ImageDetectMultiSeverityResult;

  @doc("Analysis result for Sexual category.")
  sexualResult?: ImageDetectMultiSeverityResult;

  @doc("Analysis result for Violence category.")
  violenceResult?: ImageDetectMultiSeverityResult;
}

@doc("Image analysis result")
model ImageDetectMultiSeverityResult {
  @doc("The image category.")
  category: ImageCategory;

  @doc("The higher the risk level of input content, the larger this value, currently its value could be: 0,2,4,6.")
  riskLevel: int32;
}

@doc("Text Blocklist.")
@resource("text/blocklists")
model TextBlocklist {
  @doc("Text blocklist Name.")
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
  @doc("Block Item Id.")
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

@doc("The request to add blockItems to text blocklist.")
model BatchCreateTextBlockItemsRequest {
  @doc("Array of blockItemInfo to add.")
  blockItems: TextBlockItemInfo[];
}

@doc("The response of adding blockItems to text blocklist.")
model BatchCreateTextBlockItemsResponse {
  @doc("Array of blockItems added.")
  blockItems?: TextBlockItem[];
}

@doc("The request to delete blockItems from text blocklist.")
model BatchDeleteTextBlockItemsRequest {
  @doc("Array of blockItemIds to delete.")
  blockItemIds: string[];
}

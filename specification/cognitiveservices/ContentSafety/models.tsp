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
  @doc("The accept decision made by service.")
  incidentNames?: string[];

  @added(ContentSafety.Versions.v2023_10_30_Preview)
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
  @doc("The accept decision made by service.")
  incidentNames?: string[];

  @added(ContentSafety.Versions.v2023_10_30_Preview)
  @doc("When set to true, further analyses of harmful content will not be performed in cases where incidents are hit. When set to false, all analyses of harmful content will be performed, whether or not incidents are hit.")
  haltOnIncidentHit?: boolean;
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
@resource("text/incident")
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
@resource("image/incident")
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "MUST fix in next update"
@doc("Text analyze category.")
@added(Versions.v2023_10_30_Preview)
enum AnnotateTextBuiltinCategory {
  Hate,
  SelfHarm,
  Sexual,
  Violence,
}

@doc("Annotate text options")
@added(Versions.v2023_10_30_Preview)
model AnnotateTextOptions {
  @doc("The text needs to be analyzed. We support a maximum of 10k Unicode characters (Unicode code points) in the text of one request.")
  @maxLength(10000)
  text: string;

  @doc("The category will be analyzed. If they are not assigned, a default set of analysis results for the categories will be returned.")
  category?: AnnotateTextBuiltinCategory;
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
model Label {
  label: integer;
  labelName?: string;
  scenarios: string[];
}

@added(Versions.v2023_10_30_Preview)
@doc("Text Customized categories.")
@resource("text/customizedCategories")
model TextCustomizedCategory {
  @doc("Text customizedCategories name.")
  @pattern("^Customized_[0-9A-Za-z._~-]+$")
  @key("categoryName")
  @visibility("read", "create", "query")
  @maxLength(64)
  categoryName: string;

  preDefinedConcepts?: PreDefinedConcept[];
  labels: Label[];
  emphasis?: string[];
  exampleBlobUrl?: url;
}

// @doc("The text annotation response.")
// @added(Versions.v2023_10_30_Preview)
// @resource("text/customizedCategories/operations")
// model TextCustomizedCategoryOperation {
//   @doc("The operation id.")
//   @key("operationId")
//   operationId: int32;

//   @doc("The status.")
//   status: string;

//   @doc("The reason of failure.")
//   error?: string;
// }

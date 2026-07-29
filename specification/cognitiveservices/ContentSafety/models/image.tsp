import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

namespace ContentSafety;

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

@doc("The image analysis request.")
model AnalyzeImageOptions {
  @doc("The image to be analyzed.")
  image: ImageData;

  @doc("The categories will be analyzed. If they are not assigned, a default set of analysis results for the categories will be returned.")
  categories?: ImageCategory[];

  @doc("This refers to the type of image analysis output. If no value is assigned, the default value will be \"FourSeverityLevels\".")
  outputType?: AnalyzeImageOutputType = AnalyzeImageOutputType.FourSeverityLevels;
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

@doc("The type of image analysis output.")
union AnalyzeImageOutputType {
  string,

  @doc("Output severities in four levels, the value could be 0,2,4,6.")
  FourSeverityLevels: "FourSeverityLevels",
}

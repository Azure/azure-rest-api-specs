import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/http";

import "./models.tsp";

using Azure.Core.Traits;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace ImageAnalysis;

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to analyze an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
@doc("Performs a single Image Analysis operation")
@actionSeparator("/")
@route("imageanalysis:analyze")
@post
@sharedRoute
@action("analyze")
op analyzeStream is Azure.Core.RpcOperation<
  {
    @query({
      name: "features",
      format: "csv",
    })
    @doc("A string indicating what visual feature types to return. Multiple values should be comma-separated. Valid visual feature types include: Categories, Tags, Description, Faces, ImageType, Color, Adult, Brands, Objects, and Celebrities. If VisualFeatures is not specified, then Categories, Tags, and Description are included in the response by default.")
    visualFeatures?: Array<visualFeatures>;

    @doc("Impl Detail")
    @query("overload")
    overload: "stream";

    @doc("Impl Detail")
    @header("Content-Type")
    contentType: "application/octet-stream";

    @query("model-name")
    @doc("The name of the custom trained model. This parameter needs to be specified if the parameter \"features\" is not specified.")
    modelName?: string;

    @query("langauge")
    @doc("The desired language for output generation. If this parameter is not specified, the default value is \"en\". See https://aka.ms/cv-languages for a list of supported languages.")
    language?: string = "en";

    @query("smartcrops-aspect-ratios")
    @doc("A list of aspect ratios to use for smartCrops feature. Aspect ratios are calculated by dividing the target crop width by the height. Supported values are between 0.75 and 1.8 (inclusive). Multiple values should be comma-separated. If this parameter is not specified, the service will return one crop suggestion with an aspect ratio it sees fit between 0.5 and 2.0 (inclusive).")
    smartCropsAspectRatios?: string;

    @query("gender-neutral-caption")
    @doc("Boolean flag for enabling gender-neutral captioning for caption and denseCaptions features. If this parameter is not specified, the default value is \"false\".")
    genderNeutralCaption?: boolean = false;

    @doc("The image to be analyzed")
    @body
    imageContents: bytes;
  },
  ImageAnalysisResult
>;

@doc("Performs a single Image Analysis operation")
@actionSeparator("/")
@route("imageanalysis:analyze")
@post
@sharedRoute
@action("analyze")
op analyzeUrl is Azure.Core.RpcOperation<
  {
    @doc("Impl Detail")
    @header("Content-Type")
    contentType: "application/json";

    @query({
      name: "features",
      format: "csv",
    })
    @doc("A string indicating what visual feature types to return. Multiple values should be comma-separated. Valid visual feature types include: Categories, Tags, Description, Faces, ImageType, Color, Adult, Brands, Objects, and Celebrities. If VisualFeatures is not specified, then Categories, Tags, and Description are included in the response by default.")
    visualFeatures?: Array<visualFeatures>;

    @query("model-name")
    @doc("The name of the custom trained model. This parameter needs to be specified if the parameter \"features\" is not specified.")
    modelName?: string;

    @query("langauge")
    @doc("The desired language for output generation. If this parameter is not specified, the default value is \"en\". See https://aka.ms/cv-languages for a list of supported languages.")
    language?: string = "en";

    @query("smartcrops-aspect-ratios")
    @doc("A list of aspect ratios to use for smartCrops feature. Aspect ratios are calculated by dividing the target crop width by the height. Supported values are between 0.75 and 1.8 (inclusive). Multiple values should be comma-separated. If this parameter is not specified, the service will return one crop suggestion with an aspect ratio it sees fit between 0.5 and 2.0 (inclusive).")
    smartCropsAspectRatios?: string;

    @query("gender-neutral-caption")
    @doc("Boolean flag for enabling gender-neutral captioning for caption and denseCaptions features. If this parameter is not specified, the default value is \"false\".")
    genderNeutralCaption?: boolean = false;

    @doc("The image to be analyzed")
    @body
    imageContents: ImageUrl;
  },
  ImageAnalysisResult
>;

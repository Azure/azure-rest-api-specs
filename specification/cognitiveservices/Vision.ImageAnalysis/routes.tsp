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
op analyzeFromStream is Azure.Core.RpcOperation<
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

    @doc("The format of the image stream")
    @header()
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
op analyzeFromUrl is Azure.Core.RpcOperation<
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

@doc("Segment the input image. An image stream of content type 'image/png' is returned, where the pixel values depend on the analysis mode. The returned image has the same dimensions as the input image for modes: foregroundMatting. The returned image has the same aspect ratio and same dimensions as the input image up to a limit of 16 megapixels for modes: backgroundRemoval.")
@actionSeparator("/")
@route("imageanalysis:segment")
@post
@sharedRoute
@action("segment")
op segmentFromUrl is Azure.Core.RpcOperation<
{
  @doc("The image to be analyzed")
  @body
  imageContents: ImageUrl;

  @doc("The type of segmentation to perform")
  @query("mode")
  mode: segmentationMode;

  @doc("The format of the image stream")
  @header()
  contentType: "application/octet-stream";
},
{
  @header 
  contentType: "image/png";
  @body
  bytes:bytes
} >;

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to segment an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
@doc("Segment the input image. An image stream of content type 'image/png' is returned, where the pixel values depend on the analysis mode. The returned image has the same dimensions as the input image for modes: foregroundMatting. The returned image has the same aspect ratio and same dimensions as the input image up to a limit of 16 megapixels for modes: backgroundRemoval.")
@actionSeparator("/")
@route("imageanalysis:segment")
@post
@sharedRoute
@action("segment")
op segmentFromStream is Azure.Core.RpcOperation<
{
  @doc("The image to be analyzed")
  @body
  imageContents: bytes;

  @doc("The format of the image stream")
  @header()
  contentType: "application/octet-stream";

  @doc("The type of segmentation to perform")
  @query("mode")
  mode: segmentationMode;

  @doc("Impl Detail")
  @query("overload")
  overload: "stream";
},
{
  @header 
  contentType: "image/png";
  @body
  bytes:bytes
} >;

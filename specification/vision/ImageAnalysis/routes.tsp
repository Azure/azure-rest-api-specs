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

alias SharedAnalyzeQuery = {
  @query({
    name: "features",
    format: "csv",
  })
  @doc("A string indicating what visual feature types to return. Multiple values should be comma-separated. Valid visual feature types include: Tags, Caption, DenseCaptions, Objects, Read, SmartCrops, People. At least one visual feature must be specified for Image Analysis.")
  visualFeatures?: Array<VisualFeatures>;

  @query("language")
  @doc("The desired language for output generation. If this parameter is not specified, the default value is \"en\". See https://aka.ms/cv-languages for a list of supported languages.")
  language?: string = "en";

  @query("gender-neutral-caption")
  @doc("Boolean flag for enabling gender-neutral captioning for caption and denseCaptions features. If this parameter is not specified, the default value is \"false\".")
  genderNeutralCaption?: boolean = false;

  @query({
    name: "smartcrops-aspect-ratios",
    format: "csv",
  })
  @doc("A list of aspect ratios to use for smartCrops feature. Aspect ratios are calculated by dividing the target crop width by the height. Supported values are between 0.75 and 1.8 (inclusive). Multiple values should be comma-separated. If this parameter is not specified, the service will return one crop suggestion with an aspect ratio it sees fit between 0.5 and 2.0 (inclusive).")
  smartCropsAspectRatios?: Array<float32>;

  @query("model-name")
  @doc("The name of the custom trained model. This parameter needs to be specified if the parameter \"features\" is not specified.")
  modelName?: string;
};

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to analyze an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
@doc("Performs a single Image Analysis operation")
@route("imageanalysis:analyze")
@post
@sharedRoute
op analyzeFromStream is Azure.Core.RpcOperation<
  {
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/octet-stream";

    @doc("The image to be analyzed")
    @body
    imageContent: bytes;

    ...SharedAnalyzeQuery;
  },
  ImageAnalysisResult
>;

@doc("Performs a single Image Analysis operation")
@route("imageanalysis:analyze")
@post
@sharedRoute
op analyzeFromUrl is Azure.Core.RpcOperation<
  {
    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/json";

    @doc("The image to be analyzed")
    @body
    imageContent: ImageUrl;

    ...SharedAnalyzeQuery;
  },
  ImageAnalysisResult
>;

alias SharedSegmentQuery = {
  @query("mode")
  @doc("The type of segmentation to perform")
  segmentationMode: SegmentationMode;
};

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to analyze an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
@doc("Segment the input image. An image stream of content type 'image/png' is returned, where the pixel values depend on the analysis mode. The returned image has the same dimensions as the input image for modes: foregroundMatting. The returned image has the same aspect ratio and same dimensions as the input image up to a limit of 16 megapixels for modes: backgroundRemoval.")
@route("imageanalysis:segment")
@post
@sharedRoute
op segmentFromUrl is Azure.Core.RpcOperation<
  {
    @doc("The image to be analyzed")
    @body
    imageContent: ImageUrl;

    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/json";

    ...SharedSegmentQuery;
  },
  {
    @header
    contentType: "image/png";

    @body
    bytes: bytes;
  }
>;

#suppress "@azure-tools/typespec-azure-core/byos" "It's an RPC call to segment an image, it doesn't store anything. There's a BYOS version of this call, but it's not this one."
@doc("Segment the input image. An image stream of content type 'image/png' is returned, where the pixel values depend on the analysis mode. The returned image has the same dimensions as the input image for modes: foregroundMatting. The returned image has the same aspect ratio and same dimensions as the input image up to a limit of 16 megapixels for modes: backgroundRemoval.")
@route("imageanalysis:segment")
@post
@sharedRoute
op segmentFromStream is Azure.Core.RpcOperation<
  {
    @doc("The image to be analyzed")
    @body
    imageContent: bytes;

    @doc("The format of the HTTP payload.")
    @header
    contentType: "application/octet-stream";

    ...SharedSegmentQuery;
  },
  {
    @header
    contentType: "image/png";

    @body
    bytes: bytes;
  }
>;

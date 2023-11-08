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
  @minItems(1)
  visualFeatures: Array<VisualFeatures>;

  @query("language")
  @doc("The desired language for output generation. If this parameter is not specified, the default value is \"en\". See https://aka.ms/cv-languages for a list of supported languages.")
  @minLength(2)
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

  @query("model-version")
  @doc("""
  The version of cloud AI-model used for analysis.
  The format is the following: 'latest' (default value) or 'YYYY-MM-DD' or 'YYYY-MM-DD-preview', where `YYYY`, `MM`, `DD` are the year, month and day.
  Only relevant when doing analysis with standard models. Not relevant when doing analysis with a custom-trained AI model.
  """)
  @pattern("^(latest|\\d{4}-\\d{2}-\\d{2})(-preview)?$")
  @minLength(6)
  @maxLength(18)
  modelVersion?: string = "latest";
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
